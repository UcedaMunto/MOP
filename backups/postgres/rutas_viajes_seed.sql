--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:25 CST

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

ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_ruta_id_fa1dd689_fk_ruta_id;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_piloto_id_5edaebf1_fk_piloto_id;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_parada_inicio_id_ebdbd2cc_fk_parada_id;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_parada_fin_id_5655796e_fk_parada_id;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_autobus_id_0d859c06_fk_autobus_id;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_asignacion_id_094b4304_fk_asignacio;
ALTER TABLE ONLY public.ruta_geopunto DROP CONSTRAINT ruta_geopunto_ruta_id_14d38479_fk_ruta_id;
ALTER TABLE ONLY public.ruta DROP CONSTRAINT ruta_empresa_id_5e57d76a_fk_empresa_transporte_id;
ALTER TABLE ONLY public.posicion_autobus DROP CONSTRAINT posicion_autobus_viaje_id_c2712f5b_fk_viaje_autobus_id;
ALTER TABLE ONLY public.posicion_autobus DROP CONSTRAINT posicion_autobus_autobus_id_0b447cd8_fk_autobus_id;
ALTER TABLE ONLY public.piloto DROP CONSTRAINT piloto_empresa_id_7f76b4b8_fk_empresa_transporte_id;
ALTER TABLE ONLY public.parada DROP CONSTRAINT parada_ruta_id_4defedba_fk_ruta_id;
ALTER TABLE ONLY public.autobus DROP CONSTRAINT autobus_empresa_id_0ae4a3fe_fk_empresa_transporte_id;
ALTER TABLE ONLY public.asignacion_autobus_ruta DROP CONSTRAINT asignacion_autobus_ruta_ruta_id_0cef946c_fk_ruta_id;
ALTER TABLE ONLY public.asignacion_autobus_ruta DROP CONSTRAINT asignacion_autobus_ruta_piloto_id_fd84a333_fk_piloto_id;
ALTER TABLE ONLY public.asignacion_autobus_ruta DROP CONSTRAINT asignacion_autobus_ruta_autobus_id_64395eef_fk_autobus_id;
DROP INDEX public.viaje_autobus_ruta_id_fa1dd689;
DROP INDEX public.viaje_autobus_piloto_id_5edaebf1;
DROP INDEX public.viaje_autobus_parada_inicio_id_ebdbd2cc;
DROP INDEX public.viaje_autobus_parada_fin_id_5655796e;
DROP INDEX public.viaje_autobus_autobus_id_0d859c06;
DROP INDEX public.viaje_autobus_asignacion_id_094b4304;
DROP INDEX public.viaje_autob_ruta_id_5f2ba8_idx;
DROP INDEX public.viaje_autob_inicio__5ae81b_idx;
DROP INDEX public.viaje_autob_estado_0f24d0_idx;
DROP INDEX public.viaje_autob_autobus_e6ea94_idx;
DROP INDEX public.viaje_autob_asignac_71f8ef_idx;
DROP INDEX public.ruta_nombre_20fd38_idx;
DROP INDEX public.ruta_geopunto_ruta_id_14d38479;
DROP INDEX public.ruta_geopun_ruta_id_de1a1c_idx;
DROP INDEX public.ruta_geopun_latitud_c3fe61_idx;
DROP INDEX public.ruta_empresa_id_5e57d76a;
DROP INDEX public.ruta_empresa_fefb6b_idx;
DROP INDEX public.ruta_codigo_8d8d3b25_like;
DROP INDEX public.ruta_codigo_711036_idx;
DROP INDEX public.posicion_autobus_viaje_id_c2712f5b;
DROP INDEX public.posicion_autobus_autobus_id_0b447cd8;
DROP INDEX public.posicion_au_viaje_i_cd7bf0_idx;
DROP INDEX public.posicion_au_latitud_e788f4_idx;
DROP INDEX public.posicion_au_captura_51ba03_idx;
DROP INDEX public.posicion_au_autobus_7f713a_idx;
DROP INDEX public.piloto_licenci_d891e1_idx;
DROP INDEX public.piloto_empresa_id_7f76b4b8;
DROP INDEX public.piloto_empresa_313961_idx;
DROP INDEX public.piloto_documen_d18f9b_idx;
DROP INDEX public.parada_ruta_id_bc9f8c_idx;
DROP INDEX public.parada_ruta_id_4defedba;
DROP INDEX public.parada_latitud_9fd4c1_idx;
DROP INDEX public.parada_activo_ab7555_idx;
DROP INDEX public.empresa_transporte_codigo_1ff29b2f_like;
DROP INDEX public.empresa_tra_nombre_62f3d0_idx;
DROP INDEX public.empresa_tra_codigo_00500b_idx;
DROP INDEX public.empresa_tra_activo_219b52_idx;
DROP INDEX public.autobus_placa_60ad2cdf_like;
DROP INDEX public.autobus_placa_4c0932_idx;
DROP INDEX public.autobus_empresa_id_0ae4a3fe;
DROP INDEX public.autobus_empresa_af2493_idx;
DROP INDEX public.autobus_codigo_eebd3613_like;
DROP INDEX public.autobus_codigo_63adea_idx;
DROP INDEX public.asignacion_autobus_ruta_ruta_id_0cef946c;
DROP INDEX public.asignacion_autobus_ruta_piloto_id_fd84a333;
DROP INDEX public.asignacion_autobus_ruta_autobus_id_64395eef;
DROP INDEX public.asignacion__ruta_id_570874_idx;
DROP INDEX public.asignacion__piloto__a8f074_idx;
DROP INDEX public.asignacion__fecha_9e482c_idx;
DROP INDEX public.asignacion__autobus_0e19a5_idx;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_pkey;
ALTER TABLE ONLY public.viaje_autobus DROP CONSTRAINT viaje_autobus_asignacion_id_numero_viaje_6ce1e16d_uniq;
ALTER TABLE ONLY public.ruta DROP CONSTRAINT ruta_pkey;
ALTER TABLE ONLY public.ruta_geopunto DROP CONSTRAINT ruta_geopunto_ruta_id_orden_25402e6f_uniq;
ALTER TABLE ONLY public.ruta_geopunto DROP CONSTRAINT ruta_geopunto_pkey;
ALTER TABLE ONLY public.ruta DROP CONSTRAINT ruta_codigo_key;
ALTER TABLE ONLY public.posicion_autobus DROP CONSTRAINT posicion_autobus_pkey;
ALTER TABLE ONLY public.piloto DROP CONSTRAINT piloto_pkey;
ALTER TABLE ONLY public.parada DROP CONSTRAINT parada_pkey;
ALTER TABLE ONLY public.empresa_transporte DROP CONSTRAINT empresa_transporte_pkey;
ALTER TABLE ONLY public.empresa_transporte DROP CONSTRAINT empresa_transporte_codigo_key;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.autobus DROP CONSTRAINT autobus_placa_key;
ALTER TABLE ONLY public.autobus DROP CONSTRAINT autobus_pkey;
ALTER TABLE ONLY public.autobus DROP CONSTRAINT autobus_codigo_key;
ALTER TABLE ONLY public.asignacion_autobus_ruta DROP CONSTRAINT asignacion_autobus_ruta_pkey;
ALTER TABLE ONLY public.asignacion_autobus_ruta DROP CONSTRAINT asignacion_autobus_ruta_autobus_id_fecha_hora_in_2a7896cb_uniq;
DROP TABLE public.viaje_autobus;
DROP TABLE public.ruta_geopunto;
DROP TABLE public.ruta;
DROP TABLE public.posicion_autobus;
DROP TABLE public.piloto;
DROP TABLE public.parada;
DROP TABLE public.empresa_transporte;
DROP TABLE public.django_migrations;
DROP TABLE public.autobus;
DROP TABLE public.asignacion_autobus_ruta;
SET default_table_access_method = heap;

