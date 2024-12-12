import 'package:flutter_blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:flutter_blog_app/features/auth/domain/usecases/user_login.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/user_signup.dart';
import 'features/blog/data/datasources/blog_remote_datasource.dart';
import 'features/blog/data/repositories/blog_repository_impl.dart';
import 'features/blog/domain/repositories/blog_repository.dart';
import 'features/blog/presentation/bloc/blog_bloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );

  serviceLocator.registerFactory(() => supabase.client);

  // core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    // datasources
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(serviceLocator()),
    )
    // repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(serviceLocator()),
    )
    // usecases
    ..registerFactory(
      () => UserSignUp(serviceLocator()),
    )
    ..registerFactory(
      () => UserLogin(serviceLocator()),
    )
    ..registerFactory(
      () => CurrentUser(serviceLocator()),
    )
    // bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    // datasources
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(serviceLocator()),
    )
    // repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(serviceLocator()),
    )
    // usecases
    ..registerFactory(
      () => UploadBlog(serviceLocator()),
    )
    // bloc
    ..registerLazySingleton(
      () => BlogBloc(serviceLocator()),
    );
}
