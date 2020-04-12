import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class SingleValueEditDialog extends StatelessWidget {
  SingleValueEditDialog(this.value, this.label);
  String label;
  dynamic value;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return(
        AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(label),
          content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'value': value,
                      },
                      child: Column(
                        children: <Widget>[
                          FormBuilderTouchSpin(
                            validators: [FormBuilderValidators.required()],
                            attribute: "value",
                            initialValue: value,
                            min: 0,
                            step: 1,
                          ),
                        ],
                      )),
                ],
              )),
          actions: <Widget>[
            FlatButton(
                child: Text('Regret'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            FlatButton(
              child: Text('Submit'),
              onPressed: () {
                if (_formKey.currentState.saveAndValidate()) {
                  Navigator.of(context).pop(_formKey.currentState.value['value']);
                }
              },
            ),
          ],
        )
    );
  }
}