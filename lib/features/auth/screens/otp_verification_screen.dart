import 'package:ecommerce_app_using_bloc/features/auth/widgets/pincode.dart';
import 'package:flutter/material.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Please check your Email for a message with your code. Your code is 6 numbers long.',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 30),
          PinCode(otpController: otpController),
          SizedBox(height: 20),
          Text('Resend otp in 60s'),
          TextButton(onPressed: (){}, child: Text('Resend code'))
        ],
      ),
    );
  }
}
