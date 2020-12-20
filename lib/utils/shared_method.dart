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

Future deleteQR(String code, String userId) async {
  String fileName = 'berita/$userId/$code.png';

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  await ref.delete().then((value) => print('Deleted'));
}

Future<String> uploadImage(String code, String userId, File image) async {
  String fileName = 'berita/$userId/$code.png';

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task.whenComplete(() => ref.getDownloadURL());

  return await snapshot.ref.getDownloadURL();
}

Future deleteImage(String code, String userId) async {
  String fileName = 'berita/$userId/$code.png';

  FirebaseStorage.instance
      .ref()
      .child(fileName)
      .delete()
      .then((value) => print('Successfully deleted $fileName storage item'));
}

Future<File> getImage() async {
  final pickedFile = await imagePicker.getImage(
    source: ImageSource.gallery,
    imageQuality: 20,
  );
  fileImage = File(pickedFile.path);
  return fileImage;
}
