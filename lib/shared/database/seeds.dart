class Seeds{
 static String getSeeds(){
  
return '''
INSERT OR IGNORE INTO `transaction_type` VALUES
(1, 'income'),
(2, 'expenses'),
(3, 'investments');

INSERT OR IGNORE INTO `category` VALUES
(1, 'Alimentação', 2, 'food', 00000000111100000010010000100100),
(2, 'Transporte', 2, 'car', 00000000111100000010010000100100),
(3, 'Aluguel', 2, 'home', 00000000111100000010010000100100),
(4, 'Renda fixa', 3, 'Renda_fixa', 00000000111100000010010000100100);
(5, 'Salário', 1, 'Salario', 00000000111100000010010000100100);

INSERT OR IGNORE INTO `source` VALUES
(1, 'Cartao', 1);
(2, 'Dinheiro físico', 1);
(3, 'Cheque', 1);

''';
  }
}