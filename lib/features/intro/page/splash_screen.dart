import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/services/shared_pref.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    String token = SharedPref.getUserToken();
    Future.delayed(const Duration(seconds: 2), () {
      if (token.isNotEmpty) {
        // ignore: use_build_context_synchronously
        context.pushWithReplacement(Routes.main);
      } else {
        // ignore: use_build_context_synchronously
        context.pushWithReplacement(Routes.welcome);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.logoSvg),
            Gap(10),
            Text('Order Your Book Now!', style: TextStyles.getTitle()),
          ],
        ),
      ),
    );
  }
}
