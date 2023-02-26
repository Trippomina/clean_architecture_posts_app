import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdate;
  final void Function() onPressed;

  const FormSubmitBtn(
      {super.key, required this.isUpdate, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: isUpdate ? Icon(Icons.edit) : Icon(Icons.add),
        label: Text(isUpdate ? "Update" : "Add"));
  }
}
