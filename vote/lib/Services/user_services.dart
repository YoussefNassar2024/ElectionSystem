import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/models/user_model.dart';

class UserService {
  static Future<void> addCreatedPoll(String pollId) async {
    try {
      String userId = FireBaseAuthenticationServices.getCurrentUserId();

      DocumentSnapshot userDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDocument.exists) {
        dynamic userData = userDocument.data();

        List<dynamic>? createdPolls = userData?['createdPolls'];

        if (createdPolls == null || !createdPolls.contains(pollId)) {
          await FirebaseFirestore.instance.collection('users').doc(userId).set({
            'createdPolls': FieldValue.arrayUnion([pollId]),
          }, SetOptions(merge: true));
        } else {
          print('PollId already exists in createdPolls array');
        }
      } else {
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
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        List<String> createdPolls =
            List<String>.from(userSnapshot.get('createdPolls') ?? []);
        List<String> contributedPolls =
            List<String>.from(userSnapshot.get('contributedPolls') ?? []);

        return User(
          createdPolls: createdPolls,
          contributedPolls: contributedPolls,
        );
      } else {
        print('User not found for userId: $userId');
        return null;
      }
    } catch (error, stackTrace) {
      print('Error fetching user data: $error\n$stackTrace');

      throw Exception('Error fetching user data: $error');
    }
  }
}
