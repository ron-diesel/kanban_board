import 'package:flutter/material.dart';

class TitleSmall extends StatelessWidget {
  final String data;
  final TextAlign? textAlign;
  final Color? color;

  const TitleSmall(
      this.data, {
        this.textAlign,
        this.color,
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(color: color),
      textAlign: textAlign,
    );
  }
}
