import 'dna_sequence.dart';

void main() {
  try {
    final dna = DNASequence('ATCG');
    print('DNA sequence: $dna');
    final reversedDna = dna.reverse;
    print('Reversed DNA sequence: $reversedDna');
    final complementDna = dna.complement;
    print('Complement DNA sequence: $complementDna');
    final nucleotideCount = dna.countNucleotide('A');
    print('Number of A nucleotides: $nucleotideCount');
    print('coded by: Pedro Felipe /1074822'); 
  } catch (e) {
    print('Error: $e');
  }
}


