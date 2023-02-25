import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:flutter/material.dart';

class FormWidget extends StatefulWidget {
  final bool isUpdate;
  final Post? post;

  const FormWidget({super.key, required this.isUpdate, this.post});

  @override
  State<FormWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<FormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdate) {
      _titleController.text = widget.post!.title;
      _bodyController.text = widget.post!.body;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(),
            TextField(),
            TextButton(onPressed: () {}, child: Text("hi"))
          ]),
    );
  }
}
