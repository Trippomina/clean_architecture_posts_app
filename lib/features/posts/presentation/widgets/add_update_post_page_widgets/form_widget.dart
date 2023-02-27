import '../../../domain/entities/post.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'form_submit_btn.dart';
import 'text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            TextFormFieldWidget(
                name: "Title", multiline: false, controller: _titleController),
            TextFormFieldWidget(
                name: "Body", multiline: true, controller: _bodyController),
            FormSubmitBtn(
                isUpdate: widget.isUpdate,
                onPressed: validateFormThenUpdateOrAddPost)
          ]),
    );
  }

  void validateFormThenUpdateOrAddPost() {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      final post = Post(
          id: widget.isUpdate ? widget.post!.id : null,
          title: _titleController.text,
          body: _bodyController.text);
      if (widget.isUpdate) {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(UpdatePostEvent(post: post));
      } else {
        BlocProvider.of<AddDeleteUpdatePostBloc>(context)
            .add(AddPostEvent(post: post));
      }
    }
  }
}
