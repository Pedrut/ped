// Exceção personalizada para campos faltantes
part of exchange;

class MissingFieldsException implements Exception {
  final String message;

  MissingFieldsException(this.message);

  @override
  String toString() => message;
}

// Exceção personalizada para formatos de arquivo inválidos
class InvalidFormatException implements Exception {
  final String message;

  InvalidFormatException(this.message);

  @override
  String toString() => message;
}

// Exceção personalizada para acesso inválido
class InvalidAccessException implements Exception {
  final String message;

  InvalidAccessException(this.message);

  @override
  String toString() => message;
}

// Exceção personalizada para formato de arquivo não suportado
class UnsupportedFileFormatException implements Exception {
  final String message;

  UnsupportedFileFormatException(this.message);

  @override
  String toString() => message;
}
