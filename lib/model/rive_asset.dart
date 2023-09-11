import 'package:rive/rive.dart';

class RiveAsset {
  final String title, artboard, stateMachineName, src;
//  final RiveModel rive;
  late SMIBool? input;

  RiveAsset(
    this.src, {
    required this.title,
    required this.stateMachineName,
    required this.artboard,
    this.input,
  });
  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavItems = [
  RiveAsset(
    "assets/RiveAssets/icons.riv",
    title: "Chat",
    stateMachineName: "CHAT_Interactivity",
    artboard: "CHAT",
  ),
  RiveAsset(
    title: "Search",
    "assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
  ),
  RiveAsset(
    title: "Timer",
    "assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
  ),
  RiveAsset(
    title: "Notification",
    "assets/RiveAssets/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
  ),
  RiveAsset(
    title: "Profile",
    "assets/RiveAssets/icons.riv",
    artboard: "USER",
    stateMachineName: "USER_Interactivity",
  ),
];

List<RiveAsset> sidebarMenus = [
  RiveAsset(
    title: "Home",
    "assets/RiveAssets/icons.riv",
    artboard: "HOME",
    stateMachineName: "HOME_interactivity",
  ),
  RiveAsset(
    title: "Search",
    "assets/RiveAssets/icons.riv",
    artboard: "SEARCH",
    stateMachineName: "SEARCH_Interactivity",
  ),
  RiveAsset(
    title: "Favorites",
    "assets/RiveAssets/icons.riv",
    artboard: "LIKE/STAR",
    stateMachineName: "STAR_Interactivity",
  ),
  RiveAsset(title: "Help", "assets/RiveAssets/icons.riv", artboard: "CHAT", stateMachineName: "CHAT_Interactivity"),
];

List<RiveAsset> sidebarMenus2 = [
  RiveAsset(
    title: "History",
    "assets/RiveAssets/icons.riv",
    artboard: "TIMER",
    stateMachineName: "TIMER_Interactivity",
  ),
  RiveAsset(
    title: "Notifications",
    "assets/RiveAssets/icons.riv",
    artboard: "BELL",
    stateMachineName: "BELL_Interactivity",
  ),
];
