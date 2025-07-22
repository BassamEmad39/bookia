import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppAssets.successSvg, width: 150, height: 150),
            Gap(35),
            Text('SUCCESS!', style: TextStyles.getHeadLine1(fontSize: 36)),
            Gap(5),
            Text(
              "Your order will be delivered soon.",
              style: TextStyles.getBody(color: AppColors.greyColor),
            ),
            Gap(5),
            Text(
              "Thank you for choosing our app.",
              style: TextStyles.getBody(color: AppColors.greyColor),
            ),
            Gap(60),
            MainButton(
              text: 'Back to Home',
              onPressed: () {
                context.pushWithReplacement(Routes.main);
              },
            ),
          ],
        ),
      ),
    );
  }
}
