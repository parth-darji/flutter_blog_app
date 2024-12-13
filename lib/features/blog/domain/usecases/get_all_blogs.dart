import 'package:flutter_blog_app/core/error/failures.dart';
import 'package:flutter_blog_app/core/usecase/usecase.dart';
import 'package:flutter_blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter_blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) {
    return blogRepository.getAllBlogs();
  }
}
