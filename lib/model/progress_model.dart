class ProgressModel {
  final int? id;
  final String date;
  final int cardsReviewed;
  final int correctCount;

  ProgressModel({
    this.id,
    required this.date,
    required this.cardsReviewed,
    required this.correctCount,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'cardsReviewed': cardsReviewed,
      'correctCount': correctCount,
    };
  }

  factory ProgressModel.fromMap(Map<String, dynamic> map) {
    return ProgressModel(
      id: map['id'],
      date: map['date'],
      cardsReviewed: map['cardsReviewed'],
      correctCount: map['correctCount'],
    );
  }

  ProgressModel copyWith({int? cardsReviewed, int? correctCount}) {
    return ProgressModel(
      id: id,
      date: date,
      cardsReviewed: cardsReviewed ?? this.cardsReviewed,
      correctCount: correctCount ?? this.correctCount,
    );
  }
}
