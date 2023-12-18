import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future<void> addCreatedPoll(String pollId, String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'createdPolls': FieldValue.arrayUnion([pollId]),
    });
  }

  Future<void> addContributedPoll(String pollId, String userId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
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