
## Essa classe "Individual" representa uma "pessoa" e seus atributos genotípicos e fenotípicos de sangue. A classe tem os seguintes métodos:

class Individual:
    _next_name_number = 1

## __init__(self, genotype: str, name: str = None): esse é o construtor da classe, que é chamado quando se cria uma nova instância da classe. Ele recebe um parâmetro genotype, que representa o genótipo da pessoa e é uma string com um dos seguintes valores possíveis: "AA", "Ai", "BB", "Bi", "AB", "ii". Também existe a opção de passar um nome para a pessoa (name), que é uma string. Se o nome não for passado, ele será definido como "IndivN", onde N é um número sequencial de cada instância da classe. Além disso, esse método calcula e atribui os valores para os atributos blood_type, agglutinogens e agglutinins, que são os tipos de sangue aglutinógenos e aglutininas da pessoa, respectivamente.

    def __init__(self, genotype: str, name: str = None):
        if genotype not in ["AA", "Ai", "BB", "Bi", "AB", "ii"]:
            raise ValueError("Invalid genotype.")

        self._genotype = genotype
        self._blood_type = self._get_blood_type()
        self._agglutinogens = self._get_agglutinogens()
        self._agglutinins = self._get_agglutinins()

        if name is None:
            self._name = f"Indiv{Individual._next_name_number}"
            Individual._next_name_number += 1
        else:
            self._name = name
            
## __str__(self): esse método é chamado quando a classe é convertida para uma string, quando é printada ou usada em uma concatenação de strings. Ele retorna o nome da pessoa.

    def __str__(self):
        return self._name
    
## name(self): esse é um método de "getter" para o atributo name da pessoa. Ele retorna o nome da pessoa.

    @property
    def name(self):
        return self._name
    
## genotype(self): esse é um método de "getter" para o atributo genotype da pessoa. Ele retorna o genótipo da pessoa.

    @property
    def genotype(self):
        return self._genotype
    
## blood_type(self): esse é um método de "getter" para o atributo blood_type da pessoa. Ele retorna o tipo de sangue da pessoa.

    @property
    def blood_type(self):
        return self._blood_type
    
## agglutinogens(self): esse é um método de "getter" para o atributo agglutinogens da pessoa. Ele retorna os aglutinógenos da pessoa.

    @property
    def agglutinogens(self):
        return self._agglutinogens
    
## agglutinins(self): esse é um método de "getter" para o atributo agglutinins da pessoa. Ele retorna as aglutininas da pessoa.

    @property
    def agglutinins(self):
        return self._agglutinins
    
## _get_blood_type(self): esse método é usado para calcular o tipo de sangue da pessoa. Ele usa o genótipo da pessoa para determinar se o tipo de sangue é "A", "B", "AB" ou "O".

    def _get_blood_type(self):
        if self._genotype == "AA" or self._genotype == "Ai":
            return "A"
        elif self._genotype == "BB" or self._genotype == "Bi":
            return "B"
        elif self._genotype == "AB":
            return "AB"
        else:
            return "O"
        
## _get_agglutinogens(self): esse método é usado para calcular os aglutinógenos da pessoa.

    def _get_agglutinogens(self):
        agglutinogens = set()
        if self._genotype == "AA" or self._genotype == "Ai" or self._genotype == "AB":
            agglutinogens.add("A")
        if self._genotype == "BB" or self._genotype == "Bi" or self._genotype == "AB":
            agglutinogens.add("B")
        return agglutinogens

    def _get_agglutinins(self):
        agglutinins = set()
        if self._genotype == "ii":
            agglutinins.add("A")
            agglutinins.add("B")
        elif self._genotype == "Ai":
            agglutinins.add("A")
        elif self._genotype == "Bi":
            agglutinins.add("B")
        return agglutinins

    def can_donate(self, other: "Individual"):
        if self.blood_type == "O" and self.agglutinins.issubset(other.agglutinogens):
            return True
        else:
            return False

    def can_receive(self, donor: "Individual"):
        if donor.blood_type == "O" and donor.agglutinogens.issubset(self.agglutinogens):
            return True
        else:
            return

    def offsprings_genotypes(self, other: "Individual"):
        genotypes = set()
        for allele1 in self._genotype:
            for allele2 in other.genotype:
                genotypes.add(allele1 + allele2)
        return genotypes


    def offsprings_blood_types(self, other: "Individual"):
        blood_types = set()

        for genotype in self.offsprings_genotypes(other):
            if genotype == "AA" or genotype == "Ai":
                blood_types.add("A")
            elif genotype == "BB" or genotype == "Bi":
                blood_types.add("B")
            elif genotype == "AB":
                blood_types.add("AB")
            else:
                blood_types.add("O")
        return blood_types

  #CODED BY: PEDRO R.BARROS
  #Bloco02

         
        
