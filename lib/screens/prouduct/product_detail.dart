// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/local/favorite_product_manager.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/prouduct/bloc/product_bloc.dart';
import 'package:vesam_shop/screens/prouduct/comment.dart';
import 'package:vesam_shop/screens/prouduct/widgast/product_expandabel_text.dart';
import 'package:vesam_shop/screens/prouduct/widgast/product_image_slider.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class ProudctDetailScreen extends StatefulWidget {
  final Product product;

  const ProudctDetailScreen(this.product, {super.key});

  @override
  State<ProudctDetailScreen> createState() => _ProudctDetailScreenState();
}

class _ProudctDetailScreenState extends State<ProudctDetailScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context)
        .add(ProductDetailPageStarted(widget.product.id!));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'جزئیات محصول',
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(fontWeight: FontWeight.w700),
        ),
        actions: [
          ValueListenableBuilder(
            valueListenable:
                FavoriteProductManager.favoriteProductBox.listenable(),
            builder: (context, value, child) {
              return IconButton(
                onPressed: () async {
                  if (FavoriteProductManager.isInBox(widget.product)) {
                    await FavoriteProductManager.deleteProduct(widget.product);
                  } else {
                    await FavoriteProductManager.addProduct(widget.product);
                  }
                },
                icon: Icon(
                  FavoriteProductManager.isInBox(widget.product)
                      ? Icons.favorite
                      : Icons.favorite_border_outlined,
                  size: 20.0,
                  color: FavoriteProductManager.isInBox(widget.product)
                      ? AppColors.kAlert500
                      : AppColors.kGray800,
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is GetPorductDetailSuccess) {
                var product = state.productDetailModel;
                return Stack(
                  children: [
                    Positioned.fill(
                      child: SingleChildScrollView(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 100.0),
                        child: Column(
                          children: [
                            ProductImageSlider(product),
                            const SizedBox(
                              height: 12.0,
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                product.title!,
                                style: Theme.of(context)
                                    .textTheme
                                    .displayMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 6.0,
                            ),
                            ProductExpandableText(product),
                            const SizedBox(
                              height: 6.0,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'نظرات کاربران',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                ValueListenableBuilder(
                                  valueListenable: isLogin,
                                  builder: (context, value, child) {
                                    return value
                                        ? TextButton(
                                            onPressed: () {
                                              goScreen(
                                                context: context,
                                                screen:
                                                    CommentScreen(product.id!),
                                              );
                                            },
                                            child: Text(
                                              'ثبت نظر',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall
                                                  ?.copyWith(
                                                    color: AppColors.kInfo500,
                                                  ),
                                            ),
                                          )
                                        : const SizedBox();
                                  },
                                )
                              ],
                            ),
                            product.comments!.isEmpty
                                ? Center(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/comments.svg',
                                          width: 150.0,
                                          height: 150.0,
                                        ),
                                        const Text('نظری ثبت نشده است ...'),
                                      ],
                                    ),
                                  )
                                : ListView.separated(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      var comment = product.comments![index];
                                      return SizedBox(
                                        height: 100.0,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                  comment.subject!,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )),
                                                Text(
                                                  comment.userEmail!,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 6.0,
                                            ),
                                            Text(
                                              comment.text!,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodySmall,
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return const Divider();
                                    },
                                    itemCount: product.comments!.length,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        padding:
                            const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 20.0),
                        width: MediaQuery.of(context).size.width,
                        height: 70.0,
                        decoration: const BoxDecoration(
                          color: AppColors.kWhite,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.kGray100,
                              blurRadius: 8.0,
                              offset: Offset(0.0, 0.75),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder(
                              valueListenable: isLogin,
                              builder: (context, value, child) {
                                return SizedBox(
                                  height: 45.0,
                                  child: ElevatedButton(
                                    onPressed: value
                                        ? () {
                                            BlocProvider.of<BasketBloc>(context)
                                                .add(AddProductToBasket(
                                                    product.id!));
                                          }
                                        : null,
                                    child: const Text(
                                      'افزودن به سبد خرید',
                                    ),
                                  ),
                                );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (state is GetProductDetailError) {
                return Center(
                  child: Text(state.error),
                );
              } else {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
