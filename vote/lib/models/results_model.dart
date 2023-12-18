class CandidateResult {
  String candidateId;
  int voteCount;

  CandidateResult({required this.candidateId, required this.voteCount});

  factory CandidateResult.fromJson(Map<String, dynamic> json) {
    return CandidateResult(
      candidateId: json['candidateId'],
      voteCount: json['voteCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateId': candidateId,
      'voteCount': voteCount,
    };
  }
}

class Results {
  List<CandidateResult> candidateResults;

  Results({required this.candidateResults});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      candidateResults: List<CandidateResult>.from(
        json['candidateResults']
            .map((result) => CandidateResult.fromJson(result)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateResults':
          candidateResults.map((result) => result.toJson()).toList(),
    };
  }
}
