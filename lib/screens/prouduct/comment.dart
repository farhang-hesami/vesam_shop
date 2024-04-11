import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vesam_shop/data/modeels/product.dart';
import 'package:vesam_shop/screens/prouduct/bloc/product_bloc.dart';
import 'package:vesam_shop/theme.dart';
import 'package:vesam_shop/utils/snackbar.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen(this.productId, {super.key});

  final int productId;

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is SendProductCommentSuccess) {
            BlocProvider.of<ProductBloc>(context)
                .add(ProductDetailPageStarted(widget.productId));
            showCustomAlert(
              context,
              'نظر شما با موفقیت ثبت شد',
            );
          }
        },
        builder: (context, state) {
          return Container(
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
            height: 85.0,
            padding: const EdgeInsets.fromLTRB(16.0, 15.0, 16.0, 25.0),
            child: ElevatedButton(
              onPressed: () {
                if (formkey.currentState!.validate()) {
                  BlocProvider.of<ProductBloc>(context).add(
                    SendProductComment(
                      Comments(
                        productId: widget.productId,
                        subject: subjectController.text,
                        text: textController.text,
                      ),
                    ),
                  );
                }
              },
              child: const Text('ثبت نظر'),
            ),
          );
        },
      ),
      appBar: AppBar(
        title: const Text('ثبت نظر'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: subjectController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'وارد کردن متن عنوان اجباری میباشد';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(labelText: 'عنوان'),
              ),
              const SizedBox(
                height: 12.0,
              ),
              TextFormField(
                controller: textController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'وارد کردن متن نظر اجباری میباشد';
                  }
                  return null;
                },
                textInputAction: TextInputAction.done,
                maxLines: 5,
                decoration: const InputDecoration(
                  labelText: 'نظر',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
