import 'package:hive/hive.dart';

import '../models/blog_model.dart';

abstract interface class BlogLocalDataSource {
  void uploadLocalBlogs({
    required List<BlogModel> blogs,
  });

  List<BlogModel> loadBlogs();
}

class BlogLocalDataSourceImpl implements BlogLocalDataSource {
  final Box box;

  BlogLocalDataSourceImpl(this.box);
  @override
  List<BlogModel> loadBlogs() {
    List<BlogModel> blogs = [];
    box.read(
      () {
        for (int i = 0; i < box.length; i++) {
          final json = box.get(i.toString());
          blogs.add(BlogModel.fromJson(json));
        }
      },
    );

    return blogs;
  }

  @override
  void uploadLocalBlogs({required List<BlogModel> blogs}) {
    box.clear();
    box.write(
      () {
        for (int i = 0; i < blogs.length; i++) {
          box.put(i.toString(), blogs[i].toJson());
        }
      },
    );
  }
}
