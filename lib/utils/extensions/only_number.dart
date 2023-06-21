extension OnlyNumber on String? {
  bool onlyNumber() {
    RegExp exp = RegExp(r"^[0-9]+$");
    bool value = exp.hasMatch(this ?? "");
    return value;
  }
}
