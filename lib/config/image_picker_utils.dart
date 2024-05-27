import 'package:image_picker/image_picker.dart';

class ImagePickerUtils {
  final ImagePicker _imagePicker = ImagePicker();

  Future<XFile?> pickImage() async {
    final XFile? file =
        await _imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      return file;
    } else {
      return null;
    }
  }
}
