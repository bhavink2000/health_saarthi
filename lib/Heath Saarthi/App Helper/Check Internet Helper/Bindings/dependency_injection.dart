import 'package:get/get.dart';
import '../Controller/network_controller.dart';

class CheckNetworkDependencyInjection {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}