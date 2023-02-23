import 'package:clean_architecture_posts_app/core/network/network_info.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_local_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/datasources/post_remote_data_source.dart';
import 'package:clean_architecture_posts_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/add_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/delete_post.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/get_all_posts.dart';
import 'package:clean_architecture_posts_app/features/posts/domain/usecases/update_post.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/add_delete_update_post/add_delete_update_post_bloc.dart';
import 'package:clean_architecture_posts_app/features/posts/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
//Features -> posts

//Bloc
  //register factory for the bloc because I might need more than one object of that bloc
  sl.registerFactory(() => PostsBloc(getAllPostsUseCase: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addPostUseCase: sl(), updatePostUseCase: sl(), deletePostUseCase: sl()));
//UseCases
  //register lazy singleton for the use case because I need to use the same instance multiple times
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUseCase(sl()));
  sl.registerLazySingleton(() => DeletePostUseCase(sl()));

//Repository
  //same as use cases
  sl.registerLazySingleton(() => PostRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));
//DataSource
  sl.registerLazySingleton(() => PostRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton(
      () => PostLocalDataSourceImpl(sharedPreferences: sl()));

  ///Core
  sl.registerLazySingleton(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());

  ///External
  sl.registerLazySingleton(() => http.Client());
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
