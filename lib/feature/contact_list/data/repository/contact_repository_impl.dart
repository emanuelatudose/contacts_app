import 'package:contacts_app/feature/contact_list/domain/entity/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class ContactRepositoryImpl {
  static const String tableContacts = "contacts";
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnMobile = "mobile";
  static const String columnLandline = "landline";
  static const String columnPhoto = "photo";
  static const String columnIsFavorite = "isFavorite";

  static final ContactRepositoryImpl instance =
      ContactRepositoryImpl.internal();
  factory ContactRepositoryImpl() => instance;
  ContactRepositoryImpl.internal();
  Database? _db;

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await createDatabase();
      return _db;
    }
  }

  Future<Database> createDatabase() async {
    final String databasesPath = await getDatabasesPath();

    final path = join(databasesPath, 'contacts_database.db');
    return await openDatabase(path, version: 1,
        onCreate: (db, newerVersion) async {
      await db.execute(
        'CREATE TABLE $tableContacts('
        '$columnId INTEGER PRIMARY KEY,'
        '$columnName TEXT,'
        '$columnMobile TEXT,'
        '$columnLandline TEXT,'
        '$columnPhoto TEXT,'
        '$columnIsFavorite INTEGER'
        ')',
      );
    });
  }

  Future<Contact> insertContact(Contact contact) async {
    final dbRef = await db;
    contact.id = await dbRef!.insert(
      tableContacts,
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return contact;
  }

  Future<int> updateContact(Contact contact) async {
    final dbRef = await db;

    return await dbRef!.update(
      tableContacts,
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
    );
  }

  Future<int> deleteContact(int id) async {
    final dbRef = await db;

    return await dbRef!.delete(
      tableContacts,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Contact>> getContacts() async {
    final dbRef = await db;

    var contacts = await dbRef!.query(tableContacts, columns: [
      columnId,
      columnName,
      columnMobile,
      columnLandline,
      columnPhoto,
      columnIsFavorite
    ]);

    List<Contact> contactList = [];

    for (var currentContact in contacts) {
      Contact contact = Contact.fromMap(currentContact);
      contactList.add(contact);
    }
    return contactList;
  }

  Future<List<Contact>> getFavoriteContacts() async {
    final dbRef = await db;

    var contacts = await dbRef!.query(tableContacts,
        columns: [
          columnId,
          columnName,
          columnMobile,
          columnLandline,
          columnPhoto,
          columnIsFavorite
        ],
        where: 'isFavorite = ?',
        whereArgs: [1]);

    List<Contact> favoriteList = [];

    for (var currentContact in contacts) {
      Contact contact = Contact.fromMap(currentContact);
      favoriteList.add(contact);
    }
    return favoriteList;
  }

  Future close() async {
    var dbRef = await db;
    dbRef!.close();
  }
}
