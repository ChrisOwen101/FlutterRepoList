class GitRepo {
  final num id;
  final String name;
  final String avatarUrl;
  final num stars;
  final String language;
  final String owner;
  final String desc;

  GitRepo(
      {this.id,
      this.name,
      this.avatarUrl,
      this.stars,
      this.language,
      this.owner,
      this.desc});

  factory GitRepo.fromJson(Map<String, dynamic> json) {
    return GitRepo(
        id: json['id'],
        name: json['name'],
        avatarUrl: json['owner']['avatar_url'],
        stars: json['stargazers_count'],
        language: json['language'],
        owner: json['owner']['login'],
        desc: json['description']);
    }
}
