import 'package:flutter/material.dart';

class BodyTextMedium extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;
  final Color? color;

  const BodyTextMedium(
    this.data, {
    this.textAlign,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
