import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:el_profe/src/model/post_model.dart';
import 'dart:io';
import 'package:el_profe/src/service/base/base_view_model.dart';
import 'package:el_profe/src/view/util/g_context.dart';
import 'package:firebase_storage/firebase_storage.dart';

class PostViewModel {

  static Future<dynamic> getAllPosts() async {
    return Firestore.instance.collection('posts')
      .getDocuments().then((onValue) async {
        if (onValue.documents.isNotEmpty) {
          List<Post> therapies = [];
          final listRoutines = onValue.documents.map<Post>((document) => Post.fromMap(document.data)).toList();
          therapies = listRoutines;
          return [0, therapies];
        } else {
          return [1, 'Sin posts'];
        }
      }).catchError((onError) {
          print("...---$onError---...");
          if (onError.message.toString().contains("Invalid path (posts)")) {
            return [1, 'Sin posts'];
          } else {
            return BaseViewModel.errorMap(onError);
          }
      });
  }

  static Future<dynamic> addPostStore(String description, List<File> files) async {
    List<String> urls = [];
    for (File f in files) {
      await uploadImage(f).then((onValue) {
        urls.add(onValue);
      }).catchError((onError) {
        return BaseViewModel.errorMap(onError);
      });
    }

    String id = Firestore.instance.collection('posts').document().documentID;

    Post post = Post(
      id: id,
      author: GContext.getUser.name + GContext.getUser.lastName,
      description: description,
      uid: GContext.getUser.uid,
      timeCreate: DateTime.now().millisecondsSinceEpoch,

      imageUrls: urls,
      isDelete: false,
      isAttention: false,
    );

    return Firestore.instance.collection('posts').document(id).setData(post.toJson()).then((onValue) async {
      return [0, 'success'];
    }).catchError((onError) => BaseViewModel.errorMap(onError));
  }

  static Future<String> uploadImage(File file) async{
    final StorageReference ref = FirebaseStorage.instance.ref().child("posts");
    final StorageUploadTask uploadTask = ref.putFile(file);
    await uploadTask.onComplete;
    String urlDownloaded = await ref.getDownloadURL();
    return urlDownloaded;
  }
}