import 'package:ecommerce_app_using_bloc/core/common/snackbars/app_snackbar.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_state.dart';
import 'package:ecommerce_app_using_bloc/features/auth/screens/otp_verification_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.forgotPasswordSuccess) {
          AppSnackbar.show(
            context,
            'OTP sent to your email',
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OtpVerificationScreen(
                email: _emailTEController.text.trim(),
              ),
            ),
          );
        }

        if (state.status == AuthStatus.failure) {
          AppSnackbar.show(
            context,
            state.errorMsg ?? 'Failed to send reset code',
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.75,
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter your email account to reset your password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      AppTextField(
                        borderRadius: 28,
                        controller: _emailTEController,
                        hint: 'abc@gmail.com',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        text: "Continue",
                        isLoading: state.status == AuthStatus.loading,
                        onPressed: () {
                          final email = _emailTEController.text.trim();
                          if (email.isEmpty) {
                            AppSnackbar.show(
                              context,
                              'Please enter your email',
                            );
                            return;
                          }
                          context
                              .read<AuthBloc>()
                              .add(ForgotPass(email: email));
                        },
                        gradient: const LinearGradient(
                          colors: [Color(0xFF76AAEA), Color(0xFF6B8FEE)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        textColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
