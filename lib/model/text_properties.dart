import 'package:flutter/material.dart';

class TextProperties {
  final String text;
  final String fontFamily;
  final Color color;
  final double fontSize;
  final Offset position;

  TextProperties({
    required this.text,
    required this.fontFamily,
    required this.color,
    required this.fontSize,
    required this.position,
  });

  TextProperties copyWith({
    String? text,
    String? fontFamily,
    Color? color,
    double? fontSize,
    Offset? position,
  }) {
    return TextProperties(
      text: text ?? this.text,
      fontFamily: fontFamily ?? this.fontFamily,
      color: color ?? this.color,
      fontSize: fontSize ?? this.fontSize,
      position: position ?? this.position,
    );
  }
}
