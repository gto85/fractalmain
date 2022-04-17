import 'package:app_state/app_state.dart';
import 'package:flutter/widgets.dart';

import '../pages/planed/configurations.dart';
import '../pages/authorization/configurations.dart';


class MyRouteInformationParser extends PageStacksRouteInformationParser {
  @override
  Future<PageStacksConfiguration> parseRouteInformation(RouteInformation ri) async {
    return _parseTopPageConfiguration(ri).defaultStacksConfiguration;
  }

  PageConfiguration _parseTopPageConfiguration(RouteInformation ri) {
    return
      AuthPageConfiguration.tryParse(ri) ??
          PlanedPageConfiguration.tryParse(ri) ??// Optional, it's the default page.

          // The default page if nothing worked.
           AuthPageConfiguration(authId: "null");
  }
}