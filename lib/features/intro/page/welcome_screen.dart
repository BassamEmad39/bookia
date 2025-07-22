import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/media_query.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.welcomeBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  Gap(context.height * 0.15),
                  SvgPicture.asset(AppAssets.logoSvg),
                  Gap(10),
                  Text('Order Your Book Now!', style: TextStyles.getTitle()),
                  Spacer(),
                  MainButton(
                    text: 'Login',
                    onPressed: () {
                      context.push(Routes.login);
                    },
                    textColor: AppColors.whiteColor,
                  ),
                  Gap(15),
                  MainButton(
                    bgColor: AppColors.whiteColor,
                    text: 'Register',
                    borderColor: AppColors.darkColor,
                    onPressed: () {
                      context.push(Routes.register);
                    },
                    textColor: AppColors.darkColor,
                  ),
                  Gap(context.height * 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
