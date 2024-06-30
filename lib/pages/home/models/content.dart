// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:gemini_api_vanilla/pages/home/models/part.dart';

class Content {
  String role;
  List<Part> parts;
  Content({
    required this.role,
    required this.parts,
  });

  Content copyWith({
    String? role,
    List<Part>? parts,
  }) {
    return Content(
      role: role ?? this.role,
      parts: parts ?? this.parts,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'role': role,
      'parts': parts.map((x) => x.toMap()).toList(),
    };
  }

  factory Content.fromMap(Map<String, dynamic> map) {
    return Content(
      role: map['role'] as String,
      parts: List<Part>.from(
        (map['parts'] as List<dynamic>).map<Part>(
          (x) => Part.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Content.fromJson(String source) =>
      Content.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Content(role: $role, parts: $parts)';

  @override
  bool operator ==(covariant Content other) {
    if (identical(this, other)) return true;

    return other.role == role && listEquals(other.parts, parts);
  }

  @override
  int get hashCode => role.hashCode ^ parts.hashCode;
}
