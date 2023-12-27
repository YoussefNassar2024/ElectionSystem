import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/Services/authentication_services.dart';
import 'package:vote/models/vote_model.dart';

class VoteService {
  static Future<void> uploadVote(Vote vote) async {
    await FirebaseFirestore.instance
        .collection('votes')
        .doc(FireBaseAuthenticationServices.currentUserID)
        .set(vote.toJson());
  }

  static Future<bool> hasUserVoted(String pollId, String userId) async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('votes')
        .where('pollId', isEqualTo: pollId)
        .where('voterId', isEqualTo: userId)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  // Additional methods for updating votes, checking vote status, etc...
}
