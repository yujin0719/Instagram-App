import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:instagram_yujin/constant/size.dart';
import 'package:instagram_yujin/utils/simple_snack_bar.dart';
import '../constant/size.dart';
import '../main_page.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwConstroller = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _pwConstroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Spacer(
                flex: 6,
              ),
              Image.asset("assets/insta_text_logo.png"),
              Spacer(
                flex: 1,
              ),
              TextFormField(
                controller: _emailController,
                decoration: getTextFieldDecor('Email'),
                validator: (String value) {
                  // 이메일이 비어있거나 @를 포항하지 않으면 --> 이메일의 형식이 잘못되었다면,
                  if (value.isEmpty || !value.contains('@')) {
                    return 'Please Enter Your Email Address!';
                  }
                  // null이 되면 이메일 형식이 올바르게 된 상황
                  return null;
                },
              ),
              Spacer(
                flex: 1,
              ),
              TextFormField(
                  controller: _pwConstroller,
                  decoration: getTextFieldDecor('Password'),
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'Please Enter any Password!';
                    }
                    return null;
                  }),
              Spacer(
                flex: 1,
              ),
              Text(
                "Forgotten Password?",
                textAlign: TextAlign.end,
                style: TextStyle(
                    color: Colors.blue[700], fontWeight: FontWeight.w600),
              ),
              Spacer(
                flex: 2,
              ),
              FlatButton(
                onPressed: () {
                  if (_formKey.currentState.validate()) {
                    final route = MaterialPageRoute(builder: (context) => MainPage());
                    Navigator.pushReplacement(context, route);
                  }
                },
                child: Text(
                  'Log In',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                disabledColor: Colors.blue[100],
              ),
              Spacer(
                flex: 2,
              ),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    height: 1,
                    child: Container(color: Colors.grey[300], height: 1),
                  ),
                  Container(
                    height: 3,
                    width: 50,
                    color: Colors.grey[50],
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              Spacer(
                flex: 2,
              ),
              FlatButton.icon(
                  textColor: Colors.blue,
                  onPressed: () {
                    simpleSnackbar(context,'facebook pressed');
                  },
                  icon: ImageIcon(AssetImage("assets/icon/facebook.png")),
                  label: Text("Login with Facebook")),
              Spacer(
                flex: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300], width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        // 클릭하면 focus 된다.
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[300], width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        fillColor: Colors.grey[100],
        filled: true);
  }
}
