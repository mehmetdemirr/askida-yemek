enum PickImageItem {
  gallery,
  camera,
}

extension PickImageItems on PickImageItem {
  int str() {
    switch (this) {
      case PickImageItem.gallery:
        return 1;
      case PickImageItem.camera:
        return 2;
    }
  }
}
