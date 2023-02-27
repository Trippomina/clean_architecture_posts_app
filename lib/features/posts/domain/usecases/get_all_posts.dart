import '../../../../core/error/failures.dart';
import '../entities/post.dart';
import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase {
  final PostsRepository repository;

  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}
