import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.9,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/Images/background_image_2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            AnimatedLoginButton(),
          ],
        ),
      ),
    );
  }
}

class AnimatedLoginButton extends StatefulWidget {
  const AnimatedLoginButton({Key? key}) : super(key: key);

  @override
  _AnimatedLoginButtonState createState() => _AnimatedLoginButtonState();
}

class _AnimatedLoginButtonState extends State<AnimatedLoginButton> {
  bool _progressBarVisibility = false;
  bool _textVisibility = true;
  bool _successTextVisibility = false;
  late double _maxWidth;
  late double _maxHeight;
  double _width = 300;
  double _height = 60;
  double _opacity = 0;
  late BorderRadiusGeometry _borderRadius;
  final Color _color = Colors.deepOrangeAccent;

  @override
  void initState() {
    super.initState();
    _borderRadius = BorderRadius.circular(30);
  }

  Future<void> _manageTextVisibility() async {
    await Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        if (_width == 60) {
          _textVisibility = false;
        }
      });
    });
  }

  Future<void> _manageProgressBarVisibility() async {
    await Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = true;
        } else {
          _progressBarVisibility = false;
        }
      });
    });
  }

  Future<void> _manageContainerExpansion() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        if (_width == 60) {
          _progressBarVisibility = false;
          _borderRadius = BorderRadius.circular(0);
          _width = _maxWidth;
          _height = _maxHeight;
        }
      });
    });
  }

  Future<void> _manageSuccessTextVisibility() async {
    await Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _successTextVisibility = true;
      });
    });
  }

  Future<void> _manageSuccessTextOpacity() async {
    await Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _opacity = 1;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _maxWidth = MediaQuery.of(context).size.width;
    _maxHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            alignment: Alignment.center,
            child: Image.asset('assets/Images/flutter logo1.png'),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.account_circle_outlined,
                  color: Colors.white,
                ),
                hintText: 'Username',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextFormField(
              style: TextStyle(
                color: Colors.white,
              ),
              obscureText: true,
              cursorColor: Colors.white,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  color: Colors.white,
                ),
                hintText: 'Password',
                hintStyle: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              if (_width == 100) {
                _width = 40;
              }
              _manageTextVisibility();
              _manageProgressBarVisibility();
              _manageContainerExpansion();
              _manageSuccessTextVisibility();
              _manageSuccessTextOpacity();
            });
          },
          child: AnimatedContainer(
            width: _width,
            height: _height,
            decoration: BoxDecoration(
              color: _color,
              borderRadius: _borderRadius,
            ),
            duration: const Duration(milliseconds: 1000),
            child: Center(
              child: Stack(
                children: [
                  Visibility(
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    visible: _textVisibility,
                  ),
                  Visibility(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      strokeWidth: 1,
                    ),
                    visible: _progressBarVisibility,
                  ),
                  Visibility(
                    child: AnimatedOpacity(
                      opacity: _opacity,
                      duration: const Duration(seconds: 3),
                      child: Text(
                        'Login Successful',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    visible: _successTextVisibility,
                  ),
                ],
              ),
            ),
          ),
        ),
        Spacer(),
        Text(
          "Don't have an account? Sign Up"
        ),
        Spacer(),
      ],
    );
  }
}
