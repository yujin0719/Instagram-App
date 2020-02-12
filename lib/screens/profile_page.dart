import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_yujin/constant/size.dart';
import 'package:instagram_yujin/utils/profile_image_path.dart';
import 'package:instagram_yujin/widgets/profile_side_menu.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _menuOpened = false;
  double menuWidth;
  int duration = 200;
  AlignmentGeometry tabAlign = Alignment.centerLeft;
  bool _tabIconGridSelected = true;
  double _gridMargin = 0;
  double _myImgGridMargin = size.width;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: duration));
    super.initState();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    menuWidth = size.width / 1.5;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _sideMenu(),
          _profile(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            // button 누르면 toggle (T->F/F->T)
            _menuOpened = !_menuOpened;
          });
        },
      ),
    );
  }

  Widget _sideMenu() {
    return AnimatedContainer(
      width: menuWidth,
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(
        // 메뉴가 열리면 width에서 menuWith만큼 빼주고, 그렇지 않으면 그냥 width로 한다.
        // 이렇게 해놓으면 저절로 animate된다.
        _menuOpened ? size.width - menuWidth : size.width,
        0,
        0,
      ),
      child: SafeArea(
        child: SizedBox(
          width: menuWidth,
          child: ProfileSideMenu(),
        ),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.transparent,
      duration: Duration(milliseconds: duration),
      transform: Matrix4.translationValues(
        _menuOpened ? -menuWidth : 0,
        0,
        0,
      ),
      // safeArea 위젯은 정해진 영역안에 콘텐츠가 들어갈 수 있도록 함
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate([
                      _getProfileHeader,
                      _username(),
                      _userBio(),
                      _editProfileBtn(),
                      _getTabIconButtons,
                      _getAnimatedSelectedBar,
                    ]),
                  ),
                  _getImageGrid(context)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // sliver가 아닌 것을 sliver로 바꿔주는 것 -> SliverToBoxAdapter()
  SliverToBoxAdapter _getImageGrid(BuildContext context) => SliverToBoxAdapter(
          child: Stack(
        children: <Widget>[
          AnimatedContainer(
            transform: Matrix4.translationValues(_gridMargin, 0, 0),
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut,
            child: _imageGrid,
          ),
          AnimatedContainer(
            transform: Matrix4.translationValues(_myImgGridMargin, 0, 0),
            duration: Duration(milliseconds: duration),
            curve: Curves.easeInOut,
            child: _imageGrid,
          ),
        ],
      ));

  GridView get _imageGrid => GridView.count(
        // 스크롤 못하게 하는 것 => NeverScrollableScrollPhysics
        physics: NeverScrollableScrollPhysics(),
        //item이 있는 만큼만 높이를 설정 => shrinkWrap
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 1,
        children: List.generate(30, (index) => _gridImgItem(index)),
      );

  CachedNetworkImage _gridImgItem(int index) => CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl: "http://picsum.photos/id/$index/100/100",
      );

  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      child: SizedBox(
        height: 24,
        child: OutlineButton(
          onPressed: () {},
          borderSide: BorderSide(color: Colors.black45),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            'Edit Profile',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Padding _userBio() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        'Bio form User. So Say something.',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  Padding _username() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        'User Real Name',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  Row get _getProfileHeader => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(getProfileImgPath("thecodingpapa")),
            ),
          ),
          Expanded(
            child: Table(
              children: [
                TableRow(children: [
                  _getStatusValueWidget('123'),
                  _getStatusValueWidget('123'),
                  _getStatusValueWidget('123'),
                ]),
                TableRow(children: [
                  _getStatusLabelWidget('Post'),
                  _getStatusLabelWidget('Followers'),
                  _getStatusLabelWidget('Following'),
                ]),
              ],
            ),
          ),
        ],
      );

  Widget _getStatusValueWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          // text가 길어지면 다음줄로 넘어가게 되기 때문에 fittedbox로 넘어가지 않게 고정
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  Widget _getStatusLabelWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text(
            'thecodingPapa',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        )),
        IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: _animationController,
            semanticLabel: 'Show menu',
          ),
          onPressed: () {
            _menuOpened ? _animationController.reverse() : _animationController.forward();
            setState(() {
              // button 누르면 toggle (T->F/F->T)
              _menuOpened = !_menuOpened;
            });
          },
        )
      ],
    );
  }

  Widget get _getTabIconButtons => Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage("assets/grid.png"),
                color: _tabIconGridSelected ? Colors.black : Colors.black26,
              ),
              onPressed: () {
                // 왼쪽 버튼이 눌러지면 true를 준다 --> centerleft
                // false가 되면 centerright
                _setTab(true);
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage("assets/saved.png"),
                color: _tabIconGridSelected ? Colors.black26 : Colors.black,
              ),
              onPressed: () {
                _setTab(false);
              },
            ),
          ),
        ],
      );

  Widget get _getAnimatedSelectedBar => AnimatedContainer(
        alignment: tabAlign,
        duration: Duration(milliseconds: duration),
        curve: Curves.easeInOut,
        color: Colors.transparent,
        height: 1,
        width: size.width,
        child: Container(
          height: 1,
          width: size.width / 2,
          color: Colors.black87,
        ),
      );

  _setTab(bool tabLeft) {
    setState(() {
      if (tabLeft) {
        this.tabAlign = Alignment.centerLeft;
        this._tabIconGridSelected = true;
        this._gridMargin = 0;
        this._myImgGridMargin = size.width;
      } else {
        this.tabAlign = Alignment.centerRight;
        this._tabIconGridSelected = false;
        this._gridMargin = -size.width;
        this._myImgGridMargin = 0;
      }
    });
  }
}
