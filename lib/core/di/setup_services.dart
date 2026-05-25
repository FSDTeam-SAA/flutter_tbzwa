import 'package:get/get.dart';
import '../services/session_service.dart';
import '../services/socket_service.dart';
import '../services/offline_task_queue_service.dart';
import '../services/offline_sync_manager.dart';
import '../services/webrtc_service.dart';
import '../services/smart_media_service.dart';

Future<void> setupServices() async {
  Get.put(SessionService());
  await Get.putAsync(() => OfflineTaskQueueService().init());
  await Get.putAsync(() => OfflineSyncManager().init());
  Get.lazyPut(() => WebRTCService());

}
