import 'package:hive/hive.dart';
import 'package:pipakshatriya/datamodels/user_model.dart';
import 'dart:async';

class UserDataManager {
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
  final StreamController<UserModel> userStreamController = StreamController<UserModel>.broadcast();


  Future<void> updateUser(UserModel user) async {
    await _userBox.put('currentUser', user); // ✅ No need to open again
    _currentUser = user;
    userStreamController.add(user); // Notify listeners
  }


  Future<void> clearUserData() async {
    await _userBox.clear();       // Clears all keys from this box
    _currentUser = null;          // Reset in-memory user
  }

  Future<void> updateUserField(void Function(UserModel user) updateCallback) async {
    final user = _userBox.get('currentUser');
    if (user != null) {
      updateCallback(user); // modify the field(s)
      await user.save();    // persist changes
      _currentUser = user;  // update in-memory copy
    } else {
      print('No user found to update');
    }
    userStreamController.add(user!);
  }
}
