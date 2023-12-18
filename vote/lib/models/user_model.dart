class User {
  List<String> createdPolls;
  List<String> contributedPolls;

  User({required this.createdPolls, required this.contributedPolls});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      createdPolls: List<String>.from(json['createdPolls']),
      contributedPolls: List<String>.from(json['contributedPolls']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdPolls': createdPolls,
      'contributedPolls': contributedPolls,
    };
  }
}
