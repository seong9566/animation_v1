import 'package:animation_v1/constants.dart';
import 'package:animation_v1/screens/home/home_screen.dart';
import 'package:animation_v1/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_bar.dart';
import 'model/rive_asset.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAsset selectedBottomNav = bottomNavItems.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 키보드가 화면을 겹치게 함
      resizeToAvoidBottomInset: false,
      //body영역을 바닥까지 보이게 해줌.
      extendBody: true,
      body: const HomeScreen(),
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
