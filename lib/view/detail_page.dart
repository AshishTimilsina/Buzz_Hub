import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';

import '../providers/room_provider.dart';
import 'chat_page.dart';

class DetailPage extends ConsumerWidget {
  final types.User user;
  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 300,
            width: double.infinity,
            child: Image.network(
              user.imageUrl.toString(),
              height: 400,
              width: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text('Name : ${user.firstName.toString()}'),
          const SizedBox(
            height: 10,
          ),
          Text('Email : ${user.metadata!['email']}'),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () async {
              final response = await ref.read(roomprovider).createRoom(user);
              Get.to(() => ChatPage(response!));
            },
            child: const Text('Chat'),
          ),
        ],
      ),
    ));
  }
}
