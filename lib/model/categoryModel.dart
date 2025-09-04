class CategoryModel {
  String? collectionId;
  String? color;
  String? icon;
  String? id;
  String? thumbnail;
  String? title;

  CategoryModel(
    this.collectionId,
    this.color,
    this.icon,
    this.id,
    this.thumbnail,
    this.title,
  );

  factory CategoryModel.formMapJson(Map<String, dynamic> jsonObject) {
    return CategoryModel(
      jsonObject['collectionId'],
      jsonObject['color'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['icon']}',
      jsonObject['id'],
      'http://startflutter.ir/api/files/${jsonObject['collectionId']}/${jsonObject['id']}/${jsonObject['thumbnail']}', // گرفتن تامنیل از سرور
      jsonObject['title'],
    );
  }
}
