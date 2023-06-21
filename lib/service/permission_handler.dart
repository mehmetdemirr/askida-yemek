import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

abstract class IPermissionCheck {
  Future<bool> checkMediaLibrary();
  Future<bool> checkCamera();
  Future<bool> checkNotification();
}

class PermissionCheck implements IPermissionCheck {
  @override
  Future<bool> checkMediaLibrary() async {
    PermissionStatus status;
    if (Platform.isAndroid) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.photos.request();
    }

    return status.isGranted;
  }

  @override
  Future<bool> checkCamera() async {
    var status = await Permission.camera.status;
    return status.isGranted;
  }

  @override
  Future<bool> checkNotification() async {
    var status = await Permission.camera.status;
    return status.isGranted;
  }
}
