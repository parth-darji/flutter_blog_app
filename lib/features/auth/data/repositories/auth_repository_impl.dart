import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failures.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_blog_app/features/auth/domain/entities/user.dart';

import 'package:fpdart/fpdart.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;

  AuthRepositoryImpl(this.remoteDataSources);

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final user = await remoteDataSources.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
