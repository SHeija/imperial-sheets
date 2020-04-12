import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class DualValueEditDialog extends StatelessWidget {
  DualValueEditDialog(this.val1, this.val2, this.label1, this.label2, this.title, this.style);
  dynamic val1, val2;
  String label1, label2, title, style;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    switch (style) {
      case 'touchSpin':
        return(AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title),
          content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'val1': val1,
                        'val2': val2,
                      },
                      child: Column(
                        children: <Widget>[
                          FormBuilderTouchSpin(
                            decoration: InputDecoration(labelText: label1),
                            attribute: "val1",
                            initialValue: val1,
                            min: 0,
                            step: 1,
                          ),
                          FormBuilderTouchSpin(
                            decoration: InputDecoration(labelText: label2),
                            attribute: "val2",
                            initialValue: val2,
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
                  Navigator.of(context).pop(_formKey.currentState.value);
                }
              },
            ),
          ],
        )
        );
        break;
      default:
        return(AlertDialog(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(title),
          content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilder(
                      key: _formKey,
                      initialValue: {
                        'val1': val1.toString(),
                        'val2': val2.toString(),
                      },
                      child: Column(
                        children: <Widget>[
                          FormBuilderTextField(
                            attribute: "val1",
                            decoration: InputDecoration(labelText: label1),
                            validators: [
                              FormBuilderValidators.numeric(),
                            ],
                            valueTransformer: (v) => int.parse(v),
                          ),
                          FormBuilderTextField(
                            attribute: "val2",
                            decoration: InputDecoration(labelText: label2),
                            validators: [
                              FormBuilderValidators.numeric(),
                            ],
                            valueTransformer: (v) => int.parse(v),
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
                  Navigator.of(context).pop(_formKey.currentState.value);
                }
              },
            ),
          ],
        )
        );
    }
      }
}