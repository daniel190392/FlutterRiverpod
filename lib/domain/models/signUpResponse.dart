class SignUpResponse {
  final bool signUpCompleted;
  final String? deliveryDestination;
  final String? deliveryName;

  SignUpResponse(
    this.signUpCompleted, {
    this.deliveryDestination,
    this.deliveryName,
  });
}
