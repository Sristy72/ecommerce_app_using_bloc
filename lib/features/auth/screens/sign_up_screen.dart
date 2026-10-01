import 'package:ecommerce_app_using_bloc/core/common/snackbars/app_snackbar.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_state.dart';
import 'package:ecommerce_app_using_bloc/features/auth/screens/login_screen.dart';
import 'package:ecommerce_app_using_bloc/features/auth/widgets/app_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  void dispose() {
    _nameTEController.dispose();
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
        }

        if (state.status == AuthStatus.failure) {
          AppSnackbar.show(context, state.errorMsg ?? 'Signup failed');
        }
      },
      child: Scaffold(
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(18.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 40,),
                    Image.asset('assets/images/Bakhouse_logo.png', height: 100),
                    SizedBox(height: 30),
                    Text(
                      'Sign up to your account',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 20),
                    AppLabel(text: 'Name'),
                    SizedBox(height: 4),
                    AppTextField(borderRadius: 28, hint: 'Enter your name', controller: _nameTEController,),
                    SizedBox(height: 6),
                    AppLabel(text: 'Gmail'),
                    SizedBox(height: 4),
                    AppTextField(borderRadius: 28, hint: "you@gmail.com", controller:
                      _emailTEController,),
                    SizedBox(height: 6),
                    AppLabel(text: 'Password'),
                    SizedBox(height: 4),
                    AppTextField(borderRadius: 28, hint: "Enter a password", controller: _passwordTEController,),
                    SizedBox(height: 4),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: state.isTermsAndConditions,
                          onChanged: (va) {
                            context.read<AuthBloc>().add(
                                TermsAndCondition(va ?? false)
                            );
                          },
                          fillColor: WidgetStateProperty.all(Colors.white),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          checkColor: Colors.black,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'I agree to the Terms of Service.',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      text: 'Sign up',
                      onPressed: () =>
                          context.read<AuthBloc>().add(
                            Signup(
                              name: _nameTEController.text.trim(),
                              email: _emailTEController.text.trim(),
                              password: _passwordTEController.text,
                              termsCondition: state.isTermsAndConditions,
                            ),
                          ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Login'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