--
-- TOC entry 228 (class 1259 OID 24848)
-- Name: asignacion_autobus_ruta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.asignacion_autobus_ruta (
    id bigint NOT NULL,
    fecha date NOT NULL,
    hora_inicio time without time zone NOT NULL,
    hora_fin time without time zone NOT NULL,
    estado character varying(16) NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    autobus_id bigint NOT NULL,
    piloto_id bigint NOT NULL,
    ruta_id bigint NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 24847)
-- Name: asignacion_autobus_ruta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.asignacion_autobus_ruta ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.asignacion_autobus_ruta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 24814)
-- Name: autobus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.autobus (
    id bigint NOT NULL,
    codigo character varying(32) NOT NULL,
    placa character varying(16) NOT NULL,
    capacidad integer NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    empresa_id bigint NOT NULL,
    CONSTRAINT autobus_capacidad_check CHECK ((capacidad >= 0))
);


--
-- TOC entry 219 (class 1259 OID 24813)
-- Name: autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.autobus ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.autobus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 216 (class 1259 OID 24798)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- TOC entry 215 (class 1259 OID 24797)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 24806)
-- Name: empresa_transporte; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.empresa_transporte (
    id bigint NOT NULL,
    nombre character varying(120) NOT NULL,
    codigo character varying(32) NOT NULL,
    contacto character varying(120) NOT NULL,
    telefono character varying(32) NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 24805)
