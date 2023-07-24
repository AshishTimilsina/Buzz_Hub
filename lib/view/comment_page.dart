import 'package:buzzhub/providers/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/post.dart';
import '../providers/common_provider.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class CommentPage extends ConsumerWidget {
  final Post post;
  final types.User user;
  CommentPage(this.post, this.user, {super.key});
  final titlectrl = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, ref) {
    final mode = ref.watch(modeprovider);

    return Scaffold(
        body: ListView(children: [
      SafeArea(
          child: Form(
              key: _form,
              autovalidateMode: mode,
              child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromRGBO(244, 129, 121, 1),
                      Color.fromRGBO(242, 97, 120, 1),
                      Color.fromRGBO(238, 95, 118, 1),
                    ],
                  )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 35),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: const DecorationImage(
                                    image:
                                        AssetImage('assets/images/icon.png'))),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          'Add Comment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: TextFormField(
                            style: const TextStyle(color: Colors.white),
                            onFieldSubmitted: (val) {
                              if (val.isNotEmpty) {
                                ref.read(crudprovider.notifier).commentPost(
                                    postId: post.postid,
                                    comment: Comment(
                                        userNames: user.firstName!,
                                        userimage: user.imageUrl!,
                                        usercomment: val));
                              }
                            },
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  style: BorderStyle.solid,
                                  color: Colors.white,
                                )),
                                hintText: 'Add comment',
                                hintStyle: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ]))))
    ]));
  }
}
