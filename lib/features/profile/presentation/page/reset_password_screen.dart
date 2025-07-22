import 'package:bookia/components/app_bar/main_app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/name_text_form_field.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is UpdatePasswordSuccessState) {
            context.pop();
            showSuccessDialog(context, 'Password updated successfully');
          } else if (state is UpdatePasswordErrorState) {
            context.pop();
            showErrorDialog(context, 'Failed to update password');
          } else if (state is ProfileLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<ProfileCubit>();
          return Scaffold(
            appBar: MainAppBarWithBack(),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Gap(20),
                    Text('New Password', style: TextStyles.getHeadLine1()),
                    Gap(60),
                    NameTextFormField(
                      hintText: 'Current Password',
                      controller: cubit.currentPasswordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    NameTextFormField(
                      hintText: 'New Password',
                      controller: cubit.newPasswordController,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                    NameTextFormField(
                      hintText: 'Confirm New Password',
                      controller: cubit.newPasswordConfirmationController,
                      isPassword: true,
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: MainButton(
                    borderRadius: 5,
                    text: 'Update Password',
                    onPressed: () {
                      cubit.updatePassword();
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
