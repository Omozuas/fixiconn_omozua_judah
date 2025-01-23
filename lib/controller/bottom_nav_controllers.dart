import 'package:get/get.dart';

class BottomNavControllers extends GetxController {
  RxInt bottomIndex = 0.obs;
  int get tabsIndex => bottomIndex.value;
  set setTabIndex(int newValue) {
    bottomIndex.value = newValue;
  }
}
