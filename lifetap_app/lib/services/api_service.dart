/// API service — deliberately EMPTY in Stage 5A.
///
/// Every screen in this stage uses `utils/mock_data.dart` instead, so
/// the UI and navigation can be built and demoed with zero backend
/// dependency. Stage 5B will fill these methods in using the `http`
/// package against AppConstants.apiBaseUrl, one method at a time:
///
///   5B — register(), login(), refreshToken()
///   5C — getMyProfile(), updateMyProfile()
///   5D — reportEmergency(), listMyCases(), getCase()
///   5E — (no new methods; reportEmergency() just receives real GPS)
///
/// Keeping this as a single class means every screen calls
/// `ApiService.instance.xxx()` and never talks to `http` directly —
/// so swapping mock data for real calls later doesn't touch the UI.
class ApiService {
  ApiService._();
  static final ApiService instance = ApiService._();

  // TODO (Stage 5B): implement using the `http` package, e.g.
  //
  // Future<Map<String, String>> login(String username, String password) async {
  //   final res = await http.post(
  //     Uri.parse('${AppConstants.apiBaseUrl}/auth/login/'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'username': username, 'password': password}),
  //   );
  //   ...
  // }
}
