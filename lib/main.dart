import 'package:flutter/material.dart';
import 'package:news_app/Screens/news_page.dart';
import 'package:news_app/provider/newsprovider.dart';
import 'package:provider/provider.dart';

//screens
import './Screens/login_page.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<Newsprovider>(
          create: (_) => Newsprovider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        LoginPage.routname: (context) => const LoginPage(),
        NewsPage.routname: (context) => NewsPage(),
      },
    );
  }
}
