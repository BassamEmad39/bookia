import 'package:bookia/features/auth/presentation/page/create_new_password_screen.dart';
import 'package:bookia/features/auth/presentation/page/forgot_password_screen.dart';
import 'package:bookia/features/auth/presentation/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/page/otp_screen.dart';
import 'package:bookia/features/auth/presentation/page/register_screen.dart';
import 'package:bookia/features/auth/presentation/page/success_screen.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/pages/book_details_screen.dart';
import 'package:bookia/features/intro/page/splash_screen.dart';
import 'package:bookia/features/intro/page/welcome_screen.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/profile/presentation/page/edit_profile_screen.dart';
import 'package:go_router/go_router.dart';

class Routes {
  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgotPassword';
  static const String otp = '/otp';
  static const String createNewPassword = '/createNewPassword';
  static const String success = '/success';
  static const String main = '/main';
  static const String details = '/details';
  static const String editProfile = '/editProfile';

  static final routers = GoRouter(
    routes: [
      GoRoute(path: splash, builder: (context, state) => const SplashScreen()),
      GoRoute(
        path: welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(path: login, builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: otp,
        builder: (context, state) => OtpScreen(email: state.extra as String),
      ),
      GoRoute(
        path: createNewPassword,
        builder:
            (context, state) =>
                CreateNewPasswordScreen(verifyCode: state.extra as String),
      ),
      GoRoute(path: success, builder: (context, state) => SuccessScreen()),
      GoRoute(path: main, builder: (context, state) => MainAppScreen()),
      GoRoute(
        path: details,
        builder: (context, state) {
          return BookDetailsScreen(product: state.extra as Product);
        },
      ),
      GoRoute(path: editProfile, builder: (context, state) => const EditProfileScreen()),
    ],
  );
}
