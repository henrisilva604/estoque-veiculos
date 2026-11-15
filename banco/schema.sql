CREATE DATABASE IF NOT EXISTS estoque_veiculos
  CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE estoque_veiculos;

CREATE TABLE marca (
  id   BIGINT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL UNIQUE
);

CREATE TABLE modelo (
  id       BIGINT AUTO_INCREMENT PRIMARY KEY,
  nome     VARCHAR(80) NOT NULL,
  marca_id BIGINT NOT NULL,
  CONSTRAINT fk_modelo_marca FOREIGN KEY (marca_id) REFERENCES marca(id),
  CONSTRAINT uq_modelo_marca UNIQUE (marca_id, nome)
);

CREATE TABLE veiculo (
  id             BIGINT AUTO_INCREMENT PRIMARY KEY,
  modelo_id      BIGINT NOT NULL,
  ano_fabricacao SMALLINT NOT NULL,
  cor            VARCHAR(30) NOT NULL,
  preco          DECIMAL(12,2) NOT NULL,
  quilometragem  INT NOT NULL DEFAULT 0,
  status         ENUM('DISPONIVEL','RESERVADO','VENDIDO','DESCONTINUADO')
                 NOT NULL DEFAULT 'DISPONIVEL',
  CONSTRAINT fk_veiculo_modelo FOREIGN KEY (modelo_id) REFERENCES modelo(id),
  CONSTRAINT ck_veiculo_preco CHECK (preco >= 0),
  CONSTRAINT ck_veiculo_km CHECK (quilometragem >= 0)
);

-- Índices nas colunas usadas nos filtros (requisito de performance)
CREATE INDEX idx_veiculo_status ON veiculo(status);
CREATE INDEX idx_veiculo_preco  ON veiculo(preco);
CREATE INDEX idx_veiculo_ano    ON veiculo(ano_fabricacao);

-- Dados de exemplo
INSERT INTO marca (nome) VALUES ('Toyota'), ('Honda'), ('Volkswagen');
INSERT INTO modelo (nome, marca_id) VALUES
  ('Corolla', 1), ('Hilux', 1), ('Civic', 2), ('Golf', 3);
INSERT INTO veiculo (modelo_id, ano_fabricacao, cor, preco, quilometragem, status) VALUES
  (1, 2022, 'Prata', 135000.00, 25000, 'DISPONIVEL'),
  (2, 2021, 'Branco', 210000.00, 40000, 'DISPONIVEL'),
  (3, 2020, 'Preto', 118000.00, 60000, 'VENDIDO'),
  (4, 2019, 'Azul', 95000.00, 52000, 'DISPONIVEL');