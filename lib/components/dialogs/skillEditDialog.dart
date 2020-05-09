import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/components/common/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/datamodels.dart';
import 'package:imperial_sheets/utils/enums.dart';

class SkillEditDialog extends StatelessWidget {
  SkillEditDialog(this.skill);
  final Skill skill;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: skill.canHaveMultiple()
          ? DialogTitleWithButton(
              title: Text(skill.name),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onTap: () {
                Navigator.of(context).pop({"choice": DialogChoices.delete});
              },
            )
          : Text(skill.name),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              key: _formKey,
              initialValue: {
                'stage': skill.stage.toString(),
                'subSkill': skill.canHaveMultiple() ? skill.subSkill : ''
              },
              child: Column(
                children: <Widget>[
                  skill.canHaveMultiple()
                      ? FormBuilderTextField(
                          attribute: 'subSkill',
                          decoration: InputDecoration(labelText: "Sub-skill"),
                          validators: [FormBuilderValidators.required()],
                        )
                      : Container(),
                  FormBuilderTouchSpin(
                    decoration: InputDecoration(labelText: "Stage"),
                    validators: [FormBuilderValidators.max(5)],
                    attribute: "stage",
                    initialValue: skill.stage,
                    min: 0,
                    step: 1,
                    max: 4,
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
              Navigator.of(context).pop({"choice": DialogChoices.cancel});
            }),
        FlatButton(
          child: Text('Submit'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              skill.stage = _formKey.currentState.value['stage'];
              if (skill.canHaveMultiple()) {
                skill.subSkill = _formKey.currentState.value['subSkill'];
              }
              Navigator.of(context)
                  .pop({"choice": DialogChoices.confirm, "payload": skill});
            }
          },
        ),
      ],
    );
  }
}
