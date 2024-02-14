class Seeds {
  static String getSeeds() {
    return '''
INSERT OR IGNORE INTO `transaction_type` VALUES
(1, 'income'),
(2, 'expenses'),
(3, 'investments');

--SPLIT--

INSERT OR IGNORE INTO `category` VALUES
(1, 'Alimentação', 2, 'food', 234, 22, 22),
(2, 'Transporte', 2, 'car', 234, 22, 22),
(3, 'Aluguel', 2, 'home', 234, 22, 22),
(4, 'Renda fixa', 3, 'renda_fixa', 21, 50, 236),
(5, 'Salário', 1, 'salario', 97, 165, 86);
''';
  }
}
