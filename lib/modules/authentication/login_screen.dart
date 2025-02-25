import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/core/inputs/default_text_form_field.dart';
import 'package:four_you_ecommerce/core/inputs/password_text_field.dart';
import 'package:four_you_ecommerce/core/routing/routes.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:svg_flutter/svg_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    usernameNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<AuthCubit>(),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              EasyLoading.show(status: 'Loading...');
            } else if (state is LoginSuccess) {
              EasyLoading.dismiss();
              context.goNamed(Routes.home, extra: AuthCubit.get(context));
            } else if (state is LoginFailed) {
              EasyLoading.dismiss();
              Toasts.showErrorToast(
                  context, "Failed to Login, please try again");
            }
          },
          builder: (context, state) {
            final cubit = AuthCubit.get(context);
            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 16),
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          fit: BoxFit.contain,
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 70,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Welcome back,",
                                style: TextStyle(
                                  color: AppColors.textPrimaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                )),
                            const Text(
                                "Discover Limitless Choices and Unlimited Convenience",
                                style: TextStyle(
                                  color: AppColors.textPrimaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                )),
                            const SizedBox(
                              height: 18,
                            ),
                            DefaultTextFormField(
                              hintTitle: 'Username',
                              controller: usernameController,
                              focusNode: usernameNode,
                              onSubmitted: (value) {
                                setState(() {
                                  usernameController.text = value;
                                });
                              },
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[a-zA-Z ]')), // Allows letters and spaces
                              ],
                              prefixIcon:
                                  const Icon(Icons.person_add_alt_1_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This Field is Required';
                                }
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            PasswordTextField(
                              labelText: 'Password',
                              controller: passwordController,
                              focusNode: passwordNode,
                              hintText: 'Password',
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await cubit.login(
                                          username: usernameController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  style: const ButtonStyle(),
                                  child: const Text("Sign In"),
                                )),
                            const SizedBox(
                              height: 18,
                            ),
                            SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                    onPressed: () {
                                      context.pushNamed(Routes.signup,
                                          extra: cubit);
                                    },
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          Colors.transparent),
                                      side: WidgetStatePropertyAll(
                                          BorderSide(color: Colors.grey)),
                                    ),
                                    child: const Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: AppColors.textPrimaryColor),
                                    )))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
