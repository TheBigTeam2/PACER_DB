create schema pacer;
use pacer;

create user 'admin'@'localhost' identified by '4dm1n'
grant select, insert, delete, update on pacer.* to user@'localhost';

create table pro_professor (
    pro_id bigint unsigned auto_increment,
    pro_cpf bigint not null,
    pro_nome varchar(64) not null,

    constraint pk_pro primary key(pro_id),
    constraint uk_pro_cpf unique(pro_cpf)
)

create table alu_aluno (
    alu_id bigint unsigned auto_increment,
    alu_ra bigint not null,
    alu_nome varchar(64) not null,

    constraint pk_alu primary key(alu_id),
    constraint ok_alu_ra unique(alu_ra)
)
