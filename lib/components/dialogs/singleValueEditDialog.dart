import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/fields/FormTouchSpin.dart';

class SingleValueEditDialog extends StatelessWidget {
  SingleValueEditDialog(this.value, this.label);
  final String label;
  final dynamic value;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(label),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'value': value,
              },
              child: Column(
                children: <Widget>[
                  FormTouchSpin(
                    decoration: InputDecoration(),
                    key: Key('SingleValue'),
                    name: 'value',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Regret'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              Navigator.of(context).pop(_formKey.currentState.value['value']);
            }
          },
        ),
      ],
    ));
  }
}
