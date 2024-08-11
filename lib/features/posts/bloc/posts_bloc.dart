import 'dart:async';
import 'package:api_call_using_bloc/features/posts/models/PostsDataModel.dart';
import 'package:api_call_using_bloc/features/posts/repos/posts_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<PostsInitialFetchEvent>(postsInitialFetchEvent);
    on<PostDataEvent>(postDataEvent);
  }

  FutureOr<void> postsInitialFetchEvent(PostsInitialFetchEvent event, Emitter<PostsState> emit) async{

    emit(LoadingDataState());
    List<PostsUiDataModel> posts = await PostsRepo.fetchData();
    emit(PostFetchingState(posts: posts));

  }

  FutureOr<void> postDataEvent(PostDataEvent event, Emitter<PostsState> emit) async{
    bool isUploaded = await PostsRepo.postData();
    if(isUploaded){
      print(isUploaded);
      emit(PostUploadSuccessState());
    }else{
      print(isUploaded);
      emit(PostUploadErrorState());
    }
  }
}
