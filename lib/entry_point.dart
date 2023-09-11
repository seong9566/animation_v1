import 'package:animation_v1/components/side_menu.dart';
import 'package:animation_v1/constants.dart';
import 'package:animation_v1/screens/home/home_screen.dart';
import 'package:animation_v1/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_bar.dart';
import 'components/menu_btn.dart';
import 'model/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottomNavItems.first;
  late SMIBool isSideBarClosed;
  bool isSideMenuClosed = true;

  // 화면을 부드럽게 이동 시켜주기 위한 애니메이션 Controller
  late AnimationController _animationController;
  //trans를 위한 animation
  late Animation<double> animation;
  //scale를 위한 animation
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });
    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.fastOutSlowIn),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      // 키보드가 화면을 겹치게 함
      resizeToAvoidBottomInset: false,
      //body영역을 바닥까지 보이게 해줌.
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            //curve는 애니메이션의 속도를 제어한다, fastOutSlowIn는 시작할 때 빠르게 가속하고, 중간에 천천히 감속
            curve: Curves.fastOutSlowIn,
            width: 288,
            //isSideMenuClosed가 true이면 그대로, 만약 클릭되었다면 -288.
            left: isSideMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideMenu(),
          ),
          // Transform.translate는 자식 위젯을 이동시키며. isSideMenuClosed가 클릭되지 않았다면 0 , 클릭 되었다면 가로 288만큼 이동시킨다.
          Transform.translate(
            offset: Offset(animation.value * 288, 0),
            //scale는 자식 위젯의 크기를 조정한다. 주로 동적으로 변하는 화면에 사용할 수 있다.
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: const ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: HomeScreen()),
            ),
          ),
          MenuBtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: "State Machine");
              isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              if (isSideMenuClosed) {
                _animationController.forward();
              } else {
                _animationController.reverse();
              }
              setState(() {
                isSideMenuClosed = isSideBarClosed.value;
              });
            },
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12), // 안쪽의 여백
          margin: const EdgeInsets.symmetric(horizontal: 24), // 바깥쪽으로 밀어내는 여백
          decoration: BoxDecoration(color: backgroundColor2.withOpacity(0.8), borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavItems.length,
                (index) => GestureDetector(
                  onTap: () {
                    // 계속 움직임
                    bottomNavItems[index].input!.change(true);
                    if (bottomNavItems[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = bottomNavItems[index];
                      });
                    }
                    // 1초 이후 input을 false로 바꿈으로써 1초만 움직이게 됌.
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomNavItems[index].input!.change(false);
                    });
                  },
                  child: Column(
                    //크기를 자식의 크기만큼 조정
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(isActive: bottomNavItems[index] == selectedBottomNav),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Opacity(
                          opacity: bottomNavItems[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            //src는 모두 동일하고, 나머지가 다름.
                            bottomNavItems.first.src,
                            artboard: bottomNavItems[index].artboard,
                            //onInit가 있어야 Rive의 애니메이션이 동작함.
                            onInit: (artboard) {
                              StateMachineController controller = RiveUtils.getRiveController(
                                artboard,
                                stateMachineName: bottomNavItems[index].stateMachineName,
                              );
                              //sctive는 Rive를 만든사람이 지은 변수 명. 홈페이지에서 다운받은 RiveAsset를 확인 해야함.
                              //active가 없으면 움직이지 않음.
                              bottomNavItems[index].input = controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
