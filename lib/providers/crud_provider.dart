import 'package:buzzhub/common_instances/common_state.dart';
import 'package:buzzhub/services/crud_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../models/post.dart';

final crudprovider = StateNotifierProvider<Crudprovider, CommonState>(
    (ref) => Crudprovider(CommonState.empty(), ref.watch(crudservice)));

class Crudprovider extends StateNotifier<CommonState> {
  final Crudservice service;
  Crudprovider(super.state, this.service);

  Future<void> createpost({
    required String title,
    required String detail,
    required String userid,
    required XFile image,
  }) async {
    state = state.copyWith(
        errmessage: '', isError: false, isLoad: true, isSuccess: false);
    final response =
        await service.createpost(detail: detail, userid: userid, image: image);
    response.fold((l) {
      state = state.copyWith(
          errmessage: l, isError: true, isLoad: false, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: false, isSuccess: true);
    });
  }

  Future<void> updatePost({
    required String detail,
    required String id,
    XFile? image,
    String? imageId,
  }) async {
    state = state.copyWith(
        errmessage: '', isError: false, isLoad: true, isSuccess: false);
    final response = await service.updatePost(
      detail: detail,
      id: id,
      image: image,
      imageId: imageId,
    );
    response.fold((l) {
      state = state.copyWith(
          errmessage: l, isError: true, isLoad: false, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: false, isSuccess: true);
    });
  }

  Future<void> removePost({
    required String postId,
    required String imageId,
  }) async {
    state = state.copyWith(
        errmessage: '', isError: false, isLoad: true, isSuccess: false);
    final response = await service.removePost(postId: postId, imageId: imageId);
    response.fold((l) {
      state = state.copyWith(
          errmessage: l, isError: true, isLoad: false, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: false, isSuccess: true);
    });
  }

  Future<void> likePost(
      {required String postId, required int like, required String name}) async {
    state = state.copyWith(
        errmessage: '', isError: false, isLoad: true, isSuccess: false);
    final response =
        await service.likePost(postId: postId, like: like, name: name);
    response.fold((l) {
      state = state.copyWith(
          errmessage: l, isError: true, isLoad: false, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: false, isSuccess: true);
    });
  }

  Future<void> commentPost(
      {required String postId, required Comment comment}) async {
    state = state.copyWith(
        errmessage: '', isError: false, isLoad: true, isSuccess: false);
    final response =
        await service.commentPost(postId: postId, comment: comment);
    response.fold((l) {
      state = state.copyWith(
          errmessage: l, isError: true, isLoad: false, isSuccess: false);
    }, (r) {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: false, isSuccess: true);
    });
  }
}
