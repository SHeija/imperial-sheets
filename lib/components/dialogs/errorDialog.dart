import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  ErrorDialog({
    @required this.error,
    this.content = const Text('Something went wrong.')
  });
  final Exception error;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('ERROR'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            content,
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Error message:',
                  ),
                  Text(
                    error.toString(),
                    style: Theme.of(context).textTheme.body1.copyWith(color: Colors.red),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OK'),
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }
}