import 'package:buzzhub/common_instances/firebase_instances.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home_page.dart';
import 'login_page.dart';

final streamdata =
    StreamProvider((ref) => ref.read(authprovider).authStateChanges());

class StatusPage extends ConsumerWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final authdata = ref.watch(streamdata);
    return Scaffold(
      body: authdata.when(
          data: (data) {
            if (data == null) {
              return Loginpage();
            } else {
              return HomePage();
            }
          },
          error: (error, _) {
            return Text(error.toString());
          },
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
    );
  }
}
