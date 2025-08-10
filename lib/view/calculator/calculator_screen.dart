import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pacs_loan_calc/utils/datephraser.dart';
import 'package:pacs_loan_calc/view/calculator/calculator_result.dart';
import 'package:pacs_loan_calc/widgets/app_bar.dart';
import 'package:provider/provider.dart';
import 'package:pacs_loan_calc/view_model/calculator_view_model.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/date_picker_button.dart';
import '../../widgets/calculator_button.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController amountController = TextEditingController();
  final TextEditingController interestController = TextEditingController();
  final TextEditingController odInterestController = TextEditingController();
  final TextEditingController monthsController = TextEditingController();
  final TextEditingController sanctionDateController = TextEditingController();
  final TextEditingController interestStartDateController =
      TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool useSanctionAsStart = false;
  bool useTodayAsEnd = false;
  String? selectedLoanType;
  bool readOnly = false;
  // LoanTypeModel? selectedLoan;

  @override
  void initState() {
    super.initState();
    // Default dates
    final today = DateTime.now();
    final todayStr = "${today.day}/${today.month}/${today.year}";
    endDateController.text = todayStr;
    CalculatorViewModel().loadLoanTypes();

    sanctionDateController.addListener(() {
      if (!useSanctionAsStart) {
        interestStartDateController.text = sanctionDateController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar('PACS Loan Calculator', context, isHome: true),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => CalculatorViewModel()..loadLoanTypes())
          ],
          child: Builder(
            builder: (context) {
              return SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        sectionTitle("Loan Details"),
                        buildCard([
                          buildRow(
                              "Loan Type",
                              DropdownButton<String>(
                                borderRadius: BorderRadius.circular(12),
                                isExpanded: true,
                                value: selectedLoanType,
                                hint: const Text("Select Loan Type"),
                                items: [
                                  ...context
                                      .watch<CalculatorViewModel>()
                                      .loanTypes
                                      .map((loan) {
                                    return DropdownMenuItem<String>(
                                      value: loan.name, // ✅ required
                                      child: Text(loan.name),
                                    );
                                  }),
                                  const DropdownMenuItem<String>(
                                    value: null,
                                    child: Text("Custom"), // ✅ required
                                  ),
                                ],
                                onChanged: (value) {
                                  final exists = context
                                      .read<CalculatorViewModel>()
                                      .loanTypes
                                      .any((loan) => loan.name == value);

                                  if (exists) {
                                    setState(() {
                                      readOnly = true;
                                      selectedLoanType = value;

                                      final loan = context
                                          .read<CalculatorViewModel>()
                                          .loanTypes
                                          .firstWhere((l) => l.name == value);

                                      interestController.text =
                                          loan.normalPercentage.toString();
                                      odInterestController.text =
                                          loan.odPercentage.toString();
                                      monthsController.text =
                                          loan.months.toString();
                                    });
                                  } else {
                                    setState(() {
                                      selectedLoanType = null; // fallback
                                      readOnly = false;
                                      readOnly = false;
                                      interestController.clear();
                                      odInterestController.clear();
                                      monthsController.clear();
                                    });
                                  }
                                },
                              )),
                          buildRow(
                              "Interest %",
                              buildTextInput(
                                interestController,
                                label: "Interest",
                                readOnly: readOnly,
                              )),
                          buildRow(
                              "OD %",
                              buildTextInput(
                                odInterestController,
                                label: "OD Interest",
                                readOnly: readOnly,
                              )),
                          buildRow(
                              "Months",
                              buildTextInput(
                                monthsController,
                                label: "Months",
                                readOnly: readOnly,
                              )),
                        ]),
                        sectionTitle("Loan Sanction Details"),
                        buildCard([
                          buildRow(
                            "Loan Amount",
                            buildTextInput(
                              amountController,
                              label: "Amount",
                              prefix: true,
                              inputFormatters: [
                                IndianCurrencyInputFormatter(),
                              ],
                            ),
                          ),
                          buildRow(
                              "Sanction Date",
                              buildDateInput(
                                controller: sanctionDateController,
                                readOnly: false,
                                onSuffixPressed: () async {
                                  final picked = await showDialog<DateTime>(
                                    context: context,
                                    builder: (context) =>
                                        const CustomDatePicker(),
                                  );
                                  if (picked != null) {
                                    final formatted =
                                        "${picked.day}/${picked.month}/${picked.year}";
                                    sanctionDateController.text = formatted;
                                    if (useSanctionAsStart) {
                                      interestStartDateController.text =
                                          formatted;
                                    }
                                  }
                                },
                              )),
                        ]),
                        sectionTitle("Interest Start Date"),
                        buildCard([
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Sanction Date"),
                              const SizedBox(width: 10),
                              CustomIconSwitch(
                                value: useSanctionAsStart,
                                onChanged: (val) {
                                  setState(() {
                                    useSanctionAsStart = val;
                                    if (!val) {
                                      // Switch is OFF: use sanction date
                                      interestStartDateController.text =
                                          sanctionDateController.text;
                                    } else {
                                      // Switch is ON: clear for custom date
                                      interestStartDateController.clear();
                                    }
                                  });
                                },
                                onIcon: const Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Colors.white),
                                offIcon: const Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Text("Custom Date"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          buildDateInput(
                            controller: interestStartDateController,
                            hintText: !useSanctionAsStart
                                ? "Sanction Date"
                                : "DD/MM/YYYY",
                            readOnly:
                                !useSanctionAsStart, // Switch OFF: readOnly, use sanction date
                            onSuffixPressed: useSanctionAsStart
                                ? () async {
                                    final picked = await showDialog<DateTime>(
                                      context: context,
                                      builder: (context) =>
                                          const CustomDatePicker(),
                                    );
                                    if (picked != null) {
                                      interestStartDateController.text =
                                          "${picked.day.toString().padLeft(2, '0')}/"
                                          "${picked.month.toString().padLeft(2, '0')}/"
                                          "${picked.year}";
                                    }
                                  }
                                : null,
                          ),
                        ]),
                        sectionTitle("End Date"),
                        buildCard([
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Today"),
                              const SizedBox(width: 10),
                              CustomIconSwitch(
                                value: useTodayAsEnd, // TRUE = Custom Date
                                onChanged: (val) {
                                  setState(() {
                                    useTodayAsEnd = val;

                                    if (!val) {
                                      final now = DateTime.now();
                                      endDateController.text =
                                          "${now.day}/${now.month}/${now.year}";
                                    } else {
                                      endDateController
                                          .clear(); // ready for custom date
                                    }
                                  });
                                },
                                onIcon: const Icon(
                                    Icons.arrow_circle_right_rounded,
                                    color: Colors.white),
                                offIcon: const Icon(
                                    Icons.arrow_circle_left_rounded,
                                    color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              const Text("Custom Date"),
                            ],
                          ),
                          const SizedBox(height: 10),
                          buildDateInput(
                            controller: endDateController,
                            readOnly:
                                !useTodayAsEnd, // ✅ Corrected: readOnly when using TODAY
                            onSuffixPressed: useTodayAsEnd
                                ? () async {
                                    final picked = await showDialog<DateTime>(
                                      context: context,
                                      builder: (context) =>
                                          const CustomDatePicker(),
                                    );
                                    if (picked != null) {
                                      endDateController.text =
                                          "${picked.day.toString().padLeft(2, '0')}/"
                                          "${picked.month.toString().padLeft(2, '0')}/"
                                          "${picked.year}";
                                    }
                                  }
                                : null,
                          ),
                        ]),
                        const SizedBox(height: 30),
                        Center(
                          child: CustomButton(
                            text: "Calculate",
                            onClicked: () {
                              if (interestController.text.isEmpty &&
                                  odInterestController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Interest is required");
                              }
                              if (amountController.text.isEmpty) {
                                Fluttertoast.showToast(
                                    msg: "Loan Amount is required");
                              }
                              if (!_formKey.currentState!.validate()) {
                                Fluttertoast.showToast(
                                    msg: "Fill All Required Fields");
                                return;
                              }

                              // // Proceed with calculation
                              // context
                              //     .read<CalculatorResultViewModel>()
                              //     .calculate();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => CalculatorResult(
                                            loanName: selectedLoanType,
                                            loanAmount: double.parse(
                                                "${amountController.value.text.replaceAll(",", "")}.00"),
                                            interestRate: double.parse(
                                                interestController.text),
                                            odInterestRate: double.parse(
                                                odInterestController.text),
                                            months: int.parse(
                                                monthsController.text),
                                            sanctionDate: Datephraser(
                                                    inputDate:
                                                        sanctionDateController
                                                            .text)
                                                .tryDdMmYyyy(),
                                            interestStartDate: Datephraser(
                                                    inputDate:
                                                        interestStartDateController
                                                            .text)
                                                .tryDdMmYyyy(),
                                            givenEndDate: Datephraser(
                                                    inputDate:
                                                        endDateController.text)
                                                .tryDdMmYyyy(),
                                          )));
                            },
                            buttonWidth: 300,
                            buttonHeight: 50,
                            textColor: Colors.white,
                            textSize: 20,
                            fontWeight: FontWeight.bold,
                            buttonColor: Colors.green.shade800,
                          ),
                        )
                      ]),
                ),
              );
            },
          ),
        ));
  }

  Widget sectionTitle(String title) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 8),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade800),
        ));
  }

  Widget buildCard(List<Widget> children) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: children),
      ),
    );
  }

  Widget buildRow(String label, Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 130,
              child: Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(label,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)))),
          const SizedBox(width: 10),
          Expanded(child: widget),
        ],
      ),
    );
  }

  Widget buildTextInput(TextEditingController controller,
          {String? label,
          bool readOnly = false,
          bool prefix = false,
          inputFormatters}) =>
      CustomTextInput(
        fillColor: Colors.cyan.shade100,
        controller: controller,
        label: label,
        prefixIcon: prefix ? Icons.currency_rupee_outlined : null,
        suffixIcon: !prefix ? Icons.percent_rounded : null,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        readOnly: readOnly,
        inputFormatters: inputFormatters,
      );

  Widget buildDateInput(
          {String? hintText = "DD/MM/YYYY",
          required TextEditingController controller,
          required bool readOnly,
          onSuffixPressed}) =>
      CustomTextInput(
        boxHeight: 65,
        fillColor: Colors.cyan.shade100,
        controller: controller,
        hintText: hintText,
        readOnly: readOnly, // ✅ Corrected: readOnly when using TODAY
        suffixIcon: Icons.calendar_month,
        onSuffixPressed: onSuffixPressed,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'\d|/')),
          LengthLimitingTextInputFormatter(10),
          DateTextFormatter(),
        ],
        validator: validateDate,
        keyboardType: TextInputType.number,
        // Helps maintain height
      );
}
