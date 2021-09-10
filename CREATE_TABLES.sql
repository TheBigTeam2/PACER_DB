create schema pacer;
use pacer;

create user 'admin'@'localhost' identified by '4dm1n'
grant select, insert, delete, update on pacer.* to user@'localhost';

CREATE TABLE professor (
  pro_id BIGINT AUTO_INCREMENT,
  pro_cpf BIGINT NOT NULL,
  pro_nome VARCHAR(64) NOT NULL,

  CONSTRAINT PRIMARY KEY(pro_id),
  CONSTRAINT uk_pro_cpf UNIQUE(pro_cpf)
);

CREATE TABLE aluno (
  alu_id BIGINT AUTO_INCREMENT,
  alu_ra BIGINT NOT NULL,
  alu_nome VARCHAR(64) NOT NULL,

  CONSTRAINT PRIMARY KEY(alu_id),
  CONSTRAINT uk_aluno_ra UNIQUE(alu_ra)
);

CREATE TABLE disciplina (
  dis_id BIGINT AUTO_INCREMENT,
  dis_semestre VARCHAR(32) NOT NULL,
  dis_professor BIGINT,
  dis_nome VARCHAR(64) NOT NULL,
  
  CONSTRAINT PRIMARY KEY(dis_id),
  CONSTRAINT fk_dis_pro FOREIGN KEY(dis_professor)
   REFERENCES professor(pro_id)
);

CREATE TABLE equipe (
  equ_id BIGINT AUTO_INCREMENT,
  equ_nome VARCHAR(128),
  equ_disciplina BIGINT,
  
  CONSTRAINT PRIMARY KEY(equ_id),
  CONSTRAINT fk_equ_dis FOREIGN KEY(equ_disciplina)
   REFERENCES disciplina(dis_id)
);

CREATE TABLE aluno_equipe (
  ale_aluno BIGINT,
  ale_equipe BIGINT,
  
  CONSTRAINT PRIMARY KEY(ale_aluno, ale_equipe),
  CONSTRAINT fk_ale_aluno FOREIGN KEY(ale_aluno)
   REFERENCES aluno(alu_id),
  CONSTRAINT fk_ale_equipe FOREIGN KEY(ale_equipe)
   REFERENCES equipe(equ_id)
);
