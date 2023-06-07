// Enum para representar o tipo de arquivo
part of exchange;

enum FileType {
  json,
  xml,
  tsv,
  csv,
}

// Classe abstrata que define os métodos e propriedades básicos para todas as fontes de dados
abstract class Data {
  void load(String fileName); // Carrega os dados de um arquivo
  void save(String fileName); // Salva os dados em um arquivo
  void clear(); // Limpa os dados
  bool get hasData; // Verifica se há dados
  String get data; // Obtém os dados em formato de string
  set data(String value); // Define os dados a partir de uma string
  List<String> get fields; // Obtém a lista de campos dos dados
  FileType get fileType; // Obtém o tipo de arquivo
}
