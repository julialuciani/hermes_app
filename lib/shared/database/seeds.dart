class Seeds {
  static String getSeeds() {
    return '''
INSERT OR IGNORE INTO `transaction_type` VALUES
(1, 'income'),
(2, 'expenses'),
(3, 'investments');

INSERT OR IGNORE INTO `category` VALUES
(1, 'Alimentação', 2, 'food', 1, 234, 22, 22),
(2, 'Transporte', 2, 'car', 1, 234, 22, 22),
(3, 'Aluguel', 2, 'home', 1, 234, 22, 22),
(4, 'Renda fixa', 3, 'Renda_fixa', 1, 234, 22, 22);
(5, 'Salário', 1, 'Salario', 1, 234, 22, 22);

INSERT OR IGNORE INTO `source` VALUES
(1, 'Cartao', 1);
(2, 'Dinheiro físico', 1);
(3, 'Cheque', 1);
''';
  }
}
