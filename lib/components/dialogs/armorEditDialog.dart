import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_fields/form_builder_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:imperial_sheets/components/misc/dialogTitleWithButton.dart';
import 'package:imperial_sheets/models/equipment.dart';
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
                  FormBuilderTextField(
                    key: Key('field_title'),
                    name: "title",
                    decoration: InputDecoration(labelText: 'Title'),
                    validator: FormBuilderValidators.required(context),
                  ),
                  FormBuilderTextField(
                    key: Key('field_description'),
                    name: "description",
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  FormBuilderTextField(
                    key: Key('field_weight'),
                    name: "weight",
                    decoration:
                        InputDecoration(labelText: 'Weight per armor (kg)'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_head'),
                    name: "head",
                    decoration: InputDecoration(labelText: 'Armor in head'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_leftArm'),
                    name: "leftArm",
                    decoration: InputDecoration(labelText: 'Armor in left arm'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_rightArm'),
                    name: "rightArm",
                    decoration:
                        InputDecoration(labelText: 'Armor in right arm'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_body'),
                    name: "body",
                    decoration: InputDecoration(labelText: 'Armor in body'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_leftLeg'),
                    name: "leftLeg",
                    decoration: InputDecoration(labelText: 'Armor in left leg'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTextField(
                    key: Key('field_rightLeg'),
                    name: "rightLeg",
                    decoration:
                        InputDecoration(labelText: 'Armor in right leg'),
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.numeric(context),
                      FormBuilderValidators.required(context),
                    ]),
                  ),
                  FormBuilderTouchSpin(
                    key: Key('field_amount'),
                    name: "amount",
                    initialValue: armor.amount,
                    decoration: InputDecoration(labelText: 'Amount'),
                    min: 0,
                    step: 1,
                  ),
                  FormBuilderSwitch(
                    key: Key('field_stackable'),
                    name: 'stackable',
                    initialValue: armor.stackable,
                    title: Text('This armor stacks'),
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
