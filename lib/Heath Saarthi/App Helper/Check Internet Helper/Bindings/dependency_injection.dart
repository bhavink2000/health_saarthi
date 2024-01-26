import 'package:get/get.dart';
import '../Controller/network_controller.dart';

// class NetworkBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<NetworkController>(
//           () => NetworkController(),
//     );
//   }
// }
class CheckNetworkDependencyInjection {

  static void init() {
    Get.put<NetworkController>(NetworkController(),permanent: true);
  }
}