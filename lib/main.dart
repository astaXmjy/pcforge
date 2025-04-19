import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/welcome_screen.dart';
import 'data/repositories/component_repository.dart';
import 'data/database/database_helper.dart';
import 'widgets/app_background.dart'; // New import for background widget

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database
  final databaseHelper = DatabaseHelper();

  await databaseHelper.deleteDatabase();
  await databaseHelper.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => ComponentRepository(),
      child: MaterialApp(
        title: 'PC Forge',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.light,
          scaffoldBackgroundColor:
              Colors.transparent, // Make scaffold background transparent
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.blueAccent, // Customize app bar color
          ),
        ),
        darkTheme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          brightness: Brightness.dark,
          scaffoldBackgroundColor:
              Colors.transparent, // Make scaffold background transparent
          cardTheme: CardTheme(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            elevation: 0,
            backgroundColor:
                Colors.blueGrey, // Customize dark mode app bar color
          ),
        ),
        themeMode: ThemeMode.system,
        home: const AppBackground(
          child: WelcomeScreen(),
        ),
        builder: (context, child) {
          // Wrap all screens with the background
          return AppBackground(child: child!);
        },
      ),
    );
  }
}
