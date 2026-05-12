import 'package:dio/dio.dart';
import 'package:posts_app/core/constants/api_endpoints.dart';
import 'package:posts_app/core/network/api_error.dart';
import 'package:posts_app/core/network/api_exceptions.dart';
import 'package:posts_app/core/network/api_service.dart';
import 'package:posts_app/core/utils/pref_helpers.dart';
import 'package:posts_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  ///Login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post(ApiEndpoints.login, {
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final statusCode = response['code'];
        final data = response['data'];

        if (statusCode != 200 && data == null) {
          throw ApiError(message: msg, statusCode: statusCode);
        }

        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: 'Something went wrong');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///Signup
  Future<UserModel?> signup(String name, String email, String password) async {
    try {
      final response = await apiService.post(ApiEndpoints.signup, {
        'name': name,
        'email': email,
        'password': password,
      });
      if (response is ApiError) {
        throw response;
      }
      if (response is Map<String, dynamic>) {
        final msg = response['message'];
        final errorMsg = response['errors'];
        final statusCode = response['code'];
        final coder = int.tryParse(statusCode);
        final data = response['data'];

        if (errorMsg != null) {
          throw ApiError(message: msg, statusCode: coder);
        }

        if (coder != 200 && coder != 201) {
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(data);
        if (user.token != null) {
          await PrefHelper.saveToken(user.token!);
        }

        return user;
      } else {
        throw ApiError(message: 'Something went wrong');
      }
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  ///Get Profile Data
  Future<UserModel?> getProfileData() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == 'Guest') {
        return null;
      }

      final response = await apiService.get(ApiEndpoints.profile);
      final user = UserModel.fromJson(response['data']);
      return user;
    } on DioError catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
