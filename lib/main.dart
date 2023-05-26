import 'package:flutter/material.dart';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mutation/core/data/repository/user_repository.dart';
import 'package:mutation/core/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'core/styles/colors.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initHiveForFlutter();
  runApp(
    ChangeNotifierProvider(create: (_)=>UserInteraction(), child: const RootApp(),)
  );
}

class RootApp extends StatelessWidget {
  const RootApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: grey,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
