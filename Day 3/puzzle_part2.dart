//https://adventofcode.com/2021/day/3#part2
import 'dart:io';
import 'dart:convert';

main() async{
  File file = new File('input.txt');
  List<String> report = [];
  await file.openRead()
    .map(utf8.decode)
    .transform(new LineSplitter())
    .forEach((line) => {
      report.add(line)
    });

  String oxygen = getBytesForIndex(0, report, "1");
  String co2 = getBytesForIndex(0, report, "0");

  print(int.parse(oxygen, radix: 2) * int.parse(co2, radix: 2));
}

String getBytesForIndex(int index, List<String> report, String type){
  int count = 0;
  List<String> correct = [];
  report.forEach((element) { element[index] == type ? count++ : count--; });
  if(count == 0){
    if(type == "1"){
      report.forEach((element) { element[index] == "1" ? correct.add(element) : 0; });
    }else{
      report.forEach((element) { element[index] == "0" ? correct.add(element) : 0; });
    }
  }else if(count > 0){
    report.forEach((element) { element[index] == "1" ? correct.add(element) : 0; });
  }else{
    report.forEach((element) { element[index] == "0" ? correct.add(element) : 0; });
  }

  return correct.length == 1 ? correct.first : getBytesForIndex(index += 1, correct, type);
}