import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'employee.dart';

class EmployeeProvider extends ChangeNotifier {
  List<Employee> _employees = [];

  List<Employee> get employees => _employees;

  Future<void> fetchEmployees() async {
    final response = await http.get(Uri.parse('https://dummy.restapiexample.com/api/v1/employees'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> employeeData = responseData['data'];
      _employees = employeeData.map((e) => Employee.fromJson(e)).toList();
      notifyListeners();
    } else {
      throw Exception('Failed to load employees');
    }
  }
}
