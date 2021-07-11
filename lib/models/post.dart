class Post {
  int? postID;
  int? userID;
  String? postContent;
  String? postDate;
  int? likeCount;
  int? commentCount;

  Post(
      this.postID,
      this.userID,
      this.postContent,
      this.postDate,
      this.likeCount,
      this.commentCount
      );
}