import 'package:drift/drift.dart';

// @DataClassName('Transactions')
class Transactions extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(max : 128)();
  IntColumn get category_id => integer()(); // 1 = Income, 2 = Expense

  IntColumn get amount => integer()();
  DateTimeColumn get transaction_date => dateTime()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime().nullable()();
  DateTimeColumn get deletedAt => dateTime().nullable()();
}