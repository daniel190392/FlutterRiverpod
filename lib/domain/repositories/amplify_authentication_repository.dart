import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

import '../models/models.dart';
import 'authentication_repository.dart';

class AmplifyAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<SignUpResponse> signUpUser({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      final userAttributes = {AuthUserAttributeKey.email: email};
      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(userAttributes: userAttributes),
      );
      return _handleSingUpResult(result);
    } on AuthException catch (exception) {
      throw exception.message;
    }
  }

  @override
  Future<SignUpResponse> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );
      return _handleSingUpResult(result);
    } on AuthException catch (exception) {
      throw exception.message;
    }
  }

  @override
  Future<SignInResponse> signInUser(
    String username,
    String password,
  ) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return await _handleSignInResult(result);
    } on AuthException catch (exception) {
      throw exception.message;
    }
  }

  @override
  Future<void> signOutCurrentUser() async {
    final result = await Amplify.Auth.signOut();
    if (result is CognitoCompleteSignOut) {
      return;
    } else if (result is CognitoFailedSignOut) {
      throw result.exception.message;
    } else {
      throw 'error';
    }
  }
}

extension AmplifyAuthenticationExtension on AmplifyAuthenticationRepository {
  SignUpResponse _handleSingUpResult(SignUpResult result) {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDelivery = result.nextStep.codeDeliveryDetails;
        return SignUpResponse(
          false,
          deliveryDestination: codeDelivery?.destination,
          deliveryName: codeDelivery?.deliveryMedium.name,
        );
      case AuthSignUpStep.done:
        return SignUpResponse(true);
    }
  }

  Future<SignInResponse> _handleSignInResult(SignInResult result) async {
    switch (result.nextStep.signInStep) {
      case AuthSignInStep.confirmSignInWithSmsMfaCode:
        final codeDelivery = result.nextStep.codeDeliveryDetails;
        return SignInResponse(
          false,
          deliveryDestination: codeDelivery?.destination,
          deliveryName: codeDelivery?.deliveryMedium.name,
        );
      case AuthSignInStep.done:
        return SignInResponse(true);
      default:
        return SignInResponse(false);
    }
  }
}
