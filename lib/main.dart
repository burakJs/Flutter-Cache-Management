import 'package:flutter/material.dart';
import 'package:flutter_cache_management/feature/view/user_view.dart';
import 'package:flutter_cache_management/product/cache_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.instance.initPreferences();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: UserView(),
    );
  }
}
