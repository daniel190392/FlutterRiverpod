import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/models/models.dart';
import '../../../providers/providers.dart';
import 'authentication_input.dart';
import 'authentication_input_type.dart';

class AuthenticationGroupInputs extends ConsumerStatefulWidget {
  const AuthenticationGroupInputs({super.key});

  @override
  ConsumerState<AuthenticationGroupInputs> createState() =>
      _AuthenticationGroupInputsState();
}

class _AuthenticationGroupInputsState
    extends ConsumerState<AuthenticationGroupInputs> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ref.watch(authenticationProvider);
    ref.listen(authenticationProvider, (prev, next) {
      emailController.text = next.email.value;
      passwordController.text = next.password.value;
      confirmPasswordController.text = next.confirmPassword?.value ?? '';
    });
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 16),
          child: AuthenticationInput(
            inputType: AuthenticationInputType.user,
            controller: emailController,
            inputState: userModel.email.propertyState,
            onChange: (value) {
              if (userModel.email.propertyState == UserPropertyState.error) {
                ref
                    .read(authenticationProvider.notifier)
                    .resetInputs(email: value);
              }
            },
            validator: (p0) =>
                ref.read(authenticationProvider.notifier).validEmail(p0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: AuthenticationInput(
            inputType: AuthenticationInputType.password,
            controller: passwordController,
            inputState: userModel.password.propertyState,
            onChange: (value) {
              if (userModel.password.propertyState == UserPropertyState.error) {
                ref
                    .read(authenticationProvider.notifier)
                    .resetInputs(password: value);
              }
            },
            validator: (p0) =>
                ref.read(authenticationProvider.notifier).validPassword(p0),
          ),
        ),
        if (userModel.confirmPassword != null)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: AuthenticationInput(
              inputType: AuthenticationInputType.confirmPassword,
              controller: confirmPasswordController,
              inputState: userModel.confirmPassword!.propertyState,
              onChange: (value) {
                if (userModel.confirmPassword!.propertyState ==
                    UserPropertyState.error) {
                  ref
                      .read(authenticationProvider.notifier)
                      .resetInputs(confirmPassword: value);
                }
              },
              validator: (p0) => ref
                  .read(authenticationProvider.notifier)
                  .validConfirmPassword(p0),
            ),
          ),
      ],
    );
  }
}
