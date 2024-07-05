import 'package:spareit_flutter_cli/scripts/generate_language_file.dart';
import 'package:test/test.dart';

void main() {
  test('generateLanguageFile', () {
    expect(generateLanguageFile('sheetUrl', 'outputDir'), null);
  });
}
