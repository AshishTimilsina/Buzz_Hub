import 'dart:io';
import 'package:buzzhub/models/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final crudservice = Provider((ref) => Crudservice());
final postdata = StreamProvider((ref) => Crudservice.getdata());

class Crudservice {
  static final postDb = FirebaseFirestore.instance.collection('posts');

// retrieve post data from the firebase

  static Stream<List<Post>> getdata() {
    // for filtering data which are fetched we do:
    // return postDb.where('title',isEqualTo:'').snapshots().map((event) => event.docs.map((e) {}
    return postDb.snapshots().map((event) => event.docs.map((e) {
          final json = e.data();
          return Post(
              postid: e.id,
              userid: json['userid'],
              detail: json['detail'],
              imageurl: json['imageurl'],
              imageId: json['imageId'],
              // like uta bata map ko form ma aauxa
              like: Like.fromJson(json['like']),
              // comment uta bata list ko form ma aauxa
              comment: (json['comment'] as List)
                  .map((e) => Comment.fromJson(e))
                  .toList());
        }).toList());
  }

  Future<Either<String, bool>> createpost({
    required String detail,
    required String userid,
    required XFile image,
  }) async {
    try {
      final ref =
          FirebaseStorage.instance.ref().child('postImage/${image.name}');
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      await postDb.add({
        'userid': userid,
        'detail': detail,
        'imageurl': url,
        'imageId': image.name,
        'like': {'likes': 0, 'username': []},
        'comment': [],
      });
      return const Right(true);
    } on FirebaseException catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> updatePost({
    required String detail,
    required String id,
    XFile? image,
    String? imageId,
  }) async {
    try {
      if (image == null) {
        await postDb.doc(id).update({
          'detail': detail,
        });
      } else {
        final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
        await ref.delete();
        final ref1 =
            FirebaseStorage.instance.ref().child('postImage/${image.name}');
        await ref1.putFile(File(image.path));
        final url = await ref.getDownloadURL();
        await postDb.doc(id).update({
          'detail': detail,
          'imageUrl': url,
          'imageId': image.name,
        });
      }
      return const Right(true);
    } on FirebaseException catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> removePost({
    required String postId,
    required String imageId,
  }) async {
    try {
      final ref = FirebaseStorage.instance.ref().child('postImage/$imageId');
      await ref.delete();
      await postDb.doc(postId).delete();
      return const Right(true);
    } on FirebaseException catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> likePost(
      {required String postId, required int like, required String name}) async {
    try {
      await postDb.doc(postId).update({
        'like': {
          'likes': like,
          'usernames': FieldValue.arrayUnion([name])
        }
      });
      return const Right(true);
    } on FirebaseException catch (err) {
      return Left(err.toString());
    }
  }

  Future<Either<String, bool>> commentPost(
      {required String postId, required Comment comment}) async {
    try {
      await postDb.doc(postId).update({
        'comments': FieldValue.arrayUnion([comment.tojson()])
      });
      return const Right(true);
    } on FirebaseException catch (err) {
      return Left(err.toString());
    }
  }
}
