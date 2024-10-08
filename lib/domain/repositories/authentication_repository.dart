import '../models/models.dart';

abstract class AuthenticationRepository {
  Future<SignUpResponse> signUpUser({
    required String username,
    required String password,
    required String email,
  });

  Future<SignUpResponse> confirmUser({
    required String username,
    required String confirmationCode,
  });

  Future<SignInResponse> signInUser(String username, String password);

  Future<void> signOutCurrentUser();
}
