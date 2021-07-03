import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import '../../utils/customValidators.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/character.dart';

class ExperienceEditDialog extends StatelessWidget {
  ExperienceEditDialog(this.spent, this.total, this.character);
  final int spent, total;
  final Character character;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final TextEditingController spentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // set initial value
    spentController.text = spent.toString();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: DialogTitleWithButton(
        title: Text('Experience'),
        icon: Icon(Icons.sync),
        onTap: () {
          spentController.text = character.calculateSpentExp().toString();
        },
        tooltip: 'Calculate spent experience',
      ),
      content: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'val1': spent.toString(),
                'val2': total.toString(),
              },
              child: Column(
                children: <Widget>[
                  FormTextField(
                    key: Key('SpentValue'),
                    name: "val1",
                    label: 'Spent',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      CustomValidators.numeric(context),
                    ]),
                    controller: spentController,
                  ),
                  FormTextField(
                    key: Key('TotalValue'),
                    name: "val2",
                    label: 'Total',
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(context),
                      CustomValidators.numeric(context),
                    ]),
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
    );
  }
}
