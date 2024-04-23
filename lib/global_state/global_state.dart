import 'package:get/get.dart';

class GlobalState extends GetxController {
  var isLoading = false.obs;
  var isError = false.obs;

  // state handling functions
  void showLoading() => isLoading.value = true;
  void hideLoading() => isLoading.value = false;
  void showError() => isError.value = true;
  void hideError() => isError.value = false;
}
