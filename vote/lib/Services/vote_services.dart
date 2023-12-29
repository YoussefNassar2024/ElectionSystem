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
    } on Exception catch (e) {
      // TODO
      return null;
    }
  }

  static Future<List<Vote>> getAllVotesInPoll(String pollId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('polls')
          .doc(pollId)
          .collection('votes')
          .get();

      List<Vote> votes = [];

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        // Convert document data to a Vote object using Vote.fromJson
        Vote vote = Vote.fromJson(document.data() as Map<String, dynamic>);
        votes.add(vote);
      }

      return votes;
    } catch (e) {
      print("Error getting votes: $e");
      return [];
    }
  }

  // Additional methods for updating votes, checking vote status, etc...
}
