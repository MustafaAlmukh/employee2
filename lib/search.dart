import 'package:employee/register.dart';
import 'package:employee/show.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'adminscreen.dart';

class SearchScreen extends StatefulWidget {

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _referenceController = TextEditingController();
  String _searchKey = '';
  bool _loading = false;
  bool _referenceStep = false;
  String? _employeeName;
  String? _errorMessage;
  late DatabaseReference ref;
  final int _pageSize = 50;
  String _lastKey = '';
  List<DataSnapshot> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _clearFields();
    ref = FirebaseDatabase.instance.ref('employee');
    ref.keepSynced(true);
  }

  void _clearFields() {
    _controller.clear();
    _referenceController.clear();
    _searchKey = '';
    _loading = false;
    _referenceStep = false;
    _employeeName = null;
    _errorMessage = null;
    _searchResults.clear();
  }

  Future<void> _searchWithPagination(String query) async {
    setState(() => _loading = true);

    try {
      final searchQuery = query.isEmpty
          ? ref.orderByKey().limitToFirst(_pageSize)
          : ref.orderByChild('EmployeeName')
          .startAt(query)
          .endAt('$query\uf8ff')
          .limitToFirst(100);

      final snapshot = await searchQuery.once();

      if (snapshot.snapshot.value != null) {
        // التعديل هنا
        _searchResults = snapshot.snapshot.children.toList();
        _lastKey = _searchResults.isNotEmpty
            ? _searchResults.last.key.toString()
            : '';
      } else {
        _searchResults = [];
      }
    } catch (error) {
      _errorMessage = 'حدث خطأ أثناء البحث: $error';
      showErrorDialog(_errorMessage!);
    }

    setState(() => _loading = false);
  }

  Future<void> _loadMoreData() async {
    if (_loading) return;

    setState(() => _loading = true);

    try {
      final query = ref.orderByKey().startAt(_lastKey).limitToFirst(_pageSize + 1);
      final snapshot = await query.once();

      if (snapshot.snapshot.value != null) {
        final newResults = snapshot.snapshot.children.toList();
        if (newResults.isNotEmpty) {
          _searchResults.addAll(newResults.skip(1));
          _lastKey = newResults.last.key.toString();
        }
      }
    } catch (error) {
      _errorMessage = 'حدث خطأ أثناء تحميل المزيد: $error';
      showErrorDialog(_errorMessage!);
    }

    setState(() => _loading = false);
  }

  void search() async {
    final searchKeyTrimmed = _controller.text.trim();

    if (searchKeyTrimmed == '19') {
      setState(() {
        _employeeName = 'المسؤول';
        _referenceStep = true;
      });
      return;
    }

    await _searchWithPagination(searchKeyTrimmed);
  }

  void verifyReferenceNumber() async {
    if (_controller.text.trim() == '19' && _referenceController.text.trim() == '99') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => adminscreen(
            searchKey: '',
            searchField: 'EmployeeName',
            isAdminMode: true,
          ),
        ),
      );
    } else {
      showErrorDialog('بيانات الدخول غير صحيحة');
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('خطأ'),
        content: Text(message),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text('حسناً'))],
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (scroll) {
          if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
            _loadMoreData();
          }
          return true;
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40),
          child: Column(
            children: [
              Image.asset('assets/icon/img.png', height: 240, width: 240),
              SizedBox(height: 50),
              if (!_referenceStep) ...[
                _buildSearchSection(),
              ] else ...[
                _buildPasswordSection(),
              ],
              if (_searchResults.isNotEmpty) ...[
                SizedBox(height: 20),
                ..._searchResults.map((snapshot) => _buildEmployeeCard(snapshot)).toList(),
              ],
              if (_loading) CircularProgressIndicator(),
              SizedBox(height: 80),
              Text('اعداد / م.مروان المخ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (_errorMessage != null) ...[
                SizedBox(height: 10),
                Text(_errorMessage!, style: TextStyle(color: Colors.red)),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchSection() {
    return Column(
      children: [
        TextField(
          controller: _controller,
          decoration: InputDecoration(
            labelText: 'ادخل الرقم الوطني أو الاسم',
            suffixIcon: Icon(Icons.search),
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text('بحث'),
          style: _buttonStyle,
          onPressed: _loading ? null : search,
        ),
        SizedBox(height: 10),
      /*  ElevatedButton(
          child: Text('تسجيل'),
          style: _buttonStyle,
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen())),
        ),*/
      ],
    );
  }

  Widget _buildPasswordSection() {
    return Column(
      children: [
        Text('اسم الموظف: $_employeeName', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 20),
        TextField(
          controller: _referenceController,
          decoration: InputDecoration(
            labelText: 'أدخل كلمة المرور',
            border: OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text('الرقم السري'),
          style: _buttonStyle,
          onPressed: _loading ? null : verifyReferenceNumber,
        ),
      ],
    );
  }

  Widget _buildEmployeeCard(DataSnapshot snapshot) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(snapshot.child('EmployeeName').value.toString()),
        subtitle: Text('الرقم الوطني: ${snapshot.child('Nationalnumber').value}'),
        trailing: Icon(Icons.arrow_forward),
        onTap: () => _showDetails(snapshot),
      ),
    );
  }

  void _showDetails(DataSnapshot snapshot) {
    // إضافة تفاصيل العرض هنا
  }

  final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
    primary: Colors.blueGrey,
    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );
}