import 'dart:developer';

import 'package:bookia/components/buttons/main_back_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    late String verifyCode;
    return BlocProvider(
      create: (context) => AuthCubit(),

      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.pop();
            context.pushWithReplacement(
              Routes.createNewPassword,
              extra: verifyCode,
            );
            showSuccessDialog(context, 'Email Verified');
            log('Registration successful');
          } else if (state is AuthErrorState) {
            context.pop();
            showErrorDialog(context, 'Registration failed. Please try again.');
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: MainBackButton(),
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Didn\'t receive code?'),
                  TextButton(onPressed: () {}, child: Text('Resend')),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'OTP Verification',
                        style: TextStyles.getHeadLine1(),
                      ),
                      Gap(10),
                      Text(
                        "Enter the verification code we just sent on your email address.",
                        style: TextStyles.getBody(color: AppColors.greyColor),
                      ),
                      Gap(30),
                      Center(
                        child: Pinput(
                          controller: cubit.verifyCodeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Field cannot be empty.';
                            }
                            return null;
                          },
                          defaultPinTheme: PinTheme(
                            margin: EdgeInsets.symmetric(horizontal: 8),
                            width: 70,
                            height: 60,
                            textStyle: TextStyles.getTitle(
                              color: AppColors.darkColor,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primaryColor,
                                width: 1.5,
                              ),
                            ),
                          ),
                          length: 6,
                          onCompleted: (pin) {},
                        ),
                      ),
                      Gap(38),
                      MainButton(
                        text: 'Verify',
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            verifyCode = cubit.verifyCodeController.text;
                            cubit.checkForgetPassword(email);
                          }
                        },
                      ),
                    ],
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
