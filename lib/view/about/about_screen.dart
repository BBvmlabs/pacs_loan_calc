// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

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
        body: Wrap(
            spacing: 10.0,
            runSpacing: 1.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              SingleChildScrollView(
                  child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      const Image(
                        image: AssetImage("src/assets/images/logo.png"),
                        width: 300,
                        height: 250,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Loan Calculator',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 90, 48),
                        ),
                      ),
                      const Text('for PACS',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 90, 48),
                          )),
                      const SizedBox(height: 60),
                      const Text('Version: 1.0.0',
                          style: TextStyle(fontSize: 16)),
                      TextButton(
                          onPressed: _launchURL,
                          child: const Text('BBVMLABS',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic))),
                    ]),
              ))
            ]));
  }

  void _launchURL() async {
    final Uri url = Uri.parse('https://portfolio.bbvmlabs.online');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
