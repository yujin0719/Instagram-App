import 'package:flutter/material.dart';
import 'package:instagram_yujin/constant/size.dart';
import 'package:instagram_yujin/screens/camera_page.dart';
import 'package:instagram_yujin/screens/feed_page.dart';
import 'package:instagram_yujin/screens/profile_page.dart';
import 'package:instagram_yujin/screens/search_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FeedPage(),
    SearchPage(),
    Container(
      color: Colors.primaries[2],
    ),
    Container(
      color: Colors.primaries[3],
    ),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (size == null) {
      size = MediaQuery.of(context).size;
    }
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        // 하단바 아이콘 아래 label(글자)을 넣지 않겠다는 의미
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey[900],
        // 선택이 안된경우 아이콘의 색
        selectedItemColor: Colors.black,
        // 선택된 경우 아이콘의 색
        type: BottomNavigationBarType.fixed,
        // 아이콘이 선택되었을 때 변화 (옆으로 밀리거나.. 등등)
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        // 하단바의 배경 색
        items: [
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/home_selected.png",
              iconPath: "assets/home.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/search_selected.png",
              iconPath: "assets/search.png"),
          // 하단바 중앙에 있는 + 아이콘은 실제로 선택되면 다른화면으로 이동하기 때문에 Active를 나눌 필요가 없다.
          _buildBottomNavigationBarItem(iconPath: "assets/add.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/heart_selected.png",
              iconPath: "assets/heart.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/profile_selected.png",
              iconPath: "assets/profile.png"),
        ],
        currentIndex: _selectedIndex,
        // onTap은 눌러졌을때 인덱스가 들어오게 되는 것이다. (trigger)
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath}) {
    // activeIconPath는 선택되었을 때, iconPath는 선택되지 않았을 때
    return BottomNavigationBarItem(
      // activeIconPath가 있으면, ImageIcon에 AssetImage를 가져옴
      activeIcon:
          activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      // 그냥 아이콘은 (선택되지 않은 것을 넣어준다.)
      icon: ImageIcon(AssetImage(iconPath)),
      // title에 text는 무조건 들어가야한다. --> 공백을 넣어주고 위에 showSelectedLabels: false로 바꾸면 된다.
      title: Text(''),
    );
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      openCamera(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  openCamera(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage()),
    );
  }
}
