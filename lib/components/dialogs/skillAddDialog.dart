import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormDropdown.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/fields/FormTouchSpin.dart';
import 'package:imperial_sheets/models/attributes.dart';
import 'package:imperial_sheets/utils/customValidators.dart';
import '../../utils/constants.dart' as Constants;

class SkillAddDialog extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Skill _skill = Skill.blank();
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Add a skill'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'subSkill': _skill.subSkill,
                'stage': _skill.stage,
                'cost': _skill.cost.toString()
              },
              child: Column(
                children: <Widget>[
                  FormDropdown(
                    key: key,
                    name: 'title',
                    label: 'Skill',
                    items: Constants.SKILLS_MULTIPLE,
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormTextField(
                    key: Key('field_subSkill'),
                    name: 'subSkill',
                    label: 'Subskill',
                    hint: 'e.g. Mechanicus, shipwright...',
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormTouchSpin(
                    key: Key('field_stage'),
                    name: 'stage',
                    decoration: InputDecoration(labelText: 'Stage'),
                    min: 1,
                    max: 4,
                    step: 1,
                  ),
                  FormTextField(
                      key: Key('field_cost'),
                      name: "cost",
                      label: "Exp cost in total",
                      validator: FormBuilderValidators.compose([
                        CustomValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ])),
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
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              _skill.name = _formKey.currentState.value['title'];
              _skill.subSkill = _formKey.currentState.value['subSkill'];
              _skill.stat =
                  Constants.SKILL_LIST[_formKey.currentState.value['title']];
              _skill.stage = _formKey.currentState.value['stage'];
              _skill.aptitudes = [];
              _skill.cost = int.parse(_formKey.currentState.value['cost']);
              Navigator.of(context).pop(_skill);
            }
          },
        ),
      ],
    );
  }
}
