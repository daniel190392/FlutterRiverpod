import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:example_riverpod/presentation/providers/providers.dart';
import 'package:example_riverpod/presentation/screens/screens.dart';

import '../../../domain/models/models.dart';
import '../common_widgets/common_widgets.dart';
import 'widgets/authentication_widgets.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  static var name = 'authentication_screen';

  const AuthenticationScreen({super.key});

  @override
  ConsumerState<AuthenticationScreen> createState() =>
      _AuthenticationScreenState();
}

class _AuthenticationScreenState extends ConsumerState<AuthenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: BackgroundContainer(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  ref.read(authenticationProvider.notifier).isLogin
                      ? 'Login'
                      : 'Register',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const AuthenticationGroupInputs(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: isSubmitEnabled()
                      ? () async {
                          await ref
                              .read(authenticationProvider.notifier)
                              .submit();
                          handleSubmit();
                        }
                      : null,
                  child: const Text('Submit'),
                ),
                TextButton(
                  onPressed: () => ref
                      .read(authenticationProvider.notifier)
                      .switchLoginAndRegister(),
                  child: Text(
                    ref.read(authenticationProvider.notifier).isLogin
                        ? "Don't have an account? Sing Up"
                        : "Already have an account? Login",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isSubmitEnabled() {
    final model = ref.read(authenticationProvider);
    const success = UserPropertyState.success;
    return model.email.propertyState == success &&
        model.password.propertyState == success &&
        (model.confirmPassword?.propertyState ?? success) == success;
  }

  void handleSubmit() {
    final notifier = ref.watch(authenticationProvider.notifier);
    if (notifier.showError != null) {
      showDialog(
        context: context,
        builder: (context) => ErrorModal(notifier.showError!),
      );
    }
    if (notifier.showOTP != null) {
      showDialog(
        context: context,
        builder: (context) => OtpModal(notifier.showOTP),
      );
    }
    if (notifier.authenticationCompleted) {
      context.pushReplacementNamed(AparmentsScreen.name);
    }
  }
}
