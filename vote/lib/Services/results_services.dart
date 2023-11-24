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

  // Additional methods for computing and displaying results...
}
