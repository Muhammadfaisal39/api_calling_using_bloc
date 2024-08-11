import 'dart:convert';
import 'dart:developer';

import 'package:api_call_using_bloc/features/posts/models/PostsDataModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostsUiDataModel>> fetchData() async {
    var client = http.Client();
    List<PostsUiDataModel> posts = [];
    try {
      var response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

      var result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostsUiDataModel post = PostsUiDataModel.fromJson(result[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      log(e.toString());
      return posts;
    }
  }

  static Future<bool> postData() async {
    var client = http.Client();
    try {
      var response = await client
          .post(Uri.parse('https://jsonplaceholder.typicode.com/posts'), body: {
        "title": "What is your name?",
        "body": "My Name is Muhammad Faisal",
        "id": "40"
      });
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
