import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/model/user_model.dart';

abstract class IUserService {
  final Dio dio;
  IUserService(this.dio);
  final baseUrl = 'https://reqres.in/api';
  Future<List<Data>> fetchUserList();
}

class UserService extends IUserService {
  UserService(Dio dio) : super(dio);

  final String _userPath = '/users?page=2';
  @override
  Future<List<Data>> fetchUserList() async {
    final response = await dio.get('$baseUrl$_userPath');
    if (response.statusCode == HttpStatus.ok) {
      final jsonItems = response.data;
      if (jsonItems is Map<String, dynamic>) {
        return UserModel.fromJson(jsonItems).data ?? [];
      }
    }
    return [];
  }
}
