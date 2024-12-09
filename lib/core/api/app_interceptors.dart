import 'package:dio/dio.dart';
import 'package:tasky/config/local/cache_helper.dart';
import 'package:tasky/config/routes/app_routes.dart';
import 'package:tasky/core/api/end_points.dart';
import 'package:tasky/core/utils/app_constants.dart';


class AppInterceptors extends Interceptor {
  final Dio dio;

  AppInterceptors(
     this.dio,
  );

  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async{
    String? authToken = await CacheHelper.getData(key: 'access_token');
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $authToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    if(err.response?.statusCode==403){
      NavigationService.navigateTo(Routes.loginView);
    }
    if (err.response?.statusCode == 401 &&
        err.response!.realUri !=
            Uri.parse(EndPoints.baseUrl + EndPoints.login)) {
      String? accessToken = await CacheHelper.getData(key: 'access_token');
      String? refreshToken = await CacheHelper.getData(key: 'refresh_token');
      if (refreshToken != null && refreshToken.isNotEmpty) {
        dio.options.baseUrl = EndPoints.baseUrl;
        await dio.get(
          EndPoints.refreshToken,
          queryParameters: {
            "token": refreshToken,
          },
        ).then(
              (value) {
            String newToken = value.data["access_token"];
            CacheHelper.setData(
              key: "access_token",
              value: newToken,
            );
            AppConstants.accessToken=newToken;
          },
        ).catchError((e) {});
        accessToken = await CacheHelper.getData(key: 'access_token');
        err.requestOptions.headers['Authorization'] = 'Bearer $accessToken';
        return handler.resolve(await dio.fetch(err.requestOptions));
      }
    }
    super.onError(err, handler);
  }
}
