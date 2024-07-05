import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:csv/csv.dart';

Future generateLanguageFile(String sheetUrl, String outputDir) async {
  final directoryPath = outputDir;
  List<Map> translationsForFile = [];
  List<File> arbFiles = [];
  try {
    final url = sheetUrl;
    stdout.write('\x1B[32m');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Downloading Google Sheet URL: "$url" ...');
    stdout.writeln('---------------------------------------');
    stdout.write('\x1B[0m');
    var response = await http
        .get(Uri.parse(url), headers: {'accept': 'text/csv;charset=UTF-8'});
    final bytes = response.bodyBytes;
    final csv = const CsvToListConverter().convert(utf8.decode(bytes));
    List<String> languages = csv[0].skip(1).toList().cast<String>();

    for (var language in languages) {
      String fileName = 'app_$language.arb';
      File arbFile = File(fileName);
      arbFiles.add(arbFile);
    }

    for (var _ in languages) {
      translationsForFile.add({});
    }

    for (int i = 1; i < csv.length; i++) {
      List<dynamic> row = csv[i];
      String key = row[0].trim();

      for (int j = 1; j < row.length; j++) {
        String language = languages[j - 1];
        String value = row[j].trim();

        for (int k = 0; k < translationsForFile.length; k++) {
          var languageIndex = languages.indexOf(language);

          if (languageIndex == k) {
            translationsForFile[k][key] = value;
          }
        }
      }
    }

    for (int i = 0; i < translationsForFile.length; i++) {
      Map<String, String> phrases =
          translationsForFile[i].cast<String, String>();
      String language = languages[i];

      StringBuffer arbContent = StringBuffer('{\n');
      arbContent.writeln('  "@@locale": "$language",');
      phrases.forEach((key, value) {
        arbContent.writeln('  "$key": "$value",');
      });
      arbContent.writeln('}');

      String fileName = '$directoryPath/app_$language.arb';
      File arbFile = File(fileName);
      await arbFile.writeAsString(arbContent.toString());
      stdout.writeln('Generated $fileName');
    }
    stdout.write('\x1B[32m');
    stdout.writeln('---------------------------------------');
    stdout.writeln('Successfully generated or updated localization files.');
    stdout.writeln('---------------------------------------');
  } catch (e) {
    stderr.write('\x1B[31m');
    stderr.writeln('Error: Failed to update localization files.');
    stderr.writeln(e.toString());
    stderr.write('\x1B[0m');
  }
}
