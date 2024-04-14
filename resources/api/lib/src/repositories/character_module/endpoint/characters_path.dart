// ignore_for_file: sort_constructors_first

///Enum that represnt all character endpoints
enum CharacterServicePath {
  /// /api/character
  catalogue('/catalogue'),

  price('/v1/tickers/matic-polygon');

  ///String value of the enum.
  final String value;

  String withPath(String pathParam)=>'$value/$pathParam';
  
  const CharacterServicePath(this.value);
}
