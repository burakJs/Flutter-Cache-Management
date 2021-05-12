import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/model/user_model.dart';
import 'package:flutter_cache_management/product/base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ICacheManager {
  late SharedPreferences prefs;
  Future<bool> addCacheItem<T>(String id, T model);
  Future<bool> removeCacheItem<T>(String id);
  Future<T> getCacheItem<T extends IBaseModel>(String id, IBaseModel model);
  List<T> getCacheList<T extends IBaseModel>(IBaseModel model);
  Future<void> removeAllCache<T>();
  bool isCacheData<T>(String id);
}

class CacheManager implements ICacheManager {
  static CacheManager _instance = CacheManager._init();
  static CacheManager get instance => _instance;

  late SharedPreferences prefs;
  CacheManager._init() {
    initPreferences();
  }

  Future<void> initPreferences() async {
    prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<bool> addCacheItem<T>(String id, T model) async {
    final _stringModel = jsonEncode(model);
    print(T);
    return await prefs.setString(_key<T>(id), _stringModel);
  }

  String _key<T>(String id) => '$T-$id';

  Future<bool> removeCacheItem<T>(String id) async {
    return await prefs.remove(_key<T>(id));
  }

  Future<T> getCacheItem<T extends IBaseModel>(String id, IBaseModel model) async {
    final cacheData = prefs.getString(_key<T>(id)) ?? '';
    final normalModelJson = jsonDecode(cacheData);
    return model.fromJson(normalModelJson);
  }

  List<T> getCacheList<T extends IBaseModel>(IBaseModel model) {
    final cacheDataList = prefs.getKeys().where((element) => element.contains('$T-')).toList();
    if (cacheDataList.isNotEmpty) {
      return cacheDataList.map((e) => model.fromJson(jsonDecode(prefs.getString(e) ?? '')) as T).toList();
    }
    return [];
  }

  Future<void> removeAllCache<T>() async {
    final cacheDataList = prefs.getKeys().where((element) => element.contains('$T-')).toList();
    cacheDataList.forEach((element) async {
      await prefs.remove(element);
    });
  }

  bool isCacheData<T>(String id) {
    return (prefs.getString(_key<T>(id)) ?? '').isNotEmpty;
  }
}
