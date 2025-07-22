import 'package:bookia/components/app_bar/main_app_bar_with_back.dart';
import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is AddedToWishlistCartState) {
            context.pop();
            showSuccessDialog(context, state.message);
          } else if (state is HomeErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text('Error occurred')));
          } else if (state is HomeLoadingState) {
            showLoadingDialog(context);
          }
        },
        builder:
            (context, state) => Scaffold(
              appBar: MainAppBarWithBack(
                action: IconButton(
                  onPressed: () {
                    context.read<HomeCubit>().addToWishList(product.id ?? 0);
                  },
                  icon: SvgPicture.asset(AppAssets.bookmarkSvg),
                ),
              ),
              body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        Hero(
                          tag: product.id ?? '',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: product.image ?? '',
                              fit: BoxFit.cover,
                              width: 200,
                            ),
                          ),
                        ),
                        Gap(15),
                        Text(
                          '${product.name}',
                          style: TextStyles.getHeadLine1(),
                        ),
                        Gap(10),
                        Text(
                          product.category ?? '',
                          style: TextStyles.getBody(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        Gap(15),
                        Text(
                          product.description ?? '',
                          style: TextStyles.getSmall(
                            color: AppColors.darkColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              bottomNavigationBar: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${product.price}',
                        style: TextStyles.getHeadLine2(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(30),
                      Expanded(
                        child: MainButton(
                          borderRadius: 5,
                          bgColor: AppColors.darkColor,
                          text: 'Add to Cart',
                          onPressed: () {
                            context.read<HomeCubit>().addToCart(
                              product.id ?? 0,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      ),
    );
  }
}
