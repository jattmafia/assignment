import 'package:assignment/features/profile/model/user.dart';
import 'package:hive/hive.dart';

class UserStorageProvider {
  static const String _boxName = 'userBox';


  Future<Box<User>> _openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      return await Hive.openBox<User>(_boxName);
    }
    return Hive.box<User>(_boxName);
  }

  Future<void> saveUser(String key, User user) async {
    final box = await _openBox();
    await box.put(key, user); 
  }


  Future<User?> getUser(String key) async {
    final box = await _openBox();
    return box.get(key);
  }


  Future<void> updateUser(String key, User updatedUser) async {
    final box = await _openBox();
    if (box.containsKey(key)) {
      await box.put(key, updatedUser);
    } else {
      throw Exception("User with key $key does not exist.");
    }
  }


  Future<void> deleteUser(String key) async {
    final box = await _openBox();
    await box.delete(key);
  }


  Future<bool> doesEmailExist(String email) async {
    final box = await _openBox();

    for (var user in box.values) {
      if (user.email == email) {
        return true;
      }
    }
    return false;
  }

    Future<bool> doesphoneExist(String phone) async {
    final box = await _openBox();

    for (var user in box.values) {
      if (user.phoneNumber == phone) {
        return true;
      }
    }
    return false;
  }


  Future<List<User>> getAllUsers() async {
    final box = await _openBox();
    return box.values.toList();
  }
}
