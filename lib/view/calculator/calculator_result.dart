import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/utils/datephraser.dart';
import 'package:pacs_loan_calc/view_model/calculator_result_view_model.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class CalculatorResult extends StatefulWidget {
  final String? loanName;
  final double? loanAmount;
  final double? interestRate;
  final double? odInterestRate;
  final int? months;
  final DateTime? sanctionDate;
  final DateTime? interestStartDate;
  final DateTime? givenEndDate;

  const CalculatorResult(
      {super.key,
      this.loanName,
      this.loanAmount,
      this.interestRate,
      this.odInterestRate,
      this.months,
      this.sanctionDate,
      this.interestStartDate,
      this.givenEndDate});

  @override
  State<CalculatorResult> createState() => _CalculatorResultState();
}

class _CalculatorResultState extends State<CalculatorResult> {
  final TextEditingController loanTypeController = TextEditingController();
  final TextEditingController monthTypeController = TextEditingController();
  final TextEditingController persentageTypeController =
      TextEditingController();
  final TextEditingController odPersentageController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController sancationDateController = TextEditingController();
  final TextEditingController intrestStarts = TextEditingController();
  final TextEditingController givenDateController = TextEditingController();
  final TextEditingController emiController = TextEditingController();
  final TextEditingController calculatedInterestDays = TextEditingController();
  final TextEditingController calculatedInterestAmount =
      TextEditingController();
  final TextEditingController calculatedInterestOther = TextEditingController();
  final TextEditingController totalInterestAmount = TextEditingController();
  final TextEditingController totalAddOther = TextEditingController();
  final TextEditingController totalAmount = TextEditingController();
  final TextEditingController totaldaysController = TextEditingController();
  final TextEditingController odDaysInterestAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar("Loan Result", context),
        body: Consumer<CalculatorResultViewModel>(
            builder: (context, viewModel, child) {
          CalculatorResultViewModel result = CalculatorResultViewModel(
            loanName: widget.loanName ?? '',
            loanAmount: widget.loanAmount ?? 0.0,
            interestRate: widget.interestRate ?? 0.0,
            odInterestRate: widget.odInterestRate ?? 0.0,
            months: widget.months ?? 0,
            sanctionDate: widget.sanctionDate ?? DateTime.now(),
            interestStartDate: widget.interestStartDate ?? DateTime.now(),
            givenEndDate: widget.givenEndDate ?? DateTime.now(),
          );

          final result_data = result.calculate();

          loanTypeController.text = result_data['loanName'] ?? 'No Name';
          monthTypeController.text =
              result_data['months'].toString() ?? 'Months';
          persentageTypeController.text =
              result_data['interestRate'].toString() ?? 'Persentage';
          odPersentageController.text =
              result_data['odInterestRate'].toString() ?? 'Persentage';
          loanAmountController.text =
              result_data['loanAmount'].toString() ?? 'Loan Amount';
          sancationDateController.text =
              Datephraser(inputDate: result_data['sanctionDate'].toString())
                  .toDdMmYyyy();
          intrestStarts.text = Datephraser(
                  inputDate: result_data['interestStartDate'].toString())
              .toDdMmYyyy();
          givenDateController.text =
              Datephraser(inputDate: result_data['givenEndDate'].toString())
                  .toDdMmYyyy();
          'Given Date';
          emiController.text = result_data['emi'].toString() ?? 'EMI';
          calculatedInterestDays.text =
              result_data['calculatedInterestDays'].toString() ??
                  'Calculated Interest Days';
          calculatedInterestAmount.text =
              result_data['calculatedInterestAmount'].toString() ??
                  'Calculated Interest Amount';
          calculatedInterestOther.text =
              result_data['calculatedInterestOther'].toString() ??
                  'Calculated Interest Other';
          totalInterestAmount.text =
              result_data['totalInterestAmount'].toString() ??
                  'Total Interest Amount';
          totalAddOther.text =
              result_data['totalAddOther'].toString() ?? 'Total Add Other';
          totalAmount.text =
              result_data['totalAmount'].toString() ?? 'Total Amount';
          totaldaysController.text =
              result_data['totaldays'].toString() ?? 'Total Days';
          odDaysInterestAmount.text =
              result_data['odDaysInterestAmount'].toString() ??
                  'OD Days Interest Amount';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
              child: Wrap(
                  spacing: 10.0,
                  runSpacing: 1.0,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  children: [
                    LoanCalculatorRow(
                        label: "Loan Type",
                        controller: loanTypeController,
                        readOnly: true),
                    Table(children: [
                      TableRow(children: [
                        buildRowText("No. of \nMonths"),
                        buildRowText("Interest \nPersentage"),
                        buildRowText("OD \nPersentage"),
                      ]),
                      TableRow(
                        children: [
                          buildRowWidgets("months", monthTypeController,
                              Colors.cyan.shade100, Icons.calendar_month, null),
                          buildRowWidgets("Intrest", persentageTypeController,
                              Colors.cyan.shade100, Icons.percent, null),
                          buildRowWidgets("OD", odPersentageController,
                              Colors.cyan.shade100, null, Icons.percent),
                        ],
                      )
                    ]),
                    Table(children: [
                      buildTabelRow("Loan Amount", loanAmountController, true,
                          prefixIcon: Icons.currency_rupee),
                      buildTabelRow(
                          "Sancation Date", sancationDateController, true,
                          prefixIcon: Icons.calendar_month_sharp),
                      buildTabelRow("Interest Start Date", intrestStarts, true,
                          prefixIcon: Icons.calendar_today_sharp),
                      buildTabelRow("Up to Date", givenDateController, true,
                          prefixIcon: Icons.calendar_month_sharp),
                    ]),
                    const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Center(
                          child: Text("Calculated Interest",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        )),
                    LoanCalculatorRow(
                        controller: totalAmount,
                        hintText: "Total Amount",
                        label: "Total Amount",
                        prefixIcon: Icons.currency_rupee_sharp,
                        readOnly: true),
                    Table(
                      children: [
                        TableRow(
                          children: [
                            buildRowText(""),
                            buildRowText("Normal"),
                            buildRowText("OD"),
                            buildRowText("Total"),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildRowText("Days"),
                            buildRowWidgets(
                                "Normal",
                                calculatedInterestAmount,
                                Colors.greenAccent,
                                Icons.calendar_today_rounded,
                                null),
                            buildRowWidgets(
                                "OD",
                                odDaysInterestAmount,
                                Colors.greenAccent,
                                Icons.calendar_today_rounded,
                                null),
                            buildRowWidgets(
                                "Total",
                                totaldaysController,
                                Colors.greenAccent,
                                Icons.calendar_today_rounded,
                                null),
                          ],
                        ),
                        TableRow(
                          children: [
                            buildRowText("Amount"),
                            buildRowWidgets(
                                "Normal",
                                calculatedInterestAmount,
                                Colors.greenAccent,
                                Icons.currency_rupee_sharp,
                                null),
                            buildRowWidgets(
                                "OD",
                                odDaysInterestAmount,
                                Colors.greenAccent,
                                Icons.currency_rupee_sharp,
                                null),
                            buildRowWidgets(
                                "Total",
                                totalInterestAmount,
                                Colors.greenAccent,
                                Icons.currency_rupee_sharp,
                                null)
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 5, right: 20, bottom: 5),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Others",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            CustomTextInput(
                              controller: calculatedInterestOther,
                              label: "Others",
                              fillColor: Colors.greenAccent,
                              boxWidth: 90,
                              keyboardType: TextInputType.number,
                              prefixIcon: Icons.currency_rupee_sharp,
                            ),
                            CustomButton(
                              onClicked: () {},
                              text: "Total + Others",
                              buttonColor: Colors.green,
                              buttonWidth: 130,
                              buttonHeight: 40,
                              textSize: 16,
                            ),
                          ]),
                    ),
                    LoanCalculatorRow(
                      controller: totalAmount,
                      label: "Final Amount",
                      readOnly: true,
                      fontSize: 20,
                      prefixIcon: Icons.currency_rupee_sharp,
                    ),
                    const SizedBox(height: 20),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: CustomButton(
                                icon: Icons.camera_alt_rounded,
                                onClicked: () {},
                                buttonColor: Colors.green,
                                buttonHeight: 50,
                                buttonWidth: 80,
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: CustomButton(
                                icon: Icons.download,
                                text: "Save",
                                onClicked: () {
                                  Navigator.pushNamed(context, '/loan-details');
                                },
                                buttonColor: Colors.green,
                                buttonHeight: 50,
                                buttonWidth: 110,
                              )),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: CustomButton(
                                icon: Icons.delete,
                                text: "Clear",
                                onClicked: () {
                                  setState(() {
                                    loanTypeController.clear();
                                    monthTypeController.clear();
                                    persentageTypeController.clear();
                                    odPersentageController.clear();
                                    loanAmountController.clear();
                                    sancationDateController.clear();
                                    intrestStarts.clear();
                                    givenDateController.clear();
                                    calculatedInterestAmount.clear();
                                    odDaysInterestAmount.clear();
                                    totaldaysController.clear();
                                    totalInterestAmount.clear();
                                    calculatedInterestOther.clear();
                                    totalAmount.clear();
                                  });
                                  Navigator.pop(context);
                                },
                                buttonColor: Colors.green,
                                buttonHeight: 50,
                                buttonWidth: 110,
                              )),
                        ])
                  ]),
            ),
          );
        }));
  }

  Widget buildRowText(String label) => Padding(
      padding: const EdgeInsets.only(top: 15),
      child: Center(
          child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      )));
  Widget buildRowWidgets(String label, TextEditingController controller,
          Color color, IconData? prefixIcon, IconData? suffixIcon) =>
      Padding(
        padding: const EdgeInsets.all(5),
        child: CustomTextInput(
          controller: controller,
          hintText: label,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          readOnly: true,
          fillColor: color,
        ),
      );
}
