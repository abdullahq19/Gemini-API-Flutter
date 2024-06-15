import 'dart:convert';

class Part {
  String text;
  Part({
    required this.text,
  });

  Part copyWith({
    String? text,
  }) {
    return Part(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
    };
  }

  factory Part.fromMap(Map<String, dynamic> map) {
    return Part(
      text: map['text'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Part.fromJson(String source) =>
      Part.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Part(text: $text)';

  @override
  bool operator ==(covariant Part other) {
    if (identical(this, other)) return true;

    return other.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}
