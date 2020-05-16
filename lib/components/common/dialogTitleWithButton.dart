import 'package:flutter/material.dart';

class DialogTitleWithButton extends StatelessWidget {
  DialogTitleWithButton({
    @required this.title,
    @required this.icon,
    this.tooltip,
    this.onTap,
  });
  final Widget title;
  final Widget icon;
  final String tooltip;
  final dynamic onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        title,
        tooltip != null
            ? Tooltip(
                message: tooltip,
                child: InkWell(
                  onTap: onTap,
                  child: icon,
                  borderRadius: BorderRadius.circular(20.0),
                ),
              )
            : InkWell(
                onTap: onTap,
                child: icon,
                borderRadius: BorderRadius.circular(20.0),
              ),
      ],
    );
  }
}
