class HttpsExcption implements Exception{
 final String messge;
 const HttpsExcption({required this.messge});

  @override
  String toString() {
  return messge;
  }
}