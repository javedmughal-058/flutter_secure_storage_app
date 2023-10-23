import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'page/user_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static const String title = 'Secure Storage';
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: MyApp.title,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: const ColorScheme.dark(),
          scaffoldBackgroundColor: Colors.teal.shade600,
          cardColor: Colors.white38,
          unselectedWidgetColor: Colors.white12,
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(Colors.white),
          ),
        ),
        home: const UserPage(),
      );
}
