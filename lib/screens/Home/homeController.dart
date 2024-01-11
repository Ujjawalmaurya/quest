import 'package:get/get.dart';
import 'package:quest/src/utils/getStorage.dart';
import 'package:quest/src/utils/snackBar.dart';

class HomeController extends GetxController {
  RxBool isLoading = true.obs;
  //

  @override
  void onInit() {
    //Fake DB
    Future.delayed(const Duration(seconds: 1), () => isLoading.value = false).then(
      (value) => ShowSnackbar.wecome(),
    );
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
} // 
