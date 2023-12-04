import 'package:flutter_application/pages/home_page.dart';
import 'package:flutter_application/pages/login_page.dart';
import 'package:flutter_application/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application/services/local_auth_service.dart';
import 'package:provider/provider.dart';

class AuthCheck extends StatefulWidget {
  AuthCheck({Key? key}) : super(key: key);

  @override
  _AuthCheckState createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  final ValueNotifier<bool> isLocalAuthFailed = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    checkLocalAuth();
  }

  checkLocalAuth() async {
    final localAuth = context.read<LocalAuthService>();
    final isLocalAuthAvailable = await localAuth.isBiometricAvailable();
    isLocalAuthFailed.value = false;

    if (isLocalAuthAvailable) {
      final authenticated = await localAuth.authenticate();

      if (!authenticated) {
        isLocalAuthFailed.value = true;
        return;
      } else {
        if (!mounted) return;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ));
      }
    } else {
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const HomePage(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService auth = Provider.of<AuthService>(context);

    if (auth.isLoading)
      return loading();
    else if (auth.usuario == null)
      return LoginPage();
    else
      return HomePage();
  }

  loading() {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