-- Name: empresa_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.empresa_transporte ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.empresa_transporte_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 24841)
-- Name: parada; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.parada (
    id bigint NOT NULL,
    nombre character varying(120) NOT NULL,
    orden integer NOT NULL,
    sentido character varying(16) NOT NULL,
    latitud numeric(9,6) NOT NULL,
    longitud numeric(9,6) NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    ruta_id bigint NOT NULL,
    CONSTRAINT parada_orden_check CHECK ((orden >= 0))
);


--
-- TOC entry 225 (class 1259 OID 24840)
-- Name: parada_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.parada ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.parada_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 222 (class 1259 OID 24825)
-- Name: piloto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.piloto (
    id bigint NOT NULL,
    nombre character varying(120) NOT NULL,
    documento character varying(32) NOT NULL,
    licencia_numero character varying(32) NOT NULL,
    licencia_categoria character varying(16) NOT NULL,
    telefono character varying(32) NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    empresa_id bigint NOT NULL
);


--
-- TOC entry 221 (class 1259 OID 24824)
-- Name: piloto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.piloto ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.piloto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 24869)
-- Name: posicion_autobus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posicion_autobus (
    id bigint NOT NULL,
    latitud numeric(9,6) NOT NULL,
    longitud numeric(9,6) NOT NULL,
    velocidad_kmh numeric(6,2),
    rumbo_grados numeric(5,1),
    precision_m numeric(6,2),
    fuente character varying(24) NOT NULL,
    capturado_en timestamp with time zone NOT NULL,
    recibido_en timestamp with time zone NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    autobus_id bigint NOT NULL,
    viaje_id bigint NOT NULL
);


--
-- TOC entry 233 (class 1259 OID 24868)
-- Name: posicion_autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.posicion_autobus ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.posicion_autobus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 24831)
-- Name: ruta; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ruta (
    id bigint NOT NULL,
    codigo character varying(32) NOT NULL,
    nombre character varying(120) NOT NULL,
    descripcion text NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    empresa_id bigint NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 24854)
-- Name: ruta_geopunto; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ruta_geopunto (
    id bigint NOT NULL,
    orden integer NOT NULL,
    latitud numeric(9,6) NOT NULL,
    longitud numeric(9,6) NOT NULL,
    ruta_id bigint NOT NULL,
    CONSTRAINT ruta_geopunto_orden_check CHECK ((orden >= 0))
);


--
-- TOC entry 229 (class 1259 OID 24853)
-- Name: ruta_geopunto_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ruta_geopunto ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ruta_geopunto_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 24830)
-- Name: ruta_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.ruta ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.ruta_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 24861)
-- Name: viaje_autobus; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.viaje_autobus (
    id bigint NOT NULL,
    numero_viaje integer NOT NULL,
    estado character varying(16) NOT NULL,
    inicio_en timestamp with time zone,
    fin_en timestamp with time zone,
    distancia_km numeric(8,3),
    duracion_min integer,
    velocidad_media_kmh numeric(6,2),
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    asignacion_id bigint NOT NULL,
    autobus_id bigint NOT NULL,
    parada_fin_id bigint,
    parada_inicio_id bigint,
    piloto_id bigint NOT NULL,
    ruta_id bigint NOT NULL,
    CONSTRAINT viaje_autobus_duracion_min_check CHECK ((duracion_min >= 0)),
    CONSTRAINT viaje_autobus_numero_viaje_check CHECK ((numero_viaje >= 0))
);


--
-- TOC entry 231 (class 1259 OID 24860)
-- Name: viaje_autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.viaje_autobus ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.viaje_autobus_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 3552 (class 0 OID 24848)
-- Dependencies: 228
-- Data for Name: asignacion_autobus_ruta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.asignacion_autobus_ruta (id, fecha, hora_inicio, hora_fin, estado, creado_en, actualizado_en, autobus_id, piloto_id, ruta_id) FROM stdin;
\.


