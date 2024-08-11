import 'package:hive/hive.dart';
part 'UserData.g.dart';
@HiveType(typeId: 0)
class UserData{
  @HiveField(0)
  String? date;
  @HiveField(1)
  double bmi;
  UserData({required this.date,required this.bmi});
}