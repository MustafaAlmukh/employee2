import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'ShowPage.dart';

class ShowData extends StatelessWidget {
  final dynamic searchKey; // Accepts both String and int
  final String searchField;

  ShowData({Key? key, required this.searchKey, required this.searchField}) : super(key: key);

  final DatabaseReference ref = FirebaseDatabase.instance.ref('employee');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("بيانات الموظف"),
        backgroundColor: Colors.blueGrey,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref.orderByChild(searchField).equalTo(searchKey),
              defaultChild: Center(child: Text('جاري تحميل بيانات الموظف')),
              itemBuilder: (context, snapshot, animation, index) {
                if (snapshot.value != null) {
                  return EmployeeCard(snapshot: snapshot);
                } else {
                  return Center(child: Text('No data available.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({
    Key? key,
    required this.snapshot,
  }) : super(key: key);

  final DataSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: EdgeInsets.all(8.0),
      elevation: 2.0,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ListTile(
          title: GestureDetector(
            onTap: () {
              _showDetails(context, snapshot);
            },
            child: Text(snapshot.child('EmployeeName').value?.toString() ?? 'No Name'),
          ),
          subtitle: Text('اسم المصرف:  ${snapshot.child('bank').value?.toString() ?? 'N/A'}'),
          trailing: Text(' الدرجة:  ${snapshot.child('Class').value?.toString() ?? 'N/A'}'),
        ),
      ),
    );
  }

  void _showDetails(BuildContext context, DataSnapshot snapshot) {
    final employeeName = snapshot.child('EmployeeName').value?.toString() ?? 'No Name';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Center(
            child: Text(
              employeeName,
              style: TextStyle(
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
                _buildDetailRow('المصرف:', bank),
                _buildDetailRow('فرع المصرف:', bankBranch),
                _buildDetailRow('رقم الحساب:', accountNumber),
                _buildDetailRow('الأساسي:', basic),
                _buildDetailRow('مجموع الخصميات:', totalDeductions),
                _buildDetailRow('صافي المرتب:', netSalary),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('اغلاق', style: TextStyle(color: Colors.blueGrey)),
            ),
            TextButton(
              child: Text('شهادة المرتب'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
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
            '$label ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
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
