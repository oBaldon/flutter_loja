import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';

class LocalAuthService extends ChangeNotifier {
  final LocalAuthentication auth;

  LocalAuthService({required this.auth});

  Future<bool> isBiometricAvailable() async {
    try {
      final bool hasBiometrics = await auth.canCheckBiometrics;
      final bool hasDeviceSupport = await auth.isDeviceSupported();

      if (hasBiometrics && hasDeviceSupport) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    return await auth.authenticate(
      localizedReason: 'Por favor, autentique-se.',
    );
  }
}
