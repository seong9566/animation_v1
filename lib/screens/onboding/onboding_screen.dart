import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_btn.dart';
import 'components/custom_sign_in_dialog.dart';

class OnBodingScreen extends StatefulWidget {
  const OnBodingScreen({super.key});

  @override
  State<OnBodingScreen> createState() => _OnBodingScreenState();
}

class _OnBodingScreenState extends State<OnBodingScreen> {
  late RiveAnimationController _btnAnimationController;
  bool isSignInDialogShown = false;
  @override
  void initState() {
    _btnAnimationController = OneShotAnimation(
      "active",
      autoplay: false, // 시작시 자동으로 실행되지 않도록 해줌.
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset("assets/Backgrounds/Spline.png"),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
              child: const SizedBox(),
            ),
          ),
          const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),

          // BackdropFilter가 가장 하위에 있어야하는 이유 ?
          // BackdropFilter는 하위 위젯에 필터를 씌움.
          // Pstitioned.fill은 부모 위젯을 가득 차도록 해줌, 즉 SizedBox에 필터가 씌워지고 fill로 인해 부모위젯을 모두 감싸기 때문.
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
            ),
          ),

          //Dialog가 열릴때 화면이 조금 위로 이동
          AnimatedPositioned(
            top: isSignInDialogShown ? -50 : 0,
            duration: const Duration(milliseconds: 260),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  const SizedBox(
                    width: 260, // 3 줄로 변경
                    child: Column(
                      children: [
                        Text(
                          "Learn design & code",
                          style: TextStyle(
                            fontSize: 60,
                            fontFamily: "Poppins",
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                            "Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools."),
                      ],
                    ),
                  ),
                  const Spacer(flex: 2),
                  AnimatedBtn(
                    btnAnimationController: _btnAnimationController,
                    press: () {
                      _btnAnimationController.isActive = true;
                      //_,__는 사용하지 않는다는 매개변수
                      Future.delayed(
                        //showDialog실행 시 배경화면 움직이는 속도
                        const Duration(milliseconds: 100),
                        () {
                          setState(() {
                            isSignInDialogShown = true;
                          });
                        },
                      );
                      customSigninDialog(context, onClosed: (_) {
                        setState(() {
                          isSignInDialogShown = false;
                        });
                      });
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child:
                        Text("Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates."),
                  ),
                ],
              ),
            )),
          )
        ],
      ),
    );
  }
}
