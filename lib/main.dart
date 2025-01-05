import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'table_selection_page.dart';
import 'package:hey/blocking_screen.dart';

void main() async {
  // firebase initialization
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Restaurant',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2B2D42),
          secondary: const Color.fromARGB(255, 0, 0, 0),
          tertiary: const Color(0xFFEF233C),
        ),
      ),
      home: const AppStateWrapper(),
    );
  }
}

class AppStateWrapper extends StatelessWidget {
  const AppStateWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseDatabase.instance.ref().child('appState').onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
          final appState =
              Map<String, dynamic>.from(snapshot.data!.snapshot.value as Map);

          if (appState['isBlocked'] == true) {
            return BlockingScreen(
              message: appState['blockMessage'] ?? 'App is currently disabled',
            );
          }
        }

        return const TableSelectionPage();
      },
    );
  }
}
