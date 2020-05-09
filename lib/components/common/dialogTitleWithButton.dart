import 'package:flutter/material.dart';

class DialogTitleWithButton extends StatelessWidget {
  DialogTitleWithButton({
    @required this.title,
    @required this.icon,
    this.onTap,
  });
  final Widget title;
  final Widget icon;
  final dynamic onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        title,
        GestureDetector(
          child: icon,
          onTap: onTap,
        )
      ],
    );
  }
}