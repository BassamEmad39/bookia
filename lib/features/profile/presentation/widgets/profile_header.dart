import 'package:bookia/core/services/shared_pref.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var userInfo = SharedPref.getUserInfo();
    return Row(
      children: [
        if (userInfo?.image?.isNotEmpty == true)
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: userInfo?.image ?? '',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userInfo?.name ?? 'Guest User',
              style: TextStyles.getTitle(fontSize: 22),
            ),
            Text(
              userInfo?.email ?? 'No Email',
              style: TextStyles.getSmall(fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }
}
