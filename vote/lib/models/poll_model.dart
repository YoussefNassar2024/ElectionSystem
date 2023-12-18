import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

////////////////////////////////////////Important notes////////////////////////////////////////////////////////
/// users document name is the userId /////////////////////////////////////////////////////////////////////////
/// poll document name is the pollId pollId must be generated with algorithm that makes every id different ////
/// results document name is the pollId ///////////////////////////////////////////////////////////////////////
/// vote document name is voteId //////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Candidate {
  String name;
  File photo;
  String dateOfBirth;
  String description;

  Candidate({
    required this.name,
    required this.photo,
    required this.dateOfBirth,
    required this.description,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      name: json['name'],
      photo: json['photo'],
      dateOfBirth: json['dateOfBirth'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'photo': photo,
      'dateOfBirth': dateOfBirth,
      'description': description,
    };
  }
}

class Poll {
  String title;
  List<Candidate> candidates;
  String pollCode;
  Timestamp pollExpiryDate; // Representing pollExpiryDate as Timestamp
  bool pollFinished;

  Poll({
    required this.title,
    required this.candidates,
    required this.pollCode,
    required this.pollExpiryDate,
    required this.pollFinished,
  });

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      title: json['title'],
      candidates: List<Candidate>.from(
          json['candidates'].map((c) => Candidate.fromJson(c))),
      pollCode: json['pollCode'],
      pollExpiryDate: json['pollExpiryDate'],
      pollFinished: json['pollFinished'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'candidates': candidates.map((c) => c.toJson()).toList(),
      'pollCode': pollCode,
      'pollExpiryDate': pollExpiryDate,
      'pollFinished': pollFinished,
    };
  }
}
