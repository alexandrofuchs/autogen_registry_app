abstract class RegistryDbModel{
  static const _tableName = 'Registries';
  static const List<String> _textFields = [
    'id INTEGER PRIMARY KEY',
    'topic TEXT NOT NULL',
    'description TEXT NOT NULL',
    'content_name TEXT',
    'content_data TEXT NOT NULL',
    'content_type TEXT NOT NULL',
    'content_group TEXT NOT NULL',
    'date_time TEXT NOT NULL',
  ];

  static final String createTableCommand = 'CREATE TABLE IF NOT EXISTS $_tableName (${_textFields.join(', ')})';
  static const String dropTableCommand = 'DROP TABLE IF EXISTS $_tableName';
}

