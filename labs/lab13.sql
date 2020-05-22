-- 1. Să se creeze tabelul ANGAJATI_pnu (pnu se alcatuieşte din prima literă
-- din prenume şi primele două din numele studentului) corespunzător schemei
-- relaţionale: ANGAJATI_***(cod_ang number(4), nume varchar2(20), prenume varchar2(20),
-- email char(15), data_ang date, job varchar2(10), cod_sef number(4),
-- salariu number(8, 2), cod_dep number(2))

create table ang_vmu (
    cod_ang number(4) constraint pk_ang_vmu NOT NULL,
    nume varchar2(20),
    prenume varchar2(20),
    email char(15),
    data_ang date,
    job varchar2(10),
    cod_sef number(4),
    salariu number(8, 2),
    cod_dep number(2)
);

create table ang_vmu (
    cod_ang number(4),
    nume varchar2(20) constraint NL_nume_vmu NOT NULL,
    prenume varchar2(20),
    email char(15),
    data_ang date,
    job varchar2(10),
    cod_sef number(4),
    salariu number(8, 2) constraint NL_salariul_vmu NOT NULL,
    cod_dep number(2),
    constraint pk_ang_vmu primary key (cod_ang)
);


-- 2. Adăugaţi următoarele înregistrări în tabelul ANGAJATI_***:

insert into ang_vmu (
    cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (100, 'Nume1', 'Prenume1', Null, Null, 'Director', null, 20000, 10);

insert into ang_vmu (
    cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (101, 'Nume2', 'Prenume2', 'Nume2',to_date('02-02-2004', 'dd-mm-yyyy'), 'Inginer', 100, 10000, 10);

insert into ang_vmu (cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (102, 'Nume3', 'Prenume3', 'Nume3', to_date('05-06-2000', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20);

insert into ang_vmu (cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (103, 'Nume4', 'Prenume4', Null, Null, 'Inginer', 100, 9000, 20);

insert into ang_vmu (cod_ang, nume, prenume, email, data_ang, job, cod_sef, salariu, cod_dep)
values (104, 'Nume5', 'Prenume5', 'Nume5', Null, 'Analist', 101, 3000, 30);

-- 3. Creaţi tabelul ANGAJATI10_***, prin copierea angajaţilor din departamentul 10 din tabelul
-- ANGAJATI_***. Listaţi structura noului tabel. Ce se observă?
create table angajati10_vmu as
    select * from ang_vmu where cod_dep=10;

Alter table ang_vmu modify (salariu DEFAULT 2000);
alter table ang_vmu add (comision number(4, 2));

insert into ang_vmu (cod_ang, nume, prenume, email, data_ang, job, cod_sef, cod_dep)
values (105, 'Nume6', 'Prenume6', Null, Null, 'Inginer', 100, 20);

select * from ang_vmu;

-- 7. Modificaţi tipul coloanei comision în NUMBER(2, 2) şi al coloanei salariu la NUMBER(10,2), în
-- cadrul aceleiaşi instrucţiuni.

alter table ang_vmu modify (salariu number(10,2) default 2000, comision number(2,2));

SELECT table_name, constraint_name, column_name
FROM user_cons_columns
WHERE LOWER(table_name) IN ('ang_vmu');

-- 8. Actualizati valoarea coloanei comision, setând-o la valoarea 0.1 pentru salariaţii al căror job
-- începe cu litera A. (UPDATE)
update ang_vmu set comision = 0.1 where upper(substr(job, 1,1)) = 'A';

-- 9. Modificaţi tipul de date al coloanei email în VARCHAR2.
alter table ang_vmu modify (email varchar2(20));

-- 10. Adăugaţi coloana nr_telefon în tabelul ANGAJATI_***, setându-i o valoare implicită.
alter table ang_vmu add (nr_telefon varchar2(10) default  '00000000');

-- 11. Vizualizaţi înregistrările existente. Suprimaţi coloana nr_telefon.
-- Ce efect ar avea o comandă ROLLBACK în acest moment?
alter table ang_vmu drop column nr_telefon;
rollback;

-- 15. Creaţi şi tabelul DEPARTAMENTE_***, corespunzător schemei relaţionale:
-- DEPARTAMENTE_*** (cod_dep# number(2), nume varchar2(15), cod_director number(4))
-- specificând doar constrângerea NOT NULL pentru nume (nu precizaţi deocamdată constrângerea
-- de cheie primară).
-- CREATE TABLE departamente_*** ( ... );
-- DESC departamente_***
CREATE TABLE departamente_vmu (
    cod_dep number(3),
    nume varchar(15) constraint NL_nume_dep_vmu NOT NULL,
    cod_director number(4)
);

select * from departamente_vmu;

-- 16. Introduceţi următoarele înregistrări în tabelul DEPARTAMENTE_***:
insert into departamente_vmu(cod_dep, nume, cod_director) VALUES (10, 'Administrativ', 100);
insert into departamente_vmu(cod_dep, nume, cod_director) VALUES (20, 'Proiectare', 101);
insert into departamente_vmu(cod_dep, nume, cod_director) VALUES (30, 'Programare', null);

-- 17. Se va preciza apoi cheia primara cod_dep,
-- fără suprimarea şi recreerea tabelului (comanda ALTER).
-- Obs:
-- • Introducerea unei constrângeri după crearea tabelului, presupune ca toate
-- liniile existente în tabel la momentul respective să satisfacă noua constrângere.
-- • Acest mod de specificare a constrângerilor permite numirea acestora.
-- • In situaţia in care constrângerile sunt precizate la nivel de coloană sau tabel (în CREATE
-- TABLE) ele vor primi implicit nume atribuite de sistem, dacă nu se specifică vreun alt nume
-- într-o clauză CONSTRAINT.
-- Exemplu : CREATE TABLE alfa (
-- X NUMBER
-- CONSTRAINT nn_x NOT NULL,
-- Y VARCHAR2 (10) NOT NULL
-- );
alter table departamente_vmu add constraint pk_dept_vmu primary key (cod_dep);