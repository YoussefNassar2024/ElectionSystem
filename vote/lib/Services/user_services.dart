import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/models/user_model.dart';

class UserService {
  static Future<void> addCreatedPoll(String pollId) async {
    try {
      String userId = FireBaseAuthenticationServices.getCurrentUserId();

      // Get the current user document
      DocumentSnapshot userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      // Check if the 'createdPolls' array exists
      if (userDocument.exists) {
        dynamic userData = userDocument.data();

        // Check if the 'createdPolls' array is present in the user document
        List<dynamic>? createdPolls = userData?['createdPolls'];

        // If the array doesn't exist or doesn't contain the pollId, update the array
        if (createdPolls == null || !createdPolls.contains(pollId)) {
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'createdPolls': FieldValue.arrayUnion([pollId]),
          }, SetOptions(merge: true));
        } else {
          print('PollId already exists in createdPolls array');
        }
      } else {
        // If the user document doesn't exist, create a new one
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'createdPolls': [pollId],
        });
      }
    } catch (e) {
      print('Error adding created poll: $e');
    }
  }

  static Future<void> addContributedPoll(String pollId) async {
    try {
      String userId = FireBaseAuthenticationServices.getCurrentUserId();

      await FirebaseFirestore.instance.collection('users').doc(userId).update({
        'contributedPolls': FieldValue.arrayUnion([pollId]),
      });
    } catch (e) {
      print('Error adding contributed poll: $e');
    }
  }

  static Future<User?> getUserData() async {
    try {
      String userId = FireBaseAuthenticationServices.getCurrentUserId();
      // Replace 'users' with the name of your Firestore collection
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        // If the document exists, parse the lists directly
        List<String> createdPolls =
            List<String>.from(userSnapshot.get('createdPolls') ?? []);
        List<String> contributedPolls =
            List<String>.from(userSnapshot.get('contributedPolls') ?? []);

        return User(
          createdPolls: createdPolls,
          contributedPolls: contributedPolls,
        );
      } else {
        // If the document does not exist
        print('User not found for userId: $userId');
        return null;
      }
    } catch (error, stackTrace) {
      // Handle any exceptions that occurred during the process
      print('Error fetching user data: $error\n$stackTrace');
      // Throw an exception to signal the error to the calling code
      throw Exception('Error fetching user data: $error');
    }
  }

  // Additional methods for user-related operations...
}
/* Example
// Assuming you have the current user's ID
final userService = UserService(userId: currentUserId);

// Add created poll for the user
await userService.addCreatedPoll('pollId1');

// Add contributed poll for the user
await userService.addContributedPoll('pollId3');
 */