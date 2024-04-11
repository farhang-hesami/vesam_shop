import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/data/modeels/user.dart';
import 'package:vesam_shop/screens/prouduct/product_detail.dart';
import 'package:vesam_shop/utils/date_formater.dart';
import 'package:vesam_shop/utils/navigator.dart';

class UserPaymentDetailsScreen extends StatefulWidget {
  const UserPaymentDetailsScreen(this.userPayments, {super.key});
  final UserPayments userPayments;

  @override
  State<UserPaymentDetailsScreen> createState() =>
      _UserPaymentDetailsScreenState();
}

class _UserPaymentDetailsScreenState extends State<UserPaymentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' جزیات فاکتور${widget.userPayments.factorCode}'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 50.0),
        itemCount: widget.userPayments.invoiceDetails!.length,
        itemBuilder: (context, index) {
          var paymentDetail = widget.userPayments.invoiceDetails![index];
          return GestureDetector(
            onTap: () {
              goScreen(
                context: context,
                screen: ProudctDetailScreen(
                  Product(
                    id: paymentDetail.productId,
                  ),
                ),
                fullScreen: true,
              );
            },
            behavior: HitTestBehavior.opaque,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl:
                      'https://flutter.vesam24.com/${paymentDetail.productImage}',
                  fit: BoxFit.cover,
                  width: 100.0,
                  height: 100.0,
                  placeholder: (context, url) => const Center(
                    child: CupertinoActivityIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        paymentDetail.productTitle!,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تعداد',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '${paymentDetail.count} عدد',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'تاریخ خرید',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '${converDateAndTime(widget.userPayments.createDate!).$2} - ${converDateAndTime(widget.userPayments.createDate!).$1}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'قیمت نهایی',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          Text(
                            '${paymentDetail.finalPrice!.toStringAsFixed(0).seRagham()} تومان',
                            style: Theme.of(context).textTheme.bodySmall,
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
      ),
    );
  }
}
