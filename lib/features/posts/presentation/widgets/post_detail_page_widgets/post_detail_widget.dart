import '../../../domain/entities/post.dart';
import 'delete_post_btn_widget.dart';
import 'update_post_btn_widget.dart';
import 'package:flutter/material.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8),
        child: Column(children: [
          Text(
            post.title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(fontSize: 16),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostBtnWidget(post: post),
              DeletePostBtnWidget(postId: post.id!)
            ],
          )
        ]));
  }
}
