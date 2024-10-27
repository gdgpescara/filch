extension $Double on double {
  String get toStringWholeNumber {
    if (truncate() == this) {
      return toStringAsFixed(0);
    }
    return toStringAsFixed(2);
  }
}
