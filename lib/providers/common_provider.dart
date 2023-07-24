import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final hearticonprovider = StateProvider<bool>((ref) => true);
final loginprovider = StateProvider<bool>((ref) => true);
final imageprovider = StateNotifierProvider.autoDispose<ImageProvider, XFile?>(
    (ref) => ImageProvider(null));
final passwordHide = StateProvider.autoDispose<bool>((ref) => true);
final modeprovider =
    StateNotifierProvider.autoDispose<ModeProvider, AutovalidateMode>(
        (ref) => ModeProvider(AutovalidateMode.disabled));

class ImageProvider extends StateNotifier<XFile?> {
  ImageProvider(super.state);
  final ImagePicker picker = ImagePicker();

  void pickimage(bool isCamera) async {
    if (isCamera) {
      state = await picker.pickImage(source: ImageSource.camera);
    } else {
      state = await picker.pickImage(source: ImageSource.gallery);
    }
  }
}

class ModeProvider extends StateNotifier<AutovalidateMode> {
  ModeProvider(super._state);
  void change() {
    state = AutovalidateMode.onUserInteraction;
  }
}
