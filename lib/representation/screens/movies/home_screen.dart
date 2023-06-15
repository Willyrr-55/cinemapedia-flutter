import 'package:cinemapedia/representation/widgets/shared/side_menu.dart';
import 'package:cinemapedia/representation/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../../views /views.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    HomeView(),
    SizedBox(),
    FavoritesView()
  ];

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        // key: scaffoldKey,
        body: IndexedStack(
          index: pageIndex,
          children: viewRoutes,
        ), 
        bottomNavigationBar: CustomBottomNavigation(currentIndex: pageIndex,),
        drawer: SideMenu(scaffoldKey:scaffoldKey),
    );
  }
}
