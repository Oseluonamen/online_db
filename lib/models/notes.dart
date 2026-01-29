import 'package:isar/isar.dart';

// this line is needed to generate file
// then run: dart run build_runner build
part 'notes.g.dart';

@Collection()
class Notes {
  Id id = Isar.autoIncrement;
  late String text;  
}