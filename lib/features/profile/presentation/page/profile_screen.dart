import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/extensions/navigations.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_header.dart';
import 'package:bookia/features/profile/presentation/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void fetchData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is LogoutSuccessState) {
            context.pop();
            context.pushToBase(Routes.login);
          } else if (state is ProfileErrorState) {
            context.pop();
            showErrorDialog(context, 'An error occurred while logging out');
          } else if (state is ProfileLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Profile'),
              actions: [
                IconButton(
                  onPressed: () {
                    context.read<ProfileCubit>().logout();
                  },
                  icon: SvgPicture.asset(AppAssets.logoutSvg),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  ProfileHeader(),
                  Gap(20),
                  Column(
                    children: [
                      ProfileTile(label: 'My Orders', onPressed: () {}),
                      ProfileTile(
                        label: 'Edit Profile',
                        onPressed: () {
                          context.push(Routes.editProfile).then((value) {
                            if (value == true) {
                              fetchData();
                            }
                          });
                        },
                      ),
                      ProfileTile(
                        label: 'Reset Password',
                        onPressed: () {
                          context.push(Routes.resetPassword);
                        },
                      ),
                      ProfileTile(label: 'FAQ', onPressed: () {}),
                      ProfileTile(label: 'Contact Us', onPressed: () {}),
                      ProfileTile(label: 'Privacy & Terms', onPressed: () {}),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
