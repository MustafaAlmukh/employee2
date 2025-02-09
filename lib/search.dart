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
  bool _referenceStep = false; // Step flag to show reference field
  String? _employeeName; // Store the employee name for display
  String? _errorMessage;
  late DatabaseReference ref;

  @override
  @override
  @override
  @override
  void initState() {
    super.initState();
    _clearFields();

    // Use the already-initialized Firebase instance
    setState(() {
      ref = FirebaseDatabase.instance.ref('employee');
    });
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

      // Check if search key is numeric and convert it if possible
     /* if (int.tryParse(searchKeyTrimmed) != null) {
        searchKeyForQuery = int.parse(searchKeyTrimmed);
      }*/
      searchKeyForQuery = searchKeyTrimmed; // لا تقم بتحويل الرقم إلى int


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
                    _clearFields(); // Reset fields when returning from ShowData
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
        title: Text('خطأ'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('حسناً'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("عرض بيانات الموظف")),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: EdgeInsets.all(40),
        child: SingleChildScrollView(
          child: Column(
            children: [
    /*          Text(
                'جهاز الشرطة البيئية',
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black54,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),*/
              const SizedBox(height: 20),
              Image.asset('assets/icon/2.jpg', height: 240, width: 240),
              SizedBox(height: 50),
              if (_employeeName == null) ...[
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'ادخل الرقم الوطني أو الاسم',
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('بحث'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _loading ? null : search,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  child: Text('تسجيل'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                ),
                SizedBox(height: 10),
              ] else ...[
                Text(
                  'اسم الموظف: $_employeeName',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _referenceController,
                  decoration: InputDecoration(
                    labelText: 'أدخل كلمة المرور',
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueGrey),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('الرقم السري'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueGrey,
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _loading ? null : verifyReferenceNumber,
                ),
              ],
              if (_loading) CircularProgressIndicator(),
              SizedBox(height: 80),
              Text('اعداد / م.مروان المخ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (_errorMessage != null) ...[
                SizedBox(height: 10),
                Text(
                  _errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
              ],

            ],
          ),
        ),
      ),
    );
  }
}