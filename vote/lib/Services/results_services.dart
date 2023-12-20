import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/results_model.dart';

class ResultsService {
  Future<Results> getPollResults(String pollId) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('results')
        .doc(pollId)
        .get();
    return Results.fromJson(snapshot.data()!);
  }

  static Future<void> uploadResults(String docId, Results result) async {
    try {
      // Save the poll data to Firestore
      await FirebaseFirestore.instance
          .collection('results')
          .doc(docId)
          .set(result.toJson());

      print('Poll uploaded successfully to Firestore!');
    } catch (e) {
      print('Error uploading poll to Firestore: $e');
    }
  }
  // Additional methods for computing and displaying results...
}
