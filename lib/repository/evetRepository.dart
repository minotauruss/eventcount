import 'package:eventcount/abstract/repoAbstract.dart';
import 'package:hive_flutter/hive_flutter.dart';

class EventRepository extends RepoAbstract {
  @override
  String deleteData(String tableName, String id) {
    var box = Hive.box(tableName);
    box.delete(id);
    return "Silindi";
  }

  @override
  Object getData(String tableName, String id) {
    var box = Hive.box(tableName);
    var data = box.get(id);
    return data;
  }

  @override
  List getDataAll(String tableName) {
    List box = Hive.box(tableName).values.cast().toList();
    return box;
  }

  @override
  void saveData(String tableName, String id, model) {
    var box = Hive.box(tableName);
    box.put(id, model);
  }

  @override
  void updateData(String tableName, String id, model) {
    var box = Hive.box(tableName);
    box.put(id, model);
  }
}
