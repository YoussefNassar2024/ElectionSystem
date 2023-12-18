class Vote {
  String candidateId;
  String pollId;
  String voterId;
  Map<String, dynamic> voterData;

  Vote({
    required this.candidateId,
    required this.pollId,
    required this.voterId,
    required this.voterData,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      candidateId: json['candidateId'],
      pollId: json['pollId'],
      voterId: json['voterId'],
      voterData: json['voterData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'pollId': pollId,
      'voterId': voterId,
      'voterData': voterData,
    };
  }
}
