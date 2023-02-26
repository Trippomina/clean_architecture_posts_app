import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool multiline;
  final String name;
  const TextFormFieldWidget(
      {super.key,
      required this.controller,
      required this.multiline,
      required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: TextFormField(
          controller: controller,
          validator: (val) => val!.isEmpty ? name + " can't be empty" : null,
          decoration: InputDecoration(hintText: name),
          minLines: multiline ? 6 : 1,
          maxLines: multiline ? 6 : 1,
        ));
  }
}
