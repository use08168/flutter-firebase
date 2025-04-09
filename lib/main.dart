import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marketlyze_1/firebase_options.dart';
import 'package:marketlyze_1/router.dart';
import 'package:permission_handler/permission_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await requestGalleryPermission();

  runApp(
    const ProviderScope(
      child: SafeArea(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: const Color.fromRGBO(119, 212, 252, 1),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomAppBarTheme: const BottomAppBarTheme(
          elevation: 0,
          color: Colors.white,
        ),
      ),
    );
  }
}

Future<void> requestGalleryPermission() async {
  var status = await Permission.storage.status;
  if (status.isDenied) {
    await Permission.storage.request();
  }
}
