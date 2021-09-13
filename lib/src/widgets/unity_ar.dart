import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:get/get.dart';
import '../utils/colors.dart';

import '../screens/projects_screen.dart';

//ignore: must_be_immutable
class UnityWidgetSceneRouter extends StatefulWidget {
  final BuildContext context;

  UnityWidgetSceneRouter({required this.context});
  @override
  _UnityWidgetSceneRouterState createState() => _UnityWidgetSceneRouterState();
}

class _UnityWidgetSceneRouterState extends State<UnityWidgetSceneRouter> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  UnityWidgetController? _unityWidgetController;

  @override
  void initState() {
    super.initState();
  }

  unityAction(String type) async {
    if (_unityWidgetController != null) {
      var _uc = _unityWidgetController;

      if (_uc != null) {
        switch (type) {
          case 'pause':
            _uc.pause();
            break;

          case 'unload':
            _uc.unload();
            break;

          case 'recreate':
            var value = await _uc.isPaused();
            if (value != null && value) {
              _uc.create();
            }
            break;

          case 'resume':
            var value = await _uc.isPaused();

            if (value != null && value) {
              _uc.resume();
            }
            break;

          case 'create':
            _uc.create();
            break;

          case 'dispose':
            _uc.dispose();
            // super.dispose();
            break;

          case 'pause':
            _uc.pause();
            break;

          case 'unload':
            _uc.unload();
            break;

          case 'isPaused':
            var value = await _uc.isPaused();
            if (value != null) {
              return value;
            }
            break;

          case 'isReady':
            var value = await _uc.isReady();
            if (value != null) {
              return value;
            }
            break;
        }
      }

      return false;
    }
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) async {
    this._unityWidgetController = await controller;
    if (_unityWidgetController != null) {
      await unityAction('pause');
      await unityAction('resume');
    }
  }

  // Communication from Unity to Flutter
  void onUnityMessage(message) async {
    print('Received message from unity: ${message.toString()}');
  }

  // Communication from Unity to Flutter
  void onUnityUnloaded() async {
    print('UNITY UNLOAD');
    Get.offAll(() => ProjectsScreen());
  }

  void onUnitySceneLoaded(scene) {
    if (scene != null) {
      print('Received scene loaded from unity: ${scene.name}');
      print('Received scene loaded from unity buildIndex: ${scene.buildIndex}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            bodyAr(),
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () async {
                  await unityAction('pause');
                  await unityAction('dispose');
                  Get.offAll(() => ProjectsScreen());
                },
                child: Padding(
                  padding: EdgeInsets.only(
                      top: context.height * 0.02, left: context.width * 0.03),
                  child: Container(
                    width: context.width * 0.12,
                    height: context.width * 0.12,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: black.withOpacity(.6),
                    ),
                    child: SvgPicture.asset('assets/svg/arrow_back.svg'),
                  ),
                ),
              ),
            )
          ],
        ),
        // bottomNavigationBar: wLocationBottom(),
      ),
    );
  }

  Widget bodyAr() {
    try {
      return UnityWidget(
        onUnityCreated: onUnityCreated,
        onUnityMessage: onUnityMessage,
        // onUnityUnloaded: onUnityUnloaded,
        fullscreen: true,
        useAndroidView: false,
        onUnitySceneLoaded: onUnitySceneLoaded,
      );
    } catch (e) {
      return Container(
        child: Text(e.toString()),
      );
    }
  }
}
