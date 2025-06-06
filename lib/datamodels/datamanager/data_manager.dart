import 'package:hive/hive.dart';
import 'package:pipakshatriya/datamodels/user_model.dart';
import 'dart:async';

List<dynamic> minUsersDataLocalCache = [];
List<String> minUsersKeysCache = [];

class  UserDataManager {
  static final UserDataManager _instance = UserDataManager._internal();
  factory UserDataManager() => _instance;
  UserDataManager._internal();

  UserModel? _currentUser;
  late Box<UserModel> _userBox; // ✅ Reusable box

  /// Call once at app startup
  Future<void> init() async {
    _userBox = await Hive.openBox<UserModel>('userBox'); // ✅ Only once
    _currentUser = _userBox.get('currentUser');
  }

  UserModel? get currentUser => _currentUser;


  Future<void> updateUser(UserModel user) async {
    await _userBox.put('currentUser', user); // ✅ No need to open again
    _currentUser = user;
  }


  Future<void> clearUserData() async {
    await _userBox.clear();       // Clears all keys from this box
    _currentUser = null;          // Reset in-memory user
  }

  Future<void> updateUserField(void Function(UserModel user) updateCallback) async {
    final user = _userBox.get('currentUser');
    if (user != null) {
      updateCallback(user); // modify the field(s)
      await user.save(); // persist changes
      _currentUser = user;  // update in-memory copy
    }
  }
}
