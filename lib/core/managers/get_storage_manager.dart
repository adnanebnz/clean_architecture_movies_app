import 'package:get_storage/get_storage.dart';

class GetStorageManager {
  static final GetStorage box = GetStorage();
  static GetStorage getStorage() {
    return box;
  }
}
