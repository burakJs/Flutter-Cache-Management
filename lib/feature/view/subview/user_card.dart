import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/model/user_model.dart';
import 'package:flutter_cache_management/product/cache_manager.dart';

class UserCard extends StatefulWidget {
  final Data model;

  const UserCard({Key? key, required this.model}) : super(key: key);

  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool isCached = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: buildAnimatedContainerFlag(),
          ),
          buildCenterCard(),
        ],
      ),
    );
  }

  AnimatedContainer buildAnimatedContainerFlag() {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      height: isCached ? 20 : 0,
      color: Colors.black12,
      child: Center(child: Text('Data Eklendi')),
    );
  }

  Center buildCenterCard() {
    return Center(
      child: ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.model.avatar ?? '')),
        title: Text(widget.model.email ?? ''),
        trailing: IconButton(
          icon: Icon(Icons.bookmark),
          onPressed: () async {
            final isOkey = await CacheManager.instance.addCacheItem('${widget.model.id}', widget.model);
            if (isOkey) {
              changeCachedState();
              await Future.delayed(Duration(seconds: 1));
              changeCachedState();
            }
          },
        ),
      ),
    );
  }

  void changeCachedState() {
    setState(() {
      isCached = !isCached;
    });
  }
}
