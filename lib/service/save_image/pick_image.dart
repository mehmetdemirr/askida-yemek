import 'package:image_picker/image_picker.dart';

abstract class IPickImageCustom {
  Future<XFile?> pickImageGallery();
  Future<XFile?> pickImageCamera();
}

class PickImageCustom implements IPickImageCustom {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<XFile?> pickImageGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  @override
  Future<XFile?> pickImageCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }
}
