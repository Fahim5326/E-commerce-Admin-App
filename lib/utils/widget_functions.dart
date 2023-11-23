import 'package:flutter/material.dart';

showMsg(BuildContext context, String msg) =>
  ScaffoldMessenger.of(context)
    .showSnackBar(SnackBar(content: Text(msg)));

showSingleTextInputDialogue({
  required BuildContext context,
  required String title,
  String posBtnTxt = 'SAVE',
  String negBtnTxt = 'CANCEL',
  required Function(String) onSave,
}) {
  final controller = TextEditingController();
  showDialog(context: context, builder: (context) => AlertDialog(
    title: Text(title),
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        autofocus: true,
      ),
    ),
    actions: [
      TextButton(
          onPressed: () {
            if(controller.text.isEmpty) return;
            Navigator.pop(context);
            onSave(controller.text);
          },
          child: Text(posBtnTxt),
      ),
    ],
  ));
}