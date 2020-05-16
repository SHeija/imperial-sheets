import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:imperial_sheets/components/dialogs/confirmDialog.dart';
import 'package:imperial_sheets/models/character.dart';
import 'package:imperial_sheets/database/hiveProvider.dart';

class NotesView extends StatefulWidget {
  NotesView({Key key}) : super(key: key);
  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  bool _editing = false;

  void _toggleEditing() {
    setState(() {
      _editing = !_editing;
    });
  }

  @override
  Widget build(BuildContext context) {
    Character character = HiveProvider.of(context).getActiveCharacter();
    String notes = character.notes;

    Widget _editToggleButton() {
      return _editing
          ? IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.saveAndValidate()) {
                  character.notes = _formKey.currentState.value['notes'];
                  character.save();
                  _toggleEditing();
                }
              },
            )
          : IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                _toggleEditing();
              },
            );
    }

    Widget _undoButton() {
      return _editing
          ? IconButton(
              icon: Icon(Icons.undo),
              onPressed: () {
                _formKey.currentState.reset();
              },
            )
          : Container();
    }

    Widget getEditingForm() {
      return FormBuilder(
        key: _formKey,
        initialValue: {
          "notes": notes,
        },
        child: SizedBox(
          height: 400,
          child: FormBuilderTextField(
            attribute: "notes",
          ),
        ),
      );
    }

    return CustomScrollView(
      primary: false,
      slivers: <Widget>[
        SliverAppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                final result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ConfirmDialog(
                        child: Text('Clear notes?'),
                      );
                    });
                if (result) {
                  _toggleEditing();
                  character.notes = '';
                  character.save();
                }
              },
            ),
            _undoButton(),
            _editToggleButton(),
          ],
        ),
        SliverPadding(
          padding: EdgeInsets.all(8.0),
          sliver: SliverFillRemaining(
            child: Container(
              child: _editing
                  ? getEditingForm()
                  : Markdown(data: notes.toString()),
            ),
          ),
        )
      ],
    );
  }
}
