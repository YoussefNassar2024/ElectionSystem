class Vote {
  String candidateId;
  String pollId;
  String voterId;
  Map<String, dynamic> voterData;
  bool isApproved;
  Vote(
      {required this.candidateId,
      required this.pollId,
      required this.voterId,
      required this.voterData,
      required this.isApproved});

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
        candidateId: json['candidateId'],
        pollId: json['pollId'],
        voterId: json['voterId'],
        voterData: json['voterData'],
        isApproved: json['isApproved']);
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'pollId': pollId,
      'voterId': voterId,
      'voterData': voterData,
      'isApproved': isApproved
    };
  }
}
