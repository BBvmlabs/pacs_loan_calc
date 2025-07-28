import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// ignore: depend_on_referenced_packages
import 'package:provider/provider.dart';
import 'package:pacs_loan_calc/view_model/loan_types_view_model.dart';
import 'package:pacs_loan_calc/models/loan_model.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';

class EditValueScreen extends StatefulWidget {
  final String? title;
  final int? editIndex; // Pass index if editing, null if adding

  const EditValueScreen({super.key, this.title, this.editIndex});

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
  void initState() {
    super.initState();
    final vm = Provider.of<LoanTypesViewModel>(context, listen: false);
    if (widget.editIndex != null) {
      final loan = vm.loanTypes[widget.editIndex!];
      loanNameController.text = loan.name;
      normalInterestController.text = loan.normalPercentage.toString();
      odInterestController.text = loan.odPercentage.toString();
      monthsController.text = loan.months.toString();
      // descriptionController.text = ... // If you have description
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoanTypesViewModel>(
      builder: (context, vm, child) => Scaffold(
        appBar: AppBar(title: Text("Edit ${widget.title ?? "New Loan Type"}")),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(widget.title ?? "New Loan Type",
                        style: const TextStyle(
                          fontSize: 20,
                        ))),
                if (widget.editIndex != null)
                  IconButton(
                      onPressed: () async {
                        final data =
                            await vm.getLoanTypeByName(loanNameController.text);
                        if (data != null) {
                          loanNameController.text = data.name;
                          normalInterestController.text =
                              data.normalPercentage.toString();
                          odInterestController.text =
                              data.odPercentage.toString();
                          monthsController.text = data.months.toString();
                        }
                      },
                      icon: const Icon(Icons.settings_backup_restore_sharp))
              ]),
              // const SizedBox(height: 10),
              Table(
                children: [
                  if (widget.editIndex == null)
                    buildTableRow("Loan Name", loanNameController,
                        keyboardType: TextInputType.text, validator: false),
                  buildTableRow("No. of Months", monthsController,
                      suffixIcon: Icons.calendar_month),
                  buildTableRow("Normal Interest", normalInterestController,
                      suffixIcon: Icons.percent),
                  buildTableRow("OD Interest", odInterestController,
                      suffixIcon: Icons.percent),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomButton(
                    onClicked: () {
                      if (widget.editIndex != null) {
                        vm.deleteLoanType(widget.editIndex!);
                        Navigator.pop(context);
                      }
                    },
                    text: "Delete",
                    buttonColor: Colors.red,
                    icon: Icons.delete,
                  ),
                  CustomButton(
                    onClicked: () {
                      final loan = LoanTypeModel(
                        name: loanNameController.text,
                        months: int.tryParse(monthsController.text) ?? 0,
                        normalPercentage:
                            double.tryParse(normalInterestController.text) ??
                                0.0,
                        odPercentage:
                            double.tryParse(odInterestController.text) ?? 0.0,
                      );
                      if (widget.editIndex != null) {
                        vm.updateLoanType(widget.editIndex!, loan);
                      } else {
                        vm.addLoanType(loan);
                      }
                      Navigator.pop(context);
                    },
                    text: "Save",
                    icon: Icons.check_circle,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TableRow buildTableRow(String lable, TextEditingController controller,
          {IconData? suffixIcon,
          TextInputType? keyboardType,
          bool? validator = true}) =>
      TableRow(children: [
        Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              lable,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: const EdgeInsets.all(5),
            child: CustomTextInput(
                boxHeight: 45,
                hintText: "Enter $lable",
                controller: controller,
                suffixIcon: suffixIcon,
                readOnly: false,
                keyboardType: keyboardType ??
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  if (validator == true)
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}'))
                  else
                    FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]'))
                ],
                fillColor: Colors.cyan.shade100))
      ]);
}
