import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/widgets/empty_data_ui.dart';
import 'package:bookia/features/home/presentation/widgets/wishlist_builder.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WhishlistScreen extends StatelessWidget {
  const WhishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistCubit()..getWishlist(),
      child: Scaffold(
        appBar: AppBar(title: Text('Wishlist')),
        body: BlocConsumer<WishlistCubit, WishlistState>(
          listener: blocListener,
          builder: blocBuilder,
        ),
      ),
    );
  }

  void blocListener(BuildContext context, WishlistState state) {
    if (state is WishlistErrorState) {
      context.pop();
      showErrorDialog(context, 'An error occurred while fetching wishlist');
    } else if (state is RemovedFromWishlistState) {
      context.pop();
      showSuccessDialog(context, 'Removed from wishlist');
    } else if (state is RemoveFromWishlistLoadingState) {
      showLoadingDialog(context);
    } else if (state is AddedToCartState) {
      context.pop();
      showSuccessDialog(context, 'Added to cart');
    }
  }

  Widget blocBuilder(BuildContext context, WishlistState state) {
    var cubit = context.read<WishlistCubit>();

    if (cubit.wishlistResponse?.data?.data?.isEmpty ?? true) {
      return EmptyDataUi(
        message: 'wishlist',
        icon: Icon(
          Icons.not_interested_rounded,
          size: 100,
          color: AppColors.greyColor,
        ),
      );
    }

    return WishlistBuilder(
      books: cubit.wishlistResponse?.data?.data ?? [],
      onRemove: (productId) {
        cubit.removeFromWishlist(productId);
      },
      onAddToCart: (productId) {
        cubit.addToCart(productId);
      },
    );
  }
}
