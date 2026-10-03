import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCode extends StatefulWidget {
  const PinCode({
    super.key,
    required this.otpController,
  });

  final TextEditingController otpController;

  @override
  State<PinCode> createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  late final PinInputController pinInputController;

  @override
  void initState() {
    super.initState();

    pinInputController = PinInputController(
      textController: widget.otpController,
    );
  }

  @override
  void dispose() {
    pinInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return MaterialPinField(
      length: 6,
      pinController: pinInputController,
      obscureText: true,
      keyboardType: TextInputType.number,
      theme: MaterialPinTheme(
        shape: MaterialPinShape.outlined,
        cellSize: const Size(50, 56),
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0,
        fillColor: const Color(0xFFE8ECF1),

      ),
      hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}