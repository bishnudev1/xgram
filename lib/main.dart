import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xgram/providers/post_provider.dart';
import 'package:xgram/screens/add_post_screen.dart';
import 'package:xgram/screens/register_screen.dart';
import 'package:xgram/services/auth_services.dart';
import 'providers/user_provider.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
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
    final authServices = AuthServices();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => PostProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/add-post': (context) => const AddPostScreen(),
        },
        initialRoute: authServices.isSignedIn ? '/' : '/login',
      ),
    );
  }
}