--
-- TOC entry 3544 (class 0 OID 24814)
-- Dependencies: 220
-- Data for Name: autobus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.autobus (id, codigo, placa, capacidad, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	BUS001	P123-456	45	t	2025-10-25 17:51:57.886701-06	2025-10-25 17:51:57.886937-06	1
2	BUS002	P456-DEF	45	t	2025-10-25 18:51:24.434122-06	2025-10-25 18:51:24.434608-06	2
3	232423	EWREWREWER	23	t	2025-10-25 19:53:36.078674-06	2025-10-25 19:53:36.078987-06	3
\.


--
-- TOC entry 3540 (class 0 OID 24798)
-- Dependencies: 216
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	microservicios_rutas_viajes	0001_initial	2025-10-25 17:44:46.232737-06
\.


--
-- TOC entry 3542 (class 0 OID 24806)
-- Dependencies: 218
-- Data for Name: empresa_transporte; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.empresa_transporte (id, nombre, codigo, contacto, telefono, activo, creado_en, actualizado_en) FROM stdin;
1	Transportes MOP S.A.	MOP001	Juan Pérez	2234-5678	t	2025-10-25 17:51:57.858568-06	2025-10-25 17:51:57.878526-06
2	Transporte Urbano Guatemala	TRANS001	Juan Pérez	+502-2334-5678	t	2025-10-25 18:48:21.846699-06	2025-10-25 18:48:21.847055-06
3	La experanza	003	Juan Valdez	73659816	t	2025-10-25 19:26:05.77291-06	2025-10-25 19:26:05.77335-06
\.


--
-- TOC entry 3550 (class 0 OID 24841)
-- Dependencies: 226
-- Data for Name: parada; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.parada (id, nombre, orden, sentido, latitud, longitud, activo, creado_en, actualizado_en, ruta_id) FROM stdin;
1	Parque Central	1	IDA	14.640521	-90.513197	t	2025-10-25 18:52:15.89286-06	2025-10-25 18:52:15.893287-06	2
\.


--
-- TOC entry 3546 (class 0 OID 24825)
-- Dependencies: 222
-- Data for Name: piloto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.piloto (id, nombre, documento, licencia_numero, licencia_categoria, telefono, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	Carlos Rodriguez	12345678-9	LIC123456	D	7890-1234	t	2025-10-25 17:51:57.882711-06	2025-10-25 17:51:57.882997-06	1
3	Juan Valdez	048958865	wq121231212	12	121212	t	2025-10-25 19:29:29.069893-06	2025-10-25 19:29:29.070391-06	1
4	Juan Perez	048958865	1213213	1	123132123	t	2025-10-25 19:45:03.023129-06	2025-10-25 19:45:03.023524-06	3
\.


--
-- TOC entry 3558 (class 0 OID 24869)
-- Dependencies: 234
-- Data for Name: posicion_autobus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.posicion_autobus (id, latitud, longitud, velocidad_kmh, rumbo_grados, precision_m, fuente, capturado_en, recibido_en, creado_en, autobus_id, viaje_id) FROM stdin;
\.


--
-- TOC entry 3548 (class 0 OID 24831)
-- Dependencies: 224
-- Data for Name: ruta; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ruta (id, codigo, nombre, descripcion, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	R001	Ruta Centro - Zona Industrial	Conecta el centro de la ciudad con la zona industrial	t	2025-10-25 17:51:57.891107-06	2025-10-25 17:51:57.891408-06	1
2	R101	Centro - Zone 18	Ruta que conecta el centro histórico con la Zona 18	t	2025-10-25 18:51:40.322942-06	2025-10-25 18:51:40.323354-06	2
3	44	ruta 44 - A	23232	t	2025-10-25 19:54:13.16647-06	2025-10-25 19:54:13.166757-06	3
\.


--
-- TOC entry 3554 (class 0 OID 24854)
-- Dependencies: 230
-- Data for Name: ruta_geopunto; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.ruta_geopunto (id, orden, latitud, longitud, ruta_id) FROM stdin;
1	1	14.640521	-90.513197	2
\.


--
-- TOC entry 3556 (class 0 OID 24861)
-- Dependencies: 232
-- Data for Name: viaje_autobus; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.viaje_autobus (id, numero_viaje, estado, inicio_en, fin_en, distancia_km, duracion_min, velocidad_media_kmh, creado_en, actualizado_en, asignacion_id, autobus_id, parada_fin_id, parada_inicio_id, piloto_id, ruta_id) FROM stdin;
\.


--
-- TOC entry 3564 (class 0 OID 0)
-- Dependencies: 227
-- Name: asignacion_autobus_ruta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.asignacion_autobus_ruta_id_seq', 1, true);


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 219
-- Name: autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.autobus_id_seq', 3, true);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 215
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 1, true);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 217
-- Name: empresa_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.empresa_transporte_id_seq', 3, true);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 225
-- Name: parada_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.parada_id_seq', 1, true);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 221
-- Name: piloto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.piloto_id_seq', 4, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 233
-- Name: posicion_autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.posicion_autobus_id_seq', 1, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 229
-- Name: ruta_geopunto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ruta_geopunto_id_seq', 1, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 223
-- Name: ruta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.ruta_id_seq', 3, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 231
-- Name: viaje_autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.viaje_autobus_id_seq', 1, true);


--
-- TOC entry 3345 (class 2606 OID 24891)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_autobus_id_fecha_hora_in_2a7896cb_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_autobus_id_fecha_hora_in_2a7896cb_uniq UNIQUE (autobus_id, fecha, hora_inicio);


--
-- TOC entry 3348 (class 2606 OID 24852)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 24821)
-- Name: autobus autobus_codigo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_codigo_key UNIQUE (codigo);


--
-- TOC entry 3313 (class 2606 OID 24819)
-- Name: autobus autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 24823)
-- Name: autobus autobus_placa_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_placa_key UNIQUE (placa);


