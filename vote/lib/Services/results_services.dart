import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/results_model.dart';

class ResultsService {
  static Future<Results?> getResultsByPollId(String pollId) async {
    try {
      DocumentSnapshot resultsSnapshot = await FirebaseFirestore.instance
          .collection('polls')
          .doc(pollId)
          .collection('results')
          .doc(pollId)
          .get();

      if (resultsSnapshot.exists) {
        List<Map<String, dynamic>> candidateResults =
            List<Map<String, dynamic>>.from(
                resultsSnapshot.get('candidateResults') ?? [{}]);
        return Results(candidateResults: candidateResults);
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting results: $e");
      return null;
    }
  }

  static Future<void> placeVote(String pollId, int candidateIndex) async {
    try {
      DocumentReference resultsDocRef = FirebaseFirestore.instance
          .collection('polls')
          .doc(pollId)
          .collection('results')
          .doc(pollId);

      DocumentSnapshot resultsSnapshot = await resultsDocRef.get();
      List<Map<String, dynamic>> currentCandidateResults =
          List<Map<String, dynamic>>.from(
              resultsSnapshot.get('candidateResults') ?? []);

      if (candidateIndex >= 0 &&
          candidateIndex < currentCandidateResults.length) {
        String candidateId = currentCandidateResults[candidateIndex].keys.first;
        currentCandidateResults[candidateIndex][candidateId] =
            (currentCandidateResults[candidateIndex][candidateId] ?? 0) + 1;

        await resultsDocRef
            .update({'candidateResults': currentCandidateResults});
      } else {
        print('Invalid candidate index.');
      }
    } catch (e) {
      print("Error placing vote: $e");
    }
  }

  static Future<void> uploadResults(String docId, Results result) async {
    try {
      await FirebaseFirestore.instance
          .collection('polls')
          .doc(docId)
          .collection('results')
          .doc(docId)
          .set(result.toJson());

      print('Poll uploaded successfully to Firestore!');
    } catch (e) {
      print('Error uploading poll to Firestore: $e');
    }
  }
}
