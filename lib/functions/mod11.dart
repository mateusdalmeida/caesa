int mod11(String matricula) {
  List<int> numbers = matricula
      .split("")
      .map((number) => int.parse(number, radix: 10))
      .toList();
  int modulus = numbers.length + 1;
  List<int> multiplied = [];
  for (var i = 0; i < numbers.length; i++) {
    multiplied.add(numbers[i] * (modulus - i));
  }
  int mod = multiplied.reduce((buffer, number) => buffer + number) % 11;
  return (mod < 2 ? 0 : 11 - mod);
}
