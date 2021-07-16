class AppMessage {
  final String content;
  final String idFrom;
  final String idTo;
  final String timestamp;

  AppMessage({
    required this.content,
    required this.idFrom,
    required this.idTo,
    required this.timestamp,
  });
}