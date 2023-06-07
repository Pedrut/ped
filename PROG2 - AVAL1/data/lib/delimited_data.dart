// Classe abstrata para fontes de dados delimitados por algum caractere
part of exchange;

abstract class DelimitedData extends Data {
  String
      get delimiter; // Obtém o caractere delimitador utilizado na fonte de dados
}
