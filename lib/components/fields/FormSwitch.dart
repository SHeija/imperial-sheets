import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormSwitch extends StatelessWidget {
  FormSwitch({
    @required this.name,
    @required this.label,
    @required this.key,
    this.valueTransformer,
    this.validator,
  });
  final Key key;
  final String name, label;
  final FormFieldValidator<dynamic> validator;
  final dynamic valueTransformer;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        validator: validator,
        valueTransformer: valueTransformer,
        builder: (FormFieldState<bool> field) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(label),
                ),
                Switch(
                  key: key,
                  value: field.value,
                  onChanged: field.didChange,
                ),
              ],
            )
          );
        }
    );
  }
}