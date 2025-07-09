import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';

class FileSavedScreen extends StatefulWidget {
  final String? filepath;
  final bool isFileSaved;

  const FileSavedScreen(
      {super.key, this.filepath = '', required this.isFileSaved});

  @override
  State<FileSavedScreen> createState() => _FileSavedScreenState();
}

class _FileSavedScreenState extends State<FileSavedScreen> {
  // Removed unused getter

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("File Saved", context),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),
                      Center(
                          child: Column(children: [
                        Text(
                            widget.isFileSaved
                                ? "File Saved"
                                : "File Not Saved",
                            style: const TextStyle(
                                fontSize: 42,
                                fontFamily: "Inria Sans",
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(20, 77, 54, 0.875))),
                        const SizedBox(height: 10),
                        if (widget.isFileSaved)
                          const Image(
                            image: AssetImage(
                                "src/assets/images/file_success.png"),
                            width: 300,
                            height: 250,
                          )
                        else
                          const Icon(
                            Icons.error_outline_sharp,
                            size: 250,
                            color: Color.fromARGB(255, 195, 56, 46),
                          ),
                        const SizedBox(height: 10),
                        Text("File saved to:\n${widget.filepath}"),
                        const SizedBox(height: 10),
                        Row(
                            // mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomButton(
                                onClicked: () {
                                  Navigator.pop(context);
                                },
                                icon: Icons.arrow_back,
                                text: "Error",
                                buttonWidth: 135,
                                buttonHeight: 50,
                                buttonColor:
                                    const Color.fromARGB(255, 23, 96, 67),
                                textColor: const Color.fromARGB(255, 12, 9, 9),
                                textSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              if (widget.isFileSaved) ...{
                                const SizedBox(width: 40),
                                CustomButton(
                                  onClicked: () {},
                                  icon: Icons.file_open,
                                  text: "Open File",
                                  buttonWidth: 150,
                                  buttonHeight: 50,
                                  buttonColor:
                                      const Color.fromARGB(255, 23, 96, 67),
                                  textColor:
                                      const Color.fromARGB(255, 12, 9, 9),
                                  textSize: 16,
                                  fontWeight: FontWeight.bold,
                                )
                              }
                            ])
                      ]))
                    ]))));
  }
}
