import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ShowPage.dart';

class adminscreen extends StatefulWidget {
  final dynamic searchKey;
  final String searchField;
  final bool isAdminMode;

  const adminscreen({
    Key? key,
    required this.searchKey,
    required this.searchField,
    this.isAdminMode = false,
  }) : super(key: key);

  @override
  _ShowDataState createState() => _ShowDataState();
}

class _ShowDataState extends State<adminscreen> {
  final DatabaseReference ref = FirebaseDatabase.instance.ref('employee');
  final TextEditingController _searchController = TextEditingController();
  String _searchTerm = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("بيانات الموظف"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        children: [
          if (widget.isAdminMode)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                onChanged: (value) => setState(() => _searchTerm = value),
                decoration: const InputDecoration(
                  labelText: 'ابحث بأي جزء من الاسم',
                  suffixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
            ),
          Expanded(
            child: _buildEmployeeList(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeeList() {
    if (widget.isAdminMode) {
      return StreamBuilder<DatabaseEvent>(
        stream: ref.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasError) return Text('خطأ: ${snapshot.error}');
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

          final employees = _processSnapshot(snapshot.data!.snapshot);
          final filtered = _filterEmployees(employees);

          if (filtered.isEmpty) {
            return const Center(
              child: Text(
                'لا توجد نتائج',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) => EmployeeCard(
              snapshot: filtered[index],
              isAdminMode: widget.isAdminMode,
            ),
          );
        },
      );
    } else {
      return FirebaseAnimatedList(
        query: ref.orderByChild(widget.searchField).equalTo(widget.searchKey),
        defaultChild: const Center(child: Text('جاري تحميل البيانات...')),
        itemBuilder: (context, snapshot, animation, index) {
          return EmployeeCard(
            snapshot: snapshot,
            isAdminMode: widget.isAdminMode,
          );
        },
      );
    }
  }

  List<DataSnapshot> _processSnapshot(DataSnapshot snapshot) {
    final List<DataSnapshot> employees = [];
    if (snapshot.value != null && snapshot.value is Map<dynamic, dynamic>) {
      final Map<dynamic, dynamic> values = snapshot.value as Map;
      values.forEach((key, value) {
        final childSnapshot = snapshot.child(key.toString());
        employees.add(childSnapshot);
      });
    }
    return employees;
  }

  List<DataSnapshot> _filterEmployees(List<DataSnapshot> employees) {
    return employees.where((snapshot) {
      final name = snapshot.child('EmployeeName').value?.toString().toLowerCase() ?? '';
      return name.contains(_searchTerm.trim().toLowerCase());
    }).toList();
  }
}

class EmployeeCard extends StatelessWidget {
  final DataSnapshot snapshot;
  final bool isAdminMode;

  const EmployeeCard({
    Key? key,
    required this.snapshot,
    this.isAdminMode = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(8.0),
      elevation: 2.0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          title: GestureDetector(
            onTap: () => _showDetails(context, snapshot),
            child: Text(
              snapshot.child('EmployeeName').value?.toString() ?? 'بدون اسم',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          subtitle: Text(
            'المصرف: ${snapshot.child('bank').value?.toString() ?? 'غير محدد'}',
            style: const TextStyle(fontSize: 14),
          ),
          trailing: Text(
            'الدرجة: ${snapshot.child('Class').value?.toString() ?? 'N/A'}',
            style: const TextStyle(fontSize: 14, color: Colors.blueGrey),
          ),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, DataSnapshot snapshot) {
    final employeeName = snapshot.child('EmployeeName').value?.toString() ?? 'بدون اسم';
    final nationalNumber = snapshot.child('Nationalnumber').value?.toString() ?? 'N/A';
    final referenceNumber = snapshot.child('referencenumber').value?.toString() ?? 'N/A';
    final className = snapshot.child('Class').value?.toString() ?? 'N/A';
    final bonus = snapshot.child('Bonus').value?.toString() ?? 'N/A';
    final bank = snapshot.child('bank').value?.toString() ?? 'N/A';
    final bankBranch = snapshot.child('Bankbranch').value?.toString() ?? 'N/A';
    final accountNumber = snapshot.child('accountnumber').value?.toString() ?? 'N/A';
    final basic = snapshot.child('Basic').value?.toString() ?? 'N/A';
    final totalBonuses = snapshot.child('Totalbonuses').value?.toString() ?? 'N/A';
    final total = snapshot.child('Total').value?.toString() ?? 'N/A';
    final totalDeductions = snapshot.child('Totaldeductions').value?.toString() ?? 'N/A';
    final netSalary = snapshot.child('Netsalary').value?.toString() ?? 'N/A';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: Center(
            child: Text(
              employeeName,
              style: const TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow('الرقم الوطني:', nationalNumber),
                _buildDetailRow('الرقم المرجعي:', referenceNumber),
                _buildDetailRow('الدرجة:', className),
                _buildDetailRow('العلاوة:', bonus),
                _buildDetailRow('المصرف:', bank),
                _buildDetailRow('فرع المصرف:', bankBranch),
                _buildDetailRow('رقم الحساب:', accountNumber),
                _buildDetailRow('الأساسي:', basic),
                _buildDetailRow('مجموع العلاوات:', totalBonuses),
                _buildDetailRow('الاجمالي:', total),
                _buildDetailRow('مجموع الخصميات:', totalDeductions),
                _buildDetailRow('صافي المرتب:', netSalary),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('اغلاق', style: TextStyle(color: Colors.blueGrey)),
            ),
            if (isAdminMode)
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowPage(
                        employeeName: employeeName,
                        nationalNumber: nationalNumber,
                        referenceNumber: referenceNumber,
                        className: className,
                        bonus: bonus,
                        bank: bank,
                        bankBranch: bankBranch,
                        accountNumber: accountNumber,
                        basic: basic,
                        totalBonuses: totalBonuses,
                        total: total,
                        totalDeductions: totalDeductions,
                        netSalary: netSalary,
                      ),
                    ),
                  );
                },
                child: const Text('شهادة المرتب'),
              ),
          ],
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}