/*
import 'package:employee/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nationalNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('employee');

  String? _errorMessage;
  bool _loading = false;

  void _registerEmployee() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final nationalNumber = _nationalNumberController.text.trim();
    final phoneNumber = _phoneController.text.trim();

    if (nationalNumber.isEmpty || phoneNumber.isEmpty) {
      setState(() {
        _errorMessage = 'يرجى إدخال الرقم الوطني ورقم الهاتف.';
        _loading = false;
      });
      return;
    }

    try {
      final snapshot = await _dbRef.get();
      final employees = snapshot.value;

      if (employees == null) {
        setState(() {
          _errorMessage = 'قاعدة البيانات فارغة.';
          _loading = false;
        });
        return;
      }

      print('Employees data: $employees');

      Map<String, dynamic>? matchedEmployee;

      if (employees is Map) {
        employees.forEach((key, value) {
          print('Checking employee: $value');
          if (value != null && value is Map &&
              value['Nationalnumber'] != null &&
              value['Nationalnumber'].toString() == nationalNumber) {
            matchedEmployee = Map<String, dynamic>.from(value);
          }
        });
      }

      if (matchedEmployee != null) {
        print('Matched Employee: $matchedEmployee');
        setState(() {
          _loading = false;
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              employeeName: matchedEmployee!['EmployeeName'].toString(),
              nationalNumber: matchedEmployee!['Nationalnumber'].toString(),
              cardNo: matchedEmployee!['CardNo'].toString(),
            ),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'الرقم الوطني غير موجود في قاعدة البيانات.';
          _loading = false;
        });
      }
    } catch (error) {
      setState(() {
        _loading = false;
        _errorMessage = 'حدث خطأ أثناء التسجيل: $error';
      });
    }
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التسجيل'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nationalNumberController,
              decoration: InputDecoration(
                labelText: 'الرقم الوطني',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: _loading ? null : _registerEmployee,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('التسجيل'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: _navigateToLogin,
              child: Text('تسجيل الدخول'),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 20),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}


class VerificationScreen extends StatelessWidget {
  final String employeeName;
  final String nationalNumber;
  final String cardNo;

  VerificationScreen({
    required this.employeeName,
    required this.nationalNumber,
    required this.cardNo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الموظف'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'تم التسجيل بنجاح!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('الاسم: $employeeName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Text('الرقم الوطني: $nationalNumber',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Text('الرقم السري: $cardNo',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green)),
            Divider(),
          ],
        ),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart'; // مكتبة النسخ

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nationalNumberController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('employee');

  String? _errorMessage;
  bool _loading = false;
  bool _obscurePassword = true;

  void _registerEmployee() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final nationalNumber = _nationalNumberController.text.trim();
    final password = _passwordController.text.trim();

    if (nationalNumber.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'يرجى إدخال الرقم الوطني وكلمة المرور.';
        _loading = false;
      });
      return;
    }

    try {
      final snapshot = await _dbRef.get();
      final employees = snapshot.value;

      if (employees == null) {
        setState(() {
          _errorMessage = 'قاعدة البيانات فارغة.';
          _loading = false;
        });
        return;
      }

      Map<String, dynamic>? matchedEmployee;

      if (employees is Map) {
        employees.forEach((key, value) {
          if (value != null &&
              value is Map &&
              value['Nationalnumber'] != null &&
              value['Nationalnumber'].toString() == nationalNumber) {
            matchedEmployee = Map<String, dynamic>.from(value);
            matchedEmployee!['key'] = key; // حفظ المفتاح لتحديثه لاحقًا
          }
        });
      }

      if (matchedEmployee != null) {
        // تحديث الرقم السري
        await _dbRef.child(matchedEmployee!['key']).update({
          'CardNo': password,
        });

        setState(() {
          _loading = false;
        });

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VerificationScreen(
              employeeName: matchedEmployee!['EmployeeName'].toString(),
              nationalNumber: matchedEmployee!['Nationalnumber'].toString(),
              cardNo: password,
            ),
          ),
        );
      } else {
        setState(() {
          _errorMessage = 'الرقم الوطني غير موجود في قاعدة البيانات.';
          _loading = false;
        });
      }
    } catch (error) {
      setState(() {
        _loading = false;
        _errorMessage = 'حدث خطأ أثناء التسجيل: $error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('التسجيل'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nationalNumberController,
              decoration: InputDecoration(
                labelText: 'الرقم الوطني',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              onPressed: _loading ? null : _registerEmployee,
              child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('التسجيل'),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 20),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class VerificationScreen extends StatelessWidget {
  final String employeeName;
  final String nationalNumber;
  final String cardNo;

  VerificationScreen({
    required this.employeeName,
    required this.nationalNumber,
    required this.cardNo,
  });

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: cardNo)).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم نسخ كلمة المرور!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('بيانات الموظف'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'تم التسجيل بنجاح!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text('الاسم: $employeeName',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Text('الرقم الوطني: $nationalNumber',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الرقم السري: $cardNo',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                IconButton(
                  icon: Icon(Icons.copy, color: Colors.blue),
                  onPressed: () => _copyToClipboard(context),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
