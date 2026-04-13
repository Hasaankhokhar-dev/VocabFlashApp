class WordModel {
  final int? id;
  final String word;
  final String meaning;
  final String phonetic;
  final String example;
  final int isKnown;
  final String addedDate;

  WordModel({
    this.id,
    required this.word,
    required this.meaning,
    required this.phonetic,
    required this.example,
    this.isKnown = 0,
    required this.addedDate,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'word': word,
      'meaning': meaning,
      'phonetic': phonetic,
      'example': example,
      'isKnown': isKnown,
      'addedDate': addedDate,
    };
  }
  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      word: map['word'],
      meaning: map['meaning'],
      phonetic: map['phonetic'],
      example: map['example'],
      isKnown: map['isKnown'],
      addedDate: map['addedDate'],
    );
  }
  WordModel copyWith({int? isKnown}) {
    return WordModel(
      id: id,
      word: word,
      meaning: meaning,
      phonetic: phonetic,
      example: example,
      isKnown: isKnown ?? this.isKnown,
      addedDate: addedDate,
    );
  }
}
