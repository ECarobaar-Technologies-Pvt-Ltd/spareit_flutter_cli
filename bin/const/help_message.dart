// help message for the command line interface

const String helpMessage = '''
Usage: spareit_flutter_cli <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  help   Display help information for spareit_flutter_cli.
  generate_language_file   Generate a language file from a Google Sheet.

Run "spareit_flutter_cli help <command>" for more information about a command.
''';

const String generateLanguageFileHelpMessage = '''
Usage: spareit_flutter_cli generate_language_file <sheet_url> <output_dir>

Arguments:
  sheet_url   The URL of the Google Sheet to generate the language file from.
  output_dir  The directory to save the generated language file.

Options:
  -h, --help  Print this usage information.

Generates a language file from a Google Sheet.
''';
