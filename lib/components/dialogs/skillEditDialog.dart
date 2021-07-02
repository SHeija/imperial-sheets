import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_fields/form_builder_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/attributes.dart';
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
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'stage': skill.stage.toString(),
                'subSkill': skill.canHaveMultiple() ? skill.subSkill : '',
                'cost': skill.cost.toString(),
              },
              child: Column(
                children: <Widget>[
                  skill.canHaveMultiple()
                      ? FormBuilderTextField(
                          key: Key('field_subSkill'),
                          name: 'subSkill',
                          decoration: InputDecoration(labelText: "Subskill"),
                          validator: FormBuilderValidators.required(context),
                        )
                      : Container(),
                  FormBuilderTouchSpin(
                    key: Key('field_stage'),
                    decoration: InputDecoration(labelText: "Stage"),
                    name: "stage",
                    initialValue: skill.stage,
                    min: 0,
                    step: 1,
                    max: 4,
                  ),
                  FormBuilderTextField(
                    key: Key('field_cost'),
                    name: "cost",
                    decoration: InputDecoration(labelText: "Exp cost in total"),
                    validator: FormBuilderValidators.compose(
                      [
                        FormBuilderValidators.numeric(context),
                        FormBuilderValidators.required(context),
                      ],
                    ),
                  ),
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
              Navigator.of(context).pop({"choice": DialogChoices.cancel});
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              if (skill.canHaveMultiple()) {
                skill.subSkill = _formKey.currentState.value['subSkill'];
              }
              skill.stage = _formKey.currentState.value['stage'];
              skill.cost = int.parse(_formKey.currentState.value['cost']);
              Navigator.of(context)
                  .pop({"choice": DialogChoices.confirm, "payload": skill});
            }
          },
        ),
      ],
    );
  }
}
