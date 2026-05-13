import 'package:posts_app/features/home/data/post_model.dart';

abstract class PostsState {}

class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}

class PostsSuccess extends PostsState {
  final List<PostModel> posts;
  PostsSuccess(this.posts);
}

class PostsFailure extends PostsState {
  final String error;
  PostsFailure(this.error);
}