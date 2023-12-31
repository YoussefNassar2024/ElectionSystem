import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/models/vote_model.dart';

class VoteService {
  static Future<void> uploadVote(Vote vote, String pollId) async {
    await FirebaseFirestore.instance
        .collection('polls')
        .doc(pollId)
        .collection('votes')
        .doc(FireBaseAuthenticationServices.currentUserID)
        .set(vote.toJson());
  }

  static Future<bool?> hasUserVoted(String pollId, String userId) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('polls')
          .doc(pollId)
          .collection('votes')
          .where('voterId', isEqualTo: userId)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } on Exception {
      return null;
    }
  }

  static Stream<List<Vote>> getVotesStream(String pollId) {
    return FirebaseFirestore.instance
        .collection('polls')
        .doc(pollId)
        .collection('votes')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return Vote.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  static Future<void> approveVote(Vote vote, String pollId) async {
    await FirebaseFirestore.instance
        .collection('polls')
        .doc(pollId)
        .collection('votes')
        .doc(vote.voterId)
        .update({'isApproved': true});
  }

  static Future<void> deleteVote(String voterId, String pollId) async {
    await FirebaseFirestore.instance
        .collection('polls')
        .doc(pollId)
        .collection('votes')
        .doc(voterId)
        .delete();
  }
}
