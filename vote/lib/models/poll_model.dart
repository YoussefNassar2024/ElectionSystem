import 'package:cloud_firestore/cloud_firestore.dart';

////////////////////////////////////////Important notes////////////////////////////////////////////////////////
/// users document name is the userId /////////////////////////////////////////////////////////////////////////
/// poll document name is the pollId pollId must be generated with algorithm that makes every id different ////
/// results document name is the pollId ///////////////////////////////////////////////////////////////////////
/// vote document name is voteId //////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
class Candidate {
  String name;
  String photo;
  String age;
  String description;
  String Id;
  Candidate({
    required this.name,
    required this.Id,
    required this.photo,
    required this.age,
    required this.description,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) {
    return Candidate(
      Id: json['id'],
      name: json['name'],
      photo: json['photo'],
      age: json['age'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'name': name,
      'photo': photo,
      'age': age,
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
  List<Map<String, String>> requiredData;
  Poll(
      {required this.title,
      required this.candidates,
      required this.pollCode,
      required this.pollExpiryDate,
      required this.pollFinished,
      required this.requiredData});

  factory Poll.fromJson(Map<String, dynamic> json) {
    return Poll(
      title: json['title'],
      candidates: List<Candidate>.from(
          json['candidates'].map((c) => Candidate.fromJson(c))),
      pollCode: json['pollCode'],
      pollExpiryDate: json['pollExpiryDate'],
      pollFinished: json['pollFinished'],
      requiredData: List<Map<String, String>>.from(
        json['requiredData'].map((data) => Map<String, String>.from(data)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'candidates': candidates.map((c) => c.toJson()).toList(),
      'pollCode': pollCode,
      'pollExpiryDate': pollExpiryDate,
      'pollFinished': pollFinished,
      'requiredData': requiredData
    };
  }
}
