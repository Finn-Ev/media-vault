import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:media_vault/application/auth/remote_auth/remote_auth_form/remote_auth_form_bloc.dart';
import 'package:media_vault/core/validators.dart';
import 'package:media_vault/presentation/_routes/routes.gr.dart';
import 'package:media_vault/presentation/_widgets/custom_button.dart';

class ForgotPasswordForm extends StatelessWidget {
  ForgotPasswordForm({Key? key}) : super(key: key);

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String email;

  String? validateEmail(String? value) {
    if (emailValidator(value) == null) {
      email = value!;
      return null;
    } else {
      return emailValidator(value);
    }
  }

  void submitForm(context) {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthFormBloc>(context).add(ForgotPasswordPressed(email: email));
    } else {
      BlocProvider.of<AuthFormBloc>(context).add(ForgotPasswordPressed(email: null));
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
          (eitherFailureOrSuccess) {
            showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) => PlatformAlertDialog(
                title: const Text("Info"),
                content: const Text(
                    "If the email belongs to an account, you will receive an email with a link to reset your password."),
                actions: [
                  PlatformDialogAction(
                    child: PlatformText("OK"),
                    onPressed: () => AutoRouter.of(context).replace(const LoginRoute()),
                  ),
                ],
              ),
            );
          },
        );
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages ? AutovalidateMode.always : AutovalidateMode.disabled,
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
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 16.0),
              CustomButton(text: "Confirm", isLoading: state.isSubmitting, onPressed: () => submitForm(context)),
            ],
          ),
        );
      },
    );
  }
}
