import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action, Page;
import 'global_store/state.dart';
import 'global_store/store.dart';
import 'global_store/update_store.dart';
import 'services/route_pages.dart';

Widget createApp() {
  final AbstractRoutes routes = PageRoutes(
    pages: RoutePages.pages,
    visitor: (String path, Page<Object, dynamic> page) {
      if (page.isTypeof<GlobalBaseState>()) {
        page.connectExtraStore<GlobalState>(GlobalStore.store, updateGlobalStore());
      }

      page.enhancer.append(
        viewMiddleware: <ViewMiddleware<dynamic>>[
          safetyView<dynamic>(),
        ],
        adapterMiddleware: <AdapterMiddleware<dynamic>>[safetyAdapter<dynamic>()],
        effectMiddleware: <EffectMiddleware<dynamic>>[
          _pageAnalyticsMiddleware<dynamic>(),
        ],
        middleware: <Middleware<dynamic>>[
          //logMiddleware<dynamic>(tag: page.runtimeType.toString()),
        ],
      );
    },
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: routes.buildPage(RouteNames.MainPage, null),
    onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute<Object>(
          builder: (BuildContext context) {
            return routes.buildPage(settings.name, settings.arguments);
          },
          settings: settings);
    },
  );
}

/// 简单的 Effect AOP
/// 只针对页面的生命周期进行打印
EffectMiddleware<T> _pageAnalyticsMiddleware<T>() {
  return (AbstractLogic<dynamic> logic, Store<T> store) {
    return (Effect<dynamic> effect) {
      return (Action action, Context<dynamic> ctx) {
        if (logic is Page<dynamic, dynamic> && action.type is Lifecycle) {
          //print('${logic.runtimeType} ${action.type.toString()} ');
        }
        return effect?.call(action, ctx);
      };
    };
  };
}
