import 'package:fish_redux/fish_redux.dart';
import '../views/detail/page.dart';
import '../views/main/page.dart';

class RouteNames {
  static const String MainPage = "MainPage";
  static const String DetailPage = "DetailPage";
}

class RoutePages {
  static Map<String, Page<Object, dynamic>> get pages {
    return <String, Page<Object, dynamic>>{
      RouteNames.MainPage: MainPage(),
      RouteNames.DetailPage: DetailPage(),
    };
  }
}
