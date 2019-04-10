class ReadMe {
  final num id;
  final String name;
  final String downloadUrl;

  ReadMe(
      {this.id,
        this.name,
        this.downloadUrl});

  factory ReadMe.fromJson(Map<String, dynamic> json) {
    return ReadMe(
        id: json['id'],
        name: json['name'],
        downloadUrl: json['download_url']);
  }
}
