import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/pages/post_add_update_page.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/post_list_widget.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/widgets/message_display_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clean_architecture_posts_app/core/widgets/loading_widget.dart';

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingbtn(context),
    );
  }

  AppBar _buildAppBar() => AppBar(
        title: Text("Posts"),
      );

  Widget _buildBody() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is LoadingPostsState) {
              return LoadingWidget();
            } else if (state is LoadedPostsState) {
              return RefreshIndicator(
                  child: PostListWidget(
                    posts: state.posts,
                  ),
                  onRefresh: () => _onRefresh(context));
            } else if (state is ErrorPostsState) {
              return MessageDisplayWidget(message: state.message);
            }
            //not necessary but needed to remove return type error of the _buildBody function
            return LoadingWidget();
          },
        ));
  }

  FloatingActionButton _buildFloatingbtn(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => PostAddUpdatePage(isUpdate: false)));
      },
      child: Icon(Icons.add),
    );
  }

  Future<void> _onRefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }
}
