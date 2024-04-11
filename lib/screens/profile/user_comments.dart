import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vesam_shop/data/modeels/home.dart';
import 'package:vesam_shop/screens/profile/bloc/profile_bloc.dart';
import 'package:vesam_shop/screens/prouduct/product_detail.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/date_formater.dart';
import 'package:vesam_shop/utils/navigator.dart';

class UserCommentsScreen extends StatefulWidget {
  const UserCommentsScreen({super.key});

  @override
  State<UserCommentsScreen> createState() => _UserCommentsScreenState();
}

class _UserCommentsScreenState extends State<UserCommentsScreen> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(UserCommentsScreenStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('نظرات من'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is UserCommentsSuccess) {
            return state.userComments.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/comments.svg',
                          width: 250.0,
                          height: 250.0,
                        ),
                        Text(
                          'شما نظری ثبت نکردید!',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 50.0),
                    itemCount: state.userComments.length,
                    itemBuilder: (context, index) {
                      var comment = state.userComments[index];
                      return GestureDetector(
                        onTap: () {
                          goScreen(
                            context: context,
                            screen: ProudctDetailScreen(
                                Product(id: comment.productId)),
                            fullScreen: true,
                          );
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://flutter.vesam24.com/${comment.productImage}',
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
                                    comment.productTitle!,
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Text(
                                    '${converDateAndTime(comment.createDate!).$2} - ${converDateAndTime(comment.createDate!).$1}',
                                    style:
                                        Theme.of(context).textTheme.labelSmall,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: AppColors.kGray50,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          comment.subject!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall
                                              ?.copyWith(
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                        Text(comment.text!),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 6.0),
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
          } else if (state is UserCommentsError) {
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
