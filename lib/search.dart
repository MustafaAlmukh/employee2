import 'package:employee/register.dart';
import 'package:employee/show.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  String _searchKey = '';
  bool _loading = false;
  bool _referenceStep = false; // لتحديد ظهور حقل التحقق من الرقم السري
  String? _employeeName; // تخزين اسم الموظف للعرض
  String? _errorMessage;
  late DatabaseReference ref;

  @override
  void initState() {
    super.initState();
    _clearFields();
    // استخدام Firebase المُهيأ مسبقاً
    ref = FirebaseDatabase.instance.ref('employee');
  }

  void _clearFields() {
    _controller.clear();
    _referenceController.clear();
    _searchKey = '';
    _loading = false;
    _referenceStep = false;
    _employeeName = null;
    _errorMessage = null;
  }

  void search() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
      _referenceStep = false;
      _employeeName = null;
    });

    try {
      final searchKeyTrimmed = _controller.text.trim();
      dynamic searchKeyForQuery = searchKeyTrimmed;
      // لا نقوم بتحويل الرقم إلى int كما هو الحال في قاعدة البيانات
      searchKeyForQuery = searchKeyTrimmed;

      final DataSnapshot snapshotByNationalnumber =
          (await ref.orderByChild('Nationalnumber').equalTo(searchKeyForQuery).once()).snapshot;
      final DataSnapshot snapshotByEmployeeName =
          (await ref.orderByChild('EmployeeName').equalTo(searchKeyTrimmed).once()).snapshot;

      Map<dynamic, dynamic>? employeeData;

      if (snapshotByNationalnumber.value != null) {
        if (snapshotByNationalnumber.value is Map) {
          employeeData = snapshotByNationalnumber.value as Map<dynamic, dynamic>;
        } else if (snapshotByNationalnumber.value is List) {
          employeeData = {
            for (var item in (snapshotByNationalnumber.value as List).where((e) => e != null))
              item['Nationalnumber']: item,
          };
        }
      }

      if (employeeData == null && snapshotByEmployeeName.value != null) {
        if (snapshotByEmployeeName.value is Map) {
          employeeData = snapshotByEmployeeName.value as Map<dynamic, dynamic>;
        } else if (snapshotByEmployeeName.value is List) {
          employeeData = {
            for (var item in (snapshotByEmployeeName.value as List).where((e) => e != null))
              item['EmployeeName']: item,
          };
        }
      }

      if (employeeData != null) {
        final employeeDetails = employeeData.values.firstWhere(
              (data) => data != null && data is Map && data.containsKey('EmployeeName'),
          orElse: () => null,
        );

        if (employeeDetails != null && employeeDetails is Map) {
          setState(() {
            _employeeName = employeeDetails['EmployeeName']?.toString();
            _referenceStep = true;
            _loading = false;
          });
        } else {
          setState(() {
            _loading = false;
            _errorMessage = 'No employee name found in the data.';
          });
          showErrorDialog(_errorMessage!);
        }
      } else {
        setState(() {
          _loading = false;
          _errorMessage = 'لا يوجد أي بيانات لهذا الرقم أو الاسم';
        });
        showErrorDialog(_errorMessage!);
      }
    } catch (error) {
      setState(() {
        _loading = false;
        _errorMessage = 'حدث خطأ أثناء البحث: $error';
      });
      showErrorDialog(_errorMessage!);
    }
  }

  void verifyReferenceNumber() async {
    setState(() {
      _loading = true;
      _errorMessage = null;
    });

    final enteredReferenceNumber = _referenceController.text.trim();

    try {
      final snapshot = await ref.orderByChild('EmployeeName').equalTo(_employeeName).once();
      final employeeData = snapshot.snapshot.value;

      if (employeeData != null) {
        Map<dynamic, dynamic>? employeeMap;

        if (employeeData is Map) {
          employeeMap = employeeData;
        } else if (employeeData is List) {
          employeeMap = {
            for (var item in employeeData.where((e) => e != null))
              item['EmployeeName']: item,
          };
        }

        bool referenceFound = false;
        if (employeeMap != null) {
          for (var employee in employeeMap.values) {
            if (employee != null && employee is Map) {
              if (employee['CardNo']?.toString() == enteredReferenceNumber) {
                referenceFound = true;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShowData(
                      searchKey: _employeeName!,
                      searchField: 'EmployeeName',
                    ),
                  ),
                ).then((_) {
                  setState(() {
                    _clearFields(); // إعادة تعيين الحقول عند العودة من شاشة العرض
                  });
                });
                break;
              }
            }
          }
        }

        if (!referenceFound) {
          setState(() {
            _errorMessage = 'الرقم السري غير صحيح.';
            _loading = false;
          });
          showErrorDialog(_errorMessage!);
        }
      } else {
        setState(() {
          _errorMessage = 'حدث خطأ أثناء البحث عن البيانات.';
          _loading = false;
        });
        showErrorDialog(_errorMessage!);
      }
    } catch (error) {
      setState(() {
        _errorMessage = 'حدث خطأ أثناء التحقق: $error';
        _loading = false;
      });
      showErrorDialog(_errorMessage!);
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('خطأ',
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            )),
        content: Text(message, style: TextStyle(color: Colors.black)),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('حسناً', style: TextStyle(color: Colors.blueGrey)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        Text("عرض بيانات الموظف", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        elevation: 4,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blueGrey.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Image.asset('assets/icon/img2.png',
                        height: 200, width: 200),
                  ),
                ),
                SizedBox(height: 30),
                if (_employeeName == null) ...[
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'ادخل الرقم الوطني أو الاسم',
                        suffixIcon: Icon(Icons.search, color: Colors.blueGrey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('بحث'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      onPrimary: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _loading ? null : search,
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      ).then((_) {
                        setState(() {
                          _clearFields();
                        });
                      });
                    },
                    child: Text(
                      "تعيين كلمة مرور",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ] else ...[
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'اسم الموظف: $_employeeName',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueGrey),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: TextField(
                      controller: _referenceController,
                      decoration: InputDecoration(
                        labelText: 'أدخل كلمة المرور',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blueGrey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 16, vertical: 14),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    child: Text('الرقم السري'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                      onPrimary: Colors.white,
                      padding:
                      EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      textStyle: TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: _loading ? null : verifyReferenceNumber,
                  ),
                  SizedBox(height: 10),
                  // إضافة رابط نصي لإعادة التوجيه إلى شاشة التسجيل في حال عدم توفر كلمة مرور صحيحة
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen()),
                      ).then((_) {
                        setState(() {
                          _clearFields();
                        });
                      });
                    },
                    child: Text(
                      "ليس لديك كلمة مرور؟ اضغط هنا",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        color: Colors.blueGrey,
                      ),
                    ),
                  ),
                ],
                if (_loading) ...[
                  SizedBox(height: 20),
                  CircularProgressIndicator(),
                ],
                SizedBox(height: 40),
                Text('اعداد / م.مروان المخ',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey)),
                if (_errorMessage != null) ...[
                  SizedBox(height: 10),
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
