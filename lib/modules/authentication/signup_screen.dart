import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:four_you_ecommerce/core/constants/app_colors.dart';
import 'package:four_you_ecommerce/core/helpers/toasts.dart';
import 'package:four_you_ecommerce/core/inputs/default_text_form_field.dart';
import 'package:four_you_ecommerce/core/inputs/email_text_field.dart';
import 'package:four_you_ecommerce/core/inputs/password_text_field.dart';
import 'package:four_you_ecommerce/modules/authentication/cubit/auth_cubit.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final usernameController = TextEditingController();
  final emailNode = FocusNode();
  final passwordNode = FocusNode();
  final firstNameNode = FocusNode();
  final lastNameNode = FocusNode();
  final phoneNode = FocusNode();
  final usernameNode = FocusNode();

  @override
  void dispose() {
    emailNode.dispose();
    passwordNode.dispose();
    firstNameNode.dispose();
    lastNameNode.dispose();
    phoneNode.dispose();
    usernameNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is SignUpLoading) {
            EasyLoading.show(status: 'Loading...');
          } else if (state is SignUpSuccess) {
            EasyLoading.dismiss();
            context.pop();
          } else if (state is SignUpFailed) {
            EasyLoading.dismiss();
            Toasts.showErrorToast(
                context, "Failed to Signup, please try again");
          }
        },
        builder: (context, state) {
          final cubit = AuthCubit.get(context);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Let's Create Your Account",
                              style: TextStyle(
                                color: AppColors.textPrimaryColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            children: [
                              Flexible(
                                  child: DefaultTextFormField(
                                hintTitle: 'First Name',
                                controller: firstNameController,
                                focusNode: firstNameNode,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[a-zA-Z ]')), // Allows letters and spaces
                                ],
                                prefixIcon: Icon(Icons.person_outline),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This Field is Required';
                                  }
                                },
                                onSubmitted: (value) {
                                  setState(() {
                                    firstNameController.text = value;
                                  });
                                },
                              )),
                              const SizedBox(
                                width: 16,
                              ),
                              Flexible(
                                  child: DefaultTextFormField(
                                hintTitle: 'Last Name',
                                controller: lastNameController,
                                focusNode: lastNameNode,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(
                                      r'[a-zA-Z ]')), // Allows letters and spaces
                                ],
                                onSubmitted: (value) {
                                  setState(() {
                                    lastNameController.text = value;
                                  });
                                },
                                prefixIcon: Icon(Icons.person_outline),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This Field is Required';
                                  }
                                },
                              ))
                            ],
                          ),
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
                            height: 18,
                          ),
                          EmailTextField(
                            controller: emailController,
                            focusNode: emailNode,
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          DefaultTextFormField(
                            hintTitle: 'Phone Number',
                            controller: phoneController,
                            focusNode: phoneNode,
                            onSubmitted: (value) {
                              setState(() {
                                phoneController.text = value;
                              });
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            prefixIcon: Icon(Icons.phone_outlined),
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
                                    await cubit.addNewUser(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        firstName: firstNameController.text,
                                        lastName: lastNameController.text,
                                        userName: usernameController.text,
                                        phoneNumber: phoneController.text);
                                  }
                                },
                                style: const ButtonStyle(),
                                child: const Text("Create Account"),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
