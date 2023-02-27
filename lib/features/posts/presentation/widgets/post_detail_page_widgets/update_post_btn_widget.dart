import '../../../domain/entities/post.dart';
import '../../pages/post_add_update_page.dart';
import 'package:flutter/material.dart';

class UpdatePostBtnWidget extends StatelessWidget {
  final Post post;

  const UpdatePostBtnWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostAddUpdatePage(isUpdate: true, post: post)));
      },
      icon: Icon(Icons.edit),
      label: Text("Edit"),
    );
  }
}
