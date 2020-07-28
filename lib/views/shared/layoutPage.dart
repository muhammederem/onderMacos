import 'package:flutter/material.dart';

import 'package:onder2020/views/menu/Drawer_Scaffold.dart';
import 'package:onder2020/views/menu/menu_screen.dart';

import 'package:onder2020/views/pages/announcementPage.dart';
import 'package:onder2020/views/pages/commisionPage.dart';
import 'package:onder2020/views/pages/connectionPage.dart';
import 'package:onder2020/views/pages/formRotatePage.dart';
import 'package:onder2020/views/pages/homepage.dart';
import 'package:onder2020/views/pages/newsPage.dart';

import 'package:onder2020/views/pages/stablePagesRotatePage.dart';

class LayoutPage extends StatefulWidget {
  @override
  _LayoutPageState createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
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
      new MenuItem(
        id: 'form',
        title: 'BAŞVURULAR',
        icon: Icons.contact_mail,
      ),
    ],
  );

  var selectedMenuItemId = 'home';
  Widget _widget = HomePage();

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
              setState(() => _widget = HomePage());
            } else if (itemId == 'news') {
              setState(() => _widget = NewsPage());
            } else if (itemId == 'announcement') {
              setState(() => _widget = AnnouncementPage());
            } else if (itemId == 'about') {
              setState(() => _widget = RotatePage());
            } else if (itemId == 'commisions') {
              setState(() => _widget = CommissionPage());
            } else if (itemId == 'connect') {
              setState(() => _widget = ConnectionPage());
            } else if (itemId == 'form') {
              setState(() => _widget = FormRotatePage());
            } else {
              setState(() => _widget = HomePage());
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
                child: Center(
                  child: _widget,
                ),
              ),
            ),
          ),
          color: Colors.white,
        ));
  }
}
