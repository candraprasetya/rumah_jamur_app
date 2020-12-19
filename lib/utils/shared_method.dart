part of 'utils.dart';

Future<Uint8List> generateBarCode(String inputCode) async {
  Uint8List result = await scanner.generateBarCode(inputCode);
  return result;
}

Future<String> uploadQR(String code, String userId, Uint8List image) async {
  String fileName = 'qr/$userId/$code.png';

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putData(image);
  TaskSnapshot snapshot = await task.whenComplete(() => ref.getDownloadURL());

  return await snapshot.ref.getDownloadURL();
}
