class PullRequest {
  final String? title;
  final String? body;
  final User? user;
  final DateTime? createdAt;

  PullRequest({
    this.title,
    this.body,
    this.user,
    this.createdAt,
  });

  factory PullRequest.fromJson(Map<String, dynamic> json) => PullRequest(
    title: json["title"],
    body: json["body"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "body": body,
    "user": user?.toJson(),
    "created_at": createdAt?.toIso8601String(),
  };
  // Helper method to parse list of pull requests
  static List<PullRequest> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PullRequest.fromJson(json as Map<String, dynamic>)).toList();
  }
}

class User {
  final String? login;

  User({
    this.login,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    login: json["login"],
  );

  Map<String, dynamic> toJson() => {
    "login": login,
  };
}
