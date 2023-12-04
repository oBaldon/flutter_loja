import 'package:flutter/material.dart';
import 'package:flutter_application/repositories/carrinho_repository.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:local_auth/local_auth.dart';
import 'package:provider/provider.dart';
import 'my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_application/services/local_auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LocalAuthService>(
          create: (context) => LocalAuthService(auth: LocalAuthentication()),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (context) => CarrinhoRepository(
            auth: context.read<AuthService>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}