--
-- TOC entry 3297 (class 2606 OID 24804)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 24812)
-- Name: empresa_transporte empresa_transporte_codigo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresa_transporte
    ADD CONSTRAINT empresa_transporte_codigo_key UNIQUE (codigo);


--
-- TOC entry 3305 (class 2606 OID 24810)
-- Name: empresa_transporte empresa_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.empresa_transporte
    ADD CONSTRAINT empresa_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 24846)
-- Name: parada parada_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parada
    ADD CONSTRAINT parada_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 24829)
-- Name: piloto piloto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT piloto_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 24873)
-- Name: posicion_autobus posicion_autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 24839)
-- Name: ruta ruta_codigo_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_codigo_key UNIQUE (codigo);


--
-- TOC entry 3353 (class 2606 OID 24859)
-- Name: ruta_geopunto ruta_geopunto_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 24895)
-- Name: ruta_geopunto ruta_geopunto_ruta_id_orden_25402e6f_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_ruta_id_orden_25402e6f_uniq UNIQUE (ruta_id, orden);


--
-- TOC entry 3332 (class 2606 OID 24837)
-- Name: ruta ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 24902)
-- Name: viaje_autobus viaje_autobus_asignacion_id_numero_viaje_6ce1e16d_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_asignacion_id_numero_viaje_6ce1e16d_uniq UNIQUE (asignacion_id, numero_viaje);


--
-- TOC entry 3370 (class 2606 OID 24867)
-- Name: viaje_autobus viaje_autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 1259 OID 24886)
-- Name: asignacion__autobus_0e19a5_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion__autobus_0e19a5_idx ON public.asignacion_autobus_ruta USING btree (autobus_id, fecha);


--
-- TOC entry 3340 (class 1259 OID 24889)
-- Name: asignacion__fecha_9e482c_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion__fecha_9e482c_idx ON public.asignacion_autobus_ruta USING btree (fecha, estado);


--
-- TOC entry 3341 (class 1259 OID 24888)
-- Name: asignacion__piloto__a8f074_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion__piloto__a8f074_idx ON public.asignacion_autobus_ruta USING btree (piloto_id, fecha);


--
-- TOC entry 3342 (class 1259 OID 24887)
-- Name: asignacion__ruta_id_570874_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion__ruta_id_570874_idx ON public.asignacion_autobus_ruta USING btree (ruta_id, fecha);


--
-- TOC entry 3343 (class 1259 OID 24953)
-- Name: asignacion_autobus_ruta_autobus_id_64395eef; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion_autobus_ruta_autobus_id_64395eef ON public.asignacion_autobus_ruta USING btree (autobus_id);


