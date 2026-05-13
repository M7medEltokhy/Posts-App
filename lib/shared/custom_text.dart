import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
     this.overflow,
      this.maxLines,
     this.size,
     this.color,
     this.weight,
  });

  final String text;
  final double? size;
  final Color ?color;
  final FontWeight? weight;
final int? maxLines;
final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textScaler: TextScaler.linear(1.0),
      maxLines: maxLines ?? 2,
      overflow: overflow ?? TextOverflow.ellipsis,
      style: TextStyle(color: color, fontSize: size, fontWeight: weight),
    );
  }
}
