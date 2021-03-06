-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.disciplinas
(
    codigo character varying(20) NOT NULL,
    titulo character varying(1000) NOT NULL,
    professor_matricula character varying(10) NOT NULL,
    PRIMARY KEY (codigo)
);

CREATE TABLE IF NOT EXISTS public.professores
(
    matricula character varying(10) NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(255) NOT NULL,
    sobrenome character varying(255) NOT NULL,
    PRIMARY KEY (matricula)
);

ALTER TABLE IF EXISTS public.disciplinas
    ADD FOREIGN KEY (professor_matricula)
    REFERENCES public.professores (matricula)
    NOT VALID;

END;