import 'package:app_state/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/authorization/page.dart';
import 'pages/planed/page.dart';
import 'router/page_factory.dart';
import 'router/route_information_parser.dart';
import 'router/router_delegate.dart';
import 'router/tab_enum.dart';

final pageStacksBloc = PageStacksBloc();

void main() async{
  pageStacksBloc.addPageStack(
    TabEnum.balance.name,
    PageStackBloc<PageConfiguration>(
      bottomPage: PlanedPage(),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacksBloc.addPageStack(
    TabEnum.balance.name,
    PageStackBloc<PageConfiguration>(
      bottomPage: AuthPage(),
      createPage: PageFactory.createPage,
    ),
  );

  pageStacksBloc.setCurrentStackKey(TabEnum.balance.name, fire: false);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _routerDelegate = MyRouterDelegate(pageStacksBloc);
  final _routeInformationParser = MyRouteInformationParser();
  final _backButtonDispatcher = PageStacksBackButtonDispatcher(pageStacksBloc);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: _routerDelegate,
      routeInformationParser: _routeInformationParser,
      backButtonDispatcher: _backButtonDispatcher,
    );
  }
}