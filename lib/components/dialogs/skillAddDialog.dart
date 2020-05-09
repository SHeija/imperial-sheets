import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import '../../utils/constants.dart' as Constants;

class SkillAddDialog extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    Skill _skill = Skill.blank();
    return AlertDialog(
      shape:
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('Add a skill'),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  FormBuilderDropdown(
                    attribute: 'title',
                    items: Constants.SKILLS_MULTIPLE
                        .map((skill) => DropdownMenuItem(
                        value: skill,
                        child: Text("$skill")
                    )).toList(),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTextField(
                    attribute: 'subSkill',
                    decoration: InputDecoration(labelText: 'Subskill', hintText: 'e.g. Mechanicus, shipwright...'),
                    validators: [
                      FormBuilderValidators.required(),
                    ],
                  ),
                  FormBuilderTouchSpin(
                    attribute: 'stage',
                    decoration: InputDecoration(labelText: 'Stage'),
                    initialValue: 1,
                    min: 1,
                    max: 4,
                    step: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
              _skill.name = _formKey.currentState.value['title'];
              _skill.subSkill = _formKey.currentState.value['subSkill'];
              _skill.stat = Constants.SKILL_LIST[_formKey.currentState.value['title']];
              _skill.stage = _formKey.currentState.value['stage'];
              _skill.aptitudes = [];
              Navigator.of(context).pop(_skill);
            }
          },
        ),
      ],
    );
  }
}