// Implementação para fontes de dados em formato TSV
part of exchange;

class TsvData extends DelimitedData {
  List<List<String>> _data = [];
  List<String> _fields = [];

  @override
  FileType get fileType => FileType.tsv;

  @override
  String get delimiter => '\t';

  @override
  void load(String fileName) {
    try {
      if (!fileName.contains('.tsv')) throw FormatException('Invalid format');
      if (!File(fileName).existsSync()) {
        throw FileSystemException('File not found');
      }
      final lines = File(fileName).readAsLinesSync();
      if (lines.isEmpty) throw InvalidAccessException('The file is empty.');

      _fields = lines.first.split(delimiter);
      _data = lines.sublist(1).map((line) => line.split(delimiter)).toList();
    } catch (e) {
      if (e is InvalidAccessException) {
        throw InvalidAccessException('InvalidAccessException: ${e.message}');
      } else if (e is InvalidFormatException) {
        throw InvalidFormatException('InvalidFormatException: ${e.message}');
      } else {
        rethrow;
      }
    }
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final lines = [
      _fields.join(delimiter),
      ..._data.map((record) => record.join(delimiter))
    ];
    file.writeAsStringSync(lines.join('\n'));
  }

  @override
  void clear() {
    _data.clear();
    _fields.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data =>
      '${_fields.join(delimiter)}\n${_data.map((record) => record.join(delimiter)).join('\n')}';

  @override
  set data(String value) {
    final lines = value.split('\n');
    _fields = lines.first.split(delimiter);
    _data = lines.sublist(1).map((line) => line.split(delimiter)).toList();
  }

  @override
  List<String> get fields => List.from(_fields);
}
