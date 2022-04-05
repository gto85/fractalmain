import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fractal/core/widgets/bottom_bar.dart';
import 'package:fractal/feature/authenticaiton/services/auth.dart';
import 'package:fractal/feature/balance_plan/balance_screen_plan_day.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int sectionIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
          length : 2,
          child : Scaffold(
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(
                    margin: EdgeInsets.zero,
                    padding: EdgeInsets.zero,
                    child: UserAccountsDrawerHeader (
                      decoration: BoxDecoration(color:Theme.of(context).primaryColor ),
                      accountName: const Text('Фрактал'),
                      accountEmail: const Text("home@dartflutter.ru"),
                      currentAccountPicture: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                          )
                      ),
                    ),
                  ),
                  ListTile(
                      title: const Text("О себе"),
                      leading: const Icon(Icons.account_box),
                      onTap: (){

                      }
                  ),
                  ListTile(
                      title: const Text("Настройки"),
                      leading: const Icon(Icons.settings),
                      onTap: (){}
                  )
                ],
              ),
            ),
            appBar : AppBar(
                title : const Text("FRACTAL",style: TextStyle(
                    fontFamily: "fonts/Cuprum.ttf",
                    fontSize: 27.57,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w400,
                    height: 1.27
                )
                ),
                actions: <Widget>[
                  IconButton(
                    icon: const Icon(Icons.notifications_active),
                    onPressed: () {},),
                  IconButton(
                    icon: const Icon(Icons.exit_to_app_sharp),
                    onPressed: (){
                      AuthService().logOut();
                      Navigator.popUntil(context, ModalRoute.withName("/"));
                      // print("Выход из профиля! $context");
                    },
                  ),
                ],
                centerTitle: true,
                bottom : TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorWeight: 4,
                    labelPadding: const EdgeInsets.all(0),
                    tabs : [
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text( "Запланированно".toUpperCase(),
                              style:
                              TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 16,
                                  height: 1.5,
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "fonts/Roboto-Regular.ttf")),
                        ),
                      ),
                      Tab(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text( "Выполнение".toUpperCase(),style:const TextStyle(

                              fontSize: 16,
                              height: 1.5,
                              letterSpacing: 0.1,
                              fontWeight: FontWeight.w700,
                              fontFamily: "fonts/Roboto-Regular.ttf")),
                        ),
                      ),
                    ] /* End TabBar.tabs. */
                ) /* End TabBar. */
            ), /* End AppBar. */
            body : const TabBarView(
                children : [
                  MyPage(),
                  MyPageResult()
                ] /* End TabBarView.children. */
            ), /* End TabBarView. */
          ) /* End Scaffold. */
      ) /* End DefaultTabController. */,
    );
  }
}

class MyPage extends StatefulWidget{
  const MyPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget>createState(){
    return MyPageState();
  }
}
class MyPageState extends State<MyPage>{
  int selectedindex = 0;
  // TextEditingController _txtCtrl = TextEditingController();
  final Widget _myBalance = const MyBalance ();
  final Widget _myStat = const MyStat();
  final Widget _myLife = const MyLife();
  final Widget _myProfile = const MyProfile();
  @override
  Widget build(BuildContext context) {
    // print(_firebaseRef.onValue);
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedindex,
        selectedIconTheme: const IconThemeData (
            color: Color(0xFF000000),
            opacity: 1.0,
            size: 30
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_balance_25px.png"),
            label: "Баланс",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_stat_25px.png"),
            label: "Статистика",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_time_life_25px.png"),
            label: "90 лет",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_profile_25px.png"),
            label: "Профиль",
          )
        ],
        onTap: (int index){
          onTapHandler(index);
        },
      ),
    );
  }
  Widget getBody() {
    if (selectedindex==0) {
      return _myBalance;
    } else if(selectedindex==1) {
      return _myStat;
    } else if(selectedindex==2) {
      return _myLife;
    } else {
      return _myProfile;
    }
  }
  void onTapHandler(int index)  {
    setState(() {
      selectedindex = index;
    });
  }
}
class MyPageResult extends StatefulWidget{
  const MyPageResult({Key? key}) : super(key: key);

  @override
  State<StatefulWidget>createState(){
    return MyPageResultState();
  }
}
class MyPageResultState extends State<MyPageResult>{
  int selectedindex = 0;


  final Widget _myBalance = const MyBalanceResult();
  final Widget _myStat = const MyStat();
  final Widget _myLife = const MyLife();
  final Widget _myProfile = const MyProfile();
  @override
  Widget build(BuildContext context) {
    // print(_firebaseRef.onValue);
    return Scaffold(
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor:Colors.blueAccent,
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedindex,
        selectedIconTheme: const IconThemeData (
            color: Color(0xFF000000),
            opacity: 1.0,
            size: 30
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_balance_25px.png"),
            label: "Баланс",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_stat_25px.png"),
            label: "Статистика",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_time_life_25px.png"),
            label: "90 лет",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("images/_botom_icon_profile_25px.png"),
            label: "Профиль",
          )
        ],
        onTap: (int index){
          onTapHandler(index);
        },
      ),
    );
  }
  Widget getBody() {
    if (selectedindex==0) {
      return _myBalance;
    } else if(selectedindex==1) {
      return _myStat;
    } else if(selectedindex==2) {
      return _myLife;
    } else {
      return _myProfile;
    }
  }
  void onTapHandler(int index)  {
    setState(() {
      selectedindex = index;
    });
  }
}
