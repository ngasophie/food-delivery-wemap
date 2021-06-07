import 'package:flutter/material.dart';
import 'package:wemapgl_example/scr/providers/app.dart';
import 'package:wemapgl_example/scr/providers/category.dart';
import 'package:wemapgl_example/scr/providers/product.dart';
import 'package:wemapgl_example/scr/providers/restaurant.dart';
import 'package:wemapgl_example/scr/providers/user.dart';
import 'package:wemapgl_example/scr/screens/home.dart';
import 'package:wemapgl_example/scr/screens/login.dart';
import 'package:wemapgl_example/scr/screens/splash.dart';
import 'package:wemapgl_example/scr/widgets/loading.dart';
import 'package:provider/provider.dart';
import 'package:wemapgl/wemapgl.dart' as WEMAP;
void main() {
  WEMAP.Configuration.setWeMapKey('GqfwrZUEfxbwbnQUhtBMFivEysYIxelQ');
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AppProvider()),
        ChangeNotifierProvider.value(value: UserProvider.initialize()),
        ChangeNotifierProvider.value(value: CategoryProvider.initialize()),
        ChangeNotifierProvider.value(value: RestaurantProvider.initialize()),
        ChangeNotifierProvider.value(value: ProductProvider.initialize()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food App',
          theme: ThemeData(
            primarySwatch: Colors.red,
          ),
          home: ScreensController())));
}

class ScreensController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Uninitialized:
        return Splash();
      case Status.Unauthenticated:
      case Status.Authenticating:
        return LoginScreen();
      case Status.Authenticated:
        return Home();
      default:
        return LoginScreen();
    }
  }
}
