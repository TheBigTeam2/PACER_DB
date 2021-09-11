create schema pacer;
use pacer;

create user 'admin'@'localhost' identified by '4dm1n'
grant select, insert, delete, update on pacer.* to user@'localhost';

CREATE TABLE usuario (
  usu_id BIGINT AUTO_INCREMENT,
  usu_nome VARCHAR(128),
  
  CONSTRAINT PRIMARY KEY(usu_id)
);

CREATE TABLE professor (
  pro_id BIGINT AUTO_INCREMENT,
  pro_cpf BIGINT NOT NULL,
  pro_usuario BIGINT,

  CONSTRAINT PRIMARY KEY(pro_id),
  CONSTRAINT uk_pro_cpf UNIQUE(pro_cpf),
  CONSTRAINT fk_pro_usuario FOREIGN KEY(pro_usuario)
   REFERENCES USUARIO(usu_id)
);

CREATE TABLE aluno (
  alu_id BIGINT AUTO_INCREMENT,
  alu_ra BIGINT NOT NULL,
  alu_usuario BIGINT,

  CONSTRAINT PRIMARY KEY(alu_id),
  CONSTRAINT uk_aluno_ra UNIQUE(alu_ra),
  CONSTRAINT fk_alu_usuario FOREIGN KEY(alu_usuario)
   REFERENCES USUARIO(usu_id)
);

CREATE TABLE disciplina (
  dis_id BIGINT AUTO_INCREMENT,
  dis_semestre VARCHAR(32) NOT NULL,
  dis_professor BIGINT,
  dis_nome VARCHAR(64) NOT NULL,
  
  CONSTRAINT PRIMARY KEY(dis_id),
  CONSTRAINT fk_dis_professor FOREIGN KEY(dis_professor)
   REFERENCES professor(pro_id)
);

CREATE TABLE equipe (
  equ_id BIGINT AUTO_INCREMENT,
  equ_nome VARCHAR(128),
  equ_disciplina BIGINT,
  
  CONSTRAINT PRIMARY KEY(equ_id),
  CONSTRAINT fk_equ_disciplina FOREIGN KEY(equ_disciplina)
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

CREATE TABLE projeto (
  pro_id BIGINT AUTO_INCREMENT,
  pro_equipe BIGINT,
  
  CONSTRAINT PRIMARY KEY(pro_id),
  CONSTRAINT fk_pro_equipe FOREIGN KEY(pro_equipe)
   REFERENCES equipe(equ_id)
);

CREATE TABLE disciplina_projeto(
  dip_disciplina BIGINT,
  dip_projeto BIGINT,
  
  CONSTRAINT PRIMARY KEY(dip_disciplina, dip_projeto),
  CONSTRAINT fk_dip_disciplina FOREIGN KEY(dip_disciplina)
   REFERENCES disciplina(dis_id),
  CONSTRAINT fk_dip_projeto FOREIGN KEY(dip_projeto)
   REFERENCES projeto(pro_id)
);

CREATE TABLE projeto_equipe(
  pre_projeto BIGINT,
  pre_equipe BIGINT,

  CONSTRAINT PRIMARY KEY(pre_projeto, pre_equipe),
  CONSTRAINT fk_pre_projeto FOREIGN KEY(pre_projeto)
   REFERENCES projeto(pro_id),
  CONSTRAINT fk_pre_equipe FOREIGN KEY(pre_equipe)
   REFERENCES equipe(equ_id)
);   

CREATE TABLE avaliacao (
  ava_id BIGINT AUTO_INCREMENT,
  ava_sprint INTEGER NOT NULL,
  ava_inicio DATE NOT NULL,
  ava_termino DATE NOT NULL,
  ava_avaliado BIGINT,
  ava_avaliador BIGINT,
  ava_projeto BIGINT,
  
  CONSTRAINT PRIMARY KEY(ava_id),
  CONSTRAINT fk_ava_avaliado FOREIGN KEY(ava_avaliado)
   REFERENCES usuario(usu_id),
  CONSTRAINT fk_ava_avaliador FOREIGN KEY(ava_avaliador)
   REFERENCES usuario(usu_id),
  CONSTRAINT fk_ava_projeto FOREIGN KEY(ava_projeto)
   REFERENCES projeto(pro_id)
);

CREATE TABLE nota (
  not_id BIGINT AUTO_INCREMENT,
  not_avaliacao BIGINT,
  nor_criterio VARCHAR(32) NOT NULL,
  not_valor INTEGER NOT NULL,
  
  CONSTRAINT PRIMARY KEY(not_id),
  CONSTRAINT fk_not_avalaicao FOREIGN KEY(not_avaliacao)
   REFERENCES avaliacao(ava_id)
);
