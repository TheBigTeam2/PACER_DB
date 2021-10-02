create schema pacer;
use pacer;

create user 'admin'@'localhost' identified by '4dm1n'
grant select, insert, delete, update on pacer.* to user@'localhost';


CREATE TABLE usuario (
  usu_id BIGINT AUTO_INCREMENT,
  usu_rg VARCHAR(13) NOT NULL,
  usu_cpf VARCHAR(15) NOT NULL,
  usu_nome VARCHAR(128) NOT NULL,
  usu_auth VARCHAR(32) NOT NULL,
  
  CONSTRAINT PRIMARY KEY(usu_id),
  CONSTRAINT UK_USU_RG UNIQUE KEY(usu_rg),
  CONSTRAINT UK_USU_CPF UNIQUE KEY(usu_cpf)
);


CREATE TABLE disciplina (
  dis_id BIGINT AUTO_INCREMENT,
  dis_nome VARCHAR(64) NOT NULL,
  dis_curso VARCHAR(64) NOT NULL,
  dis_periodo TINYINT,
  dis_professor BIGINT,
  
  CONSTRAINT PRIMARY KEY(dis_id),
  CONSTRAINT fk_dis_professor FOREIGN KEY(dis_professor)
   REFERENCES usuario(usu_id)
);


CREATE TABLE equipe (
  equ_id BIGINT AUTO_INCREMENT,
  equ_nome VARCHAR(128) NOT NULL,
  equ_disciplina BIGINT NOT NULL,
  
  CONSTRAINT PRIMARY KEY(equ_id),
  CONSTRAINT fk_equ_disciplina FOREIGN KEY(equ_disciplina)
    REFERENCES disciplina(dis_id)
);


CREATE TABLE projeto (
  pro_id BIGINT AUTO_INCREMENT,
  pro_tema VARCHAR(128) NOT NULL,
  pro_inicio DATE,
  pro_termino DATE,
  
  CONSTRAINT PRIMARY KEY(pro_id)
);
 

CREATE TABLE avaliacao (
  ava_id BIGINT AUTO_INCREMENT,
  ava_sprint TINYINT NOT NULL,
  ava_inicio DATE,
  ava_termino DATE,
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
  not_criterio VARCHAR(32) NOT NULL,
  not_valor INTEGER NOT NULL,
  
  CONSTRAINT PRIMARY KEY(not_id),
  CONSTRAINT fk_not_avalaicao FOREIGN KEY(not_avaliacao)
   REFERENCES avaliacao(ava_id)
);


### TABELAS DE RELAÇÃO ###

CREATE TABLE aluno_equipe (
  ale_aluno BIGINT NOT NULL,
  ale_equipe BIGINT NOT NULL,
  
  CONSTRAINT PRIMARY KEY(ale_aluno, ale_equipe),
  CONSTRAINT fk_ale_aluno FOREIGN KEY(ale_aluno)
    REFERENCES usuario(usu_id),
  CONSTRAINT fk_ale_equipe FOREIGN KEY(ale_equipe)
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
