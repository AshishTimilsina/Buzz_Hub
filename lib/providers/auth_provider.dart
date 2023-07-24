import 'package:buzzhub/common_instances/common_state.dart';
import 'package:buzzhub/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final authProvideRS = StateNotifierProvider<AuthProvider, CommonState>(
    (ref) => AuthProvider(CommonState.empty(), ref.watch(authserviceprovider)));

class AuthProvider extends StateNotifier<CommonState> {
  final AuthService service;
  AuthProvider(super.state, this.service);

  // Future<void> sendEmailVerification() async {
  //   try {
  //     state = state.copyWith(
  //         errmessage: '', isError: false, isLoad: true, isSuccess: false);
  //     final response = await service.sendEmailVerification();
  //     response.fold((l) {
  //       state = state.copyWith(
  //           errmessage: l, isError: true, isLoad: false, isSuccess: false);
  //     }, (r) {
  //       state = state.copyWith(
  //           errmessage: '', isError: false, isLoad: false, isSuccess: r);
  //     });
  //   } catch (err) {
  //     throw err.toString();
  //   }
  // }

  Future<void> userlogin({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: true, isSuccess: false);
      final response =
          await service.userlogin(email: email, password: password);
      response.fold((l) {
        state = state.copyWith(
            errmessage: l, isError: true, isLoad: false, isSuccess: false);
      }, (r) {
        state = state.copyWith(
            errmessage: '', isError: false, isLoad: false, isSuccess: r);
      });
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> usersignup({
    required String email,
    required String password,
    required String username,
    required XFile image,
  }) async {
    try {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: true, isSuccess: false);
      final response = await service.usersignup(
          email: email, password: password, username: username, image: image);
      response.fold((l) {
        state = state.copyWith(
            errmessage: l, isError: true, isLoad: false, isSuccess: false);
      }, (r) {
        state = state.copyWith(
            errmessage: '', isError: false, isLoad: false, isSuccess: r);
      });
    } catch (err) {
      throw err.toString();
    }
  }

  Future<void> userlogout() async {
    try {
      state = state.copyWith(
          errmessage: '', isError: false, isLoad: true, isSuccess: false);
      final response = await service.userlogout();
      response.fold((l) {
        state = state.copyWith(
            errmessage: l, isError: true, isLoad: false, isSuccess: false);
      }, (r) {
        state = state.copyWith(
            errmessage: '', isError: false, isLoad: false, isSuccess: r);
      });
    } catch (err) {
      throw err.toString();
    }
  }
}
