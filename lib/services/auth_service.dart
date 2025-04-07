import 'dart:convert';
import 'dart:io';
import 'package:vizeeeee/models/user.dart';
import 'package:path_provider/path_provider.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  Future<File> get _usersFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/users.json');
  }

  Future<void> registerUser(User user) async {
    final file = await _usersFile;
    List<User> users = await _getAllUsers();

    if (users.any((u) => u.email == user.email)) {
      throw Exception('User already exists');
    }

    users.add(user);
    await file.writeAsString(json.encode(users.map((u) => u.toJson()).toList()));
  }

  Future<User?> loginUser(String email, String password) async {
    final users = await _getAllUsers();
    return users.firstWhere(
          (user) => user.email == email && user.password == password,
      orElse: () => throw Exception('Invalid credentials'),
    );
  }

  Future<List<User>> _getAllUsers() async {
    try {
      final file = await _usersFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final List<dynamic> jsonList = json.decode(contents);
        return jsonList.map((json) => User.fromJson(json)).toList();
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}
