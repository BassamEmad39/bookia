import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({super.key, required this.label, required this.onPressed});
  final String label;
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0xff8A959E).withValues(alpha: 0.2),
            blurRadius: 40,
            offset: Offset(0, 7),
          ),
        ],
      ),
      child: Row(
        children: [
          Text(label, style: TextStyles.getTitle()),
          Spacer(),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.arrow_forward_ios, size: 20),
          ),
        ],
      ),
    );
  }
}
