// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:uni_links/uni_links.dart';
import 'package:vesam_shop/main.dart';
import 'package:vesam_shop/screens/basket/bloc/basket_bloc.dart';
import 'package:vesam_shop/screens/basket/widgets/expandable.factor.dart';
import 'package:vesam_shop/screens/guest.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/snackbar.dart';

class BasketScreen extends StatefulWidget {
  const BasketScreen({super.key});

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  bool isFirstBuild = true;

  StreamSubscription? sub;

  @override
  void initState() {
    sub = getLinksStream().listen((event) {
      if (event != null && event == 'vesam://success_payment') {
        Navigator.pop(context);
        showCustomAlert(context, 'پرداخت شما با موفقیت انجام شد');
        BlocProvider.of<BasketBloc>(context).add(BasketPageStarted());
        BlocProvider.of<ProfileBloc>(context).add(UserPaymentsScreenStarted());
      }

      if (event != null && event == 'vesam://error_payment') {
        Navigator.pop(context);
        showCustomAlert(context, 'پرداخت شما با خطا روبرو شد', AlertType.error);
        BlocProvider.of<BasketBloc>(context).add(BasketPageStarted());
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'سبد خرید',
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: isLogin,
        builder: (context, value, child) {
          if (isLogin.value) {
            BlocProvider.of<BasketBloc>(context).add(BasketPageStarted());
          }
          //user
          if (value) {
            return BlocConsumer<BasketBloc, BasketState>(
              listener: (context, state) {
                if (state is AddProductToBasketSuccess) {
                  showCustomAlert(
                    context,
                    'این محصول با موفقیت به سبد خرید اضافه شد',
                  );
                  BlocProvider.of<BasketBloc>(context).add(BasketPageStarted());
                }
                if (state is DeleteProductFromBasketSuccess ||
                    state is IncrementProductSuccess ||
                    state is DecrementProductSuccess) {
                  BlocProvider.of<BasketBloc>(context).add(BasketPageStarted());
                }
              },
              buildWhen: (previous, current) {
                if (current is GetBasketSuccess ||
                    current is GetBasketError ||
                    (current is GetBasketError && isFirstBuild)) {
                  return true;
                }
                return false;
              },
              builder: (context, state) {
                if (state is GetBasketSuccess) {
                  isFirstBuild = false;
                  return state.basket.items!.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                'assets/images/empty_basket.svg',
                                width: 300.0,
                                height: 300.0,
                              ),
                              Text(
                                'سبد خرید شما خالی میباشد',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                padding: const EdgeInsets.fromLTRB(
                                    16.0, 0.0, 16.0, 100.0),
                                itemCount: state.basket.items!.length,
                                itemBuilder: (context, index) {
                                  var basketProduct =
                                      state.basket.items![index];
                                  return Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            'https://flutter.vesam24.com/${basketProduct.productImage}',
                                        width: 80.0,
                                        height: 80.0,
                                        placeholder: (context, url) =>
                                            const Center(
                                          child: CupertinoActivityIndicator(),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                      const SizedBox(width: 12.0),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    basketProduct.productTitle!,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .bodySmall,
                                                  ),
                                                ),
                                                IconButton(
                                                  padding: EdgeInsets.zero,
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  splashRadius: 1.0,
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                  onPressed: () {
                                                    BlocProvider.of<BasketBloc>(
                                                            context)
                                                        .add(
                                                      DeleteProductFromBasket(
                                                          basketProduct
                                                              .productId!),
                                                    );
                                                  },
                                                  icon: const Icon(Icons
                                                      .delete_outline_outlined),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 12.0),
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      basketProduct
                                                                  .discountPercent! >
                                                              0
                                                          ? Text(
                                                              '${basketProduct.price!.toStringAsFixed(0).seRagham()} تومان',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall
                                                                  ?.copyWith(
                                                                      decoration:
                                                                          TextDecoration
                                                                              .lineThrough,
                                                                      letterSpacing:
                                                                          0.0),
                                                            )
                                                          : Text(
                                                              '',
                                                              style: Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelSmall,
                                                            ),
                                                      basketProduct.discountPercent! >
                                                              0
                                                          ? Text(
                                                              '${basketProduct.finalPrice!.toStringAsFixed(0).seRagham()} تومان')
                                                          : Text(
                                                              '${basketProduct.price!.toStringAsFixed(0).seRagham()} تومان'),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 110.0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:
                                                            AppColors
                                                                .kPrimary500,
                                                        foregroundColor:
                                                            AppColors.kWhite,
                                                        child: IconButton(
                                                          splashRadius: 1.0,
                                                          iconSize: 15.0,
                                                          onPressed: () {
                                                            BlocProvider.of<
                                                                        BasketBloc>(
                                                                    context)
                                                                .add(
                                                              IncrementProduct(
                                                                  basketProduct
                                                                      .productId!),
                                                            );
                                                          },
                                                          icon: const Icon(
                                                              Icons.add),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width: 16.0),
                                                      Text(
                                                        basketProduct.count
                                                            .toString(),
                                                      ),
                                                      const SizedBox(
                                                          width: 16.0),
                                                      CircleAvatar(
                                                        radius: 15.0,
                                                        backgroundColor:
                                                            basketProduct
                                                                        .count ==
                                                                    1
                                                                ? AppColors
                                                                    .kGray50
                                                                : AppColors
                                                                    .kGray100,
                                                        foregroundColor:
                                                            AppColors.kGray900,
                                                        child: IconButton(
                                                          splashRadius: 1.0,
                                                          iconSize: 15.0,
                                                          onPressed: basketProduct
                                                                      .count! ==
                                                                  1
                                                              ? null
                                                              : () {
                                                                  BlocProvider.of<
                                                                              BasketBloc>(
                                                                          context)
                                                                      .add(
                                                                    DecrementProduct(
                                                                        basketProduct
                                                                            .productId!),
                                                                  );
                                                                },
                                                          icon: const Icon(
                                                              Icons.remove),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const Divider();
                                },
                              ),
                            ),
                            ExpandableFactor(state.basket),
                          ],
                        );
                } else if (state is GetBasketError) {
                  return Center(
                    child: Text(state.error),
                  );
                } else {
                  return const Center(
                    child: CupertinoActivityIndicator(),
                  );
                }
              },
            );
          }
          //guest
          else {
            return const GuestScreen();
          }
        },
      ),
    );
  }
}
