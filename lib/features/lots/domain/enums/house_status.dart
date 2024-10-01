enum HouseStatus {
  available('Beschikbaar'),
  resevered('Gereserveerd'),
  sold('Verkocht'),
  invalid('Invalid');

  final valueKey;

  const HouseStatus(this.valueKey);

  static HouseStatus byKey(String key) {
    return HouseStatus.values.firstWhere((e) => e.valueKey == key,
        orElse: () => HouseStatus.invalid);
  }
}
