import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/utils/enums.dart';

class AptitudeEditDialog extends StatelessWidget {
  AptitudeEditDialog(this.aptitudes);
  final List<String> aptitudes;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Aptitudes'),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: SingleChildScrollView(
        child: FormBuilder(
          autovalidateMode: AutovalidateMode.always,
          key: _formKey,
          initialValue: {
            "aptitudes": aptitudes.join(" "),
          },
          child: Column(
            children: <Widget>[
              FormTextField(
                key: Key('field_aptitudes'),
                name: "aptitudes",
                label: "Aptitudes",
                helper: "Separate aptitudes by spaces",
                hint: "e.g. general offence finesse",
                valueTransformer: (v) => v.split(" "),
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
            child: Text('Regret'),
            onPressed: () {
              Navigator.of(context).pop({'choice': DialogChoices.cancel});
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              Navigator.of(context).pop({
                'choice': DialogChoices.confirm,
                'payload': _formKey.currentState.value['aptitudes'],
              });
            }
          },
        ),
      ],
    );
  }
}
