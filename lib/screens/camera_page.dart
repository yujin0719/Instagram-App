import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  int _selectedIntex = 1;

  // pageController는 body의 pageViewWidget를 controll하는 controller이다.
  var _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'photo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        // onPageChanged는 page가 바뀌었을때 해주는 action
        onPageChanged: (index) {
          setState(() {
            _selectedIntex = index;
          });
        },
        children: <Widget>[_galleryPage(), _takePhotoPage(), _takeVideoPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        // BottomNavigationBar는 icon이 반드시 포함되어야 하는데 이를 숨기기 위해서 iconSize를 0으로 한다.
        iconSize: 0,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              // icon을 보여주지 않을 것이기 떄문에 그냥 아무 아이콘이나 넣어도 된다.
              icon: ImageIcon(AssetImage("assets/grid.png")),
              title: Text('GALLERY')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/grid.png")),
              title: Text('PHOTO')),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage("assets/grid.png")),
              title: Text('VIDEO')),
        ],
        currentIndex: _selectedIntex,
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  void _onItemTapped(BuildContext context, int index) {
    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  Widget _galleryPage() {
    return Container(
      color: Colors.green,
    );
  }

  Widget _takePhotoPage() {
    return Container(
      color: Colors.purple,
    );
  }

  Widget _takeVideoPage() {
    return Container(
      color: Colors.deepOrange,
    );
  }
}
