import 'package:posts_app/core/constants/api_endpoints.dart';
import 'package:posts_app/core/network/api_service.dart';
import 'package:posts_app/features/home/data/post_model.dart';

class PostsRepo {
  final ApiService _apiService = ApiService();

  // Future<List<PostModel>> getPosts() async {
  //   final data = await _apiService.get(ApiEndpoints.posts);
  //   return (data as List).map((e) => PostModel.fromJson(e)).toList();
  // }
  Future<List<PostModel>> getPosts() async {
  final data = await _apiService.get(ApiEndpoints.posts);
  final list = data['posts'] as List;
  return list.map((e) => PostModel.fromJson(e)).toList();
}
}