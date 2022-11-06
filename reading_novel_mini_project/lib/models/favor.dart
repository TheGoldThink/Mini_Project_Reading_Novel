import 'package:hive/hive.dart';

part 'favor.g.dart';

@HiveType(typeId: 0)
class Favorite extends HiveObject {
  @HiveField(0)
  late String judul;

  @HiveField(1)
  late String sinopsis;

  @HiveField(2)
  late String gambar;

  @HiveField(3)
  late String genre;

  @HiveField(4)
  late List<dynamic> ch;

  Favorite(this.judul, this.sinopsis, this.gambar, this.genre, this.ch);
}
