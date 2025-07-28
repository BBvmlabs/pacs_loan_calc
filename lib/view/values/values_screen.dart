import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/view/values/edit_value_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/view_model/loan_types_view_model.dart';

class ValuesScreen extends StatefulWidget {
  const ValuesScreen({super.key});

  @override
  State<ValuesScreen> createState() => _ValuesScreenState();
}

class _ValuesScreenState extends State<ValuesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("Values", context),
        body: Consumer<LoanTypesViewModel>(
          builder: (context, vm, child) {
            final loanTypes = vm.loanTypes;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: loanTypes.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final loan = loanTypes[index];
                      return Card(
                          elevation: 2,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Text(loan.name,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 18, 127, 22)))),
                                      const SizedBox(width: 10),
                                      IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  EditValueScreen(
                                                      title: loan.name,
                                                      editIndex: index),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.edit),
                                      )
                                    ]),
                                buildTable(loan),
                              ]));
                    },
                  ),
                  const SizedBox(height: 25),
                  Center(
                    child: CustomButton(
                      onClicked: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const EditValueScreen(
                                title: "New Loan Type", editIndex: null),
                          ),
                        );
                      },
                      textSize: 20,
                      textColor: Colors.black87,
                      fontWeight: FontWeight.bold,
                      text: "Add New",
                      buttonColor: Colors.green.shade800,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }

  Table buildTable(loanData) {
    return Table(
      children: [
        buildTableRow([
          buildRowText("No. of \nMonths"),
          buildRowText("Interest \nPersentage"),
          buildRowText("OD \nPersentage"),
        ]),
        buildTableRow([
          buildTextInput("Months", loanData.months, null, Icons.calendar_month),
          buildTextInput(
              "Intrest", loanData.normalPercentage, null, Icons.percent),
          buildTextInput("OD", loanData.odPercentage, null, Icons.percent),
        ])
      ],
    );
  }

  TableRow buildTableRow(List<Widget> children) {
    return TableRow(children: children);
  }

  Widget buildRowText(String label) {
    return Center(
        child: Text(label,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w600)));
  }

  Widget buildTextInput(String hintText, dynamic value, IconData? prefixIcon,
      IconData? suffixIcon) {
    return Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          // color: Colors.greenAccent,
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // mainAxisSize: MainAxisSize.max,
            children: [
              if (prefixIcon != null) Icon(prefixIcon, size: 18),
              Text(
                value.toString(),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (suffixIcon != null) Icon(suffixIcon, size: 18),
            ],
          ),
        ));
  }
}
