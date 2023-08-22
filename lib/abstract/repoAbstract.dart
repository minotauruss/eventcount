import 'package:eventcount/model/event.dart';

abstract class RepoAbstract<T>{

  void saveData(String tableName ,String id, var model);
  List<T> getDataAll(String tableName);
  Object getData(String tableName,String id);
  String deleteData(String tableName,String id);
  void updateData(String tableName,String id, var model);
}