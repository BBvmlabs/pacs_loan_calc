import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';
import 'package:file_picker/file_picker.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _locationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 10.0,
        runSpacing: 1.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          Row(children: [
            backButton(context),
            const Text("Settings",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 20)
          ]),
          SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("File Save Location",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    CustomTextInput(
                      controller: TextEditingController(),
                      label: "Location",
                      readOnly: true,
                      fillColor: Colors.greenAccent,
                      suffixIcon: Icons.folder,
                      onTap: () async {
                        String? selectedDirectory =
                            await FilePicker.platform.getDirectoryPath();
                        if (selectedDirectory != null) {
                          setState(() {
                            _locationController.text = selectedDirectory;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: CustomButton(
                        onClicked: () {},
                        text: "Save",
                        icon: Icons.save,
                        buttonHeight: 40,
                        buttonWidth: 130,
                      ),
                    )
                  ])),
        ]);
  }
}
