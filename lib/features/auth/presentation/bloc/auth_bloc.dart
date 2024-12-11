import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/user_signup.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;

  AuthBloc({
    required UserSignUp userSignUp,
  })  : _userSignUp = userSignUp,
        super(AuthInitial()) {
    on<AuthSignUp>(
      (event, emit) async {
        emit(AuthLoading());
        final res = await _userSignUp(
          UserSignUpParams(
            name: event.name,
            email: event.email,
            password: event.password,
          ),
        );

        res.fold(
          (failure) {
            emit(AuthFailure(failure.message));
          },
          (user) {
            emit(AuthSuccess(user));
          },
        );
      },
    );
  }
}
