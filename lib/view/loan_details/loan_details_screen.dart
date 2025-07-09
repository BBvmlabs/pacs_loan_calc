import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class LoanDetails extends StatefulWidget {
  const LoanDetails({super.key});

  @override
  State<LoanDetails> createState() => _LoanDetailsState();
}

class _LoanDetailsState extends State<LoanDetails> {
  final nameController = TextEditingController();
  final loanIdController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final pincodeController = TextEditingController();
  final officeNameController = TextEditingController();
  final loanAgentController = TextEditingController();
  final officeIdController = TextEditingController();
  final officePhoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    loanIdController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    pincodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(children: [
              buildTabelRow("Name", nameController, false,
                  prefixIcon: Icons.person),
              buildTabelRow("Loan ID", loanIdController, false,
                  prefixIcon: Icons.person),
              buildTabelRow("Phone Number", phoneNumberController, false,
                  prefixIcon: Icons.phone),
            ]),
            const SizedBox(height: 5),
            const Padding(
                padding: EdgeInsets.all(5),
                child: Text("Address",
                    style: TextStyle(fontWeight: FontWeight.bold))),
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: CustomTextInput(
                  label: "Address",
                  controller: addressController,
                  hintText: "Enter the Address",
                  readOnly: false,
                  boxHeight: 150,
                  maxLines: 4,
                  boderRadius: 25,
                  boxWidth: double.infinity,
                  fillColor: const Color.fromARGB(255, 200, 202, 202),
                )),
            Table(children: [
              buildTabelRow("Pincode", pincodeController, false,
                  prefixIcon: Icons.location_on_sharp),
              buildTabelRow("Office Name", officeNameController, false,
                  prefixIcon: Icons.work),
              buildTabelRow("Loan Agent", loanAgentController, false,
                  prefixIcon: Icons.work),
              buildTabelRow("Office ID", officeIdController, false,
                  prefixIcon: Icons.work),
              buildTabelRow("Office Phone", officePhoneController, false,
                  prefixIcon: Icons.phone),
              TableRow(children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 25.0, right: 140.0, top: 5.0),
                    child: CustomButton(
                      buttonHeight: 50,
                      buttonWidth: 70,
                      onClicked: () {},
                      icon: Icons.arrow_back_ios,
                    )),
                Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: CustomButton(
                      onClicked: () {},
                      text: "Proceed",
                      icon: Icons.arrow_forward_ios,
                    )),
              ])
            ])
          ],
        ));
  }
}
