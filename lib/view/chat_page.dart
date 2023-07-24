import 'dart:io';

import 'package:buzzhub/providers/room_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:image_picker/image_picker.dart';

class ChatPage extends ConsumerStatefulWidget {
  final types.Room room;
  const ChatPage(this.room, {super.key});
  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    final msg = ref.watch(messagestream(widget.room));
    return Scaffold(
      body: msg.when(
          data: (data) {
            return Chat(
                messages: data,
                onSendPressed: (val) {
                  FirebaseChatCore.instance.sendMessage(
                      types.PartialText(text: val.text), widget.room.id);
                },
                onAttachmentPressed: () {
                  final ImagePicker image = ImagePicker();
                  image
                      .pickImage(source: ImageSource.gallery)
                      .then((value) => (val) async {
                            if (val != null) {
                              final ref = FirebaseStorage.instance
                                  .ref()
                                  .child('chatimage/${value!.name}');
                              await ref.putFile(File(val.path));
                              final url = await ref.getDownloadURL();
                              final imagedata = types.PartialImage(
                                uri: url,
                                name: val.name,
                                size: 1000,
                              );

                              FirebaseChatCore.instance
                                  .sendMessage(imagedata, widget.room.id);
                            }
                          });
                },
                showUserAvatars: true,
                showUserNames: true,
                user: types.User(
                  id: FirebaseAuth.instance.currentUser!.uid,
                ));
          },
          error: (error, _) => Container(),
          loading: () => const CircularProgressIndicator()),
    );
  }
}
