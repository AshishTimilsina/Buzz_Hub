import 'package:buzzhub/constants/fluttertoast.dart';
import 'package:buzzhub/providers/auth_provider.dart';
import 'package:buzzhub/view/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../providers/common_provider.dart';
import 'home_page.dart';

class Loginpage extends ConsumerWidget {
  Loginpage({super.key});
  final emailctrl = TextEditingController();
  final passwordctrl = TextEditingController();
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, ref) {
    ref.listen(authProvideRS, (previous, next) {
      if (next.isError) {
        FlutterToast.showerror(message: next.errmessage);
      } else if (next.isSuccess) {
        Get.to(() => HomePage());
        FlutterToast.showsuccess(message: 'Success');
      }
    });
    final pass = ref.watch(passwordHide);
    final auth = ref.watch(authProvideRS);
    final mode = ref.watch(modeprovider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: mode,
            key: _form,
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
                    'LOGIN PAGE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: emailctrl,
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
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white60,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        errorStyle: const TextStyle(
                          color: Colors.white,
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
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      controller: passwordctrl,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return ' Password cannot be empty';
                        } else if (val.length < 8) {
                          return 'Password must be atleast of 8 characters';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.done,
                      obscureText: pass ? true : false,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.white60,
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        // errorStyle: const TextStyle(
                        //   color: Colors.white,
                        // ),
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
                                    Icons.lock_open_rounded,
                                    color: Colors.white,
                                  )),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      auth.isLoad ? null : _form.currentState!.save();
                      if (_form.currentState!.validate()) {
                        ref.read(authProvideRS.notifier).userlogin(
                            email: emailctrl.text.trim(),
                            password: passwordctrl.text.trim());

                        FocusScope.of(context).unfocus();
                      } else {
                        ref.read(modeprovider.notifier).change();
                      }
                    },
                    child: auth.isLoad
                        ? const CircularProgressIndicator()
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30)),
                              child: const Center(
                                child: Text(
                                  'Login',
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
                        'Don\'t have an account ? ',
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => Signuppage(),
                              transition: Transition.rightToLeft);
                        },
                        child: const Text(
                          'Sign Up Now',
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
      ),
    );
  }
}
