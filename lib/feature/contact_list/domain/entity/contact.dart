import 'package:contacts_app/feature/contact_list/data/repository/contact_repository_impl.dart';

class Contact {
  int? id;
  String? name;
  String? mobile;
  String? landline;
  String? photo;
  late bool isFavorite;

  Contact({
    this.id,
    this.name,
    this.mobile,
    this.landline,
    this.photo,
    required this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      ContactRepositoryImpl.columnName: name,
      ContactRepositoryImpl.columnMobile: mobile,
      ContactRepositoryImpl.columnLandline: landline,
      ContactRepositoryImpl.columnPhoto: photo,
      ContactRepositoryImpl.columnIsFavorite: isFavorite ? 1 : 0
    };
    if (id != null) {
      map[ContactRepositoryImpl.columnId] = id;
    }
    return map;
  }

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[ContactRepositoryImpl.columnId];
    name = map[ContactRepositoryImpl.columnName];
    mobile = map[ContactRepositoryImpl.columnMobile];
    landline = map[ContactRepositoryImpl.columnLandline];
    photo = map[ContactRepositoryImpl.columnPhoto];
    isFavorite = map[ContactRepositoryImpl.columnIsFavorite] == 1;
  }
}
