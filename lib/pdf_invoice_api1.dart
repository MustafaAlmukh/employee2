/*
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfInvoiceApi1 {
  static Future<File> generate1(
      Name,
      generalNo,
      idnumber,
      AccountNo,
      Warranty, //الضمان
      Solidarity, //تضامن
      Battle, //جهاد
      TotalTaxes, //اجمالي الخصوم
      BaseSalary, //المرتب الاساسي
      TotalAllowances, //مجموع العلاوات
      TotalSalary,
      NetSalary,
      EmployeeTypename,
      name,
      BankName,
      DegreeName,
       Year,
       Month,


      ) async {
    final Document pdf = Document();
    var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));
    pdf.addPage(Page(
        theme: ThemeData.withFont(
          base: arabicFont,
        ),
        pageFormat: PdfPageFormat.a4,
        build: (Context context) {
          _Warranty(x) {
            try {
              double value2 = double.parse(x);
              double decimalValue2 = value2 - value2.toInt();
              return decimalValue2.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _Warrantyint() {
            try {
              var b = double.parse(Warranty);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(Warranty??'0');

            }
          }

          _Solidarity(x) {
            try {
              double value3 = double.parse(x);
              double decimalValue3 = value3 - value3.toInt();
              return decimalValue3.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _Solidarityint() {
            try {
              var b = double.parse(Solidarity);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(Solidarity??'0');

            }
          }

          _Battle(x) {
            try {
              double value4 = double.parse(x);
              double decimalValue4 = value4 - value4.toInt();
              return decimalValue4.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _Battleint() {
            try {
              var b = double.parse(Battle);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(Battle??'0');
            }
          }

          _TotalTaxes(x) {
            try {
              double value5 = double.parse(x);
              double decimalValue5 = value5 - value5.toInt();
              return decimalValue5.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _TotalTaxesint() {
            try {
              var b = double.parse(TotalTaxes);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(TotalTaxes??'0');
            }
          }

          _BaseSalary(x) {
            try {
              double value6 = double.parse(x);
              double decimalValue6 = value6 - value6.toInt();
              return decimalValue6.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _BaseSalaryint() {
            try {
              var b = double.parse(BaseSalary);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(BaseSalary??'0');
            }
          }

          _TotalAllowances() {
            try {
              double value7 = double.parse(TotalAllowances);
              double decimalValue7 = value7 - value7.toInt();
              return decimalValue7.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }

          _TotalAllowancesint() {
            try {
              var b = double.parse(TotalAllowances);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(TotalAllowances??'0');
            }
          }

          _TotalSalary(x) {
            try {
              double value8 = double.parse(x);
              double decimalValue8 = value8 - value8.toInt();
              return decimalValue8.toStringAsFixed(3);
            } catch (exception) {
              return '0'.toString();
            }
          }
          _TotalSalaryint() {
            try {
              var b = double.parse(TotalSalary);
              return Text('${b.toInt()}');
            } catch (exception) {
              return Text(TotalSalary??'0');
            }
          }

          return Container(
              width: double.infinity,
              height: double.infinity,
              // decoration: BoxDecoration(
              //     border: Border.all(
              //   color: PdfColors.black,
              // )),
              child: Column(children: [
                Align(
                  alignment: Alignment.center,
                  child: pw.Column(children: [
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'دولة ليبيا',
                      ),
                    ),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text('هيئة السلامة الوطنية',
                          style: TextStyle(
                            fontSize: 17,
                          )),
                    ),

                    Align(
                        alignment: Alignment.center,
                        child: pw.Container(
                            width: 160,
                            child: pw.Row(children: [
                              Text("${idnumber}"),
                              Directionality(
                                textDirection: TextDirection.rtl,
                                child: Text('الرقم الوطني :  '),
                              ),
                            ]))),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'الاشاري.......',
                        ),
                      ),
                    ),
                    pw.Container(color: PdfColors.black, height: 3)
                  ]),
                ),

                pw.Container(
                    // padding: EdgeInsets.only(
                    //  left: 10, top: 10, right: 10, bottom: 10),
                    // decoration: BoxDecoration(
                    //     border: Border.all(
                    //   color: PdfColors.black,
                    // )),
                    width: double.infinity,
                    height: 50,
                    child: pw.Stack(children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'الي من يهمه الامر',
                            ),
                          )),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                                'يفيدكم القسم المالي بهيئة السلامة الوطنية بان السيد/'                            ),
                          )),
                      Align(
                          alignment: Alignment.center,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'بعد التحية',
                            ),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: pw.Container(
                              // height: 30,
                              //width: 160,

                              child: pw.Row(children: [
                            Text("-----"),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text('الرقم المرجعي :  '),
                            ),
                          ]))),
                      Align(
                          alignment: Alignment.center,
                          child: pw.Container(
                              // height: 30,
                              //width: 160,

                              child: pw.Row(children: [
                            Text("${generalNo}"),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text('الرقم المالي :  '),
                            ),
                          ]))),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: pw.Container(
                              // height: 30,
                              //width: 160,

                              child: pw.Row(children: [
                            Text("-----"),
                            Directionality(
                              textDirection: TextDirection.rtl,
                              child: Text('الرقم الوظيفي :  '),
                            ),
                          ]))),
                    ])),

                //الجدوال الاول

                pw.Container(
                    height: 100,
                    // decoration: BoxDecoration(
                    //   border: Border.all(color: PdfColors.blue),
                    // ),
                    child: pw.Column(children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#f0eceb'),
                                    ),
                                    children: [
                                      Container(
                                          height: 30.0,
                                          child: Center(
                                              child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'المصرف',
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#f0eceb'),
                                    ),
                                    children: [
                                      Container(
                                          height: 30.0,
                                          child: Center(
                                              child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'رقم الحساب',
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#f0eceb'),
                                    ),
                                    children: [
                                      Container(
                                          height: 30.0,
                                          child: Center(
                                              child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'الدرجة',
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#f0eceb'),
                                    ),
                                    children: [
                                      Container(
                                          height: 30.0,
                                          child: Center(
                                              child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'نوع التعاقد',
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(
                                      color: PdfColor.fromHex('#f0eceb'),
                                    ),
                                    children: [
                                      Container(
                                          height: 30.0,
                                          child: Center(
                                              child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'الاسم',
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(),
                                    children: [
                                      Container(
                                          height: 40.0,
                                          child: Center(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                BankName ?? '-', style: pw.TextStyle(
                                                fontSize: 10,
                                              )
                                              ),
                                            ),
                                          ))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(),
                                    children: [
                                      Container(
                                          height: 40.0,
                                          child: Center(
                                              child: Text(
                                            AccountNo ?? '0',
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(),
                                    children: [
                                      Container(
                                          height: 40.0,
                                          child: Center(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(
                                                DegreeName ?? '-',
                                              ),
                                            ),
                                          ))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(),
                                    children: [
                                      Container(
                                          height: 40.0,
                                          child: Center(
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(name ?? '-',

                                              ),
                                            ),
                                          ))
                                    ]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Table(
                              border: TableBorder.all(),
                              children: [
                                TableRow(
                                    decoration: BoxDecoration(),
                                    children: [
                                      Container(
                                          height: 40.0,
                                          child: Center(
                                              child: pw.Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Directionality(
                                              textDirection: TextDirection.rtl,
                                              child: Text(Name ?? '-',
                                                  style: pw.TextStyle(
                                                    fontSize: 10,
                                                  )
                                              ),
                                            ),
                                          )))
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'هو أحد موظفي]المحالين[ و يتقاضي مرتباً  شهرياً بياناته موضحة كما يلي:',
                            ),
                          )),
                    ])),

                //الجدولين
                pw.Container(
                    child: pw.Row(children: [
                  Expanded(
                    child: pw.Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: PdfColors.amber),
                        // ),

                        child: pw.Column(children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'الاستقطاعات',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      pw.Row(children: [
                        Expanded(
                            child: pw.Column(children: [
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#ffdee2'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'البيان',
                                            ),
                                          ),
                                        ))
                                  ]),
                            ],
                          ),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#ffdee2'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'دينار',
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'درهم',
                                            ),
                                          ),
                                        ))
                                  ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 60.0,
                                    child: pw.Column(children: [
                                      _Warrantyint(),
                                      pw.SizedBox(height: 10),
                                   _Solidarityint()
                                    ])),
                                Container(
                                    height: 60.0,
                                    child: pw.Column(children: [
                                      Text(
                                        _Warranty(Warranty),
                                      ),
                                      pw.SizedBox(height: 10),
                                      Text(
                                        _Solidarity(Solidarity),
                                      )
                                    ])),
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: _Battleint()
                                    //     Text(
                                    //   Battle ?? '0',
                                    // )

                                    )),
                                Container(
                                    height: 30.0,
                                    child: Center(child: Text(_Battle(Battle))))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 30.0,
                                    child: Center(child: Text(''))),
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: Text(
                                      '',
                                    )))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: _TotalTaxesint()

                                    )),
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: Text(
                                      _TotalTaxes(TotalTaxes),
                                    )))
                              ]),
                            ],
                          ),
                        ])),
                        Expanded(
                          child: Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#ffdee2'),
                                  ),
                                  children: [
                                    Container(
                                        height: 60.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'البيان',
                                            ),
                                          ),
                                        ))
                                  ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 60.0,
                                    child: Center(
                                        child: pw.Column(children: [
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          'ضمان',
                                        ),
                                      ),
                                      pw.SizedBox(height: 20),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          'تضامن',
                                        ),
                                      ),
                                    ])))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    height: 30.0,
                                    child: Center(
                                        child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        'جهاد',
                                      ),
                                    )))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: Text(
                                        'غياب',
                                      ),
                                    )))
                              ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#ffdee2'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            'مجموع الخصميات',
                                          ),
                                        )))
                                  ]),
                            ],
                          ),
                        ),
                      ])
                    ])),
                  ),
                  pw.SizedBox(width: 10),
                  Expanded(
                    child: pw.Container(
                        // decoration: BoxDecoration(
                        //   border: Border.all(color: PdfColors.amber),
                        // ),
                        child: pw.Column(children: [
                      Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text(
                          'الاستحقاقات',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      pw.Row(children: [
                        Expanded(
                            child: pw.Column(children: [
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'المبلغ',
                                            ),
                                          ),
                                        ))
                                  ]),
                            ],
                          ),
                          Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'دينار',
                                            ),
                                          ),
                                        )),
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'درهم',
                                            ),
                                          ),
                                        ))
                                  ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 60.0,
                                    child: Center(
                                        child:_BaseSalaryint()

                                    )),
                                Container(
                                    height: 60.0,
                                    child: Center(
                                        child: Text(
                                      _BaseSalary(BaseSalary),
                                    )))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: Text(
                                      '0',
                                    ))),
                                Container(
                                    height: 30.0,
                                    child: Center(
                                        child: Text(
                                      '000',
                                    )))
                              ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child:_TotalAllowancesint()

                                        )),
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Text
                                              (_TotalAllowances())))
                                  ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child:

                                      _TotalSalaryint()

                                        )),
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Text(
                                                _TotalSalary(TotalSalary))))
                                  ]),
                            ],
                          ),
                        ])),
                        Expanded(
                          child: Table(
                            border: TableBorder.all(),
                            children: [
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 60.0,
                                        child: Center(
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Text(
                                              'البيان',
                                            ),
                                          ),
                                        ))
                                  ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    height: 60.0,
                                    child: Center(
                                      child: Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Text(
                                          'المرتب الأساسي',
                                        ),
                                      ),
                                    ))
                              ]),
                              TableRow(decoration: BoxDecoration(), children: [
                                Container(
                                    margin: const EdgeInsets.only(
                                        left: 10.0, right: 15.0),
                                    height: 30.0,
                                    child: Center(
                                        child: Divider(
                                      color: PdfColors.black,
                                      height: 10,
                                    )))
                              ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            'مجموغ العلاوات',
                                          ),
                                        )))
                                  ]),
                              TableRow(
                                  decoration: BoxDecoration(
                                    color: PdfColor.fromHex('#dfffda'),
                                  ),
                                  children: [
                                    Container(
                                        height: 30.0,
                                        child: Center(
                                            child: Directionality(
                                          textDirection: TextDirection.rtl,
                                          child: Text(
                                            'اجمالي المرتب',
                                          ),
                                        )))
                                  ]),
                            ],
                          ),
                        ),
                      ])
                    ])),
                  )
                ])),

                pw.Container(
                    child: pw.Column(children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: pw.Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                          color: PdfColor.fromHex('#dfffda'),
                          border: Border.all(color: PdfColors.black),
                        ),
                        child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: pw.Center(
                              child: Text(
                                'الصافي ' '${NetSalary ?? '0'}' '=دينار',
                              ),
                            ))),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: pw.Container(
                        height: 30,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: PdfColor.fromHex('#dfffda'),
                        ),
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child: Text(
                            ' ',
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: pw.Container(
                        width: double.infinity,
                        child: Directionality(
                          textDirection: TextDirection.rtl,
                          child:Text(
                              'استخرجت هذه الشهادة بناء علي طلبه من واقع مرتبه عن شهر '
                                  '[ ${Month} ] '
                                  'لسنة    [${Year} ]   الاستعمالها في الاغراض المسموح بها قانونا  ',
                              style: pw.TextStyle(fontSize: 10)),
                        )),
                  ),
                ])),

                pw.SizedBox(height: 10),

                pw.Container(
                    width: double.infinity,
                    child: pw.Column(children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              '_اي كشط او تغيير يلغيها.',
                            ),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'رئيس قسم المرتبات',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          )),
                      Divider(
                        height: 30,
                        thickness: 5,
                      ),
                    ])),

                pw.Container(
                    width: double.infinity,
                    child: pw.Stack(children: [
                      Align(
                          alignment: Alignment.topRight,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'المستخدم:مدير المنظومة',
                            ),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Text(
                              'التاريخ      ${pw.DateFormat("dd-MM-yyyy").format(DateTime.now())}    ',
                            ),)
                      ),
                      // Align(
                      //     alignment: Alignment.center,
                      //     child: Directionality(
                      //       textDirection: TextDirection.rtl,
                      //       child: Text(
                      //         'اسم الكمبيوتر',
                      //       ),
                      //     )),
                    ]))
              ]));
        }));

    return PdfApi.saveDocument(name: 'my_invoice.pdf', pdf: pdf);
  }
}
*/
