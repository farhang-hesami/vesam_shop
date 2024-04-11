import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:vesam_shop/screens/home/bloc/home_bloc.dart';
import 'package:vesam_shop/screens/home/widgast/home.slider.dart';
import 'package:vesam_shop/screens/home/widgast/products_list.dart';
import 'package:vesam_shop/screens/prouduct/latest_products.dart';
import 'package:vesam_shop/screens/prouduct/popular_products.dart';
import 'package:vesam_shop/utils/navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeSuccess) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 50.0),
              child: Column(
                children: [
                  HomeSlider(state.homeModel),
                  //1
                  ProductsList(
                    products: state.homeModel.news!,
                    title: 'جدیدترین محصولات',
                    seeAllProductsOnTap: () {
                      goScreen(
                        context: context,
                        screen: const LatstProductsScreen(),
                      );
                    },
                  ),
                  const Divider(),
                  //2
                  ProductsList(
                    products: state.homeModel.mostVisited!,
                    title: 'پربازدیدترین محصولات',
                    seeAllProductsOnTap: () {
                      goScreen(
                        context: context,
                        screen: const PopularProductsScreen(),
                      );
                    },
                  ),
                ],
              ),
            );
          } else if (state is HomeError) {
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
