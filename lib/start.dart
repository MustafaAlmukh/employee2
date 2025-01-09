import 'package:employee/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _errorMessage;
  bool _loading = false;
  final DatabaseReference ref = FirebaseDatabase.instance.ref('employee');

  void verifyNationalnumber() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final inputDigits = _controller.text.trim();
    if (inputDigits.length != 5) {
      setState(() {
        _errorMessage = 'Please enter exactly 5 digits.';
        _loading = false;
      });
      return;
    }

    try {
      bool isValid = false;

      // Fetch all employees and check if any Nationalnumber ends with inputDigits
      final snapshot = await ref.once();
      final employees = snapshot.snapshot.value;

      if (employees is Map) {
        // Case 1: If employees data is a Map
        employees.forEach((key, value) {
          if (value != null && value['Nationalnumber'] != null) {
            final nationalNumber = value['Nationalnumber'].toString();
            if (nationalNumber.endsWith(inputDigits)) {
              isValid = true;
            }
          }
        });
      } else if (employees is List) {
        // Case 2: If employees data is a List
        for (var value in employees) {
          if (value != null && value['Nationalnumber'] != null) {
            final nationalNumber = value['Nationalnumber'].toString();
            if (nationalNumber.endsWith(inputDigits)) {
              isValid = true;
              break; // Stop loop if a match is found
            }
          }
        }
      }

      setState(() {
        _loading = false;
      });

      if (isValid) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SearchScreen()),
        );
      } else {
        setState(() {
          _errorMessage = 'No record found with these last 5 digits.';
        });
      }
    } catch (error) {
      setState(() {
        _loading = false;
        _errorMessage = 'Error occurred: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('عملية تأكيد')),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              maxLength: 5,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ادخل اخر 5 أرقام من رقمك الوطني',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loading ? null : verifyNationalnumber,
              child: _loading
                  ? CircularProgressIndicator()
                  : Text('تأكيد والمتابعة'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueGrey,
                onPrimary: Colors.white,
              ),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 20),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
