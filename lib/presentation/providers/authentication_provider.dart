import 'package:example_riverpod/domain/models/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/repositories.dart';
import 'authentication_repository_provider.dart';

final authenticationProvider =
    StateNotifierProvider<AuthenticationNotifier, UserModel>((ref) {
  final repository = ref.watch(authenticationRepositoryProvider);
  return AuthenticationNotifier(repository);
});

class AuthenticationNotifier extends StateNotifier<UserModel> {
  bool isLogin = true;
  String? showError;
  String? showOTP;
  bool authenticationCompleted = false;
  AuthenticationRepository repository;

  AuthenticationNotifier(this.repository) : super(UserModel.empty());

  void resetInputs({
    String? email,
    String? password,
    String? confirmPassword,
  }) {
    state = state.copyWith(
      newEmail: state.email.copyWith(
        newValue: email,
        newPropertyState:
            email != null ? UserPropertyState.none : state.email.propertyState,
      ),
      newPassword: state.password.copyWith(
        newValue: password,
        newPropertyState: password != null
            ? UserPropertyState.none
            : state.password.propertyState,
      ),
      newConfirmPassword: state.confirmPassword?.copyWith(
        newValue: confirmPassword,
        newPropertyState: confirmPassword != null
            ? UserPropertyState.none
            : state.confirmPassword?.propertyState,
      ),
    );
  }

  String? validEmail(String? email) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    final isValid = email != null && email.isNotEmpty && regex.hasMatch(email);
    final emailProperty = state.email.copyWith(
      newValue: email,
      newErrorMessage: isValid ? null : 'Invalid email',
      newPropertyState:
          isValid ? UserPropertyState.success : UserPropertyState.error,
    );
    state = state.copyWith(newEmail: emailProperty);
    return isValid ? null : state.email.errorMessage;
  }

  String? validPassword(String? password) {
    final isValid = password != null && password.isNotEmpty;
    final passwordProperty = state.password.copyWith(
      newValue: password,
      newErrorMessage: isValid ? null : 'Invalid password',
      newPropertyState:
          isValid ? UserPropertyState.success : UserPropertyState.error,
    );
    state = state.copyWith(newPassword: passwordProperty);
    return isValid ? null : state.password.errorMessage;
  }

  String? validConfirmPassword(String? password) {
    final isValid = password == state.password.value;
    final confirmPasswordProperty = state.confirmPassword?.copyWith(
      newValue: password,
      newErrorMessage: isValid ? null : 'Password not match',
      newPropertyState:
          isValid ? UserPropertyState.success : UserPropertyState.error,
    );
    state = state.copyWith(newConfirmPassword: confirmPasswordProperty);
    return isValid ? null : state.confirmPassword?.errorMessage;
  }

  void switchLoginAndRegister() async {
    isLogin = !isLogin;
    state = state.copyWith(
      newConfirmPassword: isLogin ? null : UserProperty(''),
      removeConfirmPassword: isLogin,
    );
  }

  Future<bool> confirmationCode(String code) async {
    final result = await repository.confirmUser(
      username: state.email.value,
      confirmationCode: code,
    );
    return result.signUpCompleted;
  }

  Future<void> submit() async {
    return isLogin ? _signIn() : _signUp();
  }

  Future<void> _signIn() async {
    try {
      final result = await repository.signInUser(
        state.email.value,
        state.password.value,
      );
      showOTP = result.signInCompleted ? null : result.deliveryDestination;
      authenticationCompleted = result.signInCompleted;
    } catch (exception) {
      showError = exception.toString();
    }
  }

  Future<void> _signUp() async {
    try {
      final result = await repository.signUpUser(
        username: state.email.value,
        password: state.password.value,
        email: state.email.value,
      );
      showOTP = result.signUpCompleted ? null : result.deliveryDestination;
      authenticationCompleted = result.signUpCompleted;
    } catch (exception) {
      showError = exception.toString();
    }
  }
}
