import 'dart:io';
import 'package:buzzhub/constants/fluttertoast.dart';
import 'package:buzzhub/providers/auth_provider.dart';
import 'package:buzzhub/view/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/common_provider.dart';

class Signuppage extends ConsumerWidget {
  Signuppage({super.key});
  final usernamectrl = TextEditingController();
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvideRS, (previous, next) {
      if (next.isSuccess) {
        Get.to(() => Loginpage());
        FlutterToast.showsuccess(message: 'Success');
      } else if (next.isError) {
        FlutterToast.showerror(message: next.errmessage);
      }
    });
    final mode = ref.watch(modeprovider);
    final image = ref.watch(imageprovider);
    final pass = ref.watch(passwordHide);
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
                      'BuzzHub',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Think, Explore, Meet',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      'SIGNUP PAGE',
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
                        controller: usernamectrl,
                        keyboardType: TextInputType.text,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Username must not be empty';
                          } else if (val.length < 3) {
                            return 'Please Provide correct username';
                          }
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
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
                              Icons.person_2_outlined,
                              color: Color.fromRGBO(238, 95, 118, 1),
                            ),
                          ),
                          hintText: "Your name",
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Email is required';
                          } else if (!RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(val)) {
                            return 'Invalid Email';
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
                              Icons.email_outlined,
                              color: Color.fromRGBO(238, 95, 118, 1),
                            ),
                          ),
                          hintText: "Email Address",
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        controller: emailctrl,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        style: const TextStyle(color: Colors.white),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return ' Password cannot be empty';
                          } else if (val.length < 8) {
                            return 'Password must be atleast of 8 characters';
                          }
                          return null;
                        },
                        textAlign: TextAlign.center,
                        obscureText: pass ? true : false,
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
                              Icons.key,
                              color: Color.fromRGBO(238, 95, 118, 1),
                            ),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                ref.read(passwordHide.notifier).state =
                                    !ref.read(passwordHide.notifier).state;
                              },
                              icon: pass
                                  ? const Icon(
                                      Icons.lock,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.lock_open_outlined,
                                      color: Colors.white,
                                    )),
                          hintText: "Password",
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        controller: passwordctrl,
                      ),
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
                              ? const Center(child: Text('Please Insert image'))
                              : Image.file(File(image.path)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        auth.isLoad ? null : _form.currentState!.save();
                        if (_form.currentState!.validate()) {
                          if (image == null) {
                            FlutterToast.showerror(
                                message: "Please insert an image");
                          } else {
                            ref.read(authProvideRS.notifier).usersignup(
                                email: emailctrl.text.trim(),
                                password: passwordctrl.text.trim(),
                                username: usernamectrl.text.trim(),
                                image: image);
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
                          child: const Center(
                            child: Text(
                              'Sign Up',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already have an account ?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.to(() => Loginpage(),
                                transition: Transition.leftToRight);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
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
