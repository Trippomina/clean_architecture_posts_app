import '../../../../../core/utils/snack_bar_message.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import '../../pages/posts_page.dart';
import 'delete_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeletePostBtnWidget extends StatelessWidget {
  final int postId;

  const DeletePostBtnWidget({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        _deleteDialog(context);
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.redAccent)),
      icon: Icon(Icons.delete_outline),
      label: Text("Delete"),
    );
  }

  void _deleteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<AddDeleteUpdatePostBloc,
              AddDeleteUpdatePostState>(
            listener: (context, state) {
              if (state is MessageDeleteUpdatePostState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => PostsPage()),
                    (route) => false);
              }
              if (state is ErrorAddDeleteUpdatePostState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingAddDeleteUpdatePostState) {
                return AlertDialog(
                  title: LoadingWidget(),
                );
              }
              return DeleteDialogWidget(postId: postId);
            },
          );
        });
  }
}
