import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failures.dart';
import 'package:flutter_blog_app/core/network/connection_checker.dart';
import 'package:flutter_blog_app/features/auth/data/datasources/auth_remote_data_sources.dart';
import 'package:flutter_blog_app/core/common/entities/user.dart';
import 'package:flutter_blog_app/features/auth/data/models/user_model.dart';

import 'package:fpdart/fpdart.dart';

import '../../domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSources;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.remoteDataSources, this.connectionChecker);

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      if (!await connectionChecker.isConnected) {
        final session = remoteDataSources.currentUserSession;

        if (session == null) {
          return left(Failure(message: "User not logged in!"));
        }

        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? "",
            name: "",
          ),
        );
      }

      final user = await remoteDataSources.getCurrentUserData();

      if (user == null) {
        return left(Failure(message: "User not logged in!"));
      }

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await remoteDataSources.loginWithEmailPassword(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    return await _getUser(
      () async => await remoteDataSources.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      ),
    );
  }

  Future<Either<Failure, User>> _getUser(
    Future<User> Function() fn,
  ) async {
    try {
      if (!await connectionChecker.isConnected) {
        return left(
          Failure(message: "No internet connection!"),
        );
      }

      final user = await fn();

      return right(user);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
