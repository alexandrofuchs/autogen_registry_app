abstract class RegistryDbModel{
  static const _tableName = 'Registries';
  static const List<String> _textFields = [
    'id INTEGER PRIMARY KEY',
    'content_name TEXT',
    'content_data TEXT',
    'content_type TEXT',
    'content_group TEXT',
    'description TEXT',
    'date_time TEXT',
  ];

  static final String createTableCommand = 'CREATE TABLE IF NOT EXISTS $_tableName (${_textFields.join(', ')})';
  static const String dropTableCommand = 'DROP TABLE IF EXISTS $_tableName';
}

