import 'package:crossfit/strava/domain/model/model_authentication_response.dart';
import 'package:crossfit/strava/domain/model/model_authentication_scopes.dart';

abstract class RepositoryAuthentication {
  Future<TokenResponse> authenticate({
    required List<AuthenticationScope> scopes,
    required String redirectUrl,
    bool forceShowingApproval = false,
  });

  Future<void> deAuthorize();
}
