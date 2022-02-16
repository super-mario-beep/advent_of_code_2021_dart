//https://adventofcode.com/2021/day/2#part2
import 'dart:io';
import 'dart:convert';

main() async{
  File file = new File('input.txt');
  int depth = 0;
  int position = 0;
  int aim = 0;
  int step = 0;
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      step = int.parse(line[line.length - 1]),
      if(line.contains("forward")){
        position += step,
        depth += aim * step
      }else if(line.contains("down")){
        aim += step,
      }else{
        aim -= step,
      }
    });
  print(position * depth);
}