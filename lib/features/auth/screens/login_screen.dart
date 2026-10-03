import 'package:ecommerce_app_using_bloc/core/common/snackbars/app_snackbar.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_bloc.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_event.dart';
import 'package:ecommerce_app_using_bloc/features/auth/bloc/auth_state.dart';
import 'package:ecommerce_app_using_bloc/features/auth/screens/forgot_password_screen.dart';
import 'package:ecommerce_app_using_bloc/features/auth/screens/sign_up_screen.dart';
import 'package:ecommerce_app_using_bloc/features/auth/widgets/app_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.authenticated) {

        }

        if (state.status == AuthStatus.failure) {
          AppSnackbar.show(context, state.errorMsg ?? 'Login failed');
        }
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/images/Bakhouse_logo.png',
                          height: 100,
                        ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        'Login to your account',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 20),
                      AppLabel(text: 'Gmail'),
                      SizedBox(height: 4),
                  
                      AppTextField(
                        controller: _emailTEController,
                        borderRadius: 28,
                        hint: 'you@gmail.com',
                      ),
                      AppLabel(text: 'Password'),
                  
                      AppTextField(
                        controller: _passwordTEController,
                        suffixIcon: Icon(
                          Icons.visibility_off,
                          color: Colors.grey.shade500,
                        ),
                        hint: 'Enter a password',
                        borderRadius: 28,
                      ),
                  
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              context.read<AuthBloc>().add(
                                    RememberMe(!state.isRememberMe),
                                  );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Checkbox(
                                  value: state.isRememberMe,
                                  onChanged: (value) {
                                    context.read<AuthBloc>().add(
                                          RememberMe(value ?? false),
                                        );
                                  },
                                  fillColor:
                                      WidgetStateProperty.resolveWith<Color>(
                                    (states) {
                                      if (states.contains(WidgetState.selected)) {
                                        return const Color(0xFF6B8FEE);
                                      }
                                      return Colors.white;
                                    },
                                  ),
                                  checkColor: Colors.white,
                                  side: BorderSide(
                                    color: state.isRememberMe
                                        ? const Color(0xFF6B8FEE)
                                        : Colors.grey.shade400,
                                    width: 1.5,
                                  ),
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  visualDensity: VisualDensity.compact,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'Remember me',
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                  
                          TextButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotPasswordScreen()));
                            },
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Forgot your password',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      AppButton(
                        onPressed: (){
                          context.read<AuthBloc>().add(
                            Login(
                              email: _emailTEController.text.trim(),
                              password: _passwordTEController.text.trim(),
                            ),
                          );
                        },
                        text: 'Login',
                        isLoading: state.status == AuthStatus.loading,
                        gradient: LinearGradient(
                          colors: [Color(0xFF76AAEA), Color(0xFF6B8FEE)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? "),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
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
      ),
    );
  }
}
