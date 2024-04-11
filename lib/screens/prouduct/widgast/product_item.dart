import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/local/favorite_product_manager.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/prouduct/product_detail.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class Productitem extends StatelessWidget {
  const Productitem({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 170.0,
          child: GestureDetector(
            onTap: () {
              goScreen(
                context: context,
                screen: ProudctDetailScreen(product),
                fullScreen: true,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Column(
              children: [
                SizedBox(
                  width: 170.0,
                  height: 160.0,
                  child: CachedNetworkImage(
                    imageUrl: 'https://flutter.vesam24.com/${product.image}',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CupertinoActivityIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                SizedBox(
                    width: 170.0,
                    child: Text(
                      product.title!,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall,
                    )),
                const SizedBox(
                  height: 15.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          product.hasDiscount!
                              ? Text(
                                  '${product.price!.toStringAsFixed(0).seRagham()} تومان',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                          decoration:
                                              TextDecoration.lineThrough,
                                          letterSpacing: 0.0),
                                )
                              : Text(
                                  '',
                                  style: Theme.of(context).textTheme.labelSmall,
                                ),
                          product.hasDiscount!
                              ? Text(
                                  '${product.discountPrice!.toStringAsFixed(0).seRagham()} تومان')
                              : Text(
                                  '${product.price!.toStringAsFixed(0).seRagham()} تومان'),
                        ],
                      ),
                    ),
                    ValueListenableBuilder(
                        valueListenable: isLogin,
                        builder: (context, value, child) {
                          return value
                              ? CircleAvatar(
                                  backgroundColor: AppColors.kPrimary500,
                                  foregroundColor: AppColors.kWhite,
                                  radius: 18.0,
                                  child: IconButton(
                                    onPressed: () {
                                      BlocProvider.of<BasketBloc>(context)
                                          .add(AddProductToBasket(product.id!));
                                    },
                                    icon: const Icon(
                                      Icons.add,
                                      size: 18.0,
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 10.0,
          right: 10.0,
          child: ValueListenableBuilder(
            valueListenable:
                FavoriteProductManager.favoriteProductBox.listenable(),
            builder: (context, value, child) {
              return GestureDetector(
                onTap: () async {
                  if (FavoriteProductManager.isInBox(product)) {
                    await FavoriteProductManager.deleteProduct(product);
                  } else {
                    await FavoriteProductManager.addProduct(product);
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Container(
                  height: 35.0,
                  width: 35.0,
                  decoration: const BoxDecoration(
                      color: AppColors.kWhite,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.kGray100,
                          blurRadius: 1.0,
                          spreadRadius: 1.0,
                        ),
                      ]),
                  child: Icon(
                    FavoriteProductManager.isInBox(product)
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    size: 20.0,
                    color: FavoriteProductManager.isInBox(product)
                        ? AppColors.kAlert500
                        : AppColors.kGray800,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
