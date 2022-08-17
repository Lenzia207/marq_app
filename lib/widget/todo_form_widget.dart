//import 'dart:html';
import 'package:flutter/material.dart';

class TodoFormWidget extends StatelessWidget {
  //Fields
  final String title;
  final String description;

  //Callbacks
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;
  final VoidCallback onSaveTodo;

//Constructor
  const TodoFormWidget(
      {Key? key,
      this.title = '',
      this.description = '',
      required this.onChangedTitle,
      required this.onChangedDescription,
      required this.onSaveTodo})
      : super(key: key);

  get onPressed => null;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildTitle(),
            const SizedBox(height: 3),
            buildDescription(),
            const SizedBox(height: 8),
            buildSaveBtn()
          ],
        ),
      );

  //buildTitle Method for the Title/Überschrift Form Field
  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        onChanged: onChangedTitle,

        //check validator in Dialog Widget
        validator: (title) {
          if (title!.isEmpty) {
            return 'Bitte trage eine Überschrift ein';
          }
        },
        decoration: InputDecoration(
            border: UnderlineInputBorder(), labelText: 'Überschrift'),
      );

  Widget buildDescription() => TextFormField(
        maxLines: 2,
        initialValue: description,
        onChanged: onChangedDescription,
        decoration: const InputDecoration(
            border: UnderlineInputBorder(), labelText: 'Beschreibung'),
      );

  Widget buildSaveBtn() => SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.green)),
          onPressed: () {
            onSaveTodo();
          },
          child: const Text('Speichern')));
}
