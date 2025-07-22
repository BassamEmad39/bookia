import 'dart:developer';

import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/components/dialogs/loading_dialog.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/widgets/cart_builder.dart';
import 'package:bookia/features/home/presentation/widgets/empty_data_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: Scaffold(
        appBar: AppBar(title: Text('Cart')),
        body: BlocConsumer<CartCubit, CartState>(
          listener: blocListener,
          builder: blocBuilder,
        ),
      ),
    );
  }

  void blocListener(BuildContext context, CartState state) {
    if (state is CartErrorState) {
      context.pop();
      showErrorDialog(context, 'An error occurred while fetching Cart');
    } else if (state is RemovedFromCartState) {
      context.pop();
      showSuccessDialog(context, 'Removed from Cart');
    } else if (state is RemoveFromCartLoadingState) {
      showLoadingDialog(context);
    } else if (state is CartItemUpdatedState) {
      log('Cart item updated successfully');
      context.pop();
    } else if (state is CheckOutDoneState) {
      context.pop();
      log('Successful');
    }
  }

  Widget blocBuilder(BuildContext context, CartState state) {
    var cubit = context.read<CartCubit>();

    if (cubit.cartResponse?.data?.cartItems?.isEmpty == true) {
      return EmptyDataUi(
        message: 'cart',
        icon: Icon(
          Icons.remove_shopping_cart_rounded,
          size: 100,
          color: AppColors.greyColor,
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: CartBuilder(
            books: cubit.cartResponse?.data?.cartItems ?? [],
            onRemove: (productId) {
              cubit.removeFromCart(productId);
            },
            onUpdateCart: (updateParams) {
              cubit.updateCart(updateParams);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Total: ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  Text(
                    '\$${cubit.cartResponse?.data?.total ?? 0}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Gap(10),
              MainButton(
                text: 'Checkout',
                onPressed: () {
                  cubit.checkoutOrder();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
