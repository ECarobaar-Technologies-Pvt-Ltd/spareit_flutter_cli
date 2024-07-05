# SpareIT CLI for internal use

## Installation

```dart
put spareit_flutter_cli: ^0.0.1 in your pubspec.yaml

or

pub global activate spareit_flutter_cli
```

## Usage

```dart

spareit_flutter_cli -h for help

spareit_flutter_cli generate_language_file <sheet_url> <output_path>  // Generate language file from google sheet
[Note: sheet_url should be public or shared with anyone with the link] and [parameter sheet_url and output_path are optional if already configured in pubspec.yaml]

pubspec.yaml configuration

spareit_flutter_cli:
  generate_language_file:
    sheetUrl: "https://docs.google.com/spreadsheets/d/" // Google sheet url"
    outputDir: "lib/generated" // Output directory for generated language file

```

## Features

- Generate language file from google sheet


