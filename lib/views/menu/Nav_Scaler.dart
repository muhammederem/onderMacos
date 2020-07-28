import 'package:flutter/material.dart';
import 'package:onder2020/views/pages/homepage.dart';
import 'Drawer_Scaffold.dart';
import 'menu_screen.dart';

class DrawerScaleIcon extends StatefulWidget {
  @override
  _DrawerScaleIconState createState() => _DrawerScaleIconState();
}

class _DrawerScaleIconState extends State<DrawerScaleIcon> {
  final menu = new Menu(
    items: [
      new MenuItem(
        id: 'home',
        title: 'ANASAYFA',
        icon: Icons.home,
      ),
      new MenuItem(
        id: 'news',
        title: 'HABERLER',
        icon: Icons.person,
      ),
      new MenuItem(
        id: 'announcement',
        title: 'DUYURULAR',
        icon: Icons.announcement,
      ),
      new MenuItem(
        id: 'about',
        title: 'KURUMSAL',
        icon: Icons.bookmark,
      ),
      new MenuItem(
        id: 'commisions',
        title: 'KOMİSYONLAR',
        icon: Icons.group,
      ),
      new MenuItem(
        id: 'connect',
        title: 'İLETİŞİM',
        icon: Icons.phone,
      ),
    ],
  );

  var selectedMenuItemId = 'home';
  var _widget;

  @override
  Widget build(BuildContext context) {
    return new DrawerScaffold(
        percentage: 0.6,
        appBar: AppBarProps(
          title: Image.asset("assets/logo.png"),
        ),
        menuView: new MenuView(
          menu: menu,
          animation: true,
          selectorColor: Colors.yellow,
          color: Theme.of(context).primaryColor,
          selectedItemId: selectedMenuItemId,
          onMenuItemSelected: (String itemId) {
            selectedMenuItemId = itemId;
            if (itemId == 'home') {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/homepage');
            } else if (itemId == 'news') {
              setState(() => _widget = HomePage());
            } else if (itemId == 'announcement') {
              setState(() => _widget = Text("Help"));
            } else if (itemId == 'about') {
              setState(() => _widget = Text("Setting"));
            } else if (itemId == 'commisions') {
              setState(() => _widget = Text("Setting"));
            } else if (itemId == 'connect') {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/connection');
            }
          },
        ),
        contentView: Screen(
          contentBuilder: (context) => LayoutBuilder(
            builder: (context, constraint) => GestureDetector(
              child: Container(
                color: Colors.white,
                width: constraint.maxWidth,
                height: constraint.maxHeight,
                child: Center(child: _widget),
              ),
              onTap: () {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text("Clicked"),
                  duration: Duration(seconds: 3),
                ));
              },
            ),
          ),
          color: Colors.white,
        ));
  }
}
