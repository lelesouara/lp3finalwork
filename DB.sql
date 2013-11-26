--
-- PostgreSQL database dump
--

-- Dumped from database version 9.2.4
-- Dumped by pg_dump version 9.2.4
-- Started on 2013-11-26 20:53:20 AMST

SET statement_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 180 (class 3079 OID 11773)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2036 (class 0 OID 0)
-- Dependencies: 180
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 168 (class 1259 OID 16394)
-- Name: categorias; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE categorias (
    categoria_id bigint NOT NULL,
    titulo character varying(255) NOT NULL
);


ALTER TABLE public.categorias OWNER TO postgres;

--
-- TOC entry 169 (class 1259 OID 16397)
-- Name: categorias_categoria_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE categorias_categoria_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categorias_categoria_id_seq OWNER TO postgres;

--
-- TOC entry 2037 (class 0 OID 0)
-- Dependencies: 169
-- Name: categorias_categoria_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE categorias_categoria_id_seq OWNED BY categorias.categoria_id;


--
-- TOC entry 179 (class 1259 OID 16561)
-- Name: itemordemservicos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE itemordemservicos (
    itemordemservico_id bigint NOT NULL,
    ordemservico_id bigint NOT NULL,
    produto_id bigint NOT NULL,
    quantidade integer
);


ALTER TABLE public.itemordemservicos OWNER TO postgres;

--
-- TOC entry 178 (class 1259 OID 16559)
-- Name: itemordemservicos_itemordemservico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE itemordemservicos_itemordemservico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.itemordemservicos_itemordemservico_id_seq OWNER TO postgres;

--
-- TOC entry 2038 (class 0 OID 0)
-- Dependencies: 178
-- Name: itemordemservicos_itemordemservico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE itemordemservicos_itemordemservico_id_seq OWNED BY itemordemservicos.itemordemservico_id;


--
-- TOC entry 177 (class 1259 OID 16548)
-- Name: ordemservicos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE ordemservicos (
    ordemservico_id bigint NOT NULL,
    perfil_id bigint NOT NULL,
    datacompra date,
    statusos character varying(100) NOT NULL
);


ALTER TABLE public.ordemservicos OWNER TO postgres;

--
-- TOC entry 176 (class 1259 OID 16546)
-- Name: ordemservicos_ordemservico_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE ordemservicos_ordemservico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ordemservicos_ordemservico_id_seq OWNER TO postgres;

--
-- TOC entry 2039 (class 0 OID 0)
-- Dependencies: 176
-- Name: ordemservicos_ordemservico_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE ordemservicos_ordemservico_id_seq OWNED BY ordemservicos.ordemservico_id;


--
-- TOC entry 173 (class 1259 OID 16500)
-- Name: perfils; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE perfils (
    perfil_id bigint NOT NULL,
    nome character varying(255) NOT NULL,
    telefone character varying(100),
    emailalternativo character varying(100),
    endereco text
);


ALTER TABLE public.perfils OWNER TO postgres;

--
-- TOC entry 172 (class 1259 OID 16498)
-- Name: perfils_perfil_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE perfils_perfil_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.perfils_perfil_id_seq OWNER TO postgres;

--
-- TOC entry 2040 (class 0 OID 0)
-- Dependencies: 172
-- Name: perfils_perfil_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE perfils_perfil_id_seq OWNED BY perfils.perfil_id;


--
-- TOC entry 175 (class 1259 OID 16516)
-- Name: produtos; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE produtos (
    produto_id bigint NOT NULL,
    titulo character varying(255) NOT NULL,
    descricao text,
    valor numeric(9,2) NOT NULL,
    categoria_id bigint NOT NULL
);


ALTER TABLE public.produtos OWNER TO postgres;

--
-- TOC entry 174 (class 1259 OID 16514)
-- Name: produtos_produto_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE produtos_produto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.produtos_produto_id_seq OWNER TO postgres;

