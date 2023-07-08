import 'package:flutter/material.dart';
import 'package:user_infromation_bloc/views/UserDetailsPage.dart';
import 'package:user_infromation_bloc/views/UserListPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Information Bloc',
      theme: ThemeData(
        fontFamily: "sfPro-Medium",
        primarySwatch: Colors.blue,
      ),
      home: const UserListPage(),
    );
  }
}
