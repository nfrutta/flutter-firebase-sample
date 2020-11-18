
import 'package:firebase_sample_app/firestore_storage/add_book/add_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../book.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
        create: (_) => BookListModel()..fetchBooks(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('本一覧'),
          ),
          body: Consumer<BookListModel>(
          builder: (context, model, child) {
            final books = model.books;
            final listTiles = books
            .map((book) => ListTile(
              leading: Image.network(book.imageURL),
              title : Text(book.title),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddBookPage(book: book),
                      fullscreenDialog: true,
                    ),
                  );
                  model.fetchBooks();
                },
              ),
              onLongPress: () async {
                // 長押ししたら削除ダイアログを表示
                await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('${book.title}を削除しますか？'),
                    actions: [
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () async {
                          Navigator.of(context).pop();

                          deleteBook(model, book, context);
                        },
                      )
                    ],
                  );
                }
                );
              },
            ),
            ).toList();
            return ListView.separated(
              itemCount: listTiles.length,
              separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.black),
              itemBuilder: (BuildContext context, int index) {
                return listTiles[index];
              },
            );
          },
        ),
        floatingActionButton: Consumer<BookListModel>(
          builder: (context, model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddBookPage(),
                    fullscreenDialog: true,
                  ),
                );
                model.fetchBooks();
              },
            );
          }
        ),
      ),
    );
  }

  Future deleteBook(BookListModel model, Book book, BuildContext context) async {
    try {
      await model.deleteBook(book);
      await _showDialog(context, '削除しました。');
      await model.fetchBooks();

    } catch(e) {
      await _showDialog(context, e.toString());
    }
  }

  Future _showDialog(BuildContext context, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(message),
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