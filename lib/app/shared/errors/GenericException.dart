// ignore_for_file: file_names

class GenericException implements Exception {
  final String message;

  GenericException(this.message);

  @override
  String toString() {
    return message;
  }
}
