class Vote {
  String voterId;
  String pollId;
  String candidateId;

  Vote(
      {required this.voterId, required this.pollId, required this.candidateId});

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      voterId: json['voterId'],
      pollId: json['pollId'],
      candidateId: json['candidateId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'voterId': voterId,
      'pollId': pollId,
      'candidateId': candidateId,
    };
  }
}
