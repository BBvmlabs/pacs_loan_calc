import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 70),
        Image(
          image: AssetImage("src/assets/images/logo.png"),
          width: 300,
          height: 250,
        ),
        SizedBox(height: 20),
        Text(
          'Loan Calculator',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 90, 48),
          ),
        ),
        Text('for PACS',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 0, 90, 48),
            )),
        SizedBox(height: 60),
      ]),
    );
  }
}
