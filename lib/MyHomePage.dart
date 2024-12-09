import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, dynamic>> employees = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse('http://95.216.93.102/api/employee2.php'),
      headers: <String, String>{
        'Authorization': 'Basic ' +
            base64Encode(utf8.encode('admin:Y0g81hl9')),
      },
    );

    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        employees = List<Map<String, dynamic>>.from(data);
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
      ),
      body: ListView.builder(
        itemCount: employees.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(employees[index]['Name']),

            // Add more fields as needed
          );
        },
      ),
    );
  }
}