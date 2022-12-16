class Individual:
    _next_name_number = 1

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

    def __str__(self):
        return self._name

    @property
    def name(self):
        return self._name

    @property
    def genotype(self):
        return self._genotype

    @property
    def blood_type(self):
        return self._blood_type

    @property
    def agglutinogens(self):
        return self._agglutinogens

    @property
    def agglutinins(self):
        return self._agglutinins

    def _get_blood_type(self):
        if self._genotype == "AA" or self._genotype == "Ai":
            return "A"
        elif self._genotype == "BB" or self._genotype == "Bi":
            return "B"
        elif self._genotype == "AB":
            return "AB"
        else:
            return "O"

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

         
        
