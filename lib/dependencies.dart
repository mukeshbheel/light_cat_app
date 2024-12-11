import 'package:hive_flutter/adapters.dart';
import 'package:provider_project/model/catInfo.dart';

class Dependencies {
  static Future<void> initializeDependencies() async{
    await Hive.initFlutter();
    Hive.registerAdapter(CatInfoAdapter());
    await Hive.openBox<CatInfo>('cats');
  }
}