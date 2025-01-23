import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:plain_registry_app/data/local_database/models/registry/registry_db_model.dart';
import 'package:sqflite/sqflite.dart';

class AppLocalDb {
  AppLocalDb._privateConstructor();

  static final AppLocalDb _instance = AppLocalDb._privateConstructor();

  late final Database localDatabase;

  static AppLocalDb get instance => _instance;

  Future<void> loadDataBase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, 'registry_app.db');

      localDatabase = await openDatabase(path,
        onOpen: (db) async {
          debugPrint(RegistryDbModel.dropTableCommand);
          await db.execute(RegistryDbModel.dropTableCommand);
          debugPrint(RegistryDbModel.createTableCommand);
          await db.execute(RegistryDbModel.createTableCommand);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
