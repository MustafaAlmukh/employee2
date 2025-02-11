import 'package:flutter/material.dart';

class ShowPage extends StatelessWidget {
  final String employeeName;
  final String nationalNumber;
  final String referenceNumber;
  final String className;
  final String bonus;
  final String bank;
  final String bankBranch;
  final String accountNumber;
  final String basic;
  final String totalBonuses;
  final String Total;
  final String totalDeductions;
  final String netSalary;
  final String Tdamn;
  final String Box;
  final String Boxr;
  final String Atehad;
  final String Dman;
  final String Gyab;
  final String diss;


  ShowPage({
    required this.employeeName,
    required this.nationalNumber,
    required this.referenceNumber,
    required this.className,
    required this.bonus,
    required this.bank,
    required this.bankBranch,
    required this.accountNumber,
    required this.basic,
    required this.totalBonuses,
    required this.Total,
    required this.totalDeductions,
    required this.netSalary,
    required this.Tdamn,
    required this.Box,
    required this.Boxr,
    required this.Atehad,
    required this.Dman,
    required this.Gyab,
    required this.diss,

  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height,
            ),
            padding: EdgeInsets.all(20),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30,),
                Text(
                  'دولة ليبيا',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'وزارة الداخلية / جهاز حراسة المرافق التعليمية',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'شهادة مرتب',
                  style: TextStyle(
                    fontSize:                  20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1,
                  indent: 110,
                  endIndent: 110,
                ),
                Row(
                  children: [
                    Text('الإشاري : ...........', style: TextStyle(fontSize: 10)),
                    SizedBox(width: 53,),
                    Text('الرقم الوطني: $nationalNumber', style: TextStyle(fontSize: 10)),
                  ],
                ),
                Divider(
                  color: Colors.black,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('الي من يهمه الامر', style: TextStyle(fontSize: 10)),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(145, 0, 0, 0),
                          child: Text('بعد التحية,', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                        ),
                        Text('يفيدكم القسم المالي بمصرف $bank بأن السيد / ', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                    Column(
                      children: [
                        Text('الرقم المرجعي : .......... ', style: TextStyle(fontSize: 10)),
                        Text('الرقم المالي : .......... ', style: TextStyle(fontSize: 10)),
                        Text('الرقم الوظيفي : .......... ', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      decoration: BoxDecoration(color: Color.fromRGBO(239, 239, 220, 100)),
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('الاسم', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('نوع التعاقد', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('الدرجة', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('رقم الحساب', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('المصرف', textAlign: TextAlign.center, style: TextStyle(fontSize: 12)),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('$employeeName', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('-تعيين-', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('$className', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('$accountNumber', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: Text('$bank', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text('هو أحد موظفي [ حراسة المرافق التعليمية ] , ويتقاضي مرتبا شهريا بياناته موضحة كما يلي :  ', style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('الاستحقاقات', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Container(
                          height: 1,
                          width: 50,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5,),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FixedColumnWidth(70.0),
                            1: FixedColumnWidth(130.0),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(144,238,144,170)),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('البيان', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('المبلغ', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            TableRow(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('الأساسي', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('$Total', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                                height: 80,

                                ),
                              ],
                            ),



                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(144,238,144,170)),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('اجمالي المرتب ', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('$Total', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text('الاستقطاعات', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                        Container(
                          height: 1,
                          width: 50,
                          color: Colors.black,
                        ),
                        SizedBox(height: 5,),
                        Table(
                          border: TableBorder.all(),
                          columnWidths: {
                            0: FixedColumnWidth(70.0),
                            1: FixedColumnWidth(130.0),
                          },
                          children: [
                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(240,128,128,170)),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('البيان', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('المبلغ', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),TableRow(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('الخصميات', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('$diss', textAlign: TextAlign.center, style: TextStyle(fontSize: 10)),
                                ),
                              ],
                            ),

                            TableRow(
                              decoration: BoxDecoration(color: Color.fromRGBO(240,128,128,170)),
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('الاجمالي', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                                Container(
                                  padding: EdgeInsets.all(8),
                                  child: Text('$totalDeductions', textAlign: TextAlign.center, style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  width: 190,
                  decoration: BoxDecoration(
                    color:  Color.fromRGBO(144,238,144,170),
                    border: Border.all(
                      color: Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: EdgeInsets.all(2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('الصافي = $netSalary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text('صافي المرتب بالحروف : ................................. ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black)),
                        Text('استخرجت هذه الشهادة بناء علي طلبه من واقع مرتبه عن شهر 1 لسنة 2025 ', style: TextStyle(fontSize: 10),maxLines: 2,),
                        Text('لاستعمالها في الأغلااض المسموح بها قانونا ', style: TextStyle(fontSize: 10),maxLines: 2,),

                      ],
                    ),

                  ],
                ),
                SizedBox(height: 10),
                Text('كما نتعهد بعدم تحويل حسابه الي اي مصرف اخر الا بعد موافقتكم', style: TextStyle(fontSize: 10),maxLines: 2,),
                SizedBox(height: 20),

                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('وحدة المرتبات', style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),maxLines: 2,),
                    Text('المراجعة', style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),maxLines: 2,),
                    Text('الاعتماد', style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),maxLines: 2,),


                  ],)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

