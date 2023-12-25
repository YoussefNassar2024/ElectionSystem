import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vote/custom_components/utils.dart';
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

  static Future<Poll?> getPollById(String documentId) async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('polls');

    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
          await collection.doc(documentId).get();
      if (documentSnapshot.exists) {
        // Use the factory method to create an instance of MyDocument
        print("Done");
        return Poll.fromJson(documentSnapshot.data()!);
      } else {
        print('Document does not exist.');

        return null;
      }
    } catch (e) {
      print('Error retrieving document: $e');
      return null;
    }
  }
  // Additional methods for updating, deleting polls, retrieving candidates, etc...
}
