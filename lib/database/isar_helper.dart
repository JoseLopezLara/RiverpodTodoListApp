import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_change_notifier_provider/models/user.dart';

class IsarHelper {
  static IsarHelper? isarHelper;
  IsarHelper._internal();

  static IsarHelper get instance => isarHelper ??= IsarHelper._internal();

  static Isar? _isarDB;

  Isar get isar => _isarDB!;

  Future<void> init() async {
    if (_isarDB != null) {
      return;
    }
    final path = (await getApplicationDocumentsDirectory()).path;
    _isarDB = await Isar.open([UserSchema], directory: path);
  }
}
