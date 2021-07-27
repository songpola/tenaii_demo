class Post {
  Post({required this.data, required this.success});

  final List<PostData> data;
  final bool success;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        data:
            List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
        success: json["success"],
      );
}

class PostData {
  PostData({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.userId,
    required this.userName,
    required this.userImage,
    required this.rating,
    required this.price,
    required this.address,
    required this.distance,
    required this.userVerify,
    required this.createAt,
    required this.updatedAt,
  });

  final String id;
  final String title;
  final String imageUrl;
  final String userId;
  final String userName;
  final String userImage;
  final int rating;
  final int price;
  final PostDataAddress address;
  final String distance;
  final bool userVerify;
  final DateTime createAt;
  final DateTime updatedAt;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
        id: json["id"],
        title: json["title"],
        imageUrl: json["imageUrl"],
        userId: json["userID"],
        userName: json["userName"],
        userImage: json["userImage"],
        rating: json["rating"],
        price: json["price"],
        address: PostDataAddress.fromJson(json["address"]),
        distance: json["distance"],
        userVerify: json["userVerify"],
        createAt: DateTime.parse(json["createAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );
}

class PostDataAddress {
  PostDataAddress({required this.province, required this.district});

  final String province;
  final String district;

  factory PostDataAddress.fromJson(Map<String, dynamic> json) =>
      PostDataAddress(
        province: json["province"],
        district: json["district"],
      );
}
