import 'package:spareit_flutter_cli/spareit_flutter_cli.dart'
    as spareit_flutter_cli;
import 'package:yaml/yaml.dart';
import 'dart:io';
import './const/help_message.dart' as help_message;

List<String> arguments = ['help', 'generate_language_file'];

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    stdout.write(help_message.helpMessage);
    return;
  }

  if (arguments.contains('-h') || arguments.contains('--help')) {
    stdout.write(help_message.helpMessage);
    return;
  }

  String firstArgument = arguments[0];

  switch (firstArgument) {
    case '--help' || '-h':
      if (arguments.length == 1) {
        stdout.write(help_message.helpMessage);
        return;
      }
      if (arguments.length == 2) {
        final command = arguments[1];
        switch (command) {
          case 'generate_language_file':
            stdout.write(help_message.generateLanguageFileHelpMessage);
            break;
          default:
            stdout.write('\x1B[31m');
            stdout.write('Command not found.');
            stdout.write('\x1B[0m');
        }
      }
      break;
    case 'generate_language_file':
      if (arguments.length > 1 && arguments.length <= 3) {
        final sheetUrl = arguments[1];
        final outputDir = arguments[2];
        spareit_flutter_cli.generateLanguageFile(sheetUrl, outputDir);
        return;
      } else if (readParameterFromPubspec('sheetUrl',
                  parentKey: "generate_language_file") !=
              null &&
          readParameterFromPubspec('outputDir',
                  parentKey: "generate_language_file") !=
              null) {
        final sheetUrl = readParameterFromPubspec('sheetUrl',
            parentKey: "generate_language_file");
        final outputDir = readParameterFromPubspec('outputDir',
            parentKey: "generate_language_file");
        spareit_flutter_cli.generateLanguageFile(sheetUrl, outputDir);

        return;
      } else {
        stdout.write('\x1B[31m');
        stdout.write(
            'Invalid number of arguments. and no default values found in pubspec.yaml.');
        stdout.write('\x1B[0m');
        return;
      }
    case 'help':
      if (arguments.length == 1) {
        stdout.write(help_message.helpMessage);
        return;
      }
      break;
    default:
      stdout.write('\x1B[31m');
      stdout.write('Command not found.');
      stdout.write('\x1B[0m');
  }

  final file = File('pubspec.yaml');
  final yamlString = file.readAsStringSync();
  final yamlMap = loadYaml(yamlString);

  if (yamlMap.containsKey('spareit_flutter_cli')) {
    final cliConfig = yamlMap['spareit_flutter_cli'];
    stdout.write('API URL: ${cliConfig['apiUrl']}');
  } else {
    return stdout.write(
        'Error: spareit_flutter_cli configuration not found in pubspec.yaml.');
  }
}

readParameterFromPubspec(String key, {String? parentKey}) {
  final file = File('pubspec.yaml');
  final yamlString = file.readAsStringSync();
  final yamlMap = loadYaml(yamlString);

  if (yamlMap.containsKey('spareit_flutter_cli')) {
    final cliConfig = yamlMap['spareit_flutter_cli'];
    if (parentKey != null) {
      if (cliConfig[parentKey] != null) {
        return cliConfig[parentKey][key];
      } else {
        return null;
      }
    } else {
      return cliConfig[key];
    }
  } else {
    return null;
  }
}
