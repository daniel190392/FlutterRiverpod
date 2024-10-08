// import 'dart:ffi';

import 'package:flutter/material.dart';

import '../../../../domain/models/models.dart';
import 'authentication_input_type.dart';

class AuthenticationInput extends StatefulWidget {
  const AuthenticationInput({
    super.key,
    required this.inputType,
    required this.controller,
    this.inputState = UserPropertyState.none,
    this.validator,
    this.onChange,
  });

  final AuthenticationInputType inputType;
  final UserPropertyState inputState;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String?)? onChange;

  @override
  State<AuthenticationInput> createState() => _AuthenticationInputState();
}

class _AuthenticationInputState extends State<AuthenticationInput> {
  final GlobalKey<FormFieldState> _specificFieldKey =
      GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            Image.asset(
              widget.inputType.assetsName,
              width: 30,
              color: Theme.of(context).primaryColorLight,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Focus(
                child: TextFormField(
                  key: _specificFieldKey,
                  onChanged: widget.onChange,
                  validator: widget.validator,
                  style: Theme.of(context).textTheme.labelMedium,
                  controller: widget.controller,
                  obscureText: widget.inputType.obscureText,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.inputType.placeholder,
                    hintStyle: TextStyle(
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                ),
                onFocusChange: (hasFocus) {
                  if (!hasFocus) {
                    _specificFieldKey.currentState?.validate();
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            if (widget.inputState != UserPropertyState.none)
              Image.asset(
                widget.inputState.assetsName,
                width: 30,
                color: widget.inputState.assetColor(context),
              ),
          ],
        ),
      ),
    );
  }
}
