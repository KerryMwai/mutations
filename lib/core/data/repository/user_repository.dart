import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:mutation/core/model/user.dart';
import 'package:mutation/core/domain/usecase/user_usecase.dart';

class UserInteraction extends ChangeNotifier {
  List _users = [];

  UnmodifiableListView get allusers => UnmodifiableListView(_users);

  Future<void> createAUser(User user)async{
    UsersUseCase().createUser(user);
    notifyListeners();
  }

   Future getAllUsers()async{
    _users=await UsersUseCase().getAllUsers();
    notifyListeners();
  }


}
