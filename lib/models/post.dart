class Like {
  final int likes;
  final List<String> username;
  Like({
    required this.likes,
    required this.username,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      likes: json['likes'],
      username: (json['username'] as List).map((e) => e as String).toList(),
    );
  }

// to convert model into map
  Map<String, dynamic> tojson() {
    return {
      'likes': likes,
      'username': username,
    };
  }
}

class Comment {
  final String userNames;
  final String userimage;
  final String usercomment;
  Comment({
    required this.userNames,
    required this.userimage,
    required this.usercomment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
        userNames: json['userNames'],
        userimage: json['userimage'],
        usercomment: json['usercomment']);
  }

  Map<String, dynamic> tojson() {
    return {
      'userNames': userNames,
      'userimage': userimage,
      'usercomment': usercomment,
    };
  }
}

class Post {
  final String postid;
  final String userid;
  final String detail;
  final String imageurl;
  final String imageId;
  final Like like;
  final List<Comment> comment;
  Post({
    required this.postid,
    required this.userid,
    required this.detail,
    required this.imageurl,
    required this.imageId,
    required this.like,
    required this.comment,
  });
}
