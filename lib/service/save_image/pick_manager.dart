import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:askida_yemek/service/permission_handler.dart';
import 'package:askida_yemek/service/save_image/pick_image.dart';
import 'package:askida_yemek/utils/constants/pick_image_items.dart';
import 'package:askida_yemek/utils/functions/print_islem.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

abstract class IPickManager {
  final IPermissionCheck permissionCheck = PermissionCheck();
  final IPickImageCustom pickImageCustom = PickImageCustom();
  Future<XFile?> fetchMediaImage(PickImageItem pickImage);
  Future<void> saveImage(XFile? file, String id);
  Future<String?> getImageUrl(String id);
}

class PickManger extends IPickManager {
  @override
  Future<XFile?> fetchMediaImage(PickImageItem pickImage) async {
    //camera or gallery
    if (pickImage == PickImageItem.gallery) {
      //izin verildi mi kontrolü
      if (!(await permissionCheck.checkMediaLibrary())) {
        if (Platform.isAndroid) {
          DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
          AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
          if (androidInfo.version.sdkInt >= 33) {
            await Permission.photos.request();
            //print("photo android");
          } else {
            await Permission.storage.request();
            //print("storage android");
          }
        } else {
          await Permission.photos.request();
        }
        await Permission.storage.request();

        //Ayarlara git izin aç
        if (await Permission.storage.request().isPermanentlyDenied ||
            await Permission.photos.request().isPermanentlyDenied) {
          await AppSettings.openAppSettings();
        }

        return null;
      } else {
        return await pickImageCustom.pickImageGallery();
      }
    } else if (pickImage == PickImageItem.camera) {
      //izin verildi mi kontrolü
      if (!(await permissionCheck.checkCamera())) {
        await Permission.camera.request();

        //Ayarlara git izin aç
        if (await Permission.camera.request().isPermanentlyDenied) {
          await AppSettings.openAppSettings();
        }
        return null;
      } else {
        return await pickImageCustom.pickImageCamera();
      }
    }
    return null;
  }

  @override
  Future<void> saveImage(XFile? file, String id) async {
    // getting a directory path for saving
    final String dosyaYolu =
        "${(await getApplicationDocumentsDirectory()).path}/$id.jpg";
    printf(dosyaYolu);
    // copy the file to a new path
    if (file != null) {
      // ignore: unused_local_variable
      final File newImage = await File(file.path).copy(dosyaYolu);
    } else {
      //print("null geldi fotoğraf");
    }
  }

  @override
  Future<String?> getImageUrl(String id) async {
    final String path =
        "${(await getApplicationDocumentsDirectory()).path}/$id.jpg";
    return path;
  }
}
