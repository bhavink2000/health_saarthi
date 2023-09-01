import 'package:get/get.dart';
import 'package:health_saarthi/Heath%20Saarthi/App%20Helper/Backend%20Helper/Network%20Check/network_manager.dart';


class DependencyInjection {
  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent:true);
  }
}