import 'package:flutter/material.dart';

class TitleMedium extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;
  final Color? color;

  const TitleMedium(
    this.data, {
    this.textAlign,
    this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
