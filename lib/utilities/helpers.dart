import 'dart:math';

int getRandomPageNumber(int min, int max) {
  final random = Random();

  return min + random.nextInt(max - min);
}