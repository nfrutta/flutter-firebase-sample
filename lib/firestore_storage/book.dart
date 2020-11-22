
import 'package:cloud_firestore/cloud_firestore.dart';

class Book {
  Book(DocumentSnapshot doc) {
    documentId = doc.id;
    title = doc['title'];
    imageURL = doc['imageURL'];
  }

  String documentId;
  String title;
  String imageURL;
  // 登録できる情報を増やす
}