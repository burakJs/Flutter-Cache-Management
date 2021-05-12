import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/model/user_model.dart';
import 'package:flutter_cache_management/feature/service/user_service.dart';
import 'package:flutter_cache_management/feature/view/subview/user_card.dart';
import 'package:flutter_cache_management/feature/view/user_cache_view.dart';

class UserView extends StatefulWidget {
  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  late final IUserService userService;
  List<Data> userList = [];

  @override
  void initState() {
    super.initState();
    userService = UserService(Dio());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.cached),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserCacheView(),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: buildFloatingActionButton(),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return UserCard(model: userList[index]);
        },
      ),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        fetchItemsAndSave();
      },
      child: Icon(Icons.add),
    );
  }

  Future<void> fetchItemsAndSave() async {
    userList = await userService.fetchUserList();
    setState(() {});
  }
}
