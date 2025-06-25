import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';
import 'package:pacs_loan_calc/widgets/loan_type_dropdown.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController termController = TextEditingController();
  final TextEditingController monthsEditingController = TextEditingController();
  final TextEditingController amountEditingcontroller = TextEditingController();
  final TextEditingController startingDateEditingcontroller = TextEditingController();
  final TextEditingController endingDateEditingcontroller = TextEditingController(); // Added for end date

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Text("Loan Type"),
            SizedBox(width: 15),
            CustomDropDown(
              items: const [
                'Home Loan',
                'Personal Loan',
                'Business Loan',
              ],
            ),
          ],),
          LoanCalculatorRow(
            label: "Interest Percentage",
            controller: interestController,
            hintText: "Enter Interest",
            suffixIcon: Icons.percent,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          LoanCalculatorRow(
            label: "OD Percentage",
            controller: termController,
            suffixIcon: Icons.percent,
            hintText: "Enter OD",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          LoanCalculatorRow(
            label: "Loan Amount in\nRs.Ps",
            controller: amountController,
            suffixIcon: Icons.currency_rupee,
            hintText: "Enter Loan Amount",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          LoanCalculatorRow(
            label: "Loan Sanctioned\nDate",
            controller: monthsEditingController,
            suffixIcon: Icons.calendar_month,
            hintText: "Enter Sanctioned Date",
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 32),

          const Center(child: Text(
            "Select Interest Start Date",
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center
          )),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sanctioned Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 15),
              const CustomIconSwitch(

                onIcon: Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Color.fromARGB(255, 41, 41, 41),
                ),
                offIcon: Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Color.fromARGB(255, 0, 124, 27),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextInput(
                  boxWidth: 30,
                  controller: startingDateEditingcontroller,
                  label: "Interest Start Date",
                  hintText: "Start Date",
                  suffixIcon: Icons.calendar_month,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          const Center(child: Text(
            "Today Date or Custom Date",
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 16),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Today Date",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 15),
              const CustomIconSwitch(

                onIcon: Icon(
                  Icons.arrow_circle_right_rounded,
                  color: Color.fromARGB(255, 41, 41, 41),
                ),
                offIcon: Icon(
                  Icons.arrow_circle_left_rounded,
                  color: Color.fromARGB(255, 0, 124, 27),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: CustomTextInput(
                  boxWidth: 30,
                  controller: endingDateEditingcontroller,
                  label: "Ending Date",
                  hintText: "End Date",
                  suffixIcon: Icons.calendar_month,
                ),
              )
            ],
          ),
          const SizedBox(height: 30),
          Center(child: CustomButton(
            text: "Calculate",
            onClicked: () {},
            buttonWidth: 300,
            buttonHeight: 50,
            textColor: Colors.black,
            textSize: 20,
            fontWeight: FontWeight.bold,
            buttonColor: const Color.fromARGB(255, 0, 82, 37),
          )),
            ],
            ) 
          );
  }
}
