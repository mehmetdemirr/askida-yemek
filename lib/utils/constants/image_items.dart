enum ImageItem {
  ilac,
  medicalPattern,
  logo,
  medicineAdd,
  pillReminder,
}

const String a = "assets/images";

extension ImageItems on ImageItem {
  String str() {
    switch (this) {
      case ImageItem.ilac:
        return "$a/ilac.png";
      case ImageItem.medicalPattern:
        return "$a/medical_pattern.png";
      case ImageItem.logo:
        return "$a/logo.png";
      case ImageItem.medicineAdd:
        return "$a/medicine_add.png";
      case ImageItem.pillReminder:
        return "$a/pill_reminder.png";
    }
  }
}
