import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Email', style: TextStyle(fontSize: 18)),
            ),
            SizedBox(height: 4),

            AppTextField(borderRadius: 28, hint: 'you@gmail.com'),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Password', style: TextStyle(fontSize: 18)),
            ),

            AppTextField(
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Checkbox(
                      value: false,
                      onChanged: (value) {},
                      fillColor: WidgetStateProperty.all(Colors.white),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 4),
                    const Text('Remember me', style: TextStyle(fontSize: 18)),
                  ],
                ),

                TextButton(
                  onPressed: () {},
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
              text: 'Login',
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
                  onTap: () {},
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
  }
}
