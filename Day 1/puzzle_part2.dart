//https://adventofcode.com/2021/day/1#part2
import 'dart:io';
import 'dart:convert';

main() async{
  File file = new File('input.txt');
  List<int> depth = [];
  int total = 0;
  int count = 0;
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      if(depth.length < 3){
        depth.add(int.parse(line)),
      }else{
        total = depth.reduce((x, y) => x + y),
        depth.removeAt(0),
        depth.add(int.parse(line)),
        depth.reduce((x, y) => x + y) > total ? count++ : 0,
      }
    });
  print(count);
}