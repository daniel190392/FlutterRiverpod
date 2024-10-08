import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/repositories.dart';
import 'authentication_repository_provider.dart';

final aparmentsProvider = StateNotifierProvider<AparmentsNotifier, bool>((ref) {
  final repository = ref.watch(authenticationRepositoryProvider);
  return AparmentsNotifier(repository);
});

class AparmentsNotifier extends StateNotifier<bool> {
  AuthenticationRepository repository;
  AparmentsNotifier(this.repository) : super(false);

  Future<void> logout() async {
    await repository.signOutCurrentUser();
  }
}
