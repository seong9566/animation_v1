import 'package:animation_v1/components/side_menu_tile.dart';
import 'package:animation_v1/model/rive_asset.dart';
import 'package:animation_v1/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sidebarMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const InfoCard(
                name: "HyeonSeongLee",
                profession: "Mobile Developer",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "Browse".toUpperCase(), // 대문자
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveOnInIt: (artboard) {
                    // 1. controller
                    StateMachineController controller = RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: menu.stateMachineName,
                    );
                    // 2. active 넘겨주기
                    menu.input = controller.findSMI("active") as SMIBool;
                  },
                  press: () {
                    // 3. Animate 활성화
                    menu.input!.change(true);
                    // 4. 일정 시간 이후 Animate 비활성화
                    Future.delayed(const Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                    // 5. 선택 메뉴 넘겨주기.
                    setState(() {
                      selectedMenu = menu;
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "History".toUpperCase(), // 대문자
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2.map(
                (menu2) => SideMenuTile(
                  menu: menu2,
                  press: () {
                    menu2.input!.change(true);
                    Future.delayed(const Duration(microseconds: 300), () {
                      menu2.input!.change(false);
                    });
                    setState(() {
                      selectedMenu = menu2;
                    });
                  },
                  riveOnInIt: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(
                      artboard,
                      stateMachineName: menu2.stateMachineName,
                    );
                    menu2.input = controller.findSMI("active") as SMIBool;
                  },
                  isActive: selectedMenu == menu2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
