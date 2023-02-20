// ignore_for_file: prefer_const_constructors

import 'package:clean_architecture_posts_app/core/error/exceptions.dart';
import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/modals/post_model.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_posts_app/core/error/failures.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

//instead of writing: Future<Either<Failure, Unit> _getMessage(Future<Unit> Function() deleteOrUpdateOrAddPost) async{....}
//declare a typedef for Future<Unit> Function()
typedef DeleteOrUpdateOrAddPost = Future<Unit> Function();

class PostRepositoryImpl implements PostsRepository {
  final PostRemoteDataSource remoteDataSource;
  final PostLocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  PostRepositoryImpl(
      this.remoteDataSource, this.localDataSource, this.networkInfo);

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    //convert post entity (domain layer) to post model (data layer)
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int id) async {
    return await _getMessage(() {
      return remoteDataSource.deletePost(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    //convert post entity (domain layer) to post model (data layer)
    final PostModel postModel =
        PostModel(id: post.id, title: post.title, body: post.body);
    return await _getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  Future<Either<Failure, Unit>> _getMessage(
      DeleteOrUpdateOrAddPost deleteOrUpdateOrAddPost) async {
    if (await networkInfo.isConnected) {
      try {
        await deleteOrUpdateOrAddPost();
        return Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
