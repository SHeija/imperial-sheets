import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:imperial_sheets/components/common/infoChips.dart';
import 'package:imperial_sheets/components/common/speedTable.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:imperial_sheets/providers/characterModel.dart';
import 'package:provider/provider.dart';

class InfoContainer extends StatelessWidget {
  InfoContainer(this.character);
  final Character character;
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  // Dialog
  Future<void> _showEditDialog(BuildContext context) async {
    final result = await showDialog<dynamic>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return (AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            // title: Text(stat.name),
            content: SingleChildScrollView(
                child: Column(
              children: <Widget>[
                FormBuilder(
                  key: _formKey,
                  initialValue: {
                    'name': character.name,
                    'description': character.description,
                    'hp': character.hp.toString(),
                    'damage': character.damage.toString(),
                    'xp': character.xp.toString(),
                    'spentXp': character.spentXp.toString(),
                    'faith': character.faith.toString(),
                    'currentFaith': character.currentFaith.toString(),
                    'insanity': character.insanity.toString(),
                    'corruption': character.corruption.toString(),
                    'fatigue': character.fatigue.toString(),
                  },
                  child: Column(
                    children: <Widget>[
                      FormBuilderTextField(
                        attribute: "name",
                        decoration: InputDecoration(labelText: "Name"),
                      ),
                      FormBuilderTextField(
                        attribute: "description",
                        decoration: InputDecoration(labelText: "Description"),
                      ),
                      FormBuilderTextField(
                        attribute: "hp",
                        decoration: InputDecoration(labelText: "HP"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(99),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "damage",
                        decoration: InputDecoration(labelText: "Damage taken"),
                        validators: [
                          FormBuilderValidators.numeric(),
                          FormBuilderValidators.max(99),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "xp",
                        decoration: InputDecoration(labelText: "Total XP"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "spentXp",
                        decoration: InputDecoration(labelText: "Spent XP"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "faith",
                        decoration:
                            InputDecoration(labelText: "Total faith points"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "currentFaith",
                        decoration:
                            InputDecoration(labelText: "Current faith points"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "insanity",
                        decoration: InputDecoration(labelText: "Insanity"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "corruption",
                        decoration: InputDecoration(labelText: "Corruption"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                      FormBuilderTextField(
                        attribute: "fatigue",
                        decoration: InputDecoration(labelText: "Fatigue"),
                        validators: [
                          FormBuilderValidators.numeric(),
                        ],
                        valueTransformer: (v) => int.parse(v),
                      ),
                    ],
                  ),
                ),
              ],
            )),
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
                    character.name = _formKey.currentState.value['name'];
                    character.description = _formKey.currentState.value['description'];
                    character.hp = _formKey.currentState.value['hp'];
                    character.damage = _formKey.currentState.value['damage'];
                    character.xp = _formKey.currentState.value['xp'];
                    character.spentXp = _formKey.currentState.value['spentXp'];
                    character.faith = _formKey.currentState.value['faith'];
                    character.currentFaith = _formKey.currentState.value['currentFaith'];
                    character.insanity = _formKey.currentState.value['insanity'];
                    character.corruption = _formKey.currentState.value['corruption'];
                    character.fatigue = _formKey.currentState.value['fatigue'];
                    Navigator.of(context).pop(character);
                  }
                },
              ),
            ],
          ));
        });

    if (result != null) {
      Provider.of<CharacterModel>(context, listen: false).updateInfo(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return (GestureDetector(
        onLongPress: () => _showEditDialog(context),
        child: Container(
            child: Card(
                child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12.0),
                  child: Text(character.name,
                      style: Theme.of(context).textTheme.headline5),
                ),
                Container(
                    padding: EdgeInsets.all(12.0),
                    child: Text(character.description,
                        style: Theme.of(context).textTheme.bodyText2),
                ),
                InfoChips(character),
              ],
            )))));
  }
}
