// ignore_for_file: non_constant_identifier_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/local/favorite_product_manager.dart';
import 'package:vesam_shop/screens/prouduct/product_detail.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class FavoriteProductScreen extends StatefulWidget {
  const FavoriteProductScreen({super.key});

  @override
  State<FavoriteProductScreen> createState() => _FavoriteProductScreenState();
}

class _FavoriteProductScreenState extends State<FavoriteProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لیست مورد علاقه ها'),
      ),
      body: ValueListenableBuilder(
          valueListenable:
              FavoriteProductManager.favoriteProductBox.listenable(),
          builder: (context, Product, chaild) {
            return Product.values.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/favorite.svg',
                          width: 25.0,
                          height: 250.0,
                        ),
                        Text(
                          'لیست مورد علاقه های شما خالی می باشد',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 50.0),
                    itemCount: Product.length,
                    itemBuilder: (context, index) {
                      var product = Product.values.toList()[index];
                      return GestureDetector(
                        onTap: () {
                          goScreen(
                            context: context,
                            screen: ProudctDetailScreen(product),
                            fullScreen: true,
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://flutter.vesam24.com/${product.image}',
                              width: 70.0,
                              height: 70.0,
                              placeholder: (context, url) => const Center(
                                child: CupertinoActivityIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            const SizedBox(width: 12.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 6.0),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            product.hasDiscount!
                                                ? Text(
                                                    '${product.price!.toStringAsFixed(0).seRagham()} تومان',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall
                                                        ?.copyWith(
                                                            decoration:
                                                                TextDecoration
                                                                    .lineThrough,
                                                            letterSpacing: 0.0),
                                                  )
                                                : Text(
                                                    '',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelSmall,
                                                  ),
                                            product.hasDiscount!
                                                ? Text(
                                                    '${product.discountPrice!.toStringAsFixed(0).seRagham()} تومان')
                                                : Text(
                                                    '${product.price!.toStringAsFixed(0).seRagham()} تومان'),
                                          ],
                                        ),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: AppColors.kAlert50,
                                        foregroundColor: AppColors.kGray900,
                                        child: IconButton(
                                          splashRadius: 1.0,
                                          onPressed: () async {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    title: Text(
                                                      ' آیا مطمنید حذف کنید؟',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .bodyLarge,
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                              onPressed:
                                                                  () async {
                                                                Navigator.pop(
                                                                    context);
                                                                await product
                                                                    .delete();
                                                              },
                                                              child: const Text(
                                                                  'بله')),
                                                          const SizedBox(
                                                              width: 10),
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: const Text(
                                                                  'خیر')),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: const Icon(Icons.delete),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                  );
          }),
    );
  }
}