--
-- TOC entry 3346 (class 1259 OID 24954)
-- Name: asignacion_autobus_ruta_piloto_id_fd84a333; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion_autobus_ruta_piloto_id_fd84a333 ON public.asignacion_autobus_ruta USING btree (piloto_id);


--
-- TOC entry 3349 (class 1259 OID 24955)
-- Name: asignacion_autobus_ruta_ruta_id_0cef946c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX asignacion_autobus_ruta_ruta_id_0cef946c ON public.asignacion_autobus_ruta USING btree (ruta_id);


--
-- TOC entry 3306 (class 1259 OID 24875)
-- Name: autobus_codigo_63adea_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_codigo_63adea_idx ON public.autobus USING btree (codigo);


--
-- TOC entry 3307 (class 1259 OID 24916)
-- Name: autobus_codigo_eebd3613_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_codigo_eebd3613_like ON public.autobus USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3310 (class 1259 OID 24874)
-- Name: autobus_empresa_af2493_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_empresa_af2493_idx ON public.autobus USING btree (empresa_id, activo);


--
-- TOC entry 3311 (class 1259 OID 24918)
-- Name: autobus_empresa_id_0ae4a3fe; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_empresa_id_0ae4a3fe ON public.autobus USING btree (empresa_id);


--
-- TOC entry 3314 (class 1259 OID 24876)
-- Name: autobus_placa_4c0932_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_placa_4c0932_idx ON public.autobus USING btree (placa);


--
-- TOC entry 3315 (class 1259 OID 24917)
-- Name: autobus_placa_60ad2cdf_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX autobus_placa_60ad2cdf_like ON public.autobus USING btree (placa varchar_pattern_ops);


--
-- TOC entry 3298 (class 1259 OID 24909)
-- Name: empresa_tra_activo_219b52_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX empresa_tra_activo_219b52_idx ON public.empresa_transporte USING btree (activo);


--
-- TOC entry 3299 (class 1259 OID 24908)
-- Name: empresa_tra_codigo_00500b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX empresa_tra_codigo_00500b_idx ON public.empresa_transporte USING btree (codigo);


--
-- TOC entry 3300 (class 1259 OID 24910)
-- Name: empresa_tra_nombre_62f3d0_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX empresa_tra_nombre_62f3d0_idx ON public.empresa_transporte USING btree (nombre);


--
-- TOC entry 3301 (class 1259 OID 24907)
-- Name: empresa_transporte_codigo_1ff29b2f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX empresa_transporte_codigo_1ff29b2f_like ON public.empresa_transporte USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3333 (class 1259 OID 24885)
-- Name: parada_activo_ab7555_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX parada_activo_ab7555_idx ON public.parada USING btree (activo);


--
-- TOC entry 3334 (class 1259 OID 24884)
-- Name: parada_latitud_9fd4c1_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX parada_latitud_9fd4c1_idx ON public.parada USING btree (latitud, longitud);


--
-- TOC entry 3337 (class 1259 OID 24937)
-- Name: parada_ruta_id_4defedba; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX parada_ruta_id_4defedba ON public.parada USING btree (ruta_id);


--
-- TOC entry 3338 (class 1259 OID 24883)
-- Name: parada_ruta_id_bc9f8c_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX parada_ruta_id_bc9f8c_idx ON public.parada USING btree (ruta_id, sentido, orden);


--
-- TOC entry 3318 (class 1259 OID 24878)
-- Name: piloto_documen_d18f9b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX piloto_documen_d18f9b_idx ON public.piloto USING btree (documento);


--
-- TOC entry 3319 (class 1259 OID 24877)
-- Name: piloto_empresa_313961_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX piloto_empresa_313961_idx ON public.piloto USING btree (empresa_id, activo);


--
-- TOC entry 3320 (class 1259 OID 24924)
-- Name: piloto_empresa_id_7f76b4b8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX piloto_empresa_id_7f76b4b8 ON public.piloto USING btree (empresa_id);


--
-- TOC entry 3321 (class 1259 OID 24879)
-- Name: piloto_licenci_d891e1_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX piloto_licenci_d891e1_idx ON public.piloto USING btree (licencia_numero);


