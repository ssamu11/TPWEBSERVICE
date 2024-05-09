import 'package:flutter/material.dart';

// Model untuk representasi data pegawai
class Employee {
  final String name;
  final int salary;
  final int age;
  final String profileImage;

  Employee({required this.name, required this.salary, required this.age, required this.profileImage});
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List Pegawai',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Mengatur primary swatch ke ungu
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false, // Menghapus teks "Debug"
      home: EmployeeListPage(),
    );
  }
}

class EmployeeListPage extends StatelessWidget {
  // Dummy data pegawai
  final List<Employee> employees = [
    Employee(name: "John Doe", salary: 5000, age: 30, profileImage: "https://example.com/john.png"),
    Employee(name: "Jane Smith", salary: 6000, age: 28, profileImage: "https://example.com/jane.png"),
    Employee(name: "Michael Johnson", salary: 5500, age: 35, profileImage: "https://example.com/michael.png"),
    // Tambahkan pegawai lain jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Pegawai'),
        backgroundColor: Colors.purple[200], // Mengatur warna app bar menjadi ungu muda
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: employees.length,
        itemBuilder: (context, index) {
          final employee = employees[index];
          return EmployeeCard(employee: employee);
        },
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  final Employee employee;

  EmployeeCard({required this.employee});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            employee.profileImage,
            width: double.infinity,
            height: 150,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text("Gaji: ${employee.salary}"),
                Text("Umur: ${employee.age}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
