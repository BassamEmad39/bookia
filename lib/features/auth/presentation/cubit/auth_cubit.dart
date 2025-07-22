import 'package:bookia/core/services/shared_pref.dart';
import 'package:bookia/features/auth/data/model/request/register_params.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/features/auth/data/repo/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final verifyCodeController = TextEditingController();
  final newPasswordController = TextEditingController();
  final newConfirmPasswordController = TextEditingController();
  RegisterParams params = RegisterParams();

  register() {
    emit(AuthLoadingState());
    params.name = nameController.text;
    params.email = emailController.text;
    params.password = passwordController.text;
    params.passwordConfirmation = confirmPasswordController.text;
    params.verifyCode = verifyCodeController.text;
    params.newPassword = newPasswordController.text;
    params.newPasswordConfirmation = newConfirmPasswordController.text;
    try {
      AuthRepo.register(params).then((value) {
        if (value != null) {
          SharedPref.setUserInfo(value.data?.user ?? User());
          SharedPref.setUserToken(value.data?.token ?? '');
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState());
        }
      });
    } on Exception catch (_) {
      emit(AuthErrorState());
    }
  }

  login() {
    emit(AuthLoadingState());
    params.email = emailController.text;
    params.password = passwordController.text;
    try {
      AuthRepo.login(params).then((value) {
        if (value != null) {
          SharedPref.setUserInfo(value.data?.user ?? User());
          SharedPref.setUserToken(value.data?.token ?? '');
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState());
        }
      });
    } on Exception catch (_) {
      emit(AuthErrorState());
    }
  }

  forgetPassword() {
    emit(AuthLoadingState());
    params.email = emailController.text;
    try {
      AuthRepo.forgetPassword(params).then((value) {
        if (value != null) {
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState());
        }
      });
    } on Exception catch (_) {
      emit(AuthErrorState());
    }
  }

  checkForgetPassword(String email) {
    emit(AuthLoadingState());
    params.email = email;
    params.verifyCode = verifyCodeController.text;
    try {
      AuthRepo.checkForgetPassword(params).then((value) {
        if (value != null) {
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState());
        }
      });
    } on Exception catch (_) {
      emit(AuthErrorState());
    }
  }

  resetPassword(String verifyCode) {
    emit(AuthLoadingState());
    params.verifyCode = verifyCode;
    params.newPassword = newPasswordController.text;
    params.newPasswordConfirmation = newConfirmPasswordController.text;
    try {
      AuthRepo.resetPassword(params).then((value) {
        if (value != null) {
          emit(AuthSuccessState());
        } else {
          emit(AuthErrorState());
        }
      });
    } on Exception catch (_) {
      emit(AuthErrorState());
    }
  }
}