--
-- TOC entry 2041 (class 0 OID 0)
-- Dependencies: 174
-- Name: produtos_produto_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE produtos_produto_id_seq OWNED BY produtos.produto_id;


--
-- TOC entry 170 (class 1259 OID 16413)
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE usuarios (
    usuario_id bigint NOT NULL,
    login character varying(100) NOT NULL,
    senha character varying(100) NOT NULL,
    ult_acesso date,
    ativo integer DEFAULT 0,
    validacao text,
    acl integer
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- TOC entry 171 (class 1259 OID 16420)
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE usuarios_usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.usuarios_usuario_id_seq OWNER TO postgres;

--
-- TOC entry 2042 (class 0 OID 0)
-- Dependencies: 171
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE usuarios_usuario_id_seq OWNED BY usuarios.usuario_id;


--
-- TOC entry 1993 (class 2604 OID 16422)
-- Name: categoria_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY categorias ALTER COLUMN categoria_id SET DEFAULT nextval('categorias_categoria_id_seq'::regclass);


--
-- TOC entry 1999 (class 2604 OID 16564)
-- Name: itemordemservico_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY itemordemservicos ALTER COLUMN itemordemservico_id SET DEFAULT nextval('itemordemservicos_itemordemservico_id_seq'::regclass);


--
-- TOC entry 1998 (class 2604 OID 16551)
-- Name: ordemservico_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordemservicos ALTER COLUMN ordemservico_id SET DEFAULT nextval('ordemservicos_ordemservico_id_seq'::regclass);


--
-- TOC entry 1996 (class 2604 OID 16503)
-- Name: perfil_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfils ALTER COLUMN perfil_id SET DEFAULT nextval('perfils_perfil_id_seq'::regclass);


--
-- TOC entry 1997 (class 2604 OID 16519)
-- Name: produto_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produtos ALTER COLUMN produto_id SET DEFAULT nextval('produtos_produto_id_seq'::regclass);


--
-- TOC entry 1995 (class 2604 OID 16424)
-- Name: usuario_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY usuarios ALTER COLUMN usuario_id SET DEFAULT nextval('usuarios_usuario_id_seq'::regclass);


--
-- TOC entry 2017 (class 0 OID 16394)
-- Dependencies: 168
-- Data for Name: categorias; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY categorias (categoria_id, titulo) FROM stdin;
52	Informatica
53	Telefonia
54	Eletro
55	Escritorio
\.


--
-- TOC entry 2043 (class 0 OID 0)
-- Dependencies: 169
-- Name: categorias_categoria_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('categorias_categoria_id_seq', 55, true);


--
-- TOC entry 2028 (class 0 OID 16561)
-- Dependencies: 179
-- Data for Name: itemordemservicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY itemordemservicos (itemordemservico_id, ordemservico_id, produto_id, quantidade) FROM stdin;
\.


--
-- TOC entry 2044 (class 0 OID 0)
-- Dependencies: 178
-- Name: itemordemservicos_itemordemservico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('itemordemservicos_itemordemservico_id_seq', 16, true);


--
-- TOC entry 2026 (class 0 OID 16548)
-- Dependencies: 177
-- Data for Name: ordemservicos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY ordemservicos (ordemservico_id, perfil_id, datacompra, statusos) FROM stdin;
\.


--
-- TOC entry 2045 (class 0 OID 0)
-- Dependencies: 176
-- Name: ordemservicos_ordemservico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('ordemservicos_ordemservico_id_seq', 10, true);


--
-- TOC entry 2022 (class 0 OID 16500)
-- Dependencies: 173
-- Data for Name: perfils; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY perfils (perfil_id, nome, telefone, emailalternativo, endereco) FROM stdin;
7	Leandro Souza	(67) 1234-5678	leandro.web@live.com	rua dos ipes, 615
8	Administrador do Sistema	000000000	adm@adm.com	rua dos ADM
\.


--
-- TOC entry 2046 (class 0 OID 0)
-- Dependencies: 172
-- Name: perfils_perfil_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('perfils_perfil_id_seq', 1, false);


--
-- TOC entry 2024 (class 0 OID 16516)
-- Dependencies: 175
-- Data for Name: produtos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY produtos (produto_id, titulo, descricao, valor, categoria_id) FROM stdin;
8	NoteBook Accer	notebook com 2gb de ram, 500 gb de hd sata 3, processador core 2 duo de 3.2 ghz.	1000.00	52
\.


--
-- TOC entry 2047 (class 0 OID 0)
-- Dependencies: 174
-- Name: produtos_produto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('produtos_produto_id_seq', 8, true);


--
-- TOC entry 2019 (class 0 OID 16413)
-- Dependencies: 170
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY usuarios (usuario_id, login, senha, ult_acesso, ativo, validacao, acl) FROM stdin;
7	leandro.souara.web@gmail.com	123	2013-11-26	1	AA3FFBC7XFEE9X49ABX8D27X7F0A9A317AF01385509299625	3
8	admin@admin	123	2013-11-26	1	E7EC992FX305FX4D55X9F77XA377B20BCBC01385509753978	1
\.


--
-- TOC entry 2048 (class 0 OID 0)
-- Dependencies: 171
-- Name: usuarios_usuario_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('usuarios_usuario_id_seq', 8, true);


--
-- TOC entry 2001 (class 2606 OID 16426)
-- Name: categorias_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (categoria_id);


--
-- TOC entry 2011 (class 2606 OID 16566)
-- Name: itemordemservicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY itemordemservicos
    ADD CONSTRAINT itemordemservicos_pkey PRIMARY KEY (itemordemservico_id);


--
-- TOC entry 2009 (class 2606 OID 16553)
-- Name: ordemservicos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY ordemservicos
    ADD CONSTRAINT ordemservicos_pkey PRIMARY KEY (ordemservico_id);


--
-- TOC entry 2005 (class 2606 OID 16508)
-- Name: perfil_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY perfils
    ADD CONSTRAINT perfil_pkey PRIMARY KEY (perfil_id);


--
-- TOC entry 2007 (class 2606 OID 16524)
-- Name: produtos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY produtos
    ADD CONSTRAINT produtos_pkey PRIMARY KEY (produto_id);


--
-- TOC entry 2003 (class 2606 OID 16432)
-- Name: usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (usuario_id);


--
-- TOC entry 2015 (class 2606 OID 16567)
-- Name: itemordemservicos_ordemservico_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY itemordemservicos
    ADD CONSTRAINT itemordemservicos_ordemservico_id_fkey FOREIGN KEY (ordemservico_id) REFERENCES ordemservicos(ordemservico_id);


--
-- TOC entry 2016 (class 2606 OID 16572)
-- Name: itemordemservicos_produto_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY itemordemservicos
    ADD CONSTRAINT itemordemservicos_produto_id_fkey FOREIGN KEY (produto_id) REFERENCES produtos(produto_id);


--
-- TOC entry 2014 (class 2606 OID 16554)
-- Name: ordemservicos_perfil_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY ordemservicos
    ADD CONSTRAINT ordemservicos_perfil_id_fkey FOREIGN KEY (perfil_id) REFERENCES perfils(perfil_id);


--
-- TOC entry 2012 (class 2606 OID 16509)
-- Name: perfil_usuario_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY perfils
    ADD CONSTRAINT perfil_usuario_id_fkey FOREIGN KEY (perfil_id) REFERENCES usuarios(usuario_id);


--
-- TOC entry 2013 (class 2606 OID 16525)
-- Name: produtos_categoria_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY produtos
    ADD CONSTRAINT produtos_categoria_id_fkey FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id);


--
-- TOC entry 2035 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-11-26 20:53:20 AMST

--
-- PostgreSQL database dump complete
--

