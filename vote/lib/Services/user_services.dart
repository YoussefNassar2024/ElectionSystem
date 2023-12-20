import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/Services/authentication_services.dart';

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
      if (userDocument.exists && userDocument.data() != null) {
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
      }
    } catch (e) {
      print('Error adding created poll: $e');
    }
  }

  Future<void> addContributedPoll(String pollId, String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'contributedPolls': FieldValue.arrayUnion([pollId]),
    });
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