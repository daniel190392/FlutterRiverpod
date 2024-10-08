import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/repositories.dart';

final authenticationRepositoryProvider = Provider((ref) {
  return AmplifyAuthenticationRepository();
});
