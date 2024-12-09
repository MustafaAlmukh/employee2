    import 'package:flutter/services.dart';
    import 'package:pdf/pdf.dart';
    import 'package:pdf/widgets.dart' as pw;
    import 'package:intl/intl.dart' as pw;

    Future<pw.Font> loadFont() async {
      var fontData = await rootBundle.load('assets/fonts/Cairo-VariableFont_slnt,wght.ttf');
      return pw.Font.ttf(fontData);
    }

    class PdfContent {
      static Future<pw.Page> buildPage(String bankName, String expr5Value) async {
        final arabicFont = await loadFont();

        return pw.Page(
          pageFormat: PdfPageFormat.a4,
          margin: pw.EdgeInsets.all(32), // Adjust the page margins
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text('دولة ليبيا', style: pw.TextStyle(fontSize: 30, font: arabicFont)),
              pw.SizedBox(height: 10),
              pw.Text('شهادة مرتب', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold, font: arabicFont)),
              pw.Divider(thickness: 2, color: PdfColors.black),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('رقم القرض: $bankName', style: pw.TextStyle(fontSize: 18, font: arabicFont)),
                  pw.Text('الرقم المتسلسل: $expr5Value', style: pw.TextStyle(fontSize: 18, font: arabicFont)),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2, color: PdfColors.black),
              pw.Table.fromTextArray(
                context: context,
                border: null,
                headerStyle: pw.TextStyle(font: arabicFont, fontSize: 16, fontWeight: pw.FontWeight.bold),
                cellStyle: pw.TextStyle(font: arabicFont, fontSize: 16),
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),
                headerHeight: 25,
                cellHeight: 40,
                cellAlignments: {
                  0: pw.Alignment.center,
                  1: pw.Alignment.center,
                  2: pw.Alignment.center,
                  3: pw.Alignment.center
                },

                data: <List<String>>[
                  <String>['الحساب', 'رقم الوحدة', 'الموظف', 'تاريخ'],
                  <String>['113', '8000239', 'المصرف', '20013014'],
                ],
              ),
              pw.Divider(thickness: 2, color: PdfColors.black),
            ],
          ),
        );
      }
    }
