import 'package:riverpod_change_notifier_provider/database/isar_helper.dart';
import 'package:riverpod_change_notifier_provider/models/user.dart';
import 'package:isar/isar.dart';

class UserDado {
  final isar = IsarHelper.instance.isar;

  Future<List<User>> getAll() async {
    return isar.users.where().findAll();
  }

  Future<bool> deleteOne(User user) async {
    return isar.writeTxn(() => isar.users.delete(user.id));
  }

  Future<int> upset(User user) async {
    return isar.writeTxn(() => isar.users.put(user));
  }

  Stream<List<User>> watchUsers() async* {
    yield* isar.users.where().watch();
  }
}
