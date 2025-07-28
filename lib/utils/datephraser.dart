import 'package:intl/intl.dart';

class Datephraser {
  final String inputDate;
  const Datephraser({required this.inputDate});

  DateTime tryDdMmYyyy() {
    // Adjust the format to match your input, e.g. "12/08/2005"
    DateFormat format = DateFormat('dd/MM/yyyy');
    DateTime parsedDate = format.parse(inputDate);
    print('Parsed date: $parsedDate');
    return parsedDate;
  }

  String toDdMmYyyy() {
    // Adjust the format to match your input, e.g. "12/08/2005"
    DateTime date = DateTime.parse(inputDate);
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }
}
