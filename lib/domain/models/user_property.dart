class UserProperty {
  final String value;
  final String? errorMessage;
  final UserPropertyState propertyState;

  UserProperty(
    this.value, {
    this.errorMessage,
    this.propertyState = UserPropertyState.none,
  });

  UserProperty copyWith({
    String? newValue,
    String? newErrorMessage,
    UserPropertyState? newPropertyState,
  }) {
    return UserProperty(
      newValue ?? value,
      errorMessage: newErrorMessage ?? errorMessage,
      propertyState: newPropertyState ?? propertyState,
    );
  }
}

enum UserPropertyState {
  none,
  success,
  error,
}
