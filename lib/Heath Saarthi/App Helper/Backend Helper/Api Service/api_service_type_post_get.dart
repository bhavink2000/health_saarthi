
abstract class ApiServicesTypePostGet{

  Future<dynamic> postApiResponse(String url, dynamic data);

  Future<dynamic> getApiResponse(String url);

  Future<dynamic> afterpostApiResponse(String url, String accessToken ,dynamic data);

  Future<dynamic> aftergetApiResponse(String url, String accessToken);

}