import 'package:get/get.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  //

  @override
  void onInit() {
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false);
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //
    super.onClose();
  }
  //
} // HomeController Ends here
