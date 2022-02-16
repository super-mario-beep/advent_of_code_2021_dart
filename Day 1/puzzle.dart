//https://adventofcode.com/2021/day/1
import 'dart:io';
import 'dart:convert';

main() async{
  File file = new File('input.txt');
  int depth = 0;
  int count = -1;
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      int.parse(line) > depth ? count++ : 0,
      depth = int.parse(line),
    });
  print(count);
}