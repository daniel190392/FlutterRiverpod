import 'package:example_riverpod/domain/models/user_property.dart';
import 'package:example_riverpod/presentation/resources/constants.dart';
import 'package:flutter/material.dart';

enum AuthenticationInputType {
  user,
  password,
  confirmPassword,
}

extension InputTypeExtension on AuthenticationInputType {
  String get assetsName {
    switch (this) {
      case AuthenticationInputType.user:
        return 'assets/images/user.png';
      case AuthenticationInputType.password:
        return 'assets/images/password.png';
      case AuthenticationInputType.confirmPassword:
        return 'assets/images/password.png';
    }
  }

  String get placeholder {
    switch (this) {
      case AuthenticationInputType.user:
        return 'email';
      case AuthenticationInputType.password:
        return 'password';
      case AuthenticationInputType.confirmPassword:
        return 'confirm password';
    }
  }

  bool get obscureText {
    switch (this) {
      case AuthenticationInputType.user:
        return false;
      case AuthenticationInputType.password:
        return true;
      case AuthenticationInputType.confirmPassword:
        return true;
    }
  }
}

extension InputStateExtension on UserPropertyState {
  String get assetsName {
    switch (this) {
      case UserPropertyState.none:
        return '';
      case UserPropertyState.success:
        return 'assets/images/success.png';
      case UserPropertyState.error:
        return 'assets/images/error.png';
    }
  }

  Color? assetColor(BuildContext context) {
    switch (this) {
      case UserPropertyState.none:
        return null;
      case UserPropertyState.success:
        return ColorState.success.colorValue;
      case UserPropertyState.error:
        return ColorState.error.colorValue;
    }
  }
}
