import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/core/failures/remote_auth_failures.dart';
import 'package:media_vault/core/validators.dart';
import 'package:media_vault/features/auth/application/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/routes/routes.gr.dart';
import 'package:media_vault/shared/widgets/custom_button.dart';

// ignore: must_be_immutable
class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email;
  late String password;

  String? validateEmail(String? value) {
    email = value!;
    if (emailValidator(value) == null) {
      return null;
    } else {
      return emailValidator(value);
    }
  }

  String? validatePassword(String? value) {
    password = value!;
    if (value.isEmpty) {
      return "Please enter a password";
    }
    return null;
  }

  void submitForm(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthFormBloc>(context).add(
        SignInWithEmailAndPasswordPressed(email: email, password: password),
      );
    } else {
      BlocProvider.of<AuthFormBloc>(context).add(
        SignInWithEmailAndPasswordPressed(email: null, password: null),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocConsumer<AuthFormBloc, AuthFormState>(
      listenWhen: (previous, current) =>
          previous.authFailureOrSuccessOption != current.authFailureOrSuccessOption &&
          previous.isSubmitting != current.isSubmitting,
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {}, // Option is none, do nothing
            (eitherFailureOrSuccess) => eitherFailureOrSuccess.fold(
                  (failure) {
                    if (failure is EmailNotVerifiedFailure) {
                      showDialog(
                        context: context,
                        builder: (_) => PlatformAlertDialog(
                          title: const Text("Email is unverified"),
                          content: Text(mapAuthFailureToMessage(failure)),
                          actions: [
                            PlatformDialogAction(
                              child: const Text("OK"),
                              onPressed: () => Navigator.of(context).pop(),
                            )
                          ],
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.redAccent,
                          content: Text(
                            mapAuthFailureToMessage(failure),
                            style: themeData.textTheme.bodyLarge,
                          ),
                        ),
                      );
                    }
                  },
                  (success) => AutoRouter.of(context).replace(const LocalAuthRootRoute()),
                ));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode:
              state.showValidationMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                cursorColor: themeData.colorScheme.onPrimary,
                decoration: const InputDecoration(
                  labelText: "Email",
                ),
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                cursorColor: themeData.colorScheme.onPrimary,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: validatePassword,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => submitForm(context),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              CustomButton(
                  text: "Login", isLoading: state.isSubmitting, onPressed: () => submitForm(context)),
            ],
          ),
        );
      },
    );
  }
}
