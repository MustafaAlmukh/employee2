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
import 'package:flutter/services.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nationalNumberController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref('employee');

  String? _errorMessage;
  bool _loading = false;
  bool _isRegistered = false;
  String? _employeeName;

  String _selectedPrefix = "091";
  final List<String> _phonePrefixes = ["091", "092", "093", "094", "095"];

  void _registerEmployee() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final nationalNumber = _nationalNumberController.text.trim();
    final phoneNumber = "$_selectedPrefix${_phoneController.text.trim()}";
    final password = _passwordController.text.trim();

    if (nationalNumber.isEmpty || _phoneController.text.isEmpty || password.isEmpty) {
      setState(() {
        _errorMessage = 'يرجى إدخال جميع الحقول.';
        _loading = false;
      });
      return;
    }

    if (!_validatePhoneNumber(phoneNumber)) {
      setState(() {
        _errorMessage = 'رقم الهاتف غير صالح. يجب أن يبدأ بـ $_selectedPrefix ويتكون من 10 أرقام.';
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
            matchedEmployee!['key'] = key;
          }
        });
      }

      if (matchedEmployee != null) {
        await _dbRef.child(matchedEmployee!['key']).update({
          'CardNo': password,
          'PhoneNo': phoneNumber,
        });

        setState(() {
          _loading = false;
          _isRegistered = true;
          _employeeName = matchedEmployee!['EmployeeName'] ?? "غير معروف"; // ✅ تغيير الحقل
        });
      }
 else {
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

  bool _validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^(091|092|093|094|095)\d{7}$');
    return regex.hasMatch(phoneNumber);
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("تم نسخ كلمة المرور")),
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 60,  // ✅ توحيد الارتفاع
                    child: DropdownButtonFormField<String>(
                      value: _selectedPrefix,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),  // ✅ جعل الحقل بنفس الارتفاع
                        prefixIcon: Icon(Icons.phone, color: Colors.blue),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedPrefix = newValue!;
                        });
                      },
                      items: _phonePrefixes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(child: Text(value, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: Container(
                    height: 60,  // ✅ جعل الحقل بنفس ارتفاع القائمة المنسدلة
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 7,  // ✅ الحد الأقصى للأرقام (يعمل في الخلفية)
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        labelText: 'بقية رقم الهاتف',
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        counterText: "",  // ✅ إخفاء العداد من الشاشة
                      ),
                    ),

                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.lock, color: Colors.blue),
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
            if (_isRegistered) ...[
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.green, width: 1),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "الموظف: $_employeeName",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "كلمة المرور الخاصة بك:",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _passwordController.text,
                          style: TextStyle(fontSize: 18, color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.copy, color: Colors.green),
                          onPressed: () => _copyToClipboard(_passwordController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
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
