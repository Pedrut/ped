// Implementação para fontes de dados em formato JSON

part of exchange;

class JsonData extends Data {
  List<Map<String, dynamic>> _data = [];
  List<String> _fields = [];

  @override
  FileType get fileType => FileType.json;

  @override
  void load(String fileName) {
    try {
      if (!fileName.contains('.json')) throw FormatException('Invalid Format');
      final fileContent = File(fileName).readAsStringSync();
      final jsonData = jsonDecode(fileContent);
      if (jsonData is List) {
        _data = List.from(jsonData);
        _fields = _extractFieldsFromJsonData();
      } else if (jsonData is Map) {
        _data = [Map<String, dynamic>.from(jsonData)];
        _fields = _extractFieldsFromJsonData();
      } else {
        throw InvalidFormatException('Invalid JSON format.');
      }
    } catch (e) {
      if (e is FileSystemException) {
        throw FileSystemException('File not found.');
      } else {
        rethrow;
      }
    }
  }

  @override
  void save(String fileName) {
    final file = File(fileName);
    final jsonData = _data.length == 1 ? _data.first : _data;
    final jsonString = jsonEncode(jsonData);
    file.writeAsStringSync(jsonString);
  }

  @override
  void clear() {
    _data.clear();
    _fields.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => jsonEncode(_data);

  @override
  set data(String value) {
    final jsonData = jsonDecode(value);
    if (jsonData is List) {
      _data = List.from(jsonData);
      _fields = _extractFieldsFromJsonData();
    } else if (jsonData is Map) {
      _data = [Map<String, dynamic>.from(jsonData)];
      _fields = _extractFieldsFromJsonData();
    } else {
      throw InvalidFormatException('O formato JSON é inválido.');
    }
  }

  @override
  List<String> get fields => List.from(_fields);

  List<String> _extractFieldsFromJsonData() {
    final fields = <String>[];
    for (final record in _data) {
      for (final key in record.keys) {
        if (!fields.contains(key)) {
          fields.add(key);
        }
      }
    }
    return fields;
  }
}
