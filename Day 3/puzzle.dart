//https://adventofcode.com/2021/day/3
import 'dart:io';
import 'dart:convert';

main() async{
  File file = new File('input.txt');
  List<int> report = List.filled(12, 0);
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      for(var i = 0; i < line.length; i++){
        if(line[i] == "0"){
          report[i] -= 1,
        }else{
          report[i] += 1,
        }
      }
    });
  String stringDigits = "";
  report.forEach((element) { element > 0 ? stringDigits = stringDigits + "1" : stringDigits = stringDigits + "0"; });
  int gamma = int.parse(stringDigits, radix: 2);
  int epsilon = int.parse(stringDigits.replaceAll("1", "_").replaceAll("0", "1").replaceAll("_", "0"), radix: 2);
  print(gamma * epsilon);
}