--
-- TOC entry 3372 (class 1259 OID 24904)
-- Name: posicion_au_autobus_7f713a_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_au_autobus_7f713a_idx ON public.posicion_autobus USING btree (autobus_id, capturado_en);


--
-- TOC entry 3373 (class 1259 OID 24906)
-- Name: posicion_au_captura_51ba03_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_au_captura_51ba03_idx ON public.posicion_autobus USING btree (capturado_en);


--
-- TOC entry 3374 (class 1259 OID 24905)
-- Name: posicion_au_latitud_e788f4_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_au_latitud_e788f4_idx ON public.posicion_autobus USING btree (latitud, longitud);


--
-- TOC entry 3375 (class 1259 OID 24903)
-- Name: posicion_au_viaje_i_cd7bf0_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_au_viaje_i_cd7bf0_idx ON public.posicion_autobus USING btree (viaje_id, capturado_en);


--
-- TOC entry 3376 (class 1259 OID 25008)
-- Name: posicion_autobus_autobus_id_0b447cd8; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_autobus_autobus_id_0b447cd8 ON public.posicion_autobus USING btree (autobus_id);


--
-- TOC entry 3379 (class 1259 OID 25009)
-- Name: posicion_autobus_viaje_id_c2712f5b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX posicion_autobus_viaje_id_c2712f5b ON public.posicion_autobus USING btree (viaje_id);


--
-- TOC entry 3324 (class 1259 OID 24881)
-- Name: ruta_codigo_711036_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_codigo_711036_idx ON public.ruta USING btree (codigo);


--
-- TOC entry 3325 (class 1259 OID 24930)
-- Name: ruta_codigo_8d8d3b25_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_codigo_8d8d3b25_like ON public.ruta USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3328 (class 1259 OID 24880)
-- Name: ruta_empresa_fefb6b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_empresa_fefb6b_idx ON public.ruta USING btree (empresa_id, activo);


--
-- TOC entry 3329 (class 1259 OID 24931)
-- Name: ruta_empresa_id_5e57d76a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_empresa_id_5e57d76a ON public.ruta USING btree (empresa_id);


--
-- TOC entry 3350 (class 1259 OID 24893)
-- Name: ruta_geopun_latitud_c3fe61_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_geopun_latitud_c3fe61_idx ON public.ruta_geopunto USING btree (latitud, longitud);


--
-- TOC entry 3351 (class 1259 OID 24892)
-- Name: ruta_geopun_ruta_id_de1a1c_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_geopun_ruta_id_de1a1c_idx ON public.ruta_geopunto USING btree (ruta_id, orden);


--
-- TOC entry 3354 (class 1259 OID 24961)
-- Name: ruta_geopunto_ruta_id_14d38479; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_geopunto_ruta_id_14d38479 ON public.ruta_geopunto USING btree (ruta_id);


--
-- TOC entry 3330 (class 1259 OID 24882)
-- Name: ruta_nombre_20fd38_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ruta_nombre_20fd38_idx ON public.ruta USING btree (nombre);


--
-- TOC entry 3357 (class 1259 OID 24896)
-- Name: viaje_autob_asignac_71f8ef_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autob_asignac_71f8ef_idx ON public.viaje_autobus USING btree (asignacion_id, numero_viaje);


--
-- TOC entry 3358 (class 1259 OID 24897)
-- Name: viaje_autob_autobus_e6ea94_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autob_autobus_e6ea94_idx ON public.viaje_autobus USING btree (autobus_id, inicio_en);


--
-- TOC entry 3359 (class 1259 OID 24899)
-- Name: viaje_autob_estado_0f24d0_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autob_estado_0f24d0_idx ON public.viaje_autobus USING btree (estado);


--
-- TOC entry 3360 (class 1259 OID 24900)
-- Name: viaje_autob_inicio__5ae81b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autob_inicio__5ae81b_idx ON public.viaje_autobus USING btree (inicio_en, fin_en);


--
-- TOC entry 3361 (class 1259 OID 24898)
-- Name: viaje_autob_ruta_id_5f2ba8_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autob_ruta_id_5f2ba8_idx ON public.viaje_autobus USING btree (ruta_id, inicio_en);


--
-- TOC entry 3362 (class 1259 OID 24992)
-- Name: viaje_autobus_asignacion_id_094b4304; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_asignacion_id_094b4304 ON public.viaje_autobus USING btree (asignacion_id);


