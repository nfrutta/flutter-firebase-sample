import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'authentication/login/login_page.dart';
import 'authentication/signup/signup_page.dart';
import 'firestore_storage/book_list/bool_list_page.dart';
import 'main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: 'Flutter Demo',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('Firebase Sample App'),
          ),
          body: Consumer<MainModel>(
              builder: (context, model, child) {
                return Center(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Text(
                              model.overview,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          // Authentication
                          Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 320,
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.people
                                        ),
                                        Text(
                                          ' Authentication',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          SizedBox(
                                            width: 180,
                                            child: RaisedButton(
                                              child: Text(
                                                '新規登録',
                                              ),
                                              onPressed: () {
                                                //model.changeText();
                                                Navigator.push(
                                                  context,
                                                  //MaterialPageRoute(builder: (context) => BookListPage()),
                                                  MaterialPageRoute(builder: (context) => SignUpPage()),
                                                );
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            width: 180,
                                            child: RaisedButton(
                                              child: Text(
                                                'ログイン',
                                              ),
                                              onPressed: () {
                                                //model.changeText();
                                                Navigator.push(
                                                  context,
                                                  //MaterialPageRoute(builder: (context) => BookListPage()),
                                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 320,
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.cloud
                                        ),
                                        Text(
                                          ' Cloud Firestore',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: RaisedButton(
                                          child: Text(
                                            '本一覧',
                                          ),
                                          onPressed: () {
                                            //model.changeText();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => BookListPage()),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 320,
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                            Icons.folder
                                        ),
                                        Text(
                                          ' Storage',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 24,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: RaisedButton(
                                          child: Text(
                                            'TBD',
                                          ),
                                          onPressed: () {
                                            // TODO: 画面作る
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Card(
                            margin: const EdgeInsets.all(8.0),
                            child: Container(
                              margin: const EdgeInsets.all(8.0),
                              width: 320,
                              height: 140,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Icon(
                                            Icons.sync
                                        ),
                                        Text(
                                          ' Realtime Database',
                                          style: TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 180,
                                        child: RaisedButton(
                                          child: Text(
                                            'TBD',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}
