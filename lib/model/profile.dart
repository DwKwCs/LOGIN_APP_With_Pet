import 'package:drift/drift.dart';

class Profile extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get context => text()();
  DateTimeColumn get date => dateTime()();
}