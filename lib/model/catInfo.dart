import 'package:hive/hive.dart';

part 'catInfo.g.dart';
@HiveType(typeId: 1)
class CatInfo {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String imageUrl;

  CatInfo(this.id, this.name, this.imageUrl);
}
