import 'package:api_call_using_bloc/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  PostsBloc postsBloc = PostsBloc();

  @override
  void initState() {
    postsBloc.add(PostsInitialFetchEvent());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          postsBloc.add(PostDataEvent());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Posts", style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor: Colors.blue,
        elevation: 3,
        centerTitle: true,
      ),
      body: BlocConsumer<PostsBloc, PostsState>(
        bloc: postsBloc,
        listenWhen: (previous, current) => current is PostsActionState,
        buildWhen: (previous, current) => current is !PostsActionState,
        listener: (context, state) {
          if(state is PostUploadSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Post Uploaded successfully"))
            );
          }else if(state is PostUploadErrorState){
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Error"))
            );
          }
        },
        builder: (context, state) {
          switch(state.runtimeType){
            case PostFetchingState :
              final successState = state as PostFetchingState;
              return Container(
                child: ListView.builder(
                    itemCount: successState.posts.length,
                    itemBuilder: (context,index){
                      return Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(10),
                        color: Colors.grey.shade300,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(successState.posts[index].title.toString()),
                            Text(successState.posts[index].body.toString())

                          ],
                        ),
                      );
                    }),
              );
            case LoadingDataState :
              return const Center(
                child: CircularProgressIndicator(),
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
