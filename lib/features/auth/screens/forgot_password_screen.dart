import 'package:ecommerce_app_using_bloc/core/common/widgets/app_button.dart';
import 'package:ecommerce_app_using_bloc/core/common/widgets/app_text_field.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter your email account to reset your password', style: TextStyle(
                    fontSize: 20
                  ),
                  ),
                  SizedBox(height: 4,),
                  AppTextField(
                    borderRadius: 28,
                    controller: _emailTEController,
                    hint: 'abc@gmail.com',
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey.shade500),
                  ),
                  SizedBox(height: 20,),
                  AppButton(text: "Continue", gradient: LinearGradient(
                    colors: [Color(0xFF76AAEA), Color(0xFF6B8FEE)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                    textColor: Colors.white,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
