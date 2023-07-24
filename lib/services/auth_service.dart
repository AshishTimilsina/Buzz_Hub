// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../common_instances/firebase_instances.dart';

final authserviceprovider = Provider((ref) => AuthService(
      auth: ref.watch(authprovider),
      cloud: ref.watch(cloudprovider),
      chatcore: ref.watch(chatcoreprovider),
      message: ref.watch(messageprovider),
      storage: ref.watch(storageprovider),
    ));
final singleuser =
    StreamProvider.family((ref, String id) => AuthService.getuserinfo(id));
final multipleuser =
    StreamProvider.autoDispose((ref) => FirebaseChatCore.instance.users());

class AuthService {
  final FirebaseAuth auth;
  final FirebaseFirestore cloud;
  final FirebaseChatCore chatcore;
  final FirebaseMessaging message;
  final FirebaseStorage storage;
  AuthService({
    required this.auth,
    required this.cloud,
    required this.chatcore,
    required this.message,
    required this.storage,
  });

  static final userDb = FirebaseFirestore.instance.collection('users');
  static Stream<types.User> getuserinfo(String userid) {
    return userDb.doc(userid).snapshots().map((event) {
      final json = event.data() as Map<String, dynamic>;
      return types.User(
          id: event.id,
          firstName: json['firstName'],
          imageUrl: json['imageUrl'],
          metadata: {
            'email': json['metadata']['email'],
            'token': json['metadata']['token'],
          });
    });
  }

  Future<Either<String, bool>> userlogin({
    required String email,
    required String password,
  }) async {
    try {
      final token = await message.getToken();
      final response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      await userDb.doc(response.user!.uid).update({
        'metadata': {
          'email': email,
          'token': token,
        }
      });
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.toString());
    } catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> usersignup({
    required String email,
    required String password,
    required String username,
    required XFile image,
  }) async {
    try {
      final ref = storage.ref().child('userimage/${image.name}');
      await ref.putFile(File(image.path));
      final response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final url = await ref.getDownloadURL();
      final token = await message.getToken();
      FirebaseChatCore.instance.createUserInFirestore(types.User(
          id: response.user!.uid,
          firstName: username,
          imageUrl: url,
          metadata: {
            'email': email,
            'token': token,
          }));
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.toString());
    } on FirebaseException catch (err) {
      return Left(err.toString());
    } catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> userlogout() async {
    try {
      await auth.signOut();
      return const Right(true);
    } on FirebaseAuthException catch (err) {
      return Left(err.toString());
    } on FirebaseException catch (err) {
      return Left(err.toString());
    } catch (err) {
      return Left(err.toString());
    }
  }
}
