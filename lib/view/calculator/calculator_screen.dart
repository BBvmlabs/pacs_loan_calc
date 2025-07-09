import 'package:flutter/material.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/date_picker_button.dart';
import '../../widgets/custom_dropdown.dart';
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

  bool useSanctionAsStart = false;
  bool useTodayAsEnd = false;

  @override
  void initState() {
    super.initState();
    // Default dates
    final today = DateTime.now();
    final todayStr = "${today.day}/${today.month}/${today.year}";
    endDateController.text = todayStr;

    sanctionDateController.addListener(() {
      if (!useSanctionAsStart) {
        interestStartDateController.text = sanctionDateController.text;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(
              'src/assets/images/logo.png',
              fit: BoxFit.contain,
              alignment: Alignment.center,
              width: 40,
              height: 40,
            ),
          ),
          title: const Text(
            'Loan Calculator',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.black),
              onSelected: (value) {
                // Handle menu selection here
                // Example: print(value);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Settings',
                  child: const Text('Settings'),
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                PopupMenuItem(
                  value: 'Value',
                  child: const Text('Value'),
                  onTap: () {
                    Navigator.pushNamed(context, '/values');
                  },
                ),
                PopupMenuItem(
                  value: 'About',
                  child: const Text('About'),
                  onTap: () {
                    Navigator.pushNamed(context, '/about');
                  },
                ),
              ],
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sectionTitle("Loan Details"),
              buildCard([
                buildRow(
                    "Loan Type",
                    const CustomDropDown(items: [
                      'Home Loan',
                      'Personal Loan',
                      'Business Loan',
                      "Custom"
                    ])),
                buildRow(
                    "Interest %",
                    CustomTextInput(
                      fillColor: Colors.cyan.shade100,
                      controller: interestController,
                      label: "Interest",
                      suffixIcon: Icons.percent,
                      keyboardType: TextInputType.number,
                    )),
                buildRow(
                    "OD %",
                    CustomTextInput(
                      fillColor: Colors.cyan.shade100,
                      controller: odInterestController,
                      label: "OD Interest",
                      suffixIcon: Icons.percent,
                      keyboardType: TextInputType.number,
                    )),
                buildRow(
                    "Months",
                    CustomTextInput(
                      fillColor: Colors.cyan.shade100,
                      controller: monthsController,
                      label: "Months",
                      suffixIcon: Icons.calendar_month,
                      keyboardType: TextInputType.number,
                    )),
              ]),
              sectionTitle("Loan Sanction Details"),
              buildCard([
                buildRow(
                  "Loan Amount",
                  CustomTextInput(
                    fillColor: Colors.cyan.shade100,
                    controller: amountController,
                    label: "Amount",
                    prefixIcon: Icons.currency_rupee,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      IndianCurrencyInputFormatter(),
                    ],
                  ),
                ),
                buildRow(
                    "Sanction Date",
                    CustomTextInput(
                      fillColor: Colors.cyan.shade100,
                      controller: sanctionDateController,
                      label: "Sanction Date",
                      hintText: "Pick Date",
                      suffixIcon: Icons.calendar_month,
                      readOnly: true,
                      onTap: () async {
                        final picked = await showDialog<DateTime>(
                          context: context,
                          builder: (context) => const CustomDatePicker(),
                        );
                        if (picked != null) {
                          final formatted =
                              "${picked.day}/${picked.month}/${picked.year}";
                          sanctionDateController.text = formatted;
                          if (useSanctionAsStart) {
                            interestStartDateController.text = formatted;
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
                      onIcon: const Icon(Icons.arrow_circle_right_rounded,
                          color: Colors.white),
                      offIcon: const Icon(Icons.arrow_circle_left_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text("Custom Date"),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  fillColor: Colors.cyan.shade100,
                  controller: interestStartDateController,
                  label: "Interest Start Date",
                  suffixIcon: Icons.calendar_month,
                  readOnly:
                      !useSanctionAsStart, // Switch OFF: readOnly, use sanction date
                  onSuffixPressed: useSanctionAsStart
                      ? () async {
                          final picked = await showDialog<DateTime>(
                            context: context,
                            builder: (context) => const CustomDatePicker(),
                          );
                          if (picked != null) {
                            interestStartDateController.text =
                                "${picked.day.toString().padLeft(2, '0')}/"
                                "${picked.month.toString().padLeft(2, '0')}/"
                                "${picked.year}";
                          }
                        }
                      : null,
                  inputFormatters: [DateTextFormatter()],
                  keyboardType: TextInputType.number,
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
                            endDateController.clear(); // ready for custom date
                          }
                        });
                      },
                      onIcon: const Icon(Icons.arrow_circle_right_rounded,
                          color: Colors.white),
                      offIcon: const Icon(Icons.arrow_circle_left_rounded,
                          color: Colors.white),
                    ),
                    const SizedBox(width: 10),
                    const Text("Custom Date"),
                  ],
                ),
                const SizedBox(height: 10),
                CustomTextInput(
                  fillColor: Colors.cyan.shade100,
                  controller: endDateController,
                  label: "End Date",
                  suffixIcon: Icons.calendar_month,
                  readOnly:
                      !useTodayAsEnd, // ✅ Corrected: readOnly when using TODAY
                  onSuffixPressed: useTodayAsEnd
                      ? () async {
                          final picked = await showDialog<DateTime>(
                            context: context,
                            builder: (context) => const CustomDatePicker(),
                          );
                          if (picked != null) {
                            endDateController.text =
                                "${picked.day.toString().padLeft(2, '0')}/"
                                "${picked.month.toString().padLeft(2, '0')}/"
                                "${picked.year}";
                          }
                        }
                      : null,
                  inputFormatters: [DateTextFormatter()],
                  keyboardType: TextInputType.number,
                ),
              ]),
              const SizedBox(height: 30),
              Center(
                child: CustomButton(
                  text: "Calculate",
                  onClicked: () {
                    if (amountController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Loan Amount is required");
                      return;
                    }
                    if (interestController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Interest Rate is required");
                      return;
                    }
                    if (sanctionDateController.text.isEmpty) {
                      Fluttertoast.showToast(msg: "Sanction Date is required");
                    }
                    Navigator.pushNamed(context, '/calculator-result');
                  },
                  buttonWidth: 300,
                  buttonHeight: 50,
                  textColor: Colors.white,
                  textSize: 20,
                  fontWeight: FontWeight.bold,
                  buttonColor: Colors.green.shade800,
                ),
              ),
            ],
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
}
