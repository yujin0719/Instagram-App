import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_yujin/constant/size.dart';
import 'package:instagram_yujin/utils/profile_image_path.dart';
import 'package:instagram_yujin/widgets/comment.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: null,
            icon: ImageIcon(
              AssetImage('assets/actionbar_camera.png'),
              color: Colors.black,
            )),
        title: Image.asset(
          'assets/insta_text_logo.png',
          height: 26,
        ),
        actions: <Widget>[
          //Iconbutton을 사용해서 icon을 선택할 수 있도록 만든다.
          IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/actionbar_camera.png'),
                color: Colors.black,
              )),
          IconButton(
              onPressed: null,
              icon: ImageIcon(
                AssetImage('assets/direct_message.png'),
                color: Colors.black,
              )),
        ],
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return _postItem(index, context);
          }),
    );
  }

  Column _postItem(int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader('username $index'),
        _postImage(index),
        _postActions(),
        _postLikes(),
        _postCaption(context, index),
        //누를수 있도록 만들기 위해 GestureDetector 를 사용해도 된다.
        _allComments(),
      ],
    );
  }

  FlatButton _allComments() => FlatButton(
      onPressed: null,
      child: Text(
        'show all 18 comments',
        style: TextStyle(color: Colors.grey[600]),
      ));

  Padding _postCaption(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xs_gap),
      child: Comment(
        username: 'username $index',
        caption: 'I love summer sooooooooooooooo much ~~~~~~~~~~ !!!!!!',
      ),
      // 이걸로도 실행해보기!
      // child: Comment( dateTime: DateTime.now(), showProfile: true, username: 'username $index', caption: 'I love summer sooooooooooooooo much ~~~~~~~~~~ !!!!!!',),
    );
  }

  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text('80 likes', style: TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/heart_selected.png'),
            color: Colors.redAccent,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/comment.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/direct_message.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
        // 사이 공간(디엠과 북마크)을 넣어주기 위해 => spacer
        Spacer(),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/bookmark.png'),
            color: Colors.black87,
          ),
          onPressed: null,
        ),
      ],
    );
  }

  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
            backgroundImage:
                CachedNetworkImageProvider(getProfileImgPath(username)),
            radius: profile_radius,
          ),
        ),
        // text 즉, username의 길이가 얼마나 될지 알지 못하기 때문에 padding보다 expanded를 넣는것이 더 좋다.
        Expanded(child: Text(username)),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.black87,
          ),
          onPressed: null,
        )
      ],
    );
  }

  CachedNetworkImage _postImage(int index) {
    return CachedNetworkImage(
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      placeholder: (context, url) {
        return Container(
          width: size.width,
          height: size.width,
          child: Center(
            child: SizedBox(
              width: 30,
              height: 30,
              child: Image.asset('assets/loading_img.gif'),
            ),
          ),
        );
      },
      imageBuilder: (BuildContext context, ImageProvider imageProvider) =>
          AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: imageProvider,
                  // fit은 어떤식으로 이미지 공간을 채울지
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
