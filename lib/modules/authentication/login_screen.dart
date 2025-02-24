import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/di/di.dart';
import 'package:four_you_ecommerce/core/inputs/email_text_field.dart';
import 'package:four_you_ecommerce/core/inputs/password_text_field.dart';
import 'package:four_you_ecommerce/core/network/dio/dio_helper.dart';
import 'package:four_you_ecommerce/core/network/repository.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/login_cubit.dart';
import 'package:svg_flutter/svg_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginCubit>(),
      child: Scaffold(
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            final cubit = LoginCubit.get(context);
            return SafeArea(
              child: SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            EmailTextField(
                              controller: emailController,
                              focusNode: emailNode,
                              hintText: 'Email',
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
                                  onPressed: () {},
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
                                      cubit.addNewUser();
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
