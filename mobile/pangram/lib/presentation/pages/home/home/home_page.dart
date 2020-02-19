import 'package:flutter/material.dart';
import '../dashboard/dashboard_page.dart';
import '../home/widgets/drawer/home_drawer.dart';
import 'package:demo_app/presentation/pages/home/search/search_screen.dart';
import 'package:demo_app/presentation/pages/home/favorite/favorite_screen.dart';
import 'package:demo_app/presentation/pages/home/setting/setting_screen.dart';
import 'package:demo_app/presentation/pages/home/pangram/showPangram_screen.dart';

enum HomePageOptions {
  dashboard,
  serarch,
  favorite,
  settings,
  pangram,
}

class HomePage extends StatefulWidget {
  final HomePageOptions page;

  const HomePage({Key key, this.page}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    _selectedPageIndex = widget.page?.index ?? 0;
  }

  final List<Widget> _pages = [
    DashboardPage(),
    SearchScreen(),
    FavoriteScreen(),
    SettingScreen(),
    PangramScreen(),
  ];

  final List<String> titles = [
    "Dashboard",
    "Search",
    "Favorite",
    "Settings",
    "Pangram of The Day",
  ];

  void _onItemSelected(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  BottomNavigationBar _buildBottomNavigationBar() {
    return BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favorite'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Pangram'),
          ),
        ],
        currentIndex: _selectedPageIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Theme.of(context).primaryColor,
        onTap: _onItemSelected,
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(titles[_selectedPageIndex]),
      ),
      body: _pages[_selectedPageIndex],
      drawer: HomeDrawer(callback: _onItemSelected),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}
