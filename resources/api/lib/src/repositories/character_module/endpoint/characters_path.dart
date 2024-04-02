// ignore_for_file: sort_constructors_first

///Enum that represnt all character endpoints
enum CharacterServicePath {
  /// /api/character
  characters('/api/character');

  ///String value of the enum.
  final String value;

  const CharacterServicePath(this.value);
}
