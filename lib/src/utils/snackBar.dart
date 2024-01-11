import 'package:get/get.dart';
import 'package:quest/src/utils/getStorage.dart';

class ShowSnackbar {
  static wecome() {
    Get.snackbar(
      "Welcome!!",
      '${Storage.read(StorageKeys.username)}',
      overlayBlur: 1,
    );
  }
}
