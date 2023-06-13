import 'package:cinemapedia/config/menu/menu_items.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:widgets_app/config/menu/menu_items.dart';

class SideMenu extends StatefulWidget {

  final GlobalKey<ScaffoldState> scaffoldKey; 
  
  const SideMenu({super.key, required this.scaffoldKey});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  int navDraweIndex = 0;

  @override
  Widget build(BuildContext context) {

    final bool hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final colors = Theme.of(context).colorScheme;

    return NavigationDrawer(
      selectedIndex: navDraweIndex,
      onDestinationSelected: (value){
        setState(() {
          navDraweIndex = value;
        });

        final menuItem = appMenuItems[value];
        context.push(menuItem.link);
        widget.scaffoldKey.currentState?.closeDrawer();

      },
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(28, hasNotch ? 0: 20, 16, 10),
          child: Text('Menu', style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700, color: colors.primary ),)
        ),
       

        ...appMenuItems
            .map((item) => NavigationDrawerDestination(
              icon: Icon( item.icon ),
              label: Text(item.title),
            )),
        
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          child: Divider(),
        ),
      
        const Padding(
          padding: EdgeInsets.fromLTRB(28, 10, 16, 10),
          child: Text('More Options'),
        ),

        
  

        
      ],
    );
  }
}