--
-- TOC entry 3365 (class 1259 OID 24993)
-- Name: viaje_autobus_autobus_id_0d859c06; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_autobus_id_0d859c06 ON public.viaje_autobus USING btree (autobus_id);


--
-- TOC entry 3366 (class 1259 OID 24994)
-- Name: viaje_autobus_parada_fin_id_5655796e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_parada_fin_id_5655796e ON public.viaje_autobus USING btree (parada_fin_id);


--
-- TOC entry 3367 (class 1259 OID 24995)
-- Name: viaje_autobus_parada_inicio_id_ebdbd2cc; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_parada_inicio_id_ebdbd2cc ON public.viaje_autobus USING btree (parada_inicio_id);


--
-- TOC entry 3368 (class 1259 OID 24996)
-- Name: viaje_autobus_piloto_id_5edaebf1; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_piloto_id_5edaebf1 ON public.viaje_autobus USING btree (piloto_id);


--
-- TOC entry 3371 (class 1259 OID 24997)
-- Name: viaje_autobus_ruta_id_fa1dd689; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX viaje_autobus_ruta_id_fa1dd689 ON public.viaje_autobus USING btree (ruta_id);


--
-- TOC entry 3384 (class 2606 OID 24938)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_autobus_id_64395eef_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_autobus_id_64395eef_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3385 (class 2606 OID 24943)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_piloto_id_fd84a333_fk_piloto_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_piloto_id_fd84a333_fk_piloto_id FOREIGN KEY (piloto_id) REFERENCES public.piloto(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3386 (class 2606 OID 24948)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_ruta_id_0cef946c_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_ruta_id_0cef946c_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3380 (class 2606 OID 24911)
-- Name: autobus autobus_empresa_id_0ae4a3fe_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_empresa_id_0ae4a3fe_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3383 (class 2606 OID 24932)
-- Name: parada parada_ruta_id_4defedba_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.parada
    ADD CONSTRAINT parada_ruta_id_4defedba_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3381 (class 2606 OID 24919)
-- Name: piloto piloto_empresa_id_7f76b4b8_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT piloto_empresa_id_7f76b4b8_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3394 (class 2606 OID 24998)
-- Name: posicion_autobus posicion_autobus_autobus_id_0b447cd8_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_autobus_id_0b447cd8_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3395 (class 2606 OID 25003)
-- Name: posicion_autobus posicion_autobus_viaje_id_c2712f5b_fk_viaje_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_viaje_id_c2712f5b_fk_viaje_autobus_id FOREIGN KEY (viaje_id) REFERENCES public.viaje_autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3382 (class 2606 OID 24925)
-- Name: ruta ruta_empresa_id_5e57d76a_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_empresa_id_5e57d76a_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3387 (class 2606 OID 24956)
-- Name: ruta_geopunto ruta_geopunto_ruta_id_14d38479_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_ruta_id_14d38479_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3388 (class 2606 OID 24962)
-- Name: viaje_autobus viaje_autobus_asignacion_id_094b4304_fk_asignacio; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_asignacion_id_094b4304_fk_asignacio FOREIGN KEY (asignacion_id) REFERENCES public.asignacion_autobus_ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3389 (class 2606 OID 24967)
-- Name: viaje_autobus viaje_autobus_autobus_id_0d859c06_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_autobus_id_0d859c06_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3390 (class 2606 OID 24972)
-- Name: viaje_autobus viaje_autobus_parada_fin_id_5655796e_fk_parada_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_parada_fin_id_5655796e_fk_parada_id FOREIGN KEY (parada_fin_id) REFERENCES public.parada(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3391 (class 2606 OID 24977)
-- Name: viaje_autobus viaje_autobus_parada_inicio_id_ebdbd2cc_fk_parada_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_parada_inicio_id_ebdbd2cc_fk_parada_id FOREIGN KEY (parada_inicio_id) REFERENCES public.parada(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3392 (class 2606 OID 24982)
-- Name: viaje_autobus viaje_autobus_piloto_id_5edaebf1_fk_piloto_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_piloto_id_5edaebf1_fk_piloto_id FOREIGN KEY (piloto_id) REFERENCES public.piloto(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3393 (class 2606 OID 24987)
-- Name: viaje_autobus viaje_autobus_ruta_id_fa1dd689_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_ruta_id_fa1dd689_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-10-26 11:17:25 CST

--
-- PostgreSQL database dump complete
--

