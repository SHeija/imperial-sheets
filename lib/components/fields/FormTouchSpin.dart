import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_touch_spin/flutter_touch_spin.dart';

class FormTouchSpin extends StatelessWidget {
  FormTouchSpin({
    @required this.name,
    @required this.key,
    this.validator,
    this.decoration,
    this.min = 0,
    this.max = 100,
    this.step = 1,
  });
  final String name;
  final Key key;
  final FormFieldValidator<dynamic> validator;
  final InputDecoration decoration;
  final int min, max, step;
  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      builder: (FormFieldState<int> field) {
        print(field.value);
        return InputDecorator(
          decoration: decoration.copyWith(border: InputBorder.none),
          child: TouchSpin(
              key: key,
              value: field.value ?? 0,
              onChanged: field.didChange,
              min: min,
              max: max,
              step: step,
          ),
        );
      },
    );
  }
}