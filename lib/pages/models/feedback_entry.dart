class FeedbackEntry {
  int id;
  double rating;
  String feedback;

  FeedbackEntry({
    required this.id,
    required this.rating,
    required this.feedback,
  });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'feedback': feedback,
    };
  }
}
