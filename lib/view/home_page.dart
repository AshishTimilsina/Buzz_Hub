import 'package:buzzhub/providers/crud_provider.dart';
import 'package:buzzhub/services/auth_service.dart';
import 'package:buzzhub/services/crud_service.dart';
import 'package:buzzhub/view/add_page.dart';
import 'package:buzzhub/view/detail_page.dart';
import 'package:buzzhub/view/recent_chats.dart';
import 'package:buzzhub/view/update_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../providers/auth_provider.dart';
// import 'comment_page.dart';
import 'login_page.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  String? yourname;
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final uid = FirebaseAuth.instance.currentUser!.uid;
        final postdataa = ref.watch(postdata);
        final singleuserdata =
            ref.watch(singleuser(FirebaseAuth.instance.currentUser!.uid));
        final multipleuserdata = ref.watch(multipleuser);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color.fromRGBO(242, 97, 120, 1),
          ),
          drawer: Drawer(
            child: singleuserdata.whenOrNull(
              data: (data) {
                yourname = data.firstName;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: ListView(
                    children: [
                      DrawerHeader(
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                data.imageUrl.toString(),
                              ),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(data.firstName.toString()),
                      ),
                      ListTile(
                        onTap: () async {
                          Get.offAll(() => Loginpage());
                        },
                        leading: const Icon(Icons.email),
                        title: Text(data.metadata!['email'].toString()),
                      ),
                      ListTile(
                        onTap: () async {
                          Get.to(() => AddPage());
                        },
                        leading: const Icon(Icons.post_add),
                        title: const Text('Create Post'),
                      ),
                      ListTile(
                        onTap: () {
                          Get.to(() => const Recentchat());
                        },
                        leading: const Icon(Icons.message),
                        title: const Text('recent chats'),
                      ),
                      ListTile(
                        onTap: () async {
                          ref.read(authProvideRS.notifier).userlogout();
                          Get.offAll(() => Loginpage());
                        },
                        leading: const Icon(Icons.logout),
                        title: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                height: 110,
                child: multipleuserdata.when(
                    data: (data) {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(11),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => DetailPage(
                                            user: data[index],
                                          ));
                                    },
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          data[index].imageUrl.toString()),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    error: (error, stack) {
                      return Text(error.toString());
                    },
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        )),
              ),
              Expanded(
                child: Card(
                  elevation: 2,
                  child: postdataa.when(
                      data: (data) {
                        return ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        uid == data[index].userid
                                            ? CircleAvatar(
                                                maxRadius: 35,
                                                backgroundImage: NetworkImage(
                                                    singleuserdata
                                                        .value!.imageUrl
                                                        .toString()),
                                              )
                                            : CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                  multipleuserdata.value!
                                                      .elementAt(index - 1)
                                                      .imageUrl
                                                      .toString(),
                                                ),
                                                maxRadius: 35,
                                              ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        uid == data[index].userid
                                            ? Text(
                                                singleuserdata.value!.firstName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              )
                                            : Text(
                                                multipleuserdata.value!
                                                    .elementAt(index - 1)
                                                    .firstName
                                                    .toString(),
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                        const Spacer(),
                                        uid == data[index].userid
                                            ? IconButton(
                                                onPressed: () {
                                                  Get.defaultDialog(
                                                      title: 'Customize Post',
                                                      content: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Get.to(() =>
                                                                    UpdatePage(data[
                                                                        index]));
                                                              },
                                                              icon: const Icon(
                                                                  Icons.edit)),
                                                          IconButton(
                                                              onPressed: () {
                                                                ref.read(crudprovider.notifier).removePost(
                                                                    postId: data[
                                                                            index]
                                                                        .postid,
                                                                    imageId: data[
                                                                            index]
                                                                        .imageId);
                                                              },
                                                              icon: const Icon(
                                                                  Icons
                                                                      .delete)),
                                                          IconButton(
                                                              onPressed: () {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                              },
                                                              icon: const Icon(
                                                                  Icons.close)),
                                                        ],
                                                      ));
                                                },
                                                icon: const Icon(
                                                    Icons.more_horiz))
                                            : Container()
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      data[index].detail,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Image(
                                      image: NetworkImage(data[index].imageurl),
                                      height: 250,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                    FirebaseAuth.instance.currentUser!.uid !=
                                            data[index].userid
                                        ? Row(
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    // if (data[index]
                                                    //     .like
                                                    //     .username
                                                    //     .contains(yourname)) {
                                                    //   ////
                                                    // } else {
                                                    //   ref
                                                    //       .read(crudprovider
                                                    //           .notifier)
                                                    //       .likePost(
                                                    //           postId:
                                                    //               data[index]
                                                    //                   .postid,
                                                    //           like: data[index]
                                                    //                   .like
                                                    //                   .likes +
                                                    //               1,
                                                    //           name: yourname!);
                                                    // }
                                                  },
                                                  icon: const Icon(
                                                    FontAwesomeIcons.heart,
                                                    size: 30,
                                                  )),
                                              const SizedBox(width: 5),
                                              IconButton(
                                                  onPressed: () {
                                                    // Get.to(() => CommentPage(
                                                    //       data[index],
                                                    //     ));
                                                  },
                                                  icon: const Icon(
                                                    FontAwesomeIcons.comment,
                                                    size: 30,
                                                  )),
                                              const SizedBox(width: 5),
                                              IconButton(
                                                onPressed: () {},
                                                icon: const Icon(
                                                  Icons.send_outlined,
                                                  size: 30,
                                                ),
                                              ),
                                              const Spacer(),
                                              IconButton(
                                                  onPressed: () {},
                                                  icon: const Icon(
                                                    Icons.bookmark_add_outlined,
                                                    size: 30,
                                                  ))
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              );
                            });
                      },
                      error: (error, stack) {
                        return Text(error.toString());
                      },
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          )),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
