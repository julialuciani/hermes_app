class Seeds {
  static String getSeeds() {
    return '''
INSERT OR IGNORE INTO `movement_type` VALUES
(1, 'income'),
(2, 'expenses'),
(3, 'investments');

--SPLIT--

INSERT OR IGNORE INTO `category` VALUES
(1, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(2, 'Transporte', 2, 'bus', 255, 234, 22, 22),
(3, 'Aluguel', 2, 'home', 255, 234, 22, 22),
(4, 'Renda fixa', 3, 'renda_fixa', 255, 21, 50, 236),
(5, 'Salário', 1, 'salario', 255, 97, 165, 86),
(6, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(7, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(8, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(9, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(10, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(11, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(12, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(13, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(14, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(15, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(16, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(17, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(18, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(19, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(20, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(21, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(22, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(23, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(24, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(25, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(26, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(27, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(28, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(29, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(30, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(31, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(32, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(33, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(34, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(35, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(36, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(37, 'Academia', 2, 'barbell', 255, 234, 22, 22),
(38, 'Alimentação', 2, 'food', 255, 234, 22, 22),
(39, 'Mercado', 2, 'shopping_cart', 255, 234, 22, 22),
(40, 'Eletrônicos', 2, 'electronics', 255, 234, 22, 22);
''';
  }
}
