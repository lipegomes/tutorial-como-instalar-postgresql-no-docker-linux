--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.0 (Debian 14.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: disciplinas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.disciplinas (
    codigo character varying(20) NOT NULL,
    titulo character varying(1000) NOT NULL,
    professor_matricula character varying(10) NOT NULL
);


ALTER TABLE public.disciplinas OWNER TO postgres;

--
-- Name: professores; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.professores (
    matricula character varying(10) NOT NULL,
    cpf character varying(14) NOT NULL,
    nome character varying(255) NOT NULL,
    sobrenome character varying(255) NOT NULL
);


ALTER TABLE public.professores OWNER TO postgres;

--
-- Data for Name: disciplinas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.disciplinas (codigo, titulo, professor_matricula) FROM stdin;
ED123	Estrutura de dados	0001-1
BM034	Bioquímica de Macromoléculas	0358-2
MQ198	Mecânica Quantica	1765-4
FS572	Física dos Sólidos	0023-1
\.


--
-- Data for Name: professores; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.professores (matricula, cpf, nome, sobrenome) FROM stdin;
0001-1	000.000.000-01	Mark	Twin
0358-2	000.000.000-76	Letícia	Bragança
0023-1	000.000.000-18	Helena	Avelino
1765-4	000.000.000-98	Paulo	Pereira
\.


--
-- Name: disciplinas disciplinas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT disciplinas_pkey PRIMARY KEY (codigo);


--
-- Name: professores professores_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.professores
    ADD CONSTRAINT professores_pkey PRIMARY KEY (matricula);


--
-- Name: disciplinas fk_professor_disciplinas; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.disciplinas
    ADD CONSTRAINT fk_professor_disciplinas FOREIGN KEY (professor_matricula) REFERENCES public.professores(matricula);


--
-- PostgreSQL database dump complete
--

