class AppException implements Exception {
  final String message;
  final String? prefix;

  AppException([this.message = 'Terjadi kesalahan', this.prefix]);

  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}