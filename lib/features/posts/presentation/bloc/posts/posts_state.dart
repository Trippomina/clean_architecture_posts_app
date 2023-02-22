part of 'posts_bloc.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

class PostsInitial extends PostsState {}
//how to decide what states you have?
//1-when you enter the app you need to wait for the posts to get loaded (loading)
//2-some error might occur and you wont get your posts (failure/error)
//3-if you got your data than the state should hold the data (posts)

class LoadingPostsState extends PostsState {}

class LoadedPostsState extends PostsState {
  final List<Post> posts;

  LoadedPostsState({required this.posts});

  @override
  List<Object> get props => [posts];
}

class ErrorPostsState extends PostsState {
  final String message;

  ErrorPostsState({required this.message});

  @override
  List<Object> get props => [message];
}
