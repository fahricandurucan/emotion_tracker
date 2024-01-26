class Quote {
  String emotion;
  String timestamp;
  String text;
  String author;

  Quote({
    required this.emotion,
    required this.timestamp,
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      emotion: json['emotion'],
      timestamp: json['timestamp'],
      text: json['text'],
      author: json['author'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'emotion': emotion,
      'timestamp': timestamp,
      'text': text,
      'author': author,
    };
  }
}
