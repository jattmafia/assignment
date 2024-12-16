import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @HiveType(typeId: 0, adapterName: 'UserAdapter') 
  factory User({
    @HiveField(0) String? email,
    @HiveField(1) String? password,
    @HiveField(2) String? firstName,
    @HiveField(3) String? lastName,
    @HiveField(4) String? dob,
    @HiveField(5) String? currentLocation,
    @HiveField(9) String? phoneNumber
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
