import 'package:flutter/material.dart';
import 'package:pacs_loan_calc/widgets/calculator_button.dart';
import 'package:pacs_loan_calc/widgets/custom_textfield.dart';

class CalculatorResult extends StatefulWidget {
  const CalculatorResult({super.key});

  @override
  State<CalculatorResult> createState() => _CalculatorResultState();
}

class _CalculatorResultState extends State<CalculatorResult> {
  final TextEditingController loanTypeController = TextEditingController();
  final TextEditingController monthTypeController = TextEditingController();
  final TextEditingController persentageTypeController = TextEditingController();
  final TextEditingController odPersentageController = TextEditingController();
  final TextEditingController loanAmountController = TextEditingController();
  final TextEditingController sancationDateController = TextEditingController();
  final TextEditingController intrestStarts = TextEditingController();
  final TextEditingController givenDateController = TextEditingController();
  final TextEditingController emiController = TextEditingController();
  final TextEditingController calculatedInterestDays = TextEditingController();
  final TextEditingController calculatedInterestAmount = TextEditingController();
  final TextEditingController calculatedInterestOther = TextEditingController();
  final TextEditingController totalInterestAmount = TextEditingController();
  final TextEditingController totalAddOther = TextEditingController();
  final TextEditingController totalAmount = TextEditingController();
  final TextEditingController totaldaysController = TextEditingController();
  final TextEditingController odDaysInterestAmount = TextEditingController();

  @override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
      child: Wrap(
        spacing: 10.0,
        runSpacing: 1.0,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: [
          LoanCalculatorRow(label: "Loan Type", controller: loanTypeController, readOnly: true),
          Table(
            children: [
             const TableRow(
              children: [
                  Center(child:Text("No. of \nMonths", style: TextStyle(fontWeight: FontWeight.bold),)),
                  Center(child:Text("Normal\nPersentage", style:TextStyle(fontWeight: FontWeight.bold),)),
                  Center(child:Text("OD \nPersentage", style: TextStyle(fontWeight: FontWeight.bold),)),
                  
                ],
              ),
              TableRow(
                children: [
                  CustomTextInput(controller: monthTypeController, label: "months",suffixIcon: Icons.calendar_today,),
                  CustomTextInput(controller: persentageTypeController, label: "%",suffixIcon: Icons.percent,),
                  CustomTextInput(controller: odPersentageController, label: "%", suffixIcon: Icons.percent,),
                ],
              )
            
          ]),

          // Row( crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          // LoanCalculatorColumn(controller: monthTypeController, label: "No.of \nMonths", readOnly: true, boxWidth: 100),
          // LoanCalculatorColumn(controller: persentageTypeController, label: "Interest \nPercentage", readOnly: true,boxWidth: 100),
          // LoanCalculatorColumn(controller: odPersentageController, label: "OD \nPercentage", readOnly: true, boxWidth: 100),
          // ]),
          LoanCalculatorRow(controller: loanAmountController, label: "Loan Amount", readOnly: true),
          LoanCalculatorRow(controller: sancationDateController, label: "Loan Sanction \nDate", readOnly: true),
          LoanCalculatorRow(controller: intrestStarts, label: "Interest \nStart Date", readOnly: true),
          LoanCalculatorRow(controller: givenDateController, label: "Given Date", readOnly: true),
          const Center(child:  Text("Calculated Interest", style: TextStyle(fontWeight: FontWeight.bold)),),
          LoanCalculatorRow(controller: totalAmount, label: "Total Amount", readOnly: true),

          Table(
            children: [
              const TableRow(
                // decoration: BoxDecoration(color: Colors.greenAccent),
                children: [
                  Text("", style: TextStyle(fontWeight: FontWeight.bold),),
                  Center(child: Text("Normal", style: TextStyle(fontWeight: FontWeight.bold),)),
                  Center(child:Text("OD", style: TextStyle(fontWeight: FontWeight.bold),),),
                  Center(child:Text("Total", style: TextStyle(fontWeight: FontWeight.bold),),),
                ],
              ),
              TableRow(
                children: [
                  const Center(child: Text("Days", style: TextStyle(fontWeight: FontWeight.bold),),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child: CustomTextInput(controller: calculatedInterestDays, label: "Days", readOnly: false,fillColor: Colors.greenAccent,),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child: CustomTextInput(controller: odDaysInterestAmount, label: "Days", readOnly: true,fillColor: Colors.greenAccent,),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child: CustomTextInput(controller: totaldaysController, label: "Days", readOnly: true,fillColor: Colors.greenAccent,),)
                ],
              ),
              TableRow(
                children: [
                  const Center(child: Text("Amount", style: TextStyle(fontWeight: FontWeight.bold),),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child:CustomTextInput(controller: calculatedInterestAmount, label: "Amount", readOnly: true,fillColor: Colors.greenAccent,),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child:CustomTextInput(controller: odDaysInterestAmount, label: "Amount", readOnly: true,fillColor: Colors.greenAccent,),),
                  Padding(padding: const EdgeInsetsGeometry.all(5),child:CustomTextInput(controller: totalInterestAmount, label: "Amount", readOnly: true,fillColor: Colors.greenAccent,),),
                ],
              ),
            ],
          ),
          
          Padding(
            padding: const EdgeInsetsGeometry.only(left: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Others", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                const SizedBox(width:25),
                CustomTextInput(controller: calculatedInterestOther, label: "Others",fillColor: Colors.greenAccent, boxWidth: 90, ),
                const SizedBox(width: 25),
                CustomButton(onClicked: () {}, text: "Total + Others", buttonColor: Colors.green,buttonWidth: 130, buttonHeight: 40,),            
              ]
            ),
          ),
          
          LoanCalculatorRow(controller: totalAmount, label: "Final Amount", readOnly: true, fontSize: 20,),
          Row(
            children: [
              CustomButton(icon: Icons.camera_alt_rounded, onClicked: () {}, buttonColor: Colors.green,buttonHeight: 50,buttonWidth: 70,),
              const SizedBox(width: 15),
              CustomButton(icon: Icons.download, text: "Save", onClicked: () {}, buttonColor: Colors.green,buttonHeight: 50,buttonWidth: 110,),
              const SizedBox(width: 15),
              CustomButton(icon: Icons.delete, text: "Clear", onClicked: () {}, buttonColor: Colors.green,buttonHeight: 50,buttonWidth: 110,),
            ],
          ),
        ],
      ),
    ),
  );
}
}