import 'dart:io';
import 'dart:math';

class DNASequence {
  final String sequence;

  DNASequence(this.sequence) {
    if (!_isValidSequence(sequence)) {
      throw ArgumentError('Invalid DNA sequence: $sequence');
    }
  }

  factory DNASequence.random(int length) {
    final random = Random();
    final nucleotides = ['A', 'T', 'C', 'G'];
    final sequence =
        List.generate(length, (_) => nucleotides[random.nextInt(nucleotides.length)]).join();
    return DNASequence(sequence);
  }

  bool _isValidSequence(String sequence) {
    final pattern = RegExp(r'^[ATCG]+$');
    return pattern.hasMatch(sequence);
  }

  DNASequence get reverse {
    final reversedSequence = sequence.split('').reversed.join();
    return DNASequence(reversedSequence);
  }

  DNASequence get complement {
    final complementMap = {
      'A': 'T',
      'T': 'A',
      'C': 'G',
      'G': 'C',
    };
    final complementSequence =
        sequence.split('').map((nucleotide) => complementMap[nucleotide]).join();
    return DNASequence(complementSequence);
  }

  int countNucleotide(String nucleotide) {
    if (!_isValidNucleotide(nucleotide)) {
      throw ArgumentError('Invalid nucleotide: $nucleotide');
    }
    return sequence.split('').where((n) => n == nucleotide).length;
  }

  bool _isValidNucleotide(String nucleotide) {
    final validNucleotides = ['A', 'T', 'C', 'G'];
    return validNucleotides.contains(nucleotide);
  }

  @override
  String toString() => sequence;
}

void main() {
  // Testing the DNASequence class

  // Getting DNA sequence from user input
  stdout.write('Enter the DNA sequence: ');
  final inputSequence = stdin.readLineSync()!; // Add "!" to assert non-nullability

  try {
    // Creating a DNASequence from user input
    final sequence = DNASequence(inputSequence);

    print('DNA Sequence: $sequence');

    // Reversing the sequence
    final reversedSequence = sequence.reverse;
    print('Reversed Sequence: $reversedSequence');

    // Getting the complement sequence
    final complementSequence = sequence.complement;
    print('Complement Sequence: $complementSequence');

    // Counting the occurrences of a nucleotide
    stdout.write('Enter a nucleotide to count: ');
    final nucleotide = stdin.readLineSync()!; // Add "!" to assert non-nullability
    final count = sequence.countNucleotide(nucleotide);
    print('Occurrences of $nucleotide: $count');
  } catch (e) {
    print(e);
  }
}
