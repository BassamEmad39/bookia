import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class EmptyDataUi extends StatelessWidget {
  const EmptyDataUi({super.key, required this.message, required this.icon});
  final String message;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Gap(20),
          Text('Your $message is empty', style: TextStyles.getTitle()),
        ],
      ),
    );
  }
}
