class Results {
  List<Map<String, dynamic>> candidateResults;

  Results({required this.candidateResults});

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      candidateResults: List<Map<String, dynamic>>.from(
        json['candidateResults'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'candidateResults': candidateResults,
    };
  }
}
