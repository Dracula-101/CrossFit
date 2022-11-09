import 'package:crossfit/strava/domain/model/model_upload.dart';
import 'package:crossfit/strava/domain/model/model_upload_request.dart';

abstract class RepositoryUpload {
  Future<UploadResponse> uploadActivity(UploadActivityRequest request);
  Future<UploadResponse> getUpload(int uploadId);
}
