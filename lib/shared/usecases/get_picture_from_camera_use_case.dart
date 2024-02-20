import 'package:image_picker/image_picker.dart';

class GetPictureFromCameraUseCase {
  Future<XFile?> call() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(source: ImageSource.camera);
    return photo;
  }
}
