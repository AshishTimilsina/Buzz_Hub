import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';

class Recentchat extends ConsumerWidget {
  const Recentchat({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final roomdata = ref.watch(rooms);
    return Scaffold(
      body: SafeArea(
        child: roomdata.when(
            data: (data) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => ChatPage(data[index]));
                      },
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data[index].imageUrl!),
                      ),
                      title: Text(data[index].name!),
                    );
                  });
            },
            error: (err, _) => Container(),
            loading: () => const CircularProgressIndicator()),
      ),
    );
  }
}
