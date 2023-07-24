import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authprovider = Provider((ref) => FirebaseAuth.instance);
final storageprovider = Provider((ref) => FirebaseStorage.instance);
final chatcoreprovider = Provider((ref) => FirebaseChatCore.instance);
final cloudprovider = Provider((ref) => FirebaseFirestore.instance);
final messageprovider = Provider((ref) => FirebaseMessaging.instance);
