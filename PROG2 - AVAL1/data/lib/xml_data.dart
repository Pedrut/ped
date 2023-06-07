// Implementação para fontes de dados em formato XML
part of exchange;

class XmlData extends Data {
  List<Map<String, dynamic>> _data = [];
  List<String> _fields = [];
  late String _fileName;
  late String _fileContent;

  @override
  FileType get fileType => FileType.xml;

  @override
  void load(String fileName) {
    try {
      if (!fileName.contains('.xml')) throw FormatException('Invalid format');
      _fileName = fileName;
      _fileContent = File(_fileName).readAsStringSync();
      final fileContent = File(fileName).readAsStringSync();
      final document = XmlDocument.parse(fileContent);
      final elements = document.findAllElements('record');
      if (elements.isEmpty) {
        throw InvalidAccessException(
            'The XML file does not contain any "record" elements.');
      }
      _fields = _extractFieldsFromXmlData(elements.first);
      _data = elements
          .map((element) => _extractDataFromXmlElement(element))
          .toList();
    } catch (e) {
      if (e is FormatException) {
        throw FormatException('Invalid file format.');
      } else if (e is FileSystemException) {
        throw FileSystemException('File not found.');
      } else {
        rethrow;
      }
    }
  }

  @override
  void save(String fileName) {
    final document = XmlDocument.parse(File(fileName).readAsStringSync());
    final root = XmlElement(XmlName('data'));
    for (final record in _data) {
      final xmlRecord = XmlElement(XmlName('record'));
      record.forEach((key, value) {
        final attribute = XmlAttribute(XmlName(key), value.toString());
        xmlRecord.attributes.add(attribute);
      });
      root.children.add(xmlRecord);
    }
    document.children.add(root);
    final file = File(fileName);
    file.writeAsStringSync(document.toXmlString(pretty: true));
  }

  @override
  void clear() {
    _data.clear();
    _fields.clear();
  }

  @override
  bool get hasData => _data.isNotEmpty;

  @override
  String get data => _fileContent;

  @override
  set data(String value) {
    final document = XmlDocument.parse(value);
    final elements = document.findAllElements('record');
    if (elements.isEmpty) {
      throw InvalidAccessException(
          'The XML file does not contain any "record" elements.');
    }
    _fields = _extractFieldsFromXmlData(elements.first);
    _data =
        elements.map((element) => _extractDataFromXmlElement(element)).toList();
  }

  @override
  List<String> get fields => List.from(_fields);

  List<String> _extractFieldsFromXmlData(XmlElement element) {
    final fields = <String>[];
    for (final attribute in element.attributes) {
      fields.add(attribute.name.toString());
    }
    return fields;
  }

  Map<String, dynamic> _extractDataFromXmlElement(XmlElement element) {
    final data = <String, dynamic>{};
    for (final attribute in element.attributes) {
      data[attribute.name.toString()] = attribute.value;
    }
    return data;
  }
}
