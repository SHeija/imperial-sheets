import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: Center(
          child: Text('Delete?')
        ),
      ),
      actions: <Widget>[
        FlatButton(
            child: Text('No'),
            onPressed: () {
              Navigator.of(context).pop(false);
            }),
        FlatButton(
          child: Text('Yes'),
          onPressed: () {
              Navigator.of(context).pop(true);
            }
        ),
      ],
    );
  }
}