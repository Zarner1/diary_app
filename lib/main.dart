import 'package:flutter/material.dart';
import 'package:vizeeeee/models/diary_entry.dart';
import 'package:vizeeeee/pages/login_page.dart';
import 'package:vizeeeee/pages/register_page.dart';
import 'package:vizeeeee/pages/diary_list_page.dart';
import 'package:vizeeeee/pages/diary_view_page.dart';

void main() => runApp(const DiaryApp());

class DiaryApp extends StatelessWidget {
  const DiaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diary+',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/diaries': (context) => const DiaryListPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/view-diary') {
          final diary = settings.arguments as DiaryEntry?;
          return MaterialPageRoute(
            builder: (context) => DiaryViewPage(diaryEntry: diary),
          );
        } else if (settings.name == '/diaries') {
          final userId = settings.arguments as String?;
          return MaterialPageRoute(
            builder: (context) => DiaryListPage(),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}