import 'package:flutter/material.dart';
import 'package:vesam_shop/data/modeels/product.dart';
import 'package:vesam_shop/theme.dart';

class ProductExpandableText extends StatefulWidget {
  const ProductExpandableText(this.productDetailModel, {super.key});

  final ProductDetailModel productDetailModel;

  @override
  State<ProductExpandableText> createState() => _ProductExpandableTextState();
}

class _ProductExpandableTextState extends State<ProductExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      curve: Curves.fastOutSlowIn,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'توضیحات محصول',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(
              height: 6.0,
            ),
            Text(
              widget.productDetailModel.description!,
              maxLines: isExpanded ? null : 2,
              textAlign: TextAlign.justify,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.kGray600,
                  ),
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isExpanded ? 'بستن' : 'مشاهده بیشتر',
                      style: const TextStyle(
                        color: AppColors.kInfo500,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    isExpanded
                        ? const Icon(
                            Icons.keyboard_arrow_up_outlined,
                            color: AppColors.kInfo500,
                          )
                        : const Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: AppColors.kInfo500,
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
