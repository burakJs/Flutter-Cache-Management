import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/model/user_model.dart';
import 'package:flutter_cache_management/product/cache_manager.dart';

class UserCacheView extends StatefulWidget {
  @override
  _UserCacheViewState createState() => _UserCacheViewState();
}

class _UserCacheViewState extends State<UserCacheView> {
  List<Data> items = CacheManager.instance.getCacheList<Data>(Data());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cache List'),
        actions: [buildIconButton()],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Text('${items[index].email}');
        },
      ),
    );
  }

  IconButton buildIconButton() {
    return IconButton(
      icon: Icon(Icons.remove),
      onPressed: () async {
        await CacheManager.instance.removeAllCache<Data>();
        setState(() {
          items = CacheManager.instance.getCacheList<Data>(Data());
        });
      },
    );
  }
}
