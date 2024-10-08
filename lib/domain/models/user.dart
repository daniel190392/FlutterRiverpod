import 'user_property.dart';

class UserModel {
  final UserProperty email;
  final UserProperty password;
  final UserProperty? confirmPassword;

  UserModel({
    required this.email,
    required this.password,
    this.confirmPassword,
  });

  factory UserModel.empty() => UserModel(
        email: UserProperty(''),
        password: UserProperty(''),
      );

  UserModel copyWith({
    UserProperty? newEmail,
    UserProperty? newPassword,
    UserProperty? newConfirmPassword,
    bool removeConfirmPassword = false,
  }) {
    return UserModel(
      email: newEmail ?? email,
      password: newPassword ?? password,
      confirmPassword: removeConfirmPassword
          ? null
          : (newConfirmPassword ?? confirmPassword),
    );
  }
}
