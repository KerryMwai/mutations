import 'package:flutter/material.dart';
import 'dart:io';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mutation/core/domain/user_repository.dart';
import 'package:mutation/core/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

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
    // final HttpLink _link = HttpLink("https://graphqlzero.almansi.me/api");

    // ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
    //     link: _link as Link, cache: GraphQLCache(store: HiveStore())));

    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage());
  }
}
