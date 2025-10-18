enum FileUnitOfMeasure {
  byte(1),
  kilobyte(1024),
  megabyte(1024 * 1024),
  gigabyte(1024 * 1024 * 1024);

  const FileUnitOfMeasure(this.unit);

  final int unit;

  double convert(int bytes) => bytes / unit;
}
