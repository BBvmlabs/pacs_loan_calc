import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class ValuesScreen extends StatefulWidget {
  const ValuesScreen({super.key});

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  final TextEditingController monthsController = TextEditingController();
  final TextEditingController intrestController = TextEditingController();
  final TextEditingController odController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Wrap(children: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 30,
          )),
      const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Text(
            "Values",
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
          )),
      SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Wrap(
            spacing: 10.0,
            runSpacing: 1.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: [
              buildRow("Loan Type", TextEditingController(), "Loan Type"),
              const SizedBox(height: 10),
              buildTable(),
              const SizedBox(height: 25),
              buildRow("Loan Type", TextEditingController(), "Loan Type"),
              const SizedBox(height: 10),
              buildTable(),
              const SizedBox(height: 25),
              buildRow("Loan Type", TextEditingController(), "Loan Type"),
              const SizedBox(height: 10),
              buildTable(),
              const SizedBox(height: 25),
              Center(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                    CustomButton(
                      onClicked: () {},
                      textSize: 20,
                      text: "Default",
                      buttonColor: Colors.green.shade800,
                      textColor: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomButton(
                      onClicked: () {},
                      textSize: 20,
                      textColor: Colors.black87,
                      fontWeight: FontWeight.bold,
                      text: "Save",
                      buttonColor: Colors.green.shade800,
                    ),
                  ])),
            ]),
      ),
    ]);
  }

  Widget buildRow(
      String label, TextEditingController controller, String hintText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        CustomTextInput(
          controller: controller,
          hintText: hintText,
          readOnly: true,
          boxWidth: 170,
          fillColor: Colors.greenAccent,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.edit,
            color: Colors.black,
          ),
          style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all<Color>(Colors.green.shade800),
          ),
        )
      ],
    );
  }

  Widget buildRowText(String label) {
    return Center(
        child: Text(label,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600)));
  }

  TableRow buildTableRow(List<Widget> children) {
    return TableRow(children: children);
  }

  Table buildTable() {
    return Table(
      children: [
        buildTableRow([
          buildRowText("No. of \nMonths"),
          buildRowText("Interest \nPersentage"),
          buildRowText("OD \nPersentage"),
        ]),
        buildTableRow([
          buildTextInput(
              "Months", monthsController, Icons.calendar_month, null),
          buildTextInput("Intrest", intrestController, null, Icons.percent),
          buildTextInput("OD", odController, null, Icons.percent),
        ])
      ],
    );
  }

  Widget buildTextInput(String hintText, TextEditingController controller,
      IconData? prefixIcon, IconData? suffixIcon) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: (CustomTextInput(
          controller: controller,
          hintText: hintText,
          readOnly: true,
          boxWidth: 170,
          fillColor: Colors.greenAccent,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
        )));
  }
}
