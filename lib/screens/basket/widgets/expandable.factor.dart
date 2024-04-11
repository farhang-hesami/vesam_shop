import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/modeels/basket.dart';
import 'package:vesam_shop/screens/basket/payment.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/navigator.dart';

class ExpandableFactor extends StatefulWidget {
  const ExpandableFactor(
    this.basket, {
    super.key,
  });
  final Basket basket;

  @override
  State<ExpandableFactor> createState() => _ExpandableFactorState();
}

class _ExpandableFactorState extends State<ExpandableFactor> {
  bool isEXpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEXpanded = !isEXpanded;
        });
      },
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 12.0,
        ),
        height: isEXpanded ? 180.0 : 110.0,
        decoration: const BoxDecoration(
          color: AppColors.kWhite,
          boxShadow: [BoxShadow(color: AppColors.kGray200, blurRadius: 2.0)],
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              Row(
                children: [
                  isEXpanded
                      ? const Icon(Icons.keyboard_arrow_down_outlined)
                      : const Icon(Icons.keyboard_arrow_up_outlined),
                  Expanded(
                      child: isEXpanded
                          ? const Text('بستن فاکتور')
                          : const Text('مشاهده فاکتور')),
                  isEXpanded
                      ? const SizedBox()
                      : Text(
                          '${widget.basket.totalDiscountPrice!.toStringAsFixed(0).seRagham()} تومان',
                        ),
                ],
              ),
              isEXpanded
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'جمع کل',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.kGray400,
                                    ),
                              ),
                            ),
                            Text(
                              '${widget.basket.totalPrice!.toStringAsFixed(0).seRagham()}  تومان',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'مبلغ تخفیف',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.kGray400,
                                    ),
                              ),
                            ),
                            Text(
                                '${widget.basket.totalDiscountPrice!.toStringAsFixed(0).seRagham()}  تومان'),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'مبلغ نهایی',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                      color: AppColors.kGray400,
                                    ),
                              ),
                            ),
                            Text(
                                '${widget.basket.totalFinalPrice!.toStringAsFixed(0).seRagham()}  تومان'),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.only(top: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    goScreen(context: context, screen: const PaymentScreen());
                  },
                  child: const Text('تکمیل خرید'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
