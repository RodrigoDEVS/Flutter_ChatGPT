import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/provider/chat_provider.dart';
import 'package:flutter_chatgpt/provider/models_provider.dart';
import 'package:flutter_chatgpt/screens/chat_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ModelsProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          theme: ThemeData(
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(color: cardColor)),
          home: const ChatScreen()),
    );
  }
}
