import 'package:flutter/material.dart';

class Tutorial extends StatelessWidget {
  String tutorial = '1. Create, select and manage characters from left drawer \n2. Long press to edit things \n3. Tap "+" to add things \n4. Tap "trashcan" to delete things';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Tutorial'),
      content: Container(
        child: Text(tutorial),
      ),
      actions: [
        FlatButton(
            child: Text('Confirm'),
            onPressed: () {
              Navigator.of(context).pop();
            }
        )
      ],
    );
  }
}