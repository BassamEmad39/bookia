import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:bookia/features/home/data/model/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class WishlistBuilder extends StatelessWidget {
  const WishlistBuilder({
    super.key,
    required this.books,
    required this.onRemove,
    required this.onAddToCart,
  });

  final List<Product> books;
  final Function(int) onRemove;
  final Function(int) onAddToCart;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(20),
      itemCount: books.length,
      separatorBuilder: (context, index) {
        return Gap(20);
      },
      itemBuilder: (context, index) {
        var book = books[index];
        return Row(
          children: [
            Hero(
              tag: index,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: book.image ?? '',
                  fit: BoxFit.cover,
                  width: 100,
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          book.name ?? 'Unknown Book',
                          maxLines: 2,
                          style: TextStyles.getTitle(),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          onRemove(book.id ?? 0);
                        },
                        icon: SvgPicture.asset(AppAssets.closeSvg),
                      ),
                    ],
                  ),
                  Text('\$${book.price}', style: TextStyles.getBody()),
                  Gap(10),
                  MainButton(
                    text: 'Add to Cart',
                    onPressed: () {
                      onAddToCart(book.id ?? 0);
                    },
                    width: 250,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
