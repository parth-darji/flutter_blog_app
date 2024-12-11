import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/secrets/app_secrets.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repository/auth_repository.dart';
import 'features/auth/domain/usecases/user_signup.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    anonKey: AppSecrets.supabaseAnonKey,
    url: AppSecrets.supabaseUrl,
  );

  serviceLocator.registerFactory(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDataSources>(
    () => AuthRemoteDataSourcesImpl(serviceLocator()),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UserSignUp(serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(userSignUp: serviceLocator()),
  );
}
