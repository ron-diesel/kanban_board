import 'package:flutter/material.dart';

class BodyTextLarge extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;
  final Color? color;

  const BodyTextLarge(
    this.data, {
    this.textAlign,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
