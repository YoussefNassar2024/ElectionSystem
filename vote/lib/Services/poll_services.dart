import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/poll_model.dart';

class PollService {
  Future<void> createPoll(Poll poll) async {
    await FirebaseFirestore.instance.collection('polls').add(poll.toJson());
  }

  Future<Poll> getPollDetails(String pollId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('polls').doc(pollId).get();
    return Poll.fromJson(snapshot.data()!);
  }

  // Additional methods for updating, deleting polls, retrieving candidates, etc...
}
