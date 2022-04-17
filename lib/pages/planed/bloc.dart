import 'package:app_state/app_state.dart';
import 'package:fractal/models/char_needs.dart';
import '../../main.dart';
import 'configurations.dart';


class PlanedBloc extends PageBloc<PlanedPageConfiguration> {
  // void showFact(CharNeedResult clusterResult) {
  //   pageStacksBloc.currentStackBloc?.push(FactPage(factId: planed.id));
  // }
  // void showEditPlanedList(CharNeedResult clusterResult) {
  //   pageStacksBloc.currentStackBloc?.push(FactPage(factId: planed.id));
  // }
  // void showCheckListOfCluster(CharNeedResult clusterResult) {
  //   pageStacksBloc.currentStackBloc?.push(FactPage(factId: planed.id));
  // }

  @override
  PlanedPageConfiguration getConfiguration() => const PlanedPageConfiguration();
}