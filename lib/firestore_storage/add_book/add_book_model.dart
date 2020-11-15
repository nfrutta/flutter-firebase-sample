import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../book.dart';

class AddBookModel extends ChangeNotifier {
  String bookTitle = '';
  File imageFile;

  bool isLoading = false;

  startLoading() {
    isLoading = true;
    notifyListeners();
  }

  endLoading() {
    isLoading = false;
    notifyListeners();
  }

  Future showImagePicker() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    imageFile = File(pickedFile.path);
    notifyListeners();
  }

  Future addBookToFirebase() async {
    if (bookTitle.isEmpty) {
      throw('Text Empty.');
    }

    final imageURL = await _uploadImage();

    FirebaseFirestore.instance.collection('books').add({
      'title': bookTitle,
      'imageURL' : imageURL,
      'createdAt': Timestamp.now(),
    });
  }

  Future updateBook(Book book) async {
    final doc = FirebaseFirestore.instance.collection('books').doc(book.documentId);
    await doc.update({
      'title': bookTitle,
      'createdAt': Timestamp.now(),
    });
  }

  Future<String> _uploadImage() async {
    final storage = FirebaseStorage.instance;
    final ref = storage.ref().child('books').child(bookTitle);
    final snapshot = await ref.putFile(imageFile);
    final downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
