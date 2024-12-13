import 'dart:io';

import 'package:flutter_blog_app/core/error/exceptions.dart';
import 'package:flutter_blog_app/core/error/failures.dart';
import 'package:flutter_blog_app/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:flutter_blog_app/features/blog/data/models/blog_model.dart';

import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';

import '../../domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: "",
        topics: topics,
        updatedAt: DateTime.now(),
      );

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
        image: image,
        blog: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);

      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> getAllBlogs() async {
    try {
      final blogs = await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
