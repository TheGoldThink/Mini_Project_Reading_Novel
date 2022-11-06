import 'package:hive/hive.dart';
import 'package:reading_novel_mini_project/models/favor.dart';

class Boxes {
  static Box<Favorite> getTransactions() => Hive.box<Favorite>('favorite');
}
