import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:ecommerce_app_using_bloc/features/auth/widgets/app_level.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset('assets/images/Bakhouse_logo.png', height: 100),
          SizedBox(height: 30),
          Text(
            'Sign up to your account',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 20),
          AppLabel(text: 'Name'),
          SizedBox(height: 4),
          AppTextField(borderRadius: 28, hint: 'Enter your name'),
          SizedBox(height: 6),
          AppLabel(text: 'Gmail'),
          SizedBox(height: 4),
          AppTextField(borderRadius: 28, hint: "you@gmail.com"),
          SizedBox(height: 6),
          AppLabel(text: 'Password'),
          SizedBox(height: 4),
          AppTextField(borderRadius: 28, hint: "Enter a password"),
          SizedBox(height: 4),
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
              const Text(
                'I agree to the Terms of Service.',
                style: TextStyle(fontSize: 18),
              ),
            ],
          ),
          SizedBox(height: 20,),
          AppButton(text: 'Sign up'),
          SizedBox(height: 20,),
          Row(
            children: [
              Text('Already have an account?'),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Login'))
            ],
          )
        ],
      ),
    );
  }
}
