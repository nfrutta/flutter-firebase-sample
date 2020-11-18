
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../book.dart';
import 'add_book_model.dart';


class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});
  final Book book;

  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null;
    final textEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              title: Text(isUpdate ? '本を編集' : '本を追加'),
            ),
            body: Consumer<AddBookModel>(
              builder: (context, model, child) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: 120,
                        height: 180,
                        child: InkWell(
                          onTap: () async {
                            await model.showImagePicker();
                          },
                          child: isUpdate ? Image.network(book.imageURL)
                              : (model.imageFile != null
                                ? Image.file(model.imageFile)
                                : Container(color: Colors.grey)),
                        ),
                      ),
                      TextField(
                        controller: textEditingController,
                        onChanged: (text) {
                          model.bookTitle = text;
                        },
                      ),
                      RaisedButton(
                        child: Text(isUpdate ? '更新する' : '登録する'),
                        onPressed: () async {
                          model.startLoading();

                          if (isUpdate) {
                            await updateBook(model, context);
                          } else {
                            await addBook(model, context);
                          }

                          model.endLoading();
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Consumer<AddBookModel>(
            builder: (context, model, child) {
              return model.isLoading ? Container(
                color: Colors.grey.withOpacity(0.6),
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ) : SizedBox();
            }
          )
        ],
      ),
    );
  }

  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      await model.addBookToFirebase();
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('保存しました！'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }

  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      await model.updateBook(book);
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('更新しました！'),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
      Navigator.of(context).pop();
    } catch(e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(e.toString()),
              actions: [
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }
}