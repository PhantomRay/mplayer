import 'package:fish_redux/fish_redux.dart';
import '../views/main/page.dart';

class RouteNames {
  static const String MainPage = "MainPage";
}

class RoutePages {
  static Map<String, Page<Object, dynamic>> get pages {
    return <String, Page<Object, dynamic>>{
      RouteNames.MainPage: MainPage(),
    };
  }
}
