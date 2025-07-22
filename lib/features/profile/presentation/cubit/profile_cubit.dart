import 'package:bookia/core/services/shared_pref.dart';
import 'package:bookia/features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/features/profile/data/model/edit_profile_params.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController newPasswordConfirmationController =
      TextEditingController();

  logout() {
    emit(ProfileLoadingState());
    ProfileRepo.logout().then((value) {
      if (value) {
        SharedPref.removeUserData();
        emit(LogoutSuccessState());
      } else {
        emit(ProfileErrorState());
      }
    });
  }

  editProfile(EditProfileParams params) {
    emit(ProfileLoadingState());
    ProfileRepo.editProfile(params).then((value) {
      if (value != null) {
        SharedPref.setUserInfo(value.data ?? User());
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState());
      }
    });
  }

  updatePassword() {
    emit(ProfileLoadingState());
    ProfileRepo.updatePassword(
      currentPasswordController.text,
      newPasswordController.text,
      newPasswordConfirmationController.text,
    ).then((value) {
      if (value) {
        emit(UpdatePasswordSuccessState());
      } else {
        emit(UpdatePasswordErrorState());
      }
    });
  }
}
