import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/fields/FormSwitch.dart';
import 'package:imperial_sheets/components/fields/FormTextField.dart';
import 'package:imperial_sheets/components/fields/FormTouchSpin.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
import 'package:imperial_sheets/utils/customValidators.dart';
import 'package:imperial_sheets/utils/enums.dart';

class ArmorEditDialog extends StatelessWidget {
  ArmorEditDialog(this.armor, {this.isNew = false});
  final bool isNew;
  final Armor armor;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: isNew
          ? Text('Add armor')
          : DialogTitleWithButton(
              title: Text('Edit ${armor.name}'),
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).errorColor,
              ),
              onTap: () {
                Navigator.of(context).pop({'choice': DialogChoices.delete});
              },
            ),
      content: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FormBuilder(
              autovalidateMode: AutovalidateMode.always,
              key: _formKey,
              initialValue: {
                'title': armor.name,
                'description': armor.description,
                'weight': armor.weight.toString(),
                'head': armor.head.toString(),
                'leftArm': armor.leftArm.toString(),
                'rightArm': armor.rightArm.toString(),
                'body': armor.body.toString(),
                'leftLeg': armor.leftLeg.toString(),
                'rightLeg': armor.rightLeg.toString(),
                'amount': armor.amount,
                'stackable': armor.stackable,
              },
              child: Column(
                children: <Widget>[
                  FormTextField(
                    key: Key('field_title'),
                    name: "title",
                    label: 'Title',
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormTextField(
                    key: Key('field_description'),
                    name: "description",
                    label: 'Description',
                  ),
                  FormTextField(
                    key: Key('field_weight'),
                    name: "weight",
                    label: 'Weight per armor (kg)',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_head'),
                    name: "head",
                    label: 'Armor in head',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_leftArm'),
                    name: "leftArm",
                    label: 'Armor in left arm',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_rightArm'),
                    name: "rightArm",
                    label: 'Armor in right arm',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_body'),
                    name: "body",
                   label: 'Armor in body',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_leftLeg'),
                    name: "leftLeg",
                    label: 'Armor in left leg',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTextField(
                    key: Key('field_rightLeg'),
                    name: "rightLeg",
                   label: 'Armor in right leg',
                    validator: FormBuilderValidators.compose([
                      CustomValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormTouchSpin(
                    key: Key('field_amount'),
                    name: "amount",
                    decoration: InputDecoration(labelText: 'Amount'),
                    min: 0,
                    step: 1,
                  ),
                  FormSwitch(
                    key: Key('field_stackable'),
                    name: 'stackable',
                    label: 'This armor stacks',
                  )
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
              Navigator.of(context).pop({'choice': DialogChoices.cancel});
            }),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            if (_formKey.currentState.saveAndValidate()) {
              armor.name = _formKey.currentState.value['title'];
              armor.description = _formKey.currentState.value['description'];
              armor.weight = double.parse(
                  _formKey.currentState.value['weight'].replaceAll(',', '.'));
              armor.head = int.parse(_formKey.currentState.value['head']);
              armor.leftArm = int.parse(_formKey.currentState.value['leftArm']);
              armor.rightArm =
                  int.parse(_formKey.currentState.value['rightArm']);
              armor.body = int.parse(_formKey.currentState.value['body']);
              armor.leftLeg = int.parse(_formKey.currentState.value['leftLeg']);
              armor.rightLeg =
                  int.parse(_formKey.currentState.value['rightLeg']);
              armor.amount = _formKey.currentState.value['amount'];
              armor.stackable = _formKey.currentState.value['stackable'];
              Navigator.of(context).pop({
                'choice': DialogChoices.confirm,
                'payload': armor,
              });
            }
          },
        ),
      ],
    );
  }
}
