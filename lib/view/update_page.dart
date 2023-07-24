import 'dart:io';
import 'package:buzzhub/constants/fluttertoast.dart';
import 'package:buzzhub/providers/auth_provider.dart';
import 'package:buzzhub/providers/crud_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../models/post.dart';
import '../providers/common_provider.dart';

class UpdatePage extends ConsumerStatefulWidget {
  const UpdatePage(this.post, {super.key});
  final Post post;

  @override
  ConsumerState<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends ConsumerState<UpdatePage> {
  TextEditingController detailctrl = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    detailctrl.text = widget.post.detail;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(crudprovider, (previous, next) {
      if (next.isSuccess) {
        Navigator.of(context).pop();
        FlutterToast.showsuccess(message: 'Success');
      } else if (next.isError) {
        FlutterToast.showerror(message: next.errmessage);
      }
    });
    final mode = ref.watch(modeprovider);
    final image = ref.watch(imageprovider);
    final auth = ref.watch(authProvideRS);

    return Scaffold(
      body: ListView(
        children: [
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
                                image: AssetImage('assets/images/icon.png'))),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text(
                      'Update post',
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
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          style: const TextStyle(color: Colors.white),
                          validator: (val) {
                            if (val!.isEmpty) {
                              return 'detail is required';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(
                              color: Colors.white,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.white60,
                              ),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            prefixIcon: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 30,
                              child: Icon(
                                Icons.details,
                                color: Color.fromRGBO(238, 95, 118, 1),
                              ),
                            ),
                            hintText: "Caption here",
                            hintStyle: const TextStyle(color: Colors.white),
                          ),
                          controller: detailctrl),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: GestureDetector(
                        onTap: () {
                          Get.defaultDialog(
                              title: 'Choose From',
                              content: SizedBox(
                                height: 100,
                                width: 100,
                                child: Column(
                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        ref
                                            .read(imageprovider.notifier)
                                            .pickimage(true);
                                      },
                                      child: const Text('Camera'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                        ref
                                            .read(imageprovider.notifier)
                                            .pickimage(false);
                                      },
                                      child: const Text('Gallery'),
                                    )
                                  ],
                                ),
                              ));
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                          ),
                          child: image == null
                              ? Image.network(widget.post.imageurl)
                              : Image.file(File(image.path)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        const CircularProgressIndicator();
                        auth.isLoad ? null : _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          if (image == null) {
                            ref.read(crudprovider.notifier).updatePost(
                                  detail: detailctrl.text.trim(),
                                  id: widget.post.postid,
                                );
                          } else {
                            ref.read(crudprovider.notifier).updatePost(
                                  detail: detailctrl.text.trim(),
                                  id: widget.post.postid,
                                  imageId: widget.post.imageId,
                                  image: image,
                                );

                            FocusScope.of(context).unfocus();
                          }
                        } else {
                          ref.read(modeprovider.notifier).change();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30)),
                          child: auth.isLoad
                              ? const CircularProgressIndicator()
                              : const Center(
                                  child: Text(
                                    'Confirm Post ',
                                    style: TextStyle(
                                      color: Color.fromRGBO(238, 95, 118, 1),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
