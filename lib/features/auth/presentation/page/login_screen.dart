import 'package:bookia/components/buttons/main_back_button.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/name_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/extensions/validations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/features/auth/presentation/widgets/social_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.pushToBase(Routes.main);
            showSuccessDialog(context, 'Login Successful');
          } else if (state is AuthErrorState) {
            context.pop();
            showErrorDialog(context, 'Login failed. Please try again.');
          } else if (state is AuthLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<AuthCubit>();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: MainBackButton(),
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don\'t have an account?'),
                  TextButton(
                    onPressed: () {
                      context.pushWithReplacement(Routes.register);
                    },
                    child: Text('Register Now'),
                  ),
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
                        'Welcome back! Glad to see you, Again!',
                        style: TextStyles.getHeadLine1(),
                      ),
                      Gap(30),
                      NameTextFormField(
                        hintText: 'Enter your email',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          } else if (!isEmailValid(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },

                        controller: cubit.emailController,
                      ),
                      Gap(15),
                      NameTextFormField(
                        controller: cubit.passwordController,
                        hintText: 'Enter your password',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your password';
                          }
                          return null;
                        },
                        suffixIcon: Center(
                          child: IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(AppAssets.eyeSvg),
                          ),
                        ),
                      ),
                      Gap(10),
                      TextButton(
                        onPressed: () {
                          context.pushWithReplacement(Routes.forgotPassword);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.getBody(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                      Gap(30),
                      MainButton(
                        text: 'Login',
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.login();
                          }
                        },
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Gap(10),
                          Text('Or Login With'),
                          Gap(10),
                          Expanded(child: Divider()),
                        ],
                      ),
                      Gap(20),
                      SocialLogin(),
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
