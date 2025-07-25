import 'dart:io';

import 'package:bookia/components/app_bar/main_app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/components/inputs/name_text_form_field.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/shared_pref.dart';
import 'package:bookia/features/profile/data/model/edit_profile_params.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  String? imagePath;
  String? imageUrl;

  @override
  void initState() {
    super.initState();
    var userInfo = SharedPref.getUserInfo();
    imageUrl = userInfo?.image;
    nameController.text = userInfo?.name ?? '';
    addressController.text = userInfo?.address ?? '';
    phoneController.text = userInfo?.phone ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            context.pop(true);
            context.pop(true);
            showSuccessDialog(context, 'Profile updated successfully');
          } else if (state is ProfileErrorState) {
            showErrorDialog(context, 'Something went wrong.');
          } else if (state is ProfileLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: MainAppBarWithBack(),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        if (imagePath != null)
                          ClipOval(
                            child: Image.file(
                              File(imagePath ?? ''),
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        if (imagePath == null && imageUrl?.isNotEmpty == true)
                          ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: imageUrl ?? '',
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        Positioned(
                          top: 100,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(AppAssets.cameraSvg),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    NameTextFormField(
                      controller: nameController,
                      hintText: 'Name',
                    ),
                    const SizedBox(height: 20),
                    NameTextFormField(
                      controller: addressController,
                      hintText: 'Address',
                    ),
                    const SizedBox(height: 20),
                    NameTextFormField(
                      controller: phoneController,
                      hintText: 'Phone',
                    ),
                    SizedBox(height: 20),
                    MainButton(
                      text: 'Save',
                      onPressed: () {
                        context.read<ProfileCubit>().editProfile(
                          EditProfileParams(
                            name: nameController.text,
                            address: addressController.text,
                            phone: phoneController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
