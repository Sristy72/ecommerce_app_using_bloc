import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
        actions: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: const Color(0xFF7F3615)),
            ),
            child: const Padding(
              padding: EdgeInsets.all(10),
              child: Center(
                child: Icon(Icons.search, color: Color(0xFF7F3615)),
              ),
            ),
          ),
        ],
      ),
      body: Column(

      ),
    );
  }
}
