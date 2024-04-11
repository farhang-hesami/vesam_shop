import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vesam_shop/screens/prouduct/widgast/product_item.dart';
import 'package:vesam_shop/screens/prouduct/bloc/product_bloc.dart';

class PopularProductsScreen extends StatefulWidget {
  const PopularProductsScreen({super.key});

  @override
  State<PopularProductsScreen> createState() => _PopularProductsScreenState();
}

class _PopularProductsScreenState extends State<PopularProductsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProductBloc>(context).add(PopularProductsPageStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/images/logo.svg'),
          const SizedBox(
            width: 8.0,
          ),
          const Text('وسام شاپ'),
        ],
      )),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state is GetPopularPrductSuccess) {
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'پر بازدیدترین محصولات',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Expanded(
                      child: GridView.builder(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    itemCount: state.productModel.products!.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: 250.0,
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 50.0,
                    ),
                    itemBuilder: (context, index) {
                      var product = state.productModel.products![index];
                      return Center(child: Productitem(product: product));
                    },
                  )),
                ],
              ),
            );
          } else if (state is GePopulartPrductError) {
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
    );
  }
}
