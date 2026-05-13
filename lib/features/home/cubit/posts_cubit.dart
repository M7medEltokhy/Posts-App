import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:posts_app/core/network/api_error.dart';
import 'package:posts_app/features/home/cubit/posts_state.dart';
import 'package:posts_app/features/home/data/posts_repo.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepo _repo;

  PostsCubit(this._repo) : super(PostsInitial());

  Future<void> getPosts() async {
    emit(PostsLoading());
    try {
      final posts = await _repo.getPosts();
      emit(PostsSuccess(posts));
    } catch (e) {
      String errorMsg = 'Unexpected error';
      if (e is ApiError) errorMsg = e.message;
      emit(PostsFailure(errorMsg));
    }
  }
}
