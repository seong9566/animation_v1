import 'package:animation_v1/constants.dart';
import 'package:animation_v1/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'components/animated_bar.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAsset selectedBottomNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12), // 안쪽의 여백
          margin: const EdgeInsets.symmetric(horizontal: 24), // 바깥쪽으로 밀어내는 여백
          decoration: BoxDecoration(color: backgroundColor2.withOpacity(0.8), borderRadius: const BorderRadius.all(Radius.circular(24))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    // 계속 움직임
                    bottomNavs[index].input!.change(true);
                    if (bottomNavs[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = bottomNavs[index];
                      });
                    }
                    // 1초 이후 input을 false로 바꿈으로써 1초만 움직이게 됌.
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    //크기를 자식의 크기만큼 조정
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(isActive: bottomNavs[index] == selectedBottomNav),
                      SizedBox(
                        width: 36,
                        height: 36,
                        child: Opacity(
                          opacity: bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            //src는 모두 동일하고, 나머지가 다름.
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            //onInit가 있어야 Rive의 애니메이션이 동작함.
                            onInit: (artboard) {
                              StateMachineController controller = RiveUtils.getRiveController(
                                artboard,
                                stateMachineName: bottomNavs[index].stateMachineName,
                              );
                              //sctive는 Rive를 만든사람이 지은 변수 명. 홈페이지에서 다운받은 RiveAsset를 확인 해야함.
                              //active가 없으면 움직이지 않음.
                              bottomNavs[index].input = controller.findSMI("active") as SMIBool;
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

class RiveAsset {
  final String artboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.artboard,
    required this.stateMachineName,
    required this.title,
    this.input,
  });

  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "CHAT",
    stateMachineName: "CHAT_Interactivity",
    title: "Chat",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
    title: "Search",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
    title: "Timer",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
    title: "Notifications",
  ),
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
    title: "Profile",
  ),
];
