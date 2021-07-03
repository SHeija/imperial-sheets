import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormDropdown extends StatelessWidget {
  FormDropdown(
      {@required Key key,
      @required this.name,
      @required this.items,
      this.label,
      this.validator,
      this.valueTransformer});
  final String name, label;
  final List<String> items;
  final FormFieldValidator<dynamic> validator;
  final dynamic valueTransformer;

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      valueTransformer: valueTransformer,
      builder: (FormFieldState<String> field) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 5),
          child: InputDecorator(
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(),
              errorText: field.errorText,
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isDense: true,
                hint: Text('Select...'),
                value: field.value,
                items: items
                    .map<DropdownMenuItem<String>>(
                      (skill) => DropdownMenuItem<String>(
                          value: skill,
                          child: Text(skill),
                      )
                    )
                    .toList(),
                onChanged: field.didChange,
              ),
            ),
          ),
        );
      },
    );
  }
}
