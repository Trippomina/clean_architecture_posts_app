import '../../../../core/error/failures.dart';
import '../repositories/posts_repositories.dart';
import 'package:dartz/dartz.dart';

class DeletePostUseCase {
  final PostsRepository repository;

  DeletePostUseCase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}
