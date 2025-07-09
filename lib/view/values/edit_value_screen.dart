import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class EditValueScreen extends StatefulWidget {
  const EditValueScreen({super.key});

  @override
  State<EditValueScreen> createState() => _EditValueScreenState();
}

class _EditValueScreenState extends State<EditValueScreen> {
  final TextEditingController loanNameController = TextEditingController();
  final TextEditingController normalInterestController =
      TextEditingController();
  final TextEditingController odInterestController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("Edit Values", context),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Wrap(children: [
              const Text("Loan Type",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Table(children: [
                buildTabelRow("Loan Name", loanNameController),
                buildTabelRow("Normal Interest", normalInterestController,
                    suffixIcon: Icons.percent),
                buildTabelRow("OD Interest", odInterestController,
                    suffixIcon: Icons.percent),
                buildTabelRow("No. of Months", monthsController,
                    prefixIcon: Icons.calendar_month),
              ]),
              const SizedBox(height: 20),
              const Text("Description",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: CustomTextInput(
                    label: "Info about the this Loan type",
                    controller: descriptionController,
                    readOnly: false,
                    fillColor: const Color.fromARGB(255, 237, 240, 239),
                    boxHeight: 150,
                    maxLines: 4,
                    boderRadius: 25,
                    boxWidth: double.infinity,
                  )),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onClicked: () {},
                    text: "Delete",
                    buttonColor: const Color.fromARGB(255, 200, 53, 43),
                    icon: Icons.delete,
                  ),
                  CustomButton(
                      onClicked: () {}, text: "Default", icon: Icons.refresh),
                ],
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20, left: 100),
                  child: CustomButton(
                      onClicked: () {},
                      text: "Save",
                      icon: Icons.check_circle_outlined)),
            ])));
  }

  TableRow buildTabelRow(String label, TextEditingController controller,
      {IconData? prefixIcon, IconData? suffixIcon, String? hinttext}) {
    return TableRow(children: [
      Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(5),
        child: CustomTextInput(
          controller: controller,
          label: label,
          readOnly: false,
          fillColor: Colors.greenAccent,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ),
    ]);
  }
}
