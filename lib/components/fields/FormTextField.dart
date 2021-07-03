import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormTextField extends StatelessWidget {
  FormTextField({
    @required this.name,
    @required this.label,
    @required this.key,
    this.valueTransformer,
    this.validator,
    this.hint,
    this.helper,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.autofocus = false,
  });
  final Key key;
  final String name, label, hint, helper;
  final int maxLines;
  final FormFieldValidator<dynamic> validator;
  final dynamic valueTransformer;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
        name: name,
        validator: validator,
        valueTransformer: valueTransformer,
        builder: (FormFieldState<String> field) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: TextFormField(
              key: key,
              decoration: InputDecoration(
                labelText: label,
                hintText: hint,
                helperText: helper,
                border: OutlineInputBorder(),
                errorText: field.errorText,
              ),
              onChanged: field.didChange,
              initialValue: (controller == null) ? field.value : null,
              maxLines: maxLines,
              keyboardType: keyboardType,
              controller: controller,
              autofocus: autofocus,
            ),
          );
        }
    );
  }
}