
import '../models/upload_model.dart';
import 'dio_helper.dart';

class Repository {
  static final DioHelper _dioHelper = DioHelper();

  Future<uploadModel> uploadImage(Object requestBody) async {
    Map<String, dynamic> response = await _dioHelper.upload(
      url: 'https://api.escuelajs.co/api/v1/files/upload?',requestBody: requestBody
    );
    return uploadModel.fromJson(response);
  }


}
