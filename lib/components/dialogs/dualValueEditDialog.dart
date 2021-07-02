import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';

class DualValueEditDialog extends StatelessWidget {
  DualValueEditDialog(
      this.val1, this.val2, this.label1, this.label2, this.title);
  final dynamic val1, val2;
  final String label1, label2, title;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(title),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'val1': val1,
                'val2': val2,
              },
              child: Column(
                children: <Widget>[
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: label1),
                    name: "val1",
                    initialValue: val1,
                    min: 0,
                    step: 1,
                  ),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: label2),
                    name: "val2",
                    initialValue: val2,
                    min: 0,
                    step: 1,
                  ),
                ],
              )),
        ],
      )),
      actions: <Widget>[
        TextButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              Navigator.of(context).pop(_formKey.currentState.value);
            }
          },
        ),
      ],
    ));
  }
}
