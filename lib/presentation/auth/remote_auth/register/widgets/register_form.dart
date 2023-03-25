import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/core/failures/remote_auth_failures.dart';
import 'package:media_vault/core/validators.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_button.dart';

// ignore: must_be_immutable
class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  late String email;
  late String password;
  late String confirmPassword;

  String? validateEmail(String? value) {
    email = value!;
    if (emailValidator(value) != null) return emailValidator(value);
    return null;
  }

  String? validatePassword(String? value) {
    password = value!;
    if (passwordValidator(value) != null) {
      return passwordValidator(value);
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    confirmPassword = value!;
    if (password != confirmPassword) {
      return "Passwords do not match";
    } else {
      return passwordValidator(value);
    }
  }

  void submitForm(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthFormBloc>(context).add(
        RegisterWithEmailAndPasswordPressed(email: email, password: password),
      );
    } else {
      BlocProvider.of<AuthFormBloc>(context).add(
        RegisterWithEmailAndPasswordPressed(email: null, password: null),
      );
    }
  }

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text(
                          mapAuthFailureToMessage(failure),
                          style: themeData.textTheme.bodyLarge,
                        ),
                      ),
                    );
                  },
                  (success) {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return PlatformAlertDialog(
                            title: const Text("Success"),
                            content: const Text(
                                "To complete your registration, please check your email for a confirmation link."),
                            actions: [
                              PlatformDialogAction(
                                child: const Text("OK"),
                                onPressed: () => AutoRouter.of(context).replace(const LoginRoute()),
                              )
                            ],
                          );
                        });
                  },
                ));
      },
      builder: (context, state) {
        return Form(
          key: formKey,
          autovalidateMode: state.showValidationMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
          child: Column(
            children: [
              TextFormField(
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
                textInputAction: TextInputAction.next,
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                cursorColor: themeData.colorScheme.onPrimary,
                decoration: const InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: validateConfirmPassword,
                textInputAction: TextInputAction.done,
                onEditingComplete: () => submitForm(context),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              CustomButton(text: "Register", isLoading: state.isSubmitting, onPressed: () => submitForm(context)),
            ],
          ),
        );
      },
    );
  }
}
