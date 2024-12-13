import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:flutter_blog_app/features/blog/domain/usecases/upload_blog.dart';

import '../../domain/entities/blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetAllBlogs _getAllBlogs;
  BlogBloc({
    required UploadBlog uploadBlog,
    required GetAllBlogs getAllBlogs,
  })  : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllBlogs>(_onFetchAllBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics,
      ),
    );

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogGetAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final res = await _getAllBlogs(NoParams());

    res.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogsDisplaySuccess(blogs)),
    );
  }
}
