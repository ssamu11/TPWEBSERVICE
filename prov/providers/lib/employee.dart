class Employee {
  final String name;
  final int salary; 
  final int age;
  final String profileImage;

  Employee({
    required this.name,
    required this.salary,
    required this.age,
    required this.profileImage,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      name: json['employee_name'],
      salary: json['employee_salary'],
      age: json['employee_age'],
      profileImage: json['profile_image'],
    );
  }
}
