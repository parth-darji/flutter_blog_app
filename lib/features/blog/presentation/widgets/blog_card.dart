import 'package:flutter/material.dart';
import 'package:flutter_blog_app/core/utils/calculate_reading_time.dart';

import '../../domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard(
    this.blog, {
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.all(16).copyWith(
        bottom: 4,
      ),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: blog.topics
                  .map(
                    (e) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Chip(
                        label: Text(e),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Text(
            blog.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          Text(
            "${calculateReadingTime(content: blog.content)} min",
            // calculateReadingTimeChatGPT(content: blog.content),
          ),
        ],
      ),
    );
  }
}
