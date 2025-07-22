import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class SocialLogin extends StatelessWidget {
  const SocialLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        socialCard(AppAssets.fbLogoSvg),
        Gap(10),
        socialCard(AppAssets.googleLogoSvg),
        Gap(10),
        socialCard(AppAssets.appleLogoSvg),
      ],
    );
  }

  Widget socialCard(String imagePath) {
    return Expanded(
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Center(
          child: SvgPicture.asset(imagePath, width: 26, height: 26),
        ),
      ),
    );
  }
}
