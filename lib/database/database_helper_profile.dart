import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/profile_model.dart';

class DatabaseHelperProfile {
  
  static final nombreBD = "USUARIOBD";
  static final versionBD = 1;

  static Database? _database;
  

  Future<Database> get database async {
    if (_database != null) return _database!;
    return _database = await _initDatabase();
  }

  _initDatabase() async {
    
    Directory carpeta = await getApplicationDocumentsDirectory();
    String rutaBD = join(carpeta.path, nombreBD);
    return await openDatabase(rutaBD,
        version: versionBD, onCreate: _createTable);
  }

  _createTable(Database db, int version) async {
    String query =
        "CREATE TABLE tblUsuario(idUsuario INTEGER PRIMARY KEY, nombre varchar(30),apellidoMaterno varchar(30),apellidoPaterno varchar(30),email varchar(30), telefono varchar(13),github varchar(30),image TEXT)";
    db.execute(query);

    String queryNewUser = "INSERT INTO tblUsuario(nombre,apellidoMaterno,apellidoPaterno,email,telefono,github,image) VALUES ('Juan','Perez','Lopez','edgar59156@gmail.com','4612925662','edgar59156','')";
    db.execute(queryNewUser);
  }

  Future<int> insertar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.insert(nomTabla, row);
  }

  Future<int> actualizar(Map<String, dynamic> row, String nomTabla) async {
    var conexion = await database;
    return await conexion.update(nomTabla, row,
        where: 'idUsuario = ?', whereArgs: [row['idUsuario']]);
  }

  Future<int> eliminar(int idTarea, String nomTabla) async {
    var conexion = await database;
    return await conexion
        .delete(nomTabla, where: 'idUsuario = ?', whereArgs: [idTarea]);
  }

  Future<List<ProfileDAO>> getAllUsuarios() async {
    var conexion = await database;
    var result = await conexion.query('tblUsuario');
    return result.map((mapUsuario) => ProfileDAO.fromJSON(mapUsuario)).toList();
  }
}
