part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

sealed class PostsActionState extends PostsState{}

final class PostsInitial extends PostsState {}

class PostFetchingState extends PostsState{
  final List<PostsUiDataModel> posts;

  PostFetchingState({required this.posts});

}

class LoadingDataState extends PostsState{}

class LoadingErrorState extends PostsActionState{}

class PostUploadSuccessState extends PostsActionState{}

class PostUploadErrorState extends PostsActionState{}
