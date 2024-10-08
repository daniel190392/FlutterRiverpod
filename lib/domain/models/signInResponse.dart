class SignInResponse {
  final bool signInCompleted;
  final String? deliveryDestination;
  final String? deliveryName;

  SignInResponse(
    this.signInCompleted, {
    this.deliveryDestination,
    this.deliveryName,
  });
}
