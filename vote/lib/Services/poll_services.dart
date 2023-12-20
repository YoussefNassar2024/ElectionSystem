import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vote/models/poll_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PollService {
  static Future<void> createPoll(String docId, Poll poll) async {
    try {
      // Save the poll data to Firestore
      await FirebaseFirestore.instance
          .collection('polls')
          .doc(docId)
          .set(poll.toJson());

      print('Poll uploaded successfully to Firestore!');
    } catch (e) {
      print('Error uploading poll to Firestore: $e');
    }
  }

  static Future<Poll> getPollDetails(String pollId) async {
    final snapshot =
        await FirebaseFirestore.instance.collection('polls').doc(pollId).get();
    return Poll.fromJson(snapshot.data()!);
  }

  // Additional methods for updating, deleting polls, retrieving candidates, etc...
}
