import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("About", context),
        body: const Wrap(
            spacing: 10.0,
            runSpacing: 1.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              const SingleChildScrollView(
                  child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Text('Version: 1.0.0', style: TextStyle(fontSize: 16)),
                      Text('BBVMLABS',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic)),
                    ]),
              ))
            ]));
  }
}
