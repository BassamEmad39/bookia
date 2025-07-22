import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.successSvg, width: 100, height: 100),
            Gap(35),
            Text('Password Changed', style: TextStyles.getHeadLine1()),
            Gap(5),
            Text(
              "Your password has been changed successfully.",
              style: TextStyles.getBody(color: AppColors.greyColor),
            ),
            Gap(40),
            MainButton(
              text: 'Back to Login',
              onPressed: () {
                context.pushWithReplacement(Routes.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
