--
-- PostgreSQL database cluster dump
--

-- Started on 2025-10-26 11:17:26 CST

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Drop databases (except postgres and template1)
--

DROP DATABASE appdb;
DROP DATABASE eventos_trafico;
DROP DATABASE rutas_viajes;




--
-- Drop roles
--

DROP ROLE admin_user;


--
-- Roles
--

CREATE ROLE admin_user;
ALTER ROLE admin_user WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS PASSWORD 'SCRAM-SHA-256$4096:rLbyfP2uDblwE2PM251NDg==$M1uhbm1DHuNdivFg5PFfxdRE0PUX7YfJwaYr45O60FY=:HfIxU8gUkHQBN3MxXeEsBBbsxdXy8hYqJRuY+NN2UZ8=';

--
-- User Configurations
--








--
-- Databases
--

--
-- Database "template1" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:26 CST

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

UPDATE pg_catalog.pg_database SET datistemplate = false WHERE datname = 'template1';
DROP DATABASE template1;
--
-- TOC entry 3389 (class 1262 OID 1)
-- Name: template1; Type: DATABASE; Schema: -; Owner: admin_user
--

CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE template1 OWNER TO admin_user;

\connect template1

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

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 3389
-- Name: DATABASE template1; Type: COMMENT; Schema: -; Owner: admin_user
--

COMMENT ON DATABASE template1 IS 'default template for new databases';


--
-- TOC entry 3392 (class 0 OID 0)
-- Name: template1; Type: DATABASE PROPERTIES; Schema: -; Owner: admin_user
--

ALTER DATABASE template1 IS_TEMPLATE = true;


\connect template1

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

--
-- TOC entry 3391 (class 0 OID 0)
-- Dependencies: 3389
-- Name: DATABASE template1; Type: ACL; Schema: -; Owner: admin_user
--

REVOKE CONNECT,TEMPORARY ON DATABASE template1 FROM PUBLIC;
GRANT CONNECT ON DATABASE template1 TO PUBLIC;


-- Completed on 2025-10-26 11:17:26 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "appdb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:26 CST

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

--
-- TOC entry 4887 (class 1262 OID 16384)
-- Name: appdb; Type: DATABASE; Schema: -; Owner: admin_user
--

CREATE DATABASE appdb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE appdb OWNER TO admin_user;

\connect appdb

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

--
-- TOC entry 4888 (class 0 OID 0)
-- Name: appdb; Type: DATABASE PROPERTIES; Schema: -; Owner: admin_user
--

ALTER DATABASE appdb SET search_path TO '$user', 'public', 'topology', 'tiger';


\connect appdb

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

--
-- TOC entry 13 (class 2615 OID 26265)
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: admin_user
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO admin_user;

--
-- TOC entry 14 (class 2615 OID 26521)
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: admin_user
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO admin_user;

--
-- TOC entry 12 (class 2615 OID 26086)
-- Name: topology; Type: SCHEMA; Schema: -; Owner: admin_user
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO admin_user;

--
-- TOC entry 4889 (class 0 OID 0)
-- Dependencies: 12
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: admin_user
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- TOC entry 6 (class 3079 OID 26253)
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- TOC entry 4890 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- TOC entry 3 (class 3079 OID 16396)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 4891 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 4 (class 3079 OID 25010)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4892 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- TOC entry 7 (class 3079 OID 26266)
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- TOC entry 4893 (class 0 OID 0)
-- Dependencies: 7
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- TOC entry 5 (class 3079 OID 26087)
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- TOC entry 4894 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


--
-- TOC entry 2 (class 3079 OID 16385)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- TOC entry 4895 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 231 (class 1259 OID 16460)
-- Name: auth_group; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


ALTER TABLE public.auth_group OWNER TO admin_user;

--
-- TOC entry 230 (class 1259 OID 16459)
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 16468)
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_group_permissions OWNER TO admin_user;

--
-- TOC entry 232 (class 1259 OID 16467)
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 229 (class 1259 OID 16454)
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE public.auth_permission OWNER TO admin_user;

--
-- TOC entry 228 (class 1259 OID 16453)
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 235 (class 1259 OID 16474)
-- Name: auth_user; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE public.auth_user OWNER TO admin_user;

--
-- TOC entry 237 (class 1259 OID 16482)
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE public.auth_user_groups OWNER TO admin_user;

--
-- TOC entry 236 (class 1259 OID 16481)
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 234 (class 1259 OID 16473)
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 239 (class 1259 OID 16488)
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE public.auth_user_user_permissions OWNER TO admin_user;

--
-- TOC entry 238 (class 1259 OID 16487)
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 16546)
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE public.django_admin_log OWNER TO admin_user;

--
-- TOC entry 240 (class 1259 OID 16545)
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 16446)
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE public.django_content_type OWNER TO admin_user;

--
-- TOC entry 226 (class 1259 OID 16445)
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 16438)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO admin_user;

--
-- TOC entry 224 (class 1259 OID 16437)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- TOC entry 242 (class 1259 OID 16574)
-- Name: django_session; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE public.django_session OWNER TO admin_user;

--
-- TOC entry 4870 (class 0 OID 16460)
-- Dependencies: 231
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- TOC entry 4872 (class 0 OID 16468)
-- Dependencies: 233
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- TOC entry 4868 (class 0 OID 16454)
-- Dependencies: 229
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Evento de Tráfico	7	add_eventotrafico
26	Can change Evento de Tráfico	7	change_eventotrafico
27	Can delete Evento de Tráfico	7	delete_eventotrafico
28	Can view Evento de Tráfico	7	view_eventotrafico
29	Can add Estado de Evento	8	add_estadoevento
30	Can change Estado de Evento	8	change_estadoevento
31	Can delete Estado de Evento	8	delete_estadoevento
32	Can view Estado de Evento	8	view_estadoevento
33	Can add Nivel de Gravedad	9	add_nivelgravedad
34	Can change Nivel de Gravedad	9	change_nivelgravedad
35	Can delete Nivel de Gravedad	9	delete_nivelgravedad
36	Can view Nivel de Gravedad	9	view_nivelgravedad
37	Can add Tipo de Evento	10	add_tipoevento
38	Can change Tipo de Evento	10	change_tipoevento
39	Can delete Tipo de Evento	10	delete_tipoevento
40	Can view Tipo de Evento	10	view_tipoevento
41	Can add Ruta Afectada por Evento	11	add_eventorutaafectada
42	Can change Ruta Afectada por Evento	11	change_eventorutaafectada
43	Can delete Ruta Afectada por Evento	11	delete_eventorutaafectada
44	Can view Ruta Afectada por Evento	11	view_eventorutaafectada
45	Can add Empresa de Transporte	12	add_empresatransporte
46	Can change Empresa de Transporte	12	change_empresatransporte
47	Can delete Empresa de Transporte	12	delete_empresatransporte
48	Can view Empresa de Transporte	12	view_empresatransporte
49	Can add Autobús	13	add_autobus
50	Can change Autobús	13	change_autobus
51	Can delete Autobús	13	delete_autobus
52	Can view Autobús	13	view_autobus
53	Can add Piloto	14	add_piloto
54	Can change Piloto	14	change_piloto
55	Can delete Piloto	14	delete_piloto
56	Can view Piloto	14	view_piloto
57	Can add Ruta	15	add_ruta
58	Can change Ruta	15	change_ruta
59	Can delete Ruta	15	delete_ruta
60	Can view Ruta	15	view_ruta
61	Can add Parada	16	add_parada
62	Can change Parada	16	change_parada
63	Can delete Parada	16	delete_parada
64	Can view Parada	16	view_parada
65	Can add Asignación Autobús-Ruta	17	add_asignacionautobusruta
66	Can change Asignación Autobús-Ruta	17	change_asignacionautobusruta
67	Can delete Asignación Autobús-Ruta	17	delete_asignacionautobusruta
68	Can view Asignación Autobús-Ruta	17	view_asignacionautobusruta
69	Can add Punto Geográfico de Ruta	18	add_rutageopunto
70	Can change Punto Geográfico de Ruta	18	change_rutageopunto
71	Can delete Punto Geográfico de Ruta	18	delete_rutageopunto
72	Can view Punto Geográfico de Ruta	18	view_rutageopunto
73	Can add Viaje de Autobús	19	add_viajeautobus
74	Can change Viaje de Autobús	19	change_viajeautobus
75	Can delete Viaje de Autobús	19	delete_viajeautobus
76	Can view Viaje de Autobús	19	view_viajeautobus
77	Can add Posición de Autobús	20	add_posicionautobus
78	Can change Posición de Autobús	20	change_posicionautobus
79	Can delete Posición de Autobús	20	delete_posicionautobus
80	Can view Posición de Autobús	20	view_posicionautobus
\.


--
-- TOC entry 4874 (class 0 OID 16474)
-- Dependencies: 235
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
2	pbkdf2_sha256$1000000$z2IYKegENsRiiiOADHkVka$VARHlFKkr6NvGCVQNak39Xl1ZVLQVOrZ9t5zgioX/9A=	\N	f	testuser			test@test.com	f	t	2025-10-25 13:28:27.204024-06
3	pbkdf2_sha256$720000$s2q3NNv4jDmbIzFYJF6zSj$+H4G+TW9IjRMeDoKGVQmEvwUv0SDw/4lP/5WmqWDycg=	\N	f	test1			testuser@examp.net	f	t	2025-10-25 21:03:30.234911-06
4	pbkdf2_sha256$720000$wRuYjOcT9ZOAJIEUkxrK6L$7oQVJoMYUuHkFZcEDvQolOcrMTHhIyn21mb7Poj0YTs=	\N	f	nuevousuario2024			nuevo@example.com	f	t	2025-10-25 21:06:47.74079-06
5	pbkdf2_sha256$720000$a8DUR5WvQJTPTuDG4PP1YE$BsyAhY48HVq1cjdP4vN6+vdviz9OA5P1WF8q6qF6WW0=	\N	f	usuariotest123			test123@example.com	f	t	2025-10-25 21:08:10.453324-06
6	pbkdf2_sha256$720000$lNpGTn4HxKlD7cD8FxGmfa$BpGXRzL016WrlEYxOMBdRKAmBr8/+ee+Ki5tTU7+4sg=	\N	f	alexuceda			alex.uceda@hotmail.com	f	t	2025-10-25 21:16:20.847277-06
7	pbkdf2_sha256$720000$D1qDkZhX0tHRXENeddCoS4$b7arrJU7py11j5ZVtDrKw+yW01djv8X83v7g8IX4i7w=	\N	f	usuario_prueba			prueba@example.com	f	t	2025-10-25 21:28:10.211391-06
1	pbkdf2_sha256$720000$WCaDb7zQrUQVycisOnUlBT$AJ6LttIa62HROL3/xSyosg71X0nmvOsvg0/BphRZb9A=	2025-10-25 11:11:14.709604-06	t	admin	Admin	MOP	admin@mop.com	t	t	2025-10-25 09:02:51.511666-06
8	pbkdf2_sha256$720000$v09P5G1ujZ4QJBvFGV97Gm$4QCNeq3qFRGyro7VoO7pMWjDYjckXxTHs2P4dPv1eLU=	\N	f	frontend_user			frontend@mop.com	f	t	2025-10-26 08:27:01.064463-06
9	pbkdf2_sha256$720000$WHE94SujQs7JzckzLzIj2z$9MXj0d4k5Ow2d0yJdr3WuDNoOno5C6rJTuqdVmlDnUY=	\N	f	admin2			alex.uceda@gmail.com	f	t	2025-10-26 09:23:26.428215-06
\.


--
-- TOC entry 4876 (class 0 OID 16482)
-- Dependencies: 237
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- TOC entry 4878 (class 0 OID 16488)
-- Dependencies: 239
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	1	4
5	1	5
6	1	6
7	1	7
8	1	8
9	1	9
10	1	10
11	1	11
12	1	12
13	1	13
14	1	14
15	1	15
16	1	16
17	1	17
18	1	18
19	1	19
20	1	20
21	1	21
22	1	22
23	1	23
24	1	24
25	1	25
26	1	26
27	1	27
28	1	28
29	1	29
30	1	30
31	1	31
32	1	32
33	1	33
34	1	34
35	1	35
36	1	36
37	1	37
38	1	38
39	1	39
40	1	40
41	1	41
42	1	42
43	1	43
44	1	44
\.


--
-- TOC entry 4880 (class 0 OID 16546)
-- Dependencies: 241
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- TOC entry 4866 (class 0 OID 16446)
-- Dependencies: 227
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	microservicios_eventos	eventotrafico
8	microservicios_eventos	estadoevento
9	microservicios_eventos	nivelgravedad
10	microservicios_eventos	tipoevento
11	microservicios_eventos	eventorutaafectada
12	microservicios_rutas_viajes	empresatransporte
13	microservicios_rutas_viajes	autobus
14	microservicios_rutas_viajes	piloto
15	microservicios_rutas_viajes	ruta
16	microservicios_rutas_viajes	parada
17	microservicios_rutas_viajes	asignacionautobusruta
18	microservicios_rutas_viajes	rutageopunto
19	microservicios_rutas_viajes	viajeautobus
20	microservicios_rutas_viajes	posicionautobus
\.


--
-- TOC entry 4864 (class 0 OID 16438)
-- Dependencies: 225
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2025-10-24 22:34:20.959134-06
2	auth	0001_initial	2025-10-24 22:34:21.054279-06
3	admin	0001_initial	2025-10-24 22:34:21.078021-06
4	admin	0002_logentry_remove_auto_add	2025-10-24 22:34:21.08564-06
5	admin	0003_logentry_add_action_flag_choices	2025-10-24 22:34:21.093127-06
6	contenttypes	0002_remove_content_type_name	2025-10-24 22:34:21.110423-06
7	auth	0002_alter_permission_name_max_length	2025-10-24 22:34:21.13591-06
8	auth	0003_alter_user_email_max_length	2025-10-24 22:34:21.144321-06
9	auth	0004_alter_user_username_opts	2025-10-24 22:34:21.151513-06
10	auth	0005_alter_user_last_login_null	2025-10-24 22:34:21.164092-06
11	auth	0006_require_contenttypes_0002	2025-10-24 22:34:21.165864-06
12	auth	0007_alter_validators_add_error_messages	2025-10-24 22:34:21.173091-06
13	auth	0008_alter_user_username_max_length	2025-10-24 22:34:21.187996-06
14	auth	0009_alter_user_last_name_max_length	2025-10-24 22:34:21.19714-06
15	auth	0010_alter_group_name_max_length	2025-10-24 22:34:21.207301-06
16	auth	0011_update_proxy_permissions	2025-10-24 22:34:21.2152-06
17	auth	0012_alter_user_first_name_max_length	2025-10-24 22:34:21.222331-06
18	sessions	0001_initial	2025-10-24 22:34:21.234608-06
19	microservicios_eventos	0001_initial	2025-10-25 09:03:33.730024-06
20	microservicios_rutas_viajes	0001_initial	2025-10-25 17:46:29.832505-06
21	microservicios_eventos	0002_change_user_id_to_integer	2025-10-25 22:21:44.520991-06
22	microservicios_eventos	0003_alter_eventorutaafectada_ruta_id_externo_and_more	2025-10-25 22:32:42.33918-06
23	microservicios_eventos	0004_eventotrafico_area_afectacion_and_more	2025-10-26 08:01:02.760674-06
24	microservicios_eventos	0005_increase_coordinate_precision	2025-10-26 08:26:11.070828-06
\.


--
-- TOC entry 4881 (class 0 OID 16574)
-- Dependencies: 242
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- TOC entry 4622 (class 0 OID 25328)
-- Dependencies: 244
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 4626 (class 0 OID 26272)
-- Dependencies: 255
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: admin_user
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- TOC entry 4627 (class 0 OID 26604)
-- Dependencies: 300
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: admin_user
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4628 (class 0 OID 26614)
-- Dependencies: 302
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: admin_user
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- TOC entry 4629 (class 0 OID 26624)
-- Dependencies: 304
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: admin_user
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- TOC entry 4624 (class 0 OID 26089)
-- Dependencies: 249
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: admin_user
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- TOC entry 4625 (class 0 OID 26101)
-- Dependencies: 250
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: admin_user
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- TOC entry 4896 (class 0 OID 0)
-- Dependencies: 230
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- TOC entry 4897 (class 0 OID 0)
-- Dependencies: 232
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- TOC entry 4898 (class 0 OID 0)
-- Dependencies: 228
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 80, true);


--
-- TOC entry 4899 (class 0 OID 0)
-- Dependencies: 236
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- TOC entry 4900 (class 0 OID 0)
-- Dependencies: 234
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 9, true);


--
-- TOC entry 4901 (class 0 OID 0)
-- Dependencies: 238
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 44, true);


--
-- TOC entry 4902 (class 0 OID 0)
-- Dependencies: 240
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- TOC entry 4903 (class 0 OID 0)
-- Dependencies: 226
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 20, true);


--
-- TOC entry 4904 (class 0 OID 0)
-- Dependencies: 224
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- TOC entry 4905 (class 0 OID 0)
-- Dependencies: 248
-- Name: topology_id_seq; Type: SEQUENCE SET; Schema: topology; Owner: admin_user
--

SELECT pg_catalog.setval('topology.topology_id_seq', 1, false);


--
-- TOC entry 4654 (class 2606 OID 16572)
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- TOC entry 4659 (class 2606 OID 16503)
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- TOC entry 4662 (class 2606 OID 16472)
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4656 (class 2606 OID 16464)
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- TOC entry 4649 (class 2606 OID 16494)
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- TOC entry 4651 (class 2606 OID 16458)
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- TOC entry 4670 (class 2606 OID 16486)
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- TOC entry 4673 (class 2606 OID 16518)
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- TOC entry 4664 (class 2606 OID 16478)
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- TOC entry 4676 (class 2606 OID 16492)
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 4679 (class 2606 OID 16532)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- TOC entry 4667 (class 2606 OID 16567)
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- TOC entry 4682 (class 2606 OID 16553)
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- TOC entry 4644 (class 2606 OID 16452)
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- TOC entry 4646 (class 2606 OID 16450)
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- TOC entry 4642 (class 2606 OID 16444)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4686 (class 2606 OID 16580)
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- TOC entry 4652 (class 1259 OID 16573)
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- TOC entry 4657 (class 1259 OID 16514)
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- TOC entry 4660 (class 1259 OID 16515)
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- TOC entry 4647 (class 1259 OID 16500)
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- TOC entry 4668 (class 1259 OID 16530)
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- TOC entry 4671 (class 1259 OID 16529)
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- TOC entry 4674 (class 1259 OID 16544)
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- TOC entry 4677 (class 1259 OID 16543)
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- TOC entry 4665 (class 1259 OID 16568)
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- TOC entry 4680 (class 1259 OID 16564)
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- TOC entry 4683 (class 1259 OID 16565)
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- TOC entry 4684 (class 1259 OID 16582)
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- TOC entry 4687 (class 1259 OID 16581)
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- TOC entry 4707 (class 2606 OID 16509)
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4708 (class 2606 OID 16504)
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4706 (class 2606 OID 16495)
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4709 (class 2606 OID 16524)
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4710 (class 2606 OID 16519)
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4711 (class 2606 OID 16538)
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4712 (class 2606 OID 16533)
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4713 (class 2606 OID 16554)
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4714 (class 2606 OID 16559)
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-10-26 11:17:26 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "eventos_trafico" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:26 CST

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

--
-- TOC entry 4417 (class 1262 OID 24629)
-- Name: eventos_trafico; Type: DATABASE; Schema: -; Owner: admin_user
--

CREATE DATABASE eventos_trafico WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE eventos_trafico OWNER TO admin_user;

\connect eventos_trafico

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

--
-- TOC entry 2 (class 3079 OID 26677)
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24631)
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO admin_user;

--
-- TOC entry 216 (class 1259 OID 24630)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- TOC entry 219 (class 1259 OID 24709)
-- Name: estado_evento; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.estado_evento (
    id smallint NOT NULL,
    codigo character varying(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL
);


ALTER TABLE public.estado_evento OWNER TO admin_user;

--
-- TOC entry 218 (class 1259 OID 24708)
-- Name: estado_evento_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.estado_evento ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.estado_evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 227 (class 1259 OID 24743)
-- Name: evento_ruta_afectada; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.evento_ruta_afectada (
    id bigint NOT NULL,
    sistema_origen character varying(32) NOT NULL,
    ruta_id_externo integer NOT NULL,
    ruta_codigo character varying(32),
    ruta_nombre character varying(120),
    relevancia character varying(16) NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    evento_id bigint NOT NULL
);


ALTER TABLE public.evento_ruta_afectada OWNER TO admin_user;

--
-- TOC entry 226 (class 1259 OID 24742)
-- Name: evento_ruta_afectada_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.evento_ruta_afectada ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.evento_ruta_afectada_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 225 (class 1259 OID 24735)
-- Name: evento_trafico; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.evento_trafico (
    id bigint NOT NULL,
    titulo character varying(140) NOT NULL,
    descripcion text NOT NULL,
    latitud numeric(12,9),
    longitud numeric(12,9),
    radio_metros integer NOT NULL,
    fecha_ocurrencia timestamp with time zone NOT NULL,
    fecha_reporte timestamp with time zone NOT NULL,
    expira_en timestamp with time zone,
    viaje_id_externo integer,
    viaje_sistema_origen character varying(32),
    vehiculo_id_externo integer,
    conductor_id_externo integer,
    correlacion_id uuid,
    creado_por_id_externo integer,
    creado_por_username character varying(150),
    actualizado_por_id_externo integer,
    actualizado_por_username character varying(150),
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL,
    eliminado_en timestamp with time zone,
    estado_id smallint NOT NULL,
    gravedad_id smallint NOT NULL,
    tipo_id smallint NOT NULL,
    area_afectacion public.geometry(Geometry,4326),
    ubicacion public.geometry(Point,4326)
);


ALTER TABLE public.evento_trafico OWNER TO admin_user;

--
-- TOC entry 224 (class 1259 OID 24734)
-- Name: evento_trafico_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.evento_trafico ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.evento_trafico_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 24717)
-- Name: nivel_gravedad; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.nivel_gravedad (
    id smallint NOT NULL,
    codigo character varying(16) NOT NULL,
    nombre character varying(32) NOT NULL,
    orden smallint NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL
);


ALTER TABLE public.nivel_gravedad OWNER TO admin_user;

--
-- TOC entry 220 (class 1259 OID 24716)
-- Name: nivel_gravedad_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.nivel_gravedad ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.nivel_gravedad_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 223 (class 1259 OID 24725)
-- Name: tipo_evento; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.tipo_evento (
    id smallint NOT NULL,
    codigo character varying(32) NOT NULL,
    nombre character varying(64) NOT NULL,
    descripcion text NOT NULL,
    activo boolean NOT NULL,
    creado_en timestamp with time zone NOT NULL,
    actualizado_en timestamp with time zone NOT NULL
);


ALTER TABLE public.tipo_evento OWNER TO admin_user;

--
-- TOC entry 222 (class 1259 OID 24724)
-- Name: tipo_evento_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
--

ALTER TABLE public.tipo_evento ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.tipo_evento_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4401 (class 0 OID 24631)
-- Dependencies: 217
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
2	contenttypes	0001_initial	2025-10-25 09:29:14.585442-06
3	auth	0001_initial	2025-10-25 09:29:14.594396-06
4	admin	0001_initial	2025-10-25 11:14:34.547197-06
5	admin	0002_logentry_remove_auto_add	2025-10-25 11:14:34.559423-06
6	admin	0003_logentry_add_action_flag_choices	2025-10-25 11:14:34.568925-06
7	contenttypes	0002_remove_content_type_name	2025-10-25 11:14:34.583161-06
8	auth	0002_alter_permission_name_max_length	2025-10-25 11:14:34.593903-06
9	auth	0003_alter_user_email_max_length	2025-10-25 11:14:34.606084-06
10	auth	0004_alter_user_username_opts	2025-10-25 11:14:34.618027-06
11	auth	0005_alter_user_last_login_null	2025-10-25 11:14:34.635216-06
12	auth	0006_require_contenttypes_0002	2025-10-25 11:14:34.63786-06
13	auth	0007_alter_validators_add_error_messages	2025-10-25 11:14:34.650183-06
14	auth	0008_alter_user_username_max_length	2025-10-25 11:14:34.658431-06
15	auth	0009_alter_user_last_name_max_length	2025-10-25 11:14:34.667059-06
16	auth	0010_alter_group_name_max_length	2025-10-25 11:14:34.67879-06
17	auth	0011_update_proxy_permissions	2025-10-25 11:14:34.682131-06
18	auth	0012_alter_user_first_name_max_length	2025-10-25 11:14:34.690198-06
19	microservicios_eventos	0001_initial	2025-10-25 11:14:34.895843-06
20	sessions	0001_initial	2025-10-25 11:14:34.898861-06
21	microservicios_eventos	0002_change_user_id_to_integer	2025-10-26 08:04:44.029283-06
22	microservicios_eventos	0003_alter_eventorutaafectada_ruta_id_externo_and_more	2025-10-26 08:10:41.01732-06
23	microservicios_eventos	0004_eventotrafico_area_afectacion_and_more	2025-10-26 08:10:48.512486-06
24	microservicios_eventos	0005_increase_coordinate_precision	2025-10-26 08:26:21.005551-06
\.


--
-- TOC entry 4403 (class 0 OID 24709)
-- Dependencies: 219
-- Data for Name: estado_evento; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.estado_evento (id, codigo, nombre, creado_en, actualizado_en) FROM stdin;
1	001	Planificado	2025-10-25 11:18:25.667905-06	2025-10-25 11:18:25.668145-06
2	002	Activo	2025-10-25 11:18:40.153133-06	2025-10-25 11:18:40.153431-06
3	003	Finalizado	2025-10-25 11:19:07.759886-06	2025-10-25 11:19:07.760186-06
4	004	Inactivo	2025-10-25 13:33:04.069384-06	2025-10-25 13:33:04.069569-06
7	ACTIVO	Activo	2025-10-26 08:03:15.168864-06	2025-10-26 08:03:15.169095-06
\.


--
-- TOC entry 4411 (class 0 OID 24743)
-- Dependencies: 227
-- Data for Name: evento_ruta_afectada; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.evento_ruta_afectada (id, sistema_origen, ruta_id_externo, ruta_codigo, ruta_nombre, relevancia, creado_en, actualizado_en, evento_id) FROM stdin;
\.


--
-- TOC entry 4409 (class 0 OID 24735)
-- Dependencies: 225
-- Data for Name: evento_trafico; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.evento_trafico (id, titulo, descripcion, latitud, longitud, radio_metros, fecha_ocurrencia, fecha_reporte, expira_en, viaje_id_externo, viaje_sistema_origen, vehiculo_id_externo, conductor_id_externo, correlacion_id, creado_por_id_externo, creado_por_username, actualizado_por_id_externo, actualizado_por_username, creado_en, actualizado_en, eliminado_en, estado_id, gravedad_id, tipo_id, area_afectacion, ubicacion) FROM stdin;
7	Accidente en Bulevar Constitución	Colisión entre dos vehículos bloquea carril derecho	13.703300000	-89.218200000	200	2025-10-26 08:11:18.107199-06	2025-10-26 08:11:18.107202-06	\N	\N	\N	\N	\N	bd8a3657-47bb-4bb2-b1e5-62a96ee722ce	\N	\N	\N	\N	2025-10-26 08:11:18.107461-06	2025-10-26 08:11:18.108841-06	\N	7	13	7	0103000020E610000001000000210000000C708D8DD94D56C0B98D06F016682B40BDB7581EDA4D56C00B4613FFE8672B4042152ACBDB4D56C0A57917D2BC672B40DFD98683DE4D56C05038AC1B94672B40C540AC2CE24D56C0709A586C70672B4081B496A2E64D56C044632D2353672B40AB1C64B9EB4D56C05B3E47603D672B403896033FF14D56C02E52BCF92F672B402EFF21FDF64D56C0AB1462732B672B40246840BBFC4D56C02E52BCF92F672B40B1E1DF40024E56C05B3E47603D672B40DB49AD57074E56C044632D2353672B4097BD97CD0B4E56C0709A586C70672B407D24BD760F4E56C05038AC1B94672B401AE9192F124E56C0A57917D2BC672B409F46EBDB134E56C00B4613FFE8672B40508EB66C144E56C0B98D06F016682B409F46EBDB134E56C067D5F9E044682B401AE9192F124E56C0CDA1F50D71682B407D24BD760F4E56C022E360C499682B4097BD97CD0B4E56C00281B473BD682B40DB49AD57074E56C02EB8DFBCDA682B40B1E1DF40024E56C017DDC57FF0682B40246840BBFC4D56C044C950E6FD682B402EFF21FDF64D56C0C706AB6C02692B403896033FF14D56C044C950E6FD682B40AB1C64B9EB4D56C017DDC57FF0682B4081B496A2E64D56C02EB8DFBCDA682B40C540AC2CE24D56C00281B473BD682B40DFD98683DE4D56C022E360C499682B4042152ACBDB4D56C0CDA1F50D71682B40BDB7581EDA4D56C067D5F9E044682B400C708D8DD94D56C0B98D06F016682B40	0101000020E61000002EFF21FDF64D56C0B98D06F016682B40
8	Congestión en Autopista a Santa Ana	Tráfico lento por obras en la vía	13.994400000	-89.558600000	500	2025-10-26 08:11:18.130766-06	2025-10-26 08:11:18.130771-06	\N	\N	\N	\N	\N	5670b037-2598-40dd-9d9c-99f298932b47	\N	\N	\N	\N	2025-10-26 08:11:18.130902-06	2025-10-26 08:11:18.131729-06	\N	7	5	8	0103000020E61000000100000021000000177D4383766356C0E9482EFF21FD2B4050B03FED776356C0B515CE24AFFC2B401E1A4B1D7C6356C0B69658B440FC2B40A60533EA826356C062734CECDAFB2B40E48610118C6356C0B368FBB581FB2B403AA8DA37976356C0C35E0F7F38FB2B40A52CDCF0A36356C07F02D01702FB2B4084DCEABEB16356C00DB47497E0FA2B40EBE2361AC06356C0461A9347D5FA2B4052E98275CE6356C00DB47497E0FA2B4031999143DC6356C07F02D01702FB2B409C1D93FCE86356C0C35E0F7F38FB2B40F23E5D23F46356C0B368FBB581FB2B4030C03A4AFD6356C062734CECDAFB2B40B8AB2217046456C0B69658B440FC2B4086152E47086456C0B515CE24AFFC2B40BF482AB1096456C0E9482EFF21FD2B4086152E47086456C01D7C8ED994FD2B40B8AB2217046456C01CFB034A03FE2B4030C03A4AFD6356C0701E101269FE2B40F23E5D23F46356C01F296148C2FE2B409C1D93FCE86356C00F334D7F0BFF2B4031999143DC6356C0538F8CE641FF2B4052E98275CE6356C0C5DDE76663FF2B40EBE2361AC06356C08C77C9B66EFF2B4084DCEABEB16356C0C5DDE76663FF2B40A52CDCF0A36356C0538F8CE641FF2B403AA8DA37976356C00F334D7F0BFF2B40E48610118C6356C01F296148C2FE2B40A60533EA826356C0701E101269FE2B401E1A4B1D7C6356C01CFB034A03FE2B4050B03FED776356C01D7C8ED994FD2B40177D4383766356C0E9482EFF21FD2B40	0101000020E6100000EBE2361AC06356C0E9482EFF21FD2B40
9	Accidente en Carretera Panamericana	Vuelco de camión cerca de La Libertad	13.488900000	-89.322200000	300	2025-10-26 08:11:18.133651-06	2025-10-26 08:11:18.133655-06	\N	\N	\N	\N	\N	1e7c8edf-b2d4-4ff3-b2ea-f5a4c00760ca	\N	\N	\N	\N	2025-10-26 08:11:18.133771-06	2025-10-26 08:11:18.134331-06	\N	7	13	7	0103000020E61000000100000021000000A8DA60C5725456C05F07CE1951FA2A4031C6919E735456C0D91B61300CFA2A4079D2CB21765456C04069E7ECC9F92A4065F956367A5456C0418746DB8CF92A40BD130FB47F5456C0721A495457F92A4057C1EE64865456C0AF4788662BF92A4097DD22078E5456C052102FC20AF92A40EA13924F965456C00EAE5EA8F6F82A405BB1BFEC9E5456C0CA51D7DEEFF82A40CC4EED89A75456C00EAE5EA8F6F82A401F855CD2AF5456C052102FC20AF92A405FA19074B75456C0AF4788662BF92A40F94E7025BE5456C0721A495457F92A40516928A3C35456C0418746DB8CF92A403D90B3B7C75456C04069E7ECC9F92A40859CED3ACA5456C0D91B61300CFA2A400E881E14CB5456C05F07CE1951FA2A40859CED3ACA5456C0E5F23A0396FA2A403D90B3B7C75456C07EA5B446D8FA2A40516928A3C35456C07D87555815FB2A40F94E7025BE5456C04CF452DF4AFB2A405FA19074B75456C00FC713CD76FB2A401F855CD2AF5456C06CFE6C7197FB2A40CC4EED89A75456C0B0603D8BABFB2A405BB1BFEC9E5456C0F4BCC454B2FB2A40EA13924F965456C0B0603D8BABFB2A4097DD22078E5456C06CFE6C7197FB2A4057C1EE64865456C00FC713CD76FB2A40BD130FB47F5456C04CF452DF4AFB2A4065F956367A5456C07D87555815FB2A4079D2CB21765456C07EA5B446D8FA2A4031C6919E735456C0E5F23A0396FA2A40A8DA60C5725456C05F07CE1951FA2A40	0101000020E61000005BB1BFEC9E5456C05F07CE1951FA2A40
10	Obra en Boulevard de los Héroes	Mantenimiento de alcantarillado - carril cerrado	13.711500000	-89.207400000	150	2025-10-26 08:12:01.299966-06	2025-10-26 08:12:01.299972-06	\N	\N	\N	\N	\N	3fc60036-b7dc-45e9-a27e-7d446474a143	\N	\N	\N	\N	2025-10-26 08:12:01.300404-06	2025-10-26 08:12:01.302184-06	\N	7	2	9	0103000020E61000000100000021000000D7E0F6F62F4D56C03F355EBA496C2B409B568F63304D56C07CBFA745276C2B40BF5C2CA5314D56C030E6EA23066C2B4035F071AF334D56C030751A9BE76B2B4061FD4D6E364D56C0C9BE9BD7CC6B2B402ED4BDC6394D56C06755BBE0B66B2B404EE2D7973D4D56C0B9B98E8EA66B2B40787D0FBC414D56C09788A6819C6B2B40304CA60A464D56C074DAE21C996B2B40E81A3D594A4D56C09788A6819C6B2B4012B6747D4E4D56C0B9B98E8EA66B2B4032C48E4E524D56C06755BBE0B66B2B40FF9AFEA6554D56C0C9BE9BD7CC6B2B402BA8DA65584D56C030751A9BE76B2B40A13B20705A4D56C030E6EA23066C2B40C541BDB15B4D56C07CBFA745276C2B4089B7551E5C4D56C03F355EBA496C2B40C541BDB15B4D56C002AB142F6C6C2B40A13B20705A4D56C04E84D1508D6C2B402BA8DA65584D56C04EF5A1D9AB6C2B40FF9AFEA6554D56C0B5AB209DC66C2B4032C48E4E524D56C017150194DC6C2B4012B6747D4E4D56C0C5B02DE6EC6C2B40E81A3D594A4D56C0E7E115F3F66C2B40304CA60A464D56C00A90D957FA6C2B40787D0FBC414D56C0E7E115F3F66C2B404EE2D7973D4D56C0C5B02DE6EC6C2B402ED4BDC6394D56C017150194DC6C2B4061FD4D6E364D56C0B5AB209DC66C2B4035F071AF334D56C04EF5A1D9AB6C2B40BF5C2CA5314D56C04E84D1508D6C2B409B568F63304D56C002AB142F6C6C2B40D7E0F6F62F4D56C03F355EBA496C2B40	0101000020E6100000304CA60A464D56C03F355EBA496C2B40
11	Accidente Fatal Autopista Comalapa	Accidente múltiple con heridos - vía completamente cerrada	13.583300000	-89.050000000	1000	2025-10-26 08:12:01.32076-06	2025-10-26 08:12:01.320765-06	\N	\N	\N	\N	\N	a0771cd7-dd01-4b52-8cad-399e70148bbf	\N	\N	\N	\N	2025-10-26 08:12:01.320917-06	2025-10-26 08:12:01.321653-06	\N	7	17	7	0103000020E610000001000000210000008A674C05A04256C07B832F4CA62A2B40FCCD44D9A24256C0131D6F97C0292B4098A15B39AB4256C0151F84B6E3282B40AA782BD3B84256C06ED86B2618282B40267BE620CB4256C010C3C9B965272B40D1BD7A6EE14256C030AFF14BD3262B40A6C67DE0FA4256C0A6F6727D66262B4066269B7C164356C0C459BC7C23262B4033333333334356C03526F9DC0C262B400040CBE94F4356C0C459BC7C23262B40C09FE8856B4356C0A6F6727D66262B4095A8EBF7844356C030AFF14BD3262B4040EB7F459B4356C010C3C9B965272B40BCED3A93AD4356C06ED86B2618282B40CEC40A2DBB4356C0151F84B6E3282B406A98218DC34356C0131D6F97C0292B40DCFE1961C64356C07B832F4CA62A2B406A98218DC34356C0E3E9EF008C2B2B40CEC40A2DBB4356C0E1E7DAE1682C2B40BCED3A93AD4356C0882EF371342D2B4040EB7F459B4356C0E64395DEE62D2B4095A8EBF7844356C0C6576D4C792E2B40C09FE8856B4356C05010EC1AE62E2B400040CBE94F4356C032ADA21B292F2B4033333333334356C0C1E065BB3F2F2B4066269B7C164356C032ADA21B292F2B40A6C67DE0FA4256C05010EC1AE62E2B40D1BD7A6EE14256C0C6576D4C792E2B40267BE620CB4256C0E64395DEE62D2B40AA782BD3B84256C0882EF371342D2B4098A15B39AB4256C0E1E7DAE1682C2B40FCCD44D9A24256C0E3E9EF008C2B2B408A674C05A04256C07B832F4CA62A2B40	0101000020E610000033333333334356C07B832F4CA62A2B40
12	Lluvia intensa zona San Miguel	Visibilidad reducida por lluvia fuerte	13.483300000	-88.183300000	2000	2025-10-26 08:12:01.323375-06	2025-10-26 08:12:01.323377-06	\N	\N	\N	\N	\N	8a88c6a8-bbcd-4afc-b59f-eefe3f94cef4	\N	\N	\N	\N	2025-10-26 08:12:01.323465-06	2025-10-26 08:12:01.324148-06	\N	7	18	10	0103000020E6100000010000002100000084BF1ED4940A56C04850FC1873F72A40688C0F7C9A0A56C078837BAFA7F52A40A1333D3CAB0A56C07B87A5EDEDF32A40C3E1DC6FC60A56C02EFA74CD56F22A40BBE6520BEB0A56C072CF30F4F1F02A40136C7BA6170B56C0B2A78018CDEF2A40BC7D818A4A0B56C09F36837BF3EE2A403C3DBCC2810B56C0D9FC157A6DEE2A40D656EC2FBB0B56C0BB958F3A40EE2A4070701C9DF40B56C0D9FC157A6DEE2A40F02F57D52B0C56C09F36837BF3EE2A4099415DB95E0C56C0B2A78018CDEF2A40F1C685548B0C56C072CF30F4F1F02A40E9CBFBEFAF0C56C02EFA74CD56F22A400B7A9B23CB0C56C07B87A5EDEDF32A404421C9E3DB0C56C078837BAFA7F52A4028EEB98BE10C56C04850FC1873F72A404421C9E3DB0C56C0181D7D823EF92A400B7A9B23CB0C56C015195344F8FA2A40E9CBFBEFAF0C56C062A683648FFC2A40F1C685548B0C56C01ED1C73DF4FD2A4099415DB95E0C56C0DEF8771919FF2A40F02F57D52B0C56C0F16975B6F2FF2A4070701C9DF40B56C0B7A3E2B778002B40D656EC2FBB0B56C0D50A69F7A5002B403C3DBCC2810B56C0B7A3E2B778002B40BC7D818A4A0B56C0F16975B6F2FF2A40136C7BA6170B56C0DEF8771919FF2A40BBE6520BEB0A56C01ED1C73DF4FD2A40C3E1DC6FC60A56C062A683648FFC2A40A1333D3CAB0A56C015195344F8FA2A40688C0F7C9A0A56C0181D7D823EF92A4084BF1ED4940A56C04850FC1873F72A40	0101000020E6100000D656EC2FBB0B56C04850FC1873F72A40
13	Congestión en CA-1 hacia Sonsonate	Tráfico pesado en hora pico	13.718600000	-89.723800000	800	2025-10-26 08:12:01.327044-06	2025-10-26 08:12:01.327049-06	\N	\N	\N	\N	\N	23c26963-a8c7-4a55-8486-80bdaad9f5d4	\N	\N	\N	\N	2025-10-26 08:12:01.327188-06	2025-10-26 08:12:01.328146-06	\N	7	2	8	0103000020E610000001000000210000008AF9E9FEDC6D56C0ABCFD556EC6F2B404B181742DF6D56C0F1B00893346F2B40628E5CF5E56D56C0597F19DF836E2B40D6A0CFD6F06D56C0077A6C05E16D2B406D3C657BFF6D56C088021E48526D2B405C0B0F53116E56C0D5257123DD6C2B4007AC44AE256E56C03492D817866C2B403A92C2C43B6E56C07FE1AC7D506C2B4011363CBD526E56C073EB43643E6C2B40E8D9B5B5696E56C07FE1AC7D506C2B401BC033CC7F6E56C03492D817866C2B40C6606927946E56C0D5257123DD6C2B40B52F13FFA56E56C088021E48526D2B404CCBA8A3B46E56C0077A6C05E16D2B40C0DD1B85BF6E56C0597F19DF836E2B40D7536138C66E56C0F1B00893346F2B4098728E7BC86E56C0ABCFD556EC6F2B40D7536138C66E56C065EEA21AA4702B40C0DD1B85BF6E56C0FD1F92CE54712B404CCBA8A3B46E56C04F253FA8F7712B40B52F13FFA56E56C0CE9C8D6586722B40C6606927946E56C081793A8AFB722B401BC033CC7F6E56C0220DD39552732B40E8D9B5B5696E56C0D7BDFE2F88732B4011363CBD526E56C0E3B367499A732B403A92C2C43B6E56C0D7BDFE2F88732B4007AC44AE256E56C0220DD39552732B405C0B0F53116E56C081793A8AFB722B406D3C657BFF6D56C0CE9C8D6586722B40D6A0CFD6F06D56C04F253FA8F7712B40628E5CF5E56D56C0FD1F92CE54712B404B181742DF6D56C065EEA21AA4702B408AF9E9FEDC6D56C0ABCFD556EC6F2B40	0101000020E610000011363CBD526E56C0ABCFD556EC6F2B40
14	Vehículo varado en CA-1 Este km 45	Camión averiado ocupa carril derecho hacia San Miguel	13.683300000	-88.916700000	150	2025-10-26 08:15:01.181929-06	2025-10-26 08:15:01.181932-06	\N	\N	\N	\N	\N	7ed6ae4a-e5f9-4ef9-bcd9-c6a05dd7e8ae	\N	\N	\N	\N	2025-10-26 08:15:01.18228-06	2025-10-26 08:15:01.183483-06	\N	7	5	11	0103000020E6100000010000002100000038A4CA22953A56C0AEB6627FD95D2B40FC19638F953A56C0EB40AC0AB75D2B40202000D1963A56C09F67EFE8955D2B4096B345DB983A56C09FF61E60775D2B40C2C0219A9B3A56C03840A09C5C5D2B408F9791F29E3A56C0D6D6BFA5465D2B40AFA5ABC3A23A56C0283B9353365D2B40D940E3E7A63A56C0060AAB462C5D2B40910F7A36AB3A56C0E35BE7E1285D2B4049DE1085AF3A56C0060AAB462C5D2B40737948A9B33A56C0283B9353365D2B409387627AB73A56C0D6D6BFA5465D2B40605ED2D2BA3A56C03840A09C5C5D2B408C6BAE91BD3A56C09FF61E60775D2B4002FFF39BBF3A56C09F67EFE8955D2B40260591DDC03A56C0EB40AC0AB75D2B40EA7A294AC13A56C0AEB6627FD95D2B40260591DDC03A56C0712C19F4FB5D2B4002FFF39BBF3A56C0BD05D6151D5E2B408C6BAE91BD3A56C0BD76A69E3B5E2B40605ED2D2BA3A56C0242D2562565E2B409387627AB73A56C0869605596C5E2B40737948A9B33A56C0343232AB7C5E2B4049DE1085AF3A56C056631AB8865E2B40910F7A36AB3A56C07911DE1C8A5E2B40D940E3E7A63A56C056631AB8865E2B40AFA5ABC3A23A56C0343232AB7C5E2B408F9791F29E3A56C0869605596C5E2B40C2C0219A9B3A56C0242D2562565E2B4096B345DB983A56C0BD76A69E3B5E2B40202000D1963A56C0BD05D6151D5E2B40FC19638F953A56C0712C19F4FB5D2B4038A4CA22953A56C0AEB6627FD95D2B40	0101000020E6100000910F7A36AB3A56C0AEB6627FD95D2B40
15	Derrumbe en Carretera de Oro	Deslizamiento bloquea parcialmente la vía hacia La Libertad	13.550000000	-89.350000000	300	2025-10-26 08:15:01.201813-06	2025-10-26 08:15:01.201818-06	\N	\N	\N	\N	\N	7c550674-9aa6-4bc9-87f7-caede8c09cd3	\N	\N	\N	\N	2025-10-26 08:15:01.201972-06	2025-10-26 08:15:01.20298-06	\N	7	13	13	0103000020E61000000100000021000000B38F073F3A5656C09A99999999192B403C7B38183B5656C014AE2CB054192B408487729B3D5656C07BFBB26C12192B4070AEFDAF415656C07C19125BD5182B40C8C8B52D475656C0ADAC14D49F182B40627695DE4D5656C0EAD953E673182B40A292C980555656C08DA2FA4153182B40F5C838C95D5656C049402A283F182B4066666666665656C005E4A25E38182B40D70394036F5656C049402A283F182B402A3A034C775656C08DA2FA4153182B406A5637EE7E5656C0EAD953E673182B400404179F855656C0ADAC14D49F182B405C1ECF1C8B5656C07C19125BD5182B4048455A318F5656C07BFBB26C12192B40905194B4915656C014AE2CB054192B40193DC58D925656C09A99999999192B40905194B4915656C020850683DE192B4048455A318F5656C0B93780C6201A2B405C1ECF1C8B5656C0B81921D85D1A2B400404179F855656C087861E5F931A2B406A5637EE7E5656C04A59DF4CBF1A2B402A3A034C775656C0A79038F1DF1A2B40D70394036F5656C0EBF2080BF41A2B4066666666665656C02F4F90D4FA1A2B40F5C838C95D5656C0EBF2080BF41A2B40A292C980555656C0A79038F1DF1A2B40627695DE4D5656C04A59DF4CBF1A2B40C8C8B52D475656C087861E5F931A2B4070AEFDAF415656C0B81921D85D1A2B408487729B3D5656C0B93780C6201A2B403C7B38183B5656C020850683DE192B40B38F073F3A5656C09A99999999192B40	0101000020E610000066666666665656C09A99999999192B40
16	Accidente en CA-2 hacia Usulután	Choque entre bus y pick-up, un carril habilitado	13.350000000	-88.450000000	200	2025-10-26 08:15:01.205135-06	2025-10-26 08:15:01.205138-06	\N	\N	\N	\N	\N	1205f9f0-4156-4e40-b1db-5ed1b9e240db	\N	\N	\N	\N	2025-10-26 08:15:01.205238-06	2025-10-26 08:15:01.205851-06	\N	7	13	7	0103000020E61000000100000021000000AB3D385DAF1C56C03333333333B32A405C8503EEAF1C56C085EB3F4205B32A40E1E2D49AB11C56C01F1F4415D9B22A407EA73153B41C56C0CADDD85EB0B22A40640E57FCB71C56C0EA3F85AF8CB22A4020824172BC1C56C0BE085A666FB22A404AEA0E89C11C56C0D5E373A359B22A40D763AE0EC71C56C0A8F7E83C4CB22A40CDCCCCCCCC1C56C025BA8EB647B22A40C335EB8AD21C56C0A8F7E83C4CB22A4050AF8A10D81C56C0D5E373A359B22A407A175827DD1C56C0BE085A666FB22A40368B429DE11C56C0EA3F85AF8CB22A401CF26746E51C56C0CADDD85EB0B22A40B9B6C4FEE71C56C01F1F4415D9B22A403E1496ABE91C56C085EB3F4205B32A40EF5B613CEA1C56C03333333333B32A403E1496ABE91C56C0E17A262461B32A40B9B6C4FEE71C56C0474722518DB32A401CF26746E51C56C09C888D07B6B32A40368B429DE11C56C07C26E1B6D9B32A407A175827DD1C56C0A85D0C00F7B32A4050AF8A10D81C56C09182F2C20CB42A40C335EB8AD21C56C0BE6E7D291AB42A40CDCCCCCCCC1C56C041ACD7AF1EB42A40D763AE0EC71C56C0BE6E7D291AB42A404AEA0E89C11C56C09182F2C20CB42A4020824172BC1C56C0A85D0C00F7B32A40640E57FCB71C56C07C26E1B6D9B32A407EA73153B41C56C09C888D07B6B32A40E1E2D49AB11C56C0474722518DB32A405C8503EEAF1C56C0E17A262461B32A40AB3D385DAF1C56C03333333333B32A40	0101000020E6100000CDCCCCCCCC1C56C03333333333B32A40
17	Congestión en Bulevar del Ejército	Tráfico intenso por partido de fútbol en el Cuscatlán	13.690000000	-89.230000000	400	2025-10-26 08:15:01.207592-06	2025-10-26 08:15:01.207595-06	\N	\N	\N	\N	\N	0b7bf137-79a3-4217-abc7-64bda7810eb9	\N	\N	\N	\N	2025-10-26 08:15:01.207696-06	2025-10-26 08:15:01.208222-06	\N	7	5	8	0103000020E61000000100000021000000DB66C2727D4E56C0E17A14AE47612B403CF658947E4E56C084EB2DCCEB602B4048B1FBED814E56C0B852367293602B40823AB55E874E56C00FD05F0542602B404D0800B18E4E56C05094B8A6FA5F2B40C5EFD49C974E56C0F6256214C05F2B401AC06FCAA14E56C026DC958E945F2B4033B3AED5AC4E56C0CB0380C1795F2B401F85EB51B84E56C0C588CBB4705F2B400B5728CEC34E56C0CB0380C1795F2B40244A67D9CE4E56C026DC958E945F2B40791A0207D94E56C0F6256214C05F2B40F101D7F2E14E56C05094B8A6FA5F2B40BCCF2145E94E56C00FD05F0542602B40F658DBB5EE4E56C0B852367293602B4002147E0FF24E56C084EB2DCCEB602B4063A31431F34E56C0E17A14AE47612B4002147E0FF24E56C03E0AFB8FA3612B40F658DBB5EE4E56C00AA3F2E9FB612B40BCCF2145E94E56C0B325C9564D622B40F101D7F2E14E56C0726170B594622B40791A0207D94E56C0CCCFC647CF622B40244A67D9CE4E56C09C1993CDFA622B400B5728CEC34E56C0F7F1A89A15632B401F85EB51B84E56C0FD6C5DA71E632B4033B3AED5AC4E56C0F7F1A89A15632B401AC06FCAA14E56C09C1993CDFA622B40C5EFD49C974E56C0CCCFC647CF622B404D0800B18E4E56C0726170B594622B40823AB55E874E56C0B325C9564D622B4048B1FBED814E56C00AA3F2E9FB612B403CF658947E4E56C03E0AFB8FA3612B40DB66C2727D4E56C0E17A14AE47612B40	0101000020E61000001F85EB51B84E56C0E17A14AE47612B40
18	Obra en Carretera Troncal del Norte	Repavimentación - tránsito alternado con bandereros	14.100000000	-89.200000000	500	2025-10-26 08:15:01.210349-06	2025-10-26 08:15:01.210352-06	\N	\N	\N	\N	\N	e9cf2a25-a023-4140-9012-86ccfd601cf6	\N	\N	\N	\N	2025-10-26 08:15:01.210431-06	2025-10-26 08:15:01.210974-06	\N	7	2	9	0103000020E61000000100000021000000F966D935834C56C03333333333332C40329AD59F844C56C0FFFFD258C0322C400004E1CF884C56C000815DE851322C4088EFC89C8F4C56C0AC5D5120EC312C40C670A6C3984C56C0FD5200EA92312C401C9270EAA34C56C00D4914B349312C40871672A3B04C56C0C9ECD44B13312C4066C68071BE4C56C0579E79CBF1302C40CDCCCCCCCC4C56C09004987BE6302C4034D31828DB4C56C0579E79CBF1302C40138327F6E84C56C0C9ECD44B13312C407E0729AFF54C56C00D4914B349312C40D428F3D5004D56C0FD5200EA92312C4012AAD0FC094D56C0AC5D5120EC312C409A95B8C9104D56C000815DE851322C4068FFC3F9144D56C0FFFFD258C0322C40A132C063164D56C03333333333332C4068FFC3F9144D56C06766930DA6332C409A95B8C9104D56C066E5087E14342C4012AAD0FC094D56C0BA0815467A342C40D428F3D5004D56C06913667CD3342C407E0729AFF54C56C0591D52B31C352C40138327F6E84C56C09D79911A53352C4034D31828DB4C56C00FC8EC9A74352C40CDCCCCCCCC4C56C0D661CEEA7F352C4066C68071BE4C56C00FC8EC9A74352C40871672A3B04C56C09D79911A53352C401C9270EAA34C56C0591D52B31C352C40C670A6C3984C56C06913667CD3342C4088EFC89C8F4C56C0BA0815467A342C400004E1CF884C56C066E5087E14342C40329AD59F844C56C06766930DA6332C40F966D935834C56C03333333333332C40	0101000020E6100000CDCCCCCCCC4C56C03333333333332C40
19	Bloqueo en CA-4 Chalatenango	Manifestación de transportistas bloquea completamente la vía	14.033300000	-89.033300000	1000	2025-10-26 08:15:01.21255-06	2025-10-26 08:15:01.212552-06	\N	\N	\N	\N	\N	a4b52e5a-0924-41e8-a107-43459f7d9d5a	\N	\N	\N	\N	2025-10-26 08:15:01.212629-06	2025-10-26 08:15:01.213194-06	\N	7	17	12	0103000020E6100000010000002100000093F16B688E4156C0E2E995B20C112C400558643C914156C07A83D5FD26102C40A12B7B9C994156C07C85EA1C4A0F2C40B3024B36A74156C0D53ED28C7E0E2C402F050684B94156C077293020CC0D2C40DA479AD1CF4156C0971558B2390D2C40AF509D43E94156C00D5DD9E3CC0C2C406FB0BADF044256C02BC022E3890C2C403CBD5296214256C09C8C5F43730C2C4009CAEA4C3E4256C02BC022E3890C2C40C92908E9594256C00D5DD9E3CC0C2C409E320B5B734256C0971558B2390D2C4049759FA8894256C077293020CC0D2C40C5775AF69B4256C0D53ED28C7E0E2C40D74E2A90A94256C07C85EA1C4A0F2C40732241F0B14256C07A83D5FD26102C40E58839C4B44256C0E2E995B20C112C40732241F0B14256C04A505667F2112C40D74E2A90A94256C0484E4148CF122C40C5775AF69B4256C0EF9459D89A132C4049759FA8894256C04DAAFB444D142C409E320B5B734256C02DBED3B2DF142C40C92908E9594256C0B77652814C152C4009CAEA4C3E4256C0991309828F152C403CBD5296214256C02847CC21A6152C406FB0BADF044256C0991309828F152C40AF509D43E94156C0B77652814C152C40DA479AD1CF4156C02DBED3B2DF142C402F050684B94156C04DAAFB444D142C40B3024B36A74156C0EF9459D89A132C40A12B7B9C994156C0484E4148CF122C400558643C914156C04A505667F2112C4093F16B688E4156C0E2E995B20C112C40	0101000020E61000003CBD5296214256C0E2E995B20C112C40
20	Lluvia en Carretera Panamericana Ahuachapán	Aguacero fuerte reduce visibilidad en zona montañosa	13.916700000	-89.850000000	2000	2025-10-26 08:15:01.214923-06	2025-10-26 08:15:01.214925-06	\N	\N	\N	\N	\N	ad4cde1d-391d-4bea-96b1-b9f43e1f04f2	\N	\N	\N	\N	2025-10-26 08:15:01.215002-06	2025-10-26 08:15:01.215501-06	\N	7	5	10	0103000020E6100000010000002100000014CF980A407556C0857CD0B359D52B40F89B89B2457556C0B5AF4F4A8ED32B403143B772567556C0B8B37988D4D12B4053F156A6717556C06B2649683DD02B404BF6CC41967556C0AFFB048FD8CE2B40A37BF5DCC27556C0EFD354B3B3CD2B404C8DFBC0F57556C0DC625716DACC2B40CC4C36F92C7656C01629EA1454CC2B4066666666667656C0F8C163D526CC2B40008096D39F7656C01629EA1454CC2B40803FD10BD77656C0DC625716DACC2B402951D7EF097756C0EFD354B3B3CD2B4081D6FF8A367756C0AFFB048FD8CE2B4079DB75265B7756C06B2649683DD02B409B89155A767756C0B8B37988D4D12B40D430431A877756C0B5AF4F4A8ED32B40B8FD33C28C7756C0857CD0B359D52B40D430431A877756C05549511D25D72B409B89155A767756C0524527DFDED82B4079DB75265B7756C09FD257FF75DA2B4081D6FF8A367756C05BFD9BD8DADB2B402951D7EF097756C01B254CB4FFDC2B40803FD10BD77656C02E964951D9DD2B40008096D39F7656C0F4CFB6525FDE2B4066666666667656C012373D928CDE2B40CC4C36F92C7656C0F4CFB6525FDE2B404C8DFBC0F57556C02E964951D9DD2B40A37BF5DCC27556C01B254CB4FFDC2B404BF6CC41967556C05BFD9BD8DADB2B4053F156A6717556C09FD257FF75DA2B403143B772567556C0524527DFDED82B40F89B89B2457556C05549511D25D72B4014CF980A407556C0857CD0B359D52B40	0101000020E610000066666666667656C0857CD0B359D52B40
21	Vehículo incendiado en CA-1 Oeste	Bus se incendia cerca de Sonsonate - bomberos en camino	13.700000000	-89.600000000	800	2025-10-26 08:15:01.21697-06	2025-10-26 08:15:01.216973-06	\N	\N	\N	\N	\N	a9d51e2b-7278-45fd-a44a-96b49314b053	\N	\N	\N	\N	2025-10-26 08:15:01.217082-06	2025-10-26 08:15:01.217767-06	\N	7	17	7	0103000020E61000000100000021000000DF2914A8F06556C06666666666662B40A04841EBF26556C0AC4799A2AE652B40B7BE869EF96556C01416AAEEFD642B402BD1F97F046656C0C210FD145B642B40C26C8F24136656C04399AE57CC632B40B13B39FC246656C090BC013357632B405CDC6E57396656C0EF28692700632B408FC2EC6D4F6656C03A783D8DCA622B4066666666666656C02E82D473B8622B403D0AE05E7D6656C03A783D8DCA622B4070F05D75936656C0EF28692700632B401B9193D0A76656C090BC013357632B400A603DA8B96656C04399AE57CC632B40A1FBD24CC86656C0C210FD145B642B40150E462ED36656C01416AAEEFD642B402C848BE1D96656C0AC4799A2AE652B40EDA2B824DC6656C06666666666662B402C848BE1D96656C02085332A1E672B40150E462ED36656C0B8B622DECE672B40A1FBD24CC86656C00ABCCFB771682B400A603DA8B96656C089331E7500692B401B9193D0A76656C03C10CB9975692B4070F05D75936656C0DDA363A5CC692B403D0AE05E7D6656C092548F3F026A2B4066666666666656C09E4AF858146A2B408FC2EC6D4F6656C092548F3F026A2B405CDC6E57396656C0DDA363A5CC692B40B13B39FC246656C03C10CB9975692B40C26C8F24136656C089331E7500692B402BD1F97F046656C00ABCCFB771682B40B7BE869EF96556C0B8B622DECE672B40A04841EBF26556C02085332A1E672B40DF2914A8F06556C06666666666662B40	0101000020E610000066666666666656C06666666666662B40
22	Control policial en Carretera Los Chorros	Retén de la PNC causa lentitud hacia Los Chorros	13.820000000	-89.280000000	300	2025-10-26 08:15:01.21965-06	2025-10-26 08:15:01.219653-06	\N	\N	\N	\N	\N	82d3478c-dfa4-4bef-9fe9-fba58ad33505	\N	\N	\N	\N	2025-10-26 08:15:01.219768-06	2025-10-26 08:15:01.220339-06	\N	7	2	8	0103000020E610000001000000210000009FE1BF5DBF5156C0A4703D0AD7A32B4028CDF036C05156C01E85D02092A32B4070D92ABAC25156C085D256DD4FA32B405C00B6CEC65156C086F0B5CB12A32B40B41A6E4CCC5156C0B783B844DDA22B404EC84DFDD25156C0F4B0F756B1A22B408EE4819FDA5156C097799EB290A22B40E11AF1E7E25156C05317CE987CA22B4052B81E85EB5156C00FBB46CF75A22B40C3554C22F45156C05317CE987CA22B40168CBB6AFC5156C097799EB290A22B4056A8EF0C045256C0F4B0F756B1A22B40F055CFBD0A5256C0B783B844DDA22B404870873B105256C086F0B5CB12A32B4034971250145256C085D256DD4FA32B407CA34CD3165256C01E85D02092A32B40058F7DAC175256C0A4703D0AD7A32B407CA34CD3165256C02A5CAAF31BA42B4034971250145256C0C30E24375EA42B404870873B105256C0C2F0C4489BA42B40F055CFBD0A5256C0915DC2CFD0A42B4056A8EF0C045256C0543083BDFCA42B40168CBB6AFC5156C0B167DC611DA52B40C3554C22F45156C0F5C9AC7B31A52B4052B81E85EB5156C03926344538A52B40E11AF1E7E25156C0F5C9AC7B31A52B408EE4819FDA5156C0B167DC611DA52B404EC84DFDD25156C0543083BDFCA42B40B41A6E4CCC5156C0915DC2CFD0A42B405C00B6CEC65156C0C2F0C4489BA42B4070D92ABAC25156C0C30E24375EA42B4028CDF036C05156C02A5CAAF31BA42B409FE1BF5DBF5156C0A4703D0AD7A32B40	0101000020E610000052B81E85EB5156C0A4703D0AD7A32B40
23	Ganado suelto en RN-5 San Vicente	Varias reses obstaculizan el tránsito hacia San Vicente	13.633300000	-88.783300000	100	2025-10-26 08:15:01.221949-06	2025-10-26 08:15:01.221952-06	\N	\N	\N	\N	\N	4a4b2778-7472-4395-9a9c-bc566b8e7776	\N	\N	\N	\N	2025-10-26 08:15:01.222033-06	2025-10-26 08:15:01.222556-06	\N	7	5	12	0103000020E61000000100000021000000AB7588DE123256C0151DC9E53F442B408319EE26133256C03E794FED28442B4046C856FD133256C00B93D1D612442B40952A8559153256C060F29B7BFE432B4007DE172E173256C07123F2A3EC432B40E5170D69193256C0DA875CFFDD432B40FBCB73F41B3256C06675E91DD3432B40C18843B71E3256C04FFFA36ACC432B403CBD5296213256C08EE07627CA432B40B7F16175243256C04FFFA36ACC432B407DAE3138273256C06675E91DD3432B40936298C3293256C0DA875CFFDD432B40719C8DFE2B3256C07123F2A3EC432B40E34F20D32D3256C060F29B7BFE432B4032B24E2F2F3256C00B93D1D612442B40F560B705303256C03E794FED28442B40CD041D4E303256C0151DC9E53F442B40F560B705303256C0ECC042DE56442B4032B24E2F2F3256C01FA7C0F46C442B40E34F20D32D3256C0CA47F64F81442B40719C8DFE2B3256C0B916A02793442B40936298C3293256C050B235CCA1442B407DAE3138273256C0C4C4A8ADAC442B40B7F16175243256C0DB3AEE60B3442B403CBD5296213256C09C591BA4B5442B40C18843B71E3256C0DB3AEE60B3442B40FBCB73F41B3256C0C4C4A8ADAC442B40E5170D69193256C050B235CCA1442B4007DE172E173256C0B916A02793442B40952A8559153256C0CA47F64F81442B4046C856FD133256C01FA7C0F46C442B408319EE26133256C0ECC042DE56442B40AB7588DE123256C0151DC9E53F442B40	0101000020E61000003CBD5296213256C0151DC9E53F442B40
24	inundacion	inundacion en mi casa	13.749837418	-89.599081000	50	2025-10-26 08:26:47.42363-06	2025-10-26 08:26:47.423644-06	2025-11-25 08:26:47.423646-06	\N	\N	\N	\N	f926a2ed-e519-425c-9426-77f539bd9922	\N	\N	\N	\N	2025-10-26 08:26:47.424835-06	2025-10-26 08:26:47.426762-06	\N	2	17	10	0103000020E610000001000000210000002386F0FB4F6656C047D0A5B0EA7F2B400F582320506656C05BFE6834DF7F2B4070AF578B506656C0420B2A29D47F2B4097E06E39516656C0ED3A8FFBC97F2B40513AB823526656C07553BA0FC17F2B4040D73241536656C0AA856FBDB97F2B404A31E686546656C070FCB54CB47F2B40AE0F4EE8556656C0644113F3B07F2B40EBA9D557576656C003B27CD1AF7F2B4028445DC7586656C0644113F3B07F2B408C22C5285A6656C070FCB54CB47F2B40967C786E5B6656C0AA856FBDB97F2B408519F38B5C6656C07553BA0FC17F2B403F733C765D6656C0ED3A8FFBC97F2B4066A453245E6656C0420B2A29D47F2B40C7FB878F5E6656C05BFE6834DF7F2B40B3CDBAB35E6656C047D0A5B0EA7F2B40C7FB878F5E6656C033A2E22CF67F2B4066A453245E6656C04C95213801802B403F733C765D6656C0A165BC650B802B408519F38B5C6656C0194D915114802B40967C786E5B6656C0E41ADCA31B802B408C22C5285A6656C01EA4951421802B4028445DC7586656C02A5F386E24802B40EBA9D557576656C08BEECE8F25802B40AE0F4EE8556656C02A5F386E24802B404A31E686546656C01EA4951421802B4040D73241536656C0E41ADCA31B802B40513AB823526656C0194D915114802B4097E06E39516656C0A165BC650B802B4070AF578B506656C04C95213801802B400F582320506656C033A2E22CF67F2B402386F0FB4F6656C047D0A5B0EA7F2B40	0101000020E6100000EBA9D557576656C047D0A5B0EA7F2B40
25	inundacion	inundacion en mi casa	13.744903300	-89.599081000	50	2025-10-26 08:20:00-06	2025-10-26 08:20:00-06	2025-11-26 00:00:00-06	\N	\N	\N	\N	4466a242-8fa6-4d53-bd13-bb6b341f32c8	1	admin	\N	\N	2025-10-26 08:29:42.471799-06	2025-10-26 08:29:42.473354-06	\N	2	17	10	0103000020E610000001000000210000002386F0FB4F6656C06E5D20F7637D2B400F582320506656C0828BE37A587D2B4070AF578B506656C06998A46F4D7D2B4097E06E39516656C014C80942437D2B40513AB823526656C09CE034563A7D2B4040D73241536656C0D112EA03337D2B404A31E686546656C0978930932D7D2B40AE0F4EE8556656C08BCE8D392A7D2B40EBA9D557576656C02A3FF717297D2B4028445DC7586656C08BCE8D392A7D2B408C22C5285A6656C0978930932D7D2B40967C786E5B6656C0D112EA03337D2B408519F38B5C6656C09CE034563A7D2B403F733C765D6656C014C80942437D2B4066A453245E6656C06998A46F4D7D2B40C7FB878F5E6656C0828BE37A587D2B40B3CDBAB35E6656C06E5D20F7637D2B40C7FB878F5E6656C05A2F5D736F7D2B4066A453245E6656C073229C7E7A7D2B403F733C765D6656C0C8F236AC847D2B408519F38B5C6656C040DA0B988D7D2B40967C786E5B6656C00BA856EA947D2B408C22C5285A6656C04531105B9A7D2B4028445DC7586656C051ECB2B49D7D2B40EBA9D557576656C0B27B49D69E7D2B40AE0F4EE8556656C051ECB2B49D7D2B404A31E686546656C04531105B9A7D2B4040D73241536656C00BA856EA947D2B40513AB823526656C040DA0B988D7D2B4097E06E39516656C0C8F236AC847D2B4070AF578B506656C073229C7E7A7D2B400F582320506656C05A2F5D736F7D2B402386F0FB4F6656C06E5D20F7637D2B40	0101000020E6100000EBA9D557576656C06E5D20F7637D2B40
26	Test Event UPDATED via PUT	Descripción actualizada desde API PUT - funciona correctamente	13.700000000	-89.200000000	150	2025-10-26 08:54:20.971158-06	2025-10-26 08:54:20.971167-06	\N	\N	\N	\N	\N	8b484b5a-a929-49a6-b985-1e04c61c4ec6	8	frontend_user	8	frontend_user	2025-10-26 08:54:20.971228-06	2025-10-26 08:58:15.566349-06	2025-10-26 08:58:15.566047-06	2	5	1	0103000020E610000001000000210000003C850215BE4C56C06666666666662B401429685DBE4C56C08FC2EC6D4F662B40D7D7D033BF4C56C05CDC6E5739662B40263AFF8FC04C56C0B13B39FC24662B4098ED9164C24C56C0C26C8F2413662B407627879FC44C56C02BD1F97F04662B408CDBED2AC74C56C0B7BE869EF9652B405298BDEDC94C56C0A04841EBF2652B40CDCCCCCCCC4C56C0DF2914A8F0652B404801DCABCF4C56C0A04841EBF2652B400EBEAB6ED24C56C0B7BE869EF9652B40247212FAD44C56C02BD1F97F04662B4002AC0735D74C56C0C26C8F2413662B40745F9A09D94C56C0B13B39FC24662B40C3C1C865DA4C56C05CDC6E5739662B408670313CDB4C56C08FC2EC6D4F662B405E149784DB4C56C06666666666662B408670313CDB4C56C03D0AE05E7D662B40C3C1C865DA4C56C070F05D7593662B40745F9A09D94C56C01B9193D0A7662B4002AC0735D74C56C00A603DA8B9662B40247212FAD44C56C0A1FBD24CC8662B400EBEAB6ED24C56C0150E462ED3662B404801DCABCF4C56C02C848BE1D9662B40CDCCCCCCCC4C56C0EDA2B824DC662B405298BDEDC94C56C02C848BE1D9662B408CDBED2AC74C56C0150E462ED3662B407627879FC44C56C0A1FBD24CC8662B4098ED9164C24C56C00A603DA8B9662B40263AFF8FC04C56C01B9193D0A7662B40D7D7D033BF4C56C070F05D7593662B401429685DBE4C56C03D0AE05E7D662B403C850215BE4C56C06666666666662B40	0101000020E6100000CDCCCCCCCC4C56C06666666666662B40
\.


--
-- TOC entry 4405 (class 0 OID 24717)
-- Dependencies: 221
-- Data for Name: nivel_gravedad; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.nivel_gravedad (id, codigo, nombre, orden, creado_en, actualizado_en) FROM stdin;
2	BAJO	Crítica	5	2025-10-25 13:27:57.867995-06	2025-10-25 13:27:57.868234-06
5	MEDIO	Gravedad Baja	1	2025-10-25 13:41:19.336436-06	2025-10-25 13:41:19.336678-06
13	ALTO	muy bajo	1	2025-10-25 14:03:14.942118-06	2025-10-25 14:03:14.942495-06
17	CRITICO	Crítico	5	2025-10-26 08:12:01.281539-06	2025-10-26 08:12:01.281803-06
18	INFORMATIVO	Informativo	1	2025-10-26 08:12:01.286045-06	2025-10-26 08:12:01.286179-06
\.


--
-- TOC entry 4194 (class 0 OID 26995)
-- Dependencies: 229
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- TOC entry 4407 (class 0 OID 24725)
-- Dependencies: 223
-- Data for Name: tipo_evento; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.tipo_evento (id, codigo, nombre, descripcion, activo, creado_en, actualizado_en) FROM stdin;
1	ACC	Accidente	Accidente de tráfico	t	2025-10-25 11:15:22.104249-06	2025-10-25 11:15:22.119521-06
2	CON	Construcción	Trabajos de construcción	t	2025-10-25 11:15:22.123158-06	2025-10-25 11:15:22.123365-06
3	CA	Caida de arbol		t	2025-10-25 11:17:12.447712-06	2025-10-25 11:17:12.448019-06
4	EMER	Situación de Emergencia	Eventos que requieren atención inmediata	t	2025-10-25 13:32:56.855019-06	2025-10-25 13:32:56.855231-06
5	DER	Derrumbe		t	2025-10-25 13:34:37.140485-06	2025-10-25 13:34:37.14097-06
7	ACCIDENTE	Accidente de Tránsito	Accidente vehicular	t	2025-10-26 08:03:15.16038-06	2025-10-26 08:03:15.160669-06
8	CONGESTION	Congestión Vehicular	Tráfico lento o detenido	t	2025-10-26 08:11:18.100164-06	2025-10-26 08:11:18.100435-06
9	OBRA	Obra Vial	Trabajos de construcción o mantenimiento	t	2025-10-26 08:12:01.294025-06	2025-10-26 08:12:01.294243-06
10	CLIMA	Condición Climática	Lluvia, neblina u otras condiciones climáticas	t	2025-10-26 08:12:01.296984-06	2025-10-26 08:12:01.297205-06
11	VEHICULO_VARADO	Vehículo Varado	Vehículo descompuesto en la vía	t	2025-10-26 08:15:01.171969-06	2025-10-26 08:15:01.172371-06
12	BLOQUEO	Bloqueo de Vía	Manifestación o bloqueo de carretera	t	2025-10-26 08:15:01.175759-06	2025-10-26 08:15:01.176006-06
13	DERRUMBE	Derrumbe	Deslizamiento de tierra o rocas	t	2025-10-26 08:15:01.178326-06	2025-10-26 08:15:01.178591-06
\.


--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 216
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 218
-- Name: estado_evento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.estado_evento_id_seq', 7, true);


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 226
-- Name: evento_ruta_afectada_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.evento_ruta_afectada_id_seq', 1, false);


--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 224
-- Name: evento_trafico_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.evento_trafico_id_seq', 26, true);


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 220
-- Name: nivel_gravedad_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.nivel_gravedad_id_seq', 18, true);


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 222
-- Name: tipo_evento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.tipo_evento_id_seq', 13, true);


--
-- TOC entry 4197 (class 2606 OID 24637)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 4201 (class 2606 OID 24715)
-- Name: estado_evento estado_evento_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.estado_evento
    ADD CONSTRAINT estado_evento_codigo_key UNIQUE (codigo);


--
-- TOC entry 4203 (class 2606 OID 24713)
-- Name: estado_evento estado_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.estado_evento
    ADD CONSTRAINT estado_evento_pkey PRIMARY KEY (id);


--
-- TOC entry 4239 (class 2606 OID 27838)
-- Name: evento_ruta_afectada evento_ruta_afectada_evento_id_sistema_origen_0acf55d4_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_ruta_afectada
    ADD CONSTRAINT evento_ruta_afectada_evento_id_sistema_origen_0acf55d4_uniq UNIQUE (evento_id, sistema_origen, ruta_id_externo);


--
-- TOC entry 4241 (class 2606 OID 24747)
-- Name: evento_ruta_afectada evento_ruta_afectada_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_ruta_afectada
    ADD CONSTRAINT evento_ruta_afectada_pkey PRIMARY KEY (id);


--
-- TOC entry 4234 (class 2606 OID 24741)
-- Name: evento_trafico evento_trafico_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_trafico
    ADD CONSTRAINT evento_trafico_pkey PRIMARY KEY (id);


--
-- TOC entry 4208 (class 2606 OID 24723)
-- Name: nivel_gravedad nivel_gravedad_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.nivel_gravedad
    ADD CONSTRAINT nivel_gravedad_codigo_key UNIQUE (codigo);


--
-- TOC entry 4210 (class 2606 OID 24721)
-- Name: nivel_gravedad nivel_gravedad_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.nivel_gravedad
    ADD CONSTRAINT nivel_gravedad_pkey PRIMARY KEY (id);


--
-- TOC entry 4215 (class 2606 OID 24733)
-- Name: tipo_evento tipo_evento_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.tipo_evento
    ADD CONSTRAINT tipo_evento_codigo_key UNIQUE (codigo);


--
-- TOC entry 4217 (class 2606 OID 24731)
-- Name: tipo_evento tipo_evento_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.tipo_evento
    ADD CONSTRAINT tipo_evento_pkey PRIMARY KEY (id);


--
-- TOC entry 4198 (class 1259 OID 24759)
-- Name: estado_even_codigo_5f531c_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX estado_even_codigo_5f531c_idx ON public.estado_evento USING btree (codigo);


--
-- TOC entry 4199 (class 1259 OID 24758)
-- Name: estado_evento_codigo_3d93a0b5_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX estado_evento_codigo_3d93a0b5_like ON public.estado_evento USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 4237 (class 1259 OID 24791)
-- Name: evento_ruta_afectada_evento_id_929d21eb; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_ruta_afectada_evento_id_929d21eb ON public.evento_ruta_afectada USING btree (evento_id);


--
-- TOC entry 4242 (class 1259 OID 24792)
-- Name: evento_ruta_evento__ec847f_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_ruta_evento__ec847f_idx ON public.evento_ruta_afectada USING btree (evento_id);


--
-- TOC entry 4243 (class 1259 OID 24795)
-- Name: evento_ruta_relevan_820be0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_ruta_relevan_820be0_idx ON public.evento_ruta_afectada USING btree (relevancia);


--
-- TOC entry 4244 (class 1259 OID 24794)
-- Name: evento_ruta_ruta_co_7b55ec_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_ruta_ruta_co_7b55ec_idx ON public.evento_ruta_afectada USING btree (ruta_codigo);


--
-- TOC entry 4245 (class 1259 OID 27839)
-- Name: evento_ruta_sistema_502bb6_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_ruta_sistema_502bb6_idx ON public.evento_ruta_afectada USING btree (sistema_origen, ruta_id_externo);


--
-- TOC entry 4218 (class 1259 OID 27910)
-- Name: evento_traf_area_af_836cc5_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_area_af_836cc5_idx ON public.evento_trafico USING gist (area_afectacion);


--
-- TOC entry 4219 (class 1259 OID 24756)
-- Name: evento_traf_correla_5388a7_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_correla_5388a7_idx ON public.evento_trafico USING btree (correlacion_id);


--
-- TOC entry 4220 (class 1259 OID 24757)
-- Name: evento_traf_elimina_d5d5fa_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_elimina_d5d5fa_idx ON public.evento_trafico USING btree (eliminado_en);


--
-- TOC entry 4221 (class 1259 OID 24750)
-- Name: evento_traf_estado__03c98c_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_estado__03c98c_idx ON public.evento_trafico USING btree (estado_id);


--
-- TOC entry 4222 (class 1259 OID 24751)
-- Name: evento_traf_fecha_o_7b2e94_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_fecha_o_7b2e94_idx ON public.evento_trafico USING btree (fecha_ocurrencia);


--
-- TOC entry 4223 (class 1259 OID 24752)
-- Name: evento_traf_fecha_r_a163fc_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_fecha_r_a163fc_idx ON public.evento_trafico USING btree (fecha_reporte);


--
-- TOC entry 4224 (class 1259 OID 24749)
-- Name: evento_traf_graveda_655ff4_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_graveda_655ff4_idx ON public.evento_trafico USING btree (gravedad_id);


--
-- TOC entry 4225 (class 1259 OID 27937)
-- Name: evento_traf_latitud_3313c0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_latitud_3313c0_idx ON public.evento_trafico USING btree (latitud, longitud);


--
-- TOC entry 4226 (class 1259 OID 24748)
-- Name: evento_traf_tipo_id_8e77ff_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_tipo_id_8e77ff_idx ON public.evento_trafico USING btree (tipo_id);


--
-- TOC entry 4227 (class 1259 OID 27909)
-- Name: evento_traf_ubicaci_7c2435_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_ubicaci_7c2435_idx ON public.evento_trafico USING gist (ubicacion);


--
-- TOC entry 4228 (class 1259 OID 27869)
-- Name: evento_traf_vehicul_57a3f0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_vehicul_57a3f0_idx ON public.evento_trafico USING btree (vehiculo_id_externo);


--
-- TOC entry 4229 (class 1259 OID 27889)
-- Name: evento_traf_viaje_i_a297b6_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_traf_viaje_i_a297b6_idx ON public.evento_trafico USING btree (viaje_id_externo);


--
-- TOC entry 4230 (class 1259 OID 27911)
-- Name: evento_trafico_area_afectacion_7098fbfa_id; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_trafico_area_afectacion_7098fbfa_id ON public.evento_trafico USING gist (area_afectacion);


--
-- TOC entry 4231 (class 1259 OID 24781)
-- Name: evento_trafico_estado_id_8e5e9d1d; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_trafico_estado_id_8e5e9d1d ON public.evento_trafico USING btree (estado_id);


--
-- TOC entry 4232 (class 1259 OID 24782)
-- Name: evento_trafico_gravedad_id_3d2043c2; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_trafico_gravedad_id_3d2043c2 ON public.evento_trafico USING btree (gravedad_id);


--
-- TOC entry 4235 (class 1259 OID 24783)
-- Name: evento_trafico_tipo_id_dd29038f; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_trafico_tipo_id_dd29038f ON public.evento_trafico USING btree (tipo_id);


--
-- TOC entry 4236 (class 1259 OID 27912)
-- Name: evento_trafico_ubicacion_a0d25425_id; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX evento_trafico_ubicacion_a0d25425_id ON public.evento_trafico USING gist (ubicacion);


--
-- TOC entry 4204 (class 1259 OID 24761)
-- Name: nivel_grave_codigo_e08f2d_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX nivel_grave_codigo_e08f2d_idx ON public.nivel_gravedad USING btree (codigo);


--
-- TOC entry 4205 (class 1259 OID 24762)
-- Name: nivel_grave_orden_c557b6_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX nivel_grave_orden_c557b6_idx ON public.nivel_gravedad USING btree (orden);


--
-- TOC entry 4206 (class 1259 OID 24760)
-- Name: nivel_gravedad_codigo_070aa497_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX nivel_gravedad_codigo_070aa497_like ON public.nivel_gravedad USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 4211 (class 1259 OID 24765)
-- Name: tipo_evento_activo_432b5b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX tipo_evento_activo_432b5b_idx ON public.tipo_evento USING btree (activo);


--
-- TOC entry 4212 (class 1259 OID 24764)
-- Name: tipo_evento_codigo_b80c1b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX tipo_evento_codigo_b80c1b_idx ON public.tipo_evento USING btree (codigo);


--
-- TOC entry 4213 (class 1259 OID 24763)
-- Name: tipo_evento_codigo_bcc5e2a7_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX tipo_evento_codigo_bcc5e2a7_like ON public.tipo_evento USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 4251 (class 2606 OID 24786)
-- Name: evento_ruta_afectada evento_ruta_afectada_evento_id_929d21eb_fk_evento_trafico_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_ruta_afectada
    ADD CONSTRAINT evento_ruta_afectada_evento_id_929d21eb_fk_evento_trafico_id FOREIGN KEY (evento_id) REFERENCES public.evento_trafico(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4248 (class 2606 OID 24766)
-- Name: evento_trafico evento_trafico_estado_id_8e5e9d1d_fk_estado_evento_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_trafico
    ADD CONSTRAINT evento_trafico_estado_id_8e5e9d1d_fk_estado_evento_id FOREIGN KEY (estado_id) REFERENCES public.estado_evento(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4249 (class 2606 OID 24771)
-- Name: evento_trafico evento_trafico_gravedad_id_3d2043c2_fk_nivel_gravedad_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_trafico
    ADD CONSTRAINT evento_trafico_gravedad_id_3d2043c2_fk_nivel_gravedad_id FOREIGN KEY (gravedad_id) REFERENCES public.nivel_gravedad(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 4250 (class 2606 OID 24776)
-- Name: evento_trafico evento_trafico_tipo_id_dd29038f_fk_tipo_evento_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.evento_trafico
    ADD CONSTRAINT evento_trafico_tipo_id_dd29038f_fk_tipo_evento_id FOREIGN KEY (tipo_id) REFERENCES public.tipo_evento(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-10-26 11:17:27 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:27 CST

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

DROP DATABASE postgres;
--
-- TOC entry 3389 (class 1262 OID 5)
-- Name: postgres; Type: DATABASE; Schema: -; Owner: admin_user
--

CREATE DATABASE postgres WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE postgres OWNER TO admin_user;

\connect postgres

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

--
-- TOC entry 3390 (class 0 OID 0)
-- Dependencies: 3389
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: admin_user
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


-- Completed on 2025-10-26 11:17:27 CST

--
-- PostgreSQL database dump complete
--

--
-- Database "rutas_viajes" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 16.4
-- Dumped by pg_dump version 16.4

-- Started on 2025-10-26 11:17:27 CST

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

--
-- TOC entry 3564 (class 1262 OID 24796)
-- Name: rutas_viajes; Type: DATABASE; Schema: -; Owner: admin_user
--

CREATE DATABASE rutas_viajes WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE rutas_viajes OWNER TO admin_user;

\connect rutas_viajes

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
-- TOC entry 228 (class 1259 OID 24848)
-- Name: asignacion_autobus_ruta; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.asignacion_autobus_ruta OWNER TO admin_user;

--
-- TOC entry 227 (class 1259 OID 24847)
-- Name: asignacion_autobus_ruta_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: autobus; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.autobus OWNER TO admin_user;

--
-- TOC entry 219 (class 1259 OID 24813)
-- Name: autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE public.django_migrations OWNER TO admin_user;

--
-- TOC entry 215 (class 1259 OID 24797)
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: empresa_transporte; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.empresa_transporte OWNER TO admin_user;

--
-- TOC entry 217 (class 1259 OID 24805)
-- Name: empresa_transporte_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: parada; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.parada OWNER TO admin_user;

--
-- TOC entry 225 (class 1259 OID 24840)
-- Name: parada_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: piloto; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.piloto OWNER TO admin_user;

--
-- TOC entry 221 (class 1259 OID 24824)
-- Name: piloto_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: posicion_autobus; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.posicion_autobus OWNER TO admin_user;

--
-- TOC entry 233 (class 1259 OID 24868)
-- Name: posicion_autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: ruta; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.ruta OWNER TO admin_user;

--
-- TOC entry 230 (class 1259 OID 24854)
-- Name: ruta_geopunto; Type: TABLE; Schema: public; Owner: admin_user
--

CREATE TABLE public.ruta_geopunto (
    id bigint NOT NULL,
    orden integer NOT NULL,
    latitud numeric(9,6) NOT NULL,
    longitud numeric(9,6) NOT NULL,
    ruta_id bigint NOT NULL,
    CONSTRAINT ruta_geopunto_orden_check CHECK ((orden >= 0))
);


ALTER TABLE public.ruta_geopunto OWNER TO admin_user;

--
-- TOC entry 229 (class 1259 OID 24853)
-- Name: ruta_geopunto_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: ruta_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Name: viaje_autobus; Type: TABLE; Schema: public; Owner: admin_user
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


ALTER TABLE public.viaje_autobus OWNER TO admin_user;

--
-- TOC entry 231 (class 1259 OID 24860)
-- Name: viaje_autobus_id_seq; Type: SEQUENCE; Schema: public; Owner: admin_user
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
-- Data for Name: asignacion_autobus_ruta; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.asignacion_autobus_ruta (id, fecha, hora_inicio, hora_fin, estado, creado_en, actualizado_en, autobus_id, piloto_id, ruta_id) FROM stdin;
\.


--
-- TOC entry 3544 (class 0 OID 24814)
-- Dependencies: 220
-- Data for Name: autobus; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.autobus (id, codigo, placa, capacidad, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	BUS001	P123-456	45	t	2025-10-25 17:51:57.886701-06	2025-10-25 17:51:57.886937-06	1
2	BUS002	P456-DEF	45	t	2025-10-25 18:51:24.434122-06	2025-10-25 18:51:24.434608-06	2
3	232423	EWREWREWER	23	t	2025-10-25 19:53:36.078674-06	2025-10-25 19:53:36.078987-06	3
\.


--
-- TOC entry 3540 (class 0 OID 24798)
-- Dependencies: 216
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	microservicios_rutas_viajes	0001_initial	2025-10-25 17:44:46.232737-06
\.


--
-- TOC entry 3542 (class 0 OID 24806)
-- Dependencies: 218
-- Data for Name: empresa_transporte; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.empresa_transporte (id, nombre, codigo, contacto, telefono, activo, creado_en, actualizado_en) FROM stdin;
1	Transportes MOP S.A.	MOP001	Juan Pérez	2234-5678	t	2025-10-25 17:51:57.858568-06	2025-10-25 17:51:57.878526-06
2	Transporte Urbano Guatemala	TRANS001	Juan Pérez	+502-2334-5678	t	2025-10-25 18:48:21.846699-06	2025-10-25 18:48:21.847055-06
3	La experanza	003	Juan Valdez	73659816	t	2025-10-25 19:26:05.77291-06	2025-10-25 19:26:05.77335-06
\.


--
-- TOC entry 3550 (class 0 OID 24841)
-- Dependencies: 226
-- Data for Name: parada; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.parada (id, nombre, orden, sentido, latitud, longitud, activo, creado_en, actualizado_en, ruta_id) FROM stdin;
1	Parque Central	1	IDA	14.640521	-90.513197	t	2025-10-25 18:52:15.89286-06	2025-10-25 18:52:15.893287-06	2
\.


--
-- TOC entry 3546 (class 0 OID 24825)
-- Dependencies: 222
-- Data for Name: piloto; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.piloto (id, nombre, documento, licencia_numero, licencia_categoria, telefono, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	Carlos Rodriguez	12345678-9	LIC123456	D	7890-1234	t	2025-10-25 17:51:57.882711-06	2025-10-25 17:51:57.882997-06	1
3	Juan Valdez	048958865	wq121231212	12	121212	t	2025-10-25 19:29:29.069893-06	2025-10-25 19:29:29.070391-06	1
4	Juan Perez	048958865	1213213	1	123132123	t	2025-10-25 19:45:03.023129-06	2025-10-25 19:45:03.023524-06	3
\.


--
-- TOC entry 3558 (class 0 OID 24869)
-- Dependencies: 234
-- Data for Name: posicion_autobus; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.posicion_autobus (id, latitud, longitud, velocidad_kmh, rumbo_grados, precision_m, fuente, capturado_en, recibido_en, creado_en, autobus_id, viaje_id) FROM stdin;
\.


--
-- TOC entry 3548 (class 0 OID 24831)
-- Dependencies: 224
-- Data for Name: ruta; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.ruta (id, codigo, nombre, descripcion, activo, creado_en, actualizado_en, empresa_id) FROM stdin;
1	R001	Ruta Centro - Zona Industrial	Conecta el centro de la ciudad con la zona industrial	t	2025-10-25 17:51:57.891107-06	2025-10-25 17:51:57.891408-06	1
2	R101	Centro - Zone 18	Ruta que conecta el centro histórico con la Zona 18	t	2025-10-25 18:51:40.322942-06	2025-10-25 18:51:40.323354-06	2
3	44	ruta 44 - A	23232	t	2025-10-25 19:54:13.16647-06	2025-10-25 19:54:13.166757-06	3
\.


--
-- TOC entry 3554 (class 0 OID 24854)
-- Dependencies: 230
-- Data for Name: ruta_geopunto; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.ruta_geopunto (id, orden, latitud, longitud, ruta_id) FROM stdin;
1	1	14.640521	-90.513197	2
\.


--
-- TOC entry 3556 (class 0 OID 24861)
-- Dependencies: 232
-- Data for Name: viaje_autobus; Type: TABLE DATA; Schema: public; Owner: admin_user
--

COPY public.viaje_autobus (id, numero_viaje, estado, inicio_en, fin_en, distancia_km, duracion_min, velocidad_media_kmh, creado_en, actualizado_en, asignacion_id, autobus_id, parada_fin_id, parada_inicio_id, piloto_id, ruta_id) FROM stdin;
\.


--
-- TOC entry 3565 (class 0 OID 0)
-- Dependencies: 227
-- Name: asignacion_autobus_ruta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.asignacion_autobus_ruta_id_seq', 1, true);


--
-- TOC entry 3566 (class 0 OID 0)
-- Dependencies: 219
-- Name: autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.autobus_id_seq', 3, true);


--
-- TOC entry 3567 (class 0 OID 0)
-- Dependencies: 215
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 1, true);


--
-- TOC entry 3568 (class 0 OID 0)
-- Dependencies: 217
-- Name: empresa_transporte_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.empresa_transporte_id_seq', 3, true);


--
-- TOC entry 3569 (class 0 OID 0)
-- Dependencies: 225
-- Name: parada_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.parada_id_seq', 1, true);


--
-- TOC entry 3570 (class 0 OID 0)
-- Dependencies: 221
-- Name: piloto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.piloto_id_seq', 4, true);


--
-- TOC entry 3571 (class 0 OID 0)
-- Dependencies: 233
-- Name: posicion_autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.posicion_autobus_id_seq', 1, true);


--
-- TOC entry 3572 (class 0 OID 0)
-- Dependencies: 229
-- Name: ruta_geopunto_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.ruta_geopunto_id_seq', 1, true);


--
-- TOC entry 3573 (class 0 OID 0)
-- Dependencies: 223
-- Name: ruta_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.ruta_id_seq', 3, true);


--
-- TOC entry 3574 (class 0 OID 0)
-- Dependencies: 231
-- Name: viaje_autobus_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin_user
--

SELECT pg_catalog.setval('public.viaje_autobus_id_seq', 1, true);


--
-- TOC entry 3345 (class 2606 OID 24891)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_autobus_id_fecha_hora_in_2a7896cb_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_autobus_id_fecha_hora_in_2a7896cb_uniq UNIQUE (autobus_id, fecha, hora_inicio);


--
-- TOC entry 3348 (class 2606 OID 24852)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_pkey PRIMARY KEY (id);


--
-- TOC entry 3309 (class 2606 OID 24821)
-- Name: autobus autobus_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_codigo_key UNIQUE (codigo);


--
-- TOC entry 3313 (class 2606 OID 24819)
-- Name: autobus autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3317 (class 2606 OID 24823)
-- Name: autobus autobus_placa_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_placa_key UNIQUE (placa);


--
-- TOC entry 3297 (class 2606 OID 24804)
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3303 (class 2606 OID 24812)
-- Name: empresa_transporte empresa_transporte_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.empresa_transporte
    ADD CONSTRAINT empresa_transporte_codigo_key UNIQUE (codigo);


--
-- TOC entry 3305 (class 2606 OID 24810)
-- Name: empresa_transporte empresa_transporte_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.empresa_transporte
    ADD CONSTRAINT empresa_transporte_pkey PRIMARY KEY (id);


--
-- TOC entry 3336 (class 2606 OID 24846)
-- Name: parada parada_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.parada
    ADD CONSTRAINT parada_pkey PRIMARY KEY (id);


--
-- TOC entry 3323 (class 2606 OID 24829)
-- Name: piloto piloto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT piloto_pkey PRIMARY KEY (id);


--
-- TOC entry 3378 (class 2606 OID 24873)
-- Name: posicion_autobus posicion_autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3327 (class 2606 OID 24839)
-- Name: ruta ruta_codigo_key; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_codigo_key UNIQUE (codigo);


--
-- TOC entry 3353 (class 2606 OID 24859)
-- Name: ruta_geopunto ruta_geopunto_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_pkey PRIMARY KEY (id);


--
-- TOC entry 3356 (class 2606 OID 24895)
-- Name: ruta_geopunto ruta_geopunto_ruta_id_orden_25402e6f_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_ruta_id_orden_25402e6f_uniq UNIQUE (ruta_id, orden);


--
-- TOC entry 3332 (class 2606 OID 24837)
-- Name: ruta ruta_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_pkey PRIMARY KEY (id);


--
-- TOC entry 3364 (class 2606 OID 24902)
-- Name: viaje_autobus viaje_autobus_asignacion_id_numero_viaje_6ce1e16d_uniq; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_asignacion_id_numero_viaje_6ce1e16d_uniq UNIQUE (asignacion_id, numero_viaje);


--
-- TOC entry 3370 (class 2606 OID 24867)
-- Name: viaje_autobus viaje_autobus_pkey; Type: CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_pkey PRIMARY KEY (id);


--
-- TOC entry 3339 (class 1259 OID 24886)
-- Name: asignacion__autobus_0e19a5_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion__autobus_0e19a5_idx ON public.asignacion_autobus_ruta USING btree (autobus_id, fecha);


--
-- TOC entry 3340 (class 1259 OID 24889)
-- Name: asignacion__fecha_9e482c_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion__fecha_9e482c_idx ON public.asignacion_autobus_ruta USING btree (fecha, estado);


--
-- TOC entry 3341 (class 1259 OID 24888)
-- Name: asignacion__piloto__a8f074_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion__piloto__a8f074_idx ON public.asignacion_autobus_ruta USING btree (piloto_id, fecha);


--
-- TOC entry 3342 (class 1259 OID 24887)
-- Name: asignacion__ruta_id_570874_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion__ruta_id_570874_idx ON public.asignacion_autobus_ruta USING btree (ruta_id, fecha);


--
-- TOC entry 3343 (class 1259 OID 24953)
-- Name: asignacion_autobus_ruta_autobus_id_64395eef; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion_autobus_ruta_autobus_id_64395eef ON public.asignacion_autobus_ruta USING btree (autobus_id);


--
-- TOC entry 3346 (class 1259 OID 24954)
-- Name: asignacion_autobus_ruta_piloto_id_fd84a333; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion_autobus_ruta_piloto_id_fd84a333 ON public.asignacion_autobus_ruta USING btree (piloto_id);


--
-- TOC entry 3349 (class 1259 OID 24955)
-- Name: asignacion_autobus_ruta_ruta_id_0cef946c; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX asignacion_autobus_ruta_ruta_id_0cef946c ON public.asignacion_autobus_ruta USING btree (ruta_id);


--
-- TOC entry 3306 (class 1259 OID 24875)
-- Name: autobus_codigo_63adea_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_codigo_63adea_idx ON public.autobus USING btree (codigo);


--
-- TOC entry 3307 (class 1259 OID 24916)
-- Name: autobus_codigo_eebd3613_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_codigo_eebd3613_like ON public.autobus USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3310 (class 1259 OID 24874)
-- Name: autobus_empresa_af2493_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_empresa_af2493_idx ON public.autobus USING btree (empresa_id, activo);


--
-- TOC entry 3311 (class 1259 OID 24918)
-- Name: autobus_empresa_id_0ae4a3fe; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_empresa_id_0ae4a3fe ON public.autobus USING btree (empresa_id);


--
-- TOC entry 3314 (class 1259 OID 24876)
-- Name: autobus_placa_4c0932_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_placa_4c0932_idx ON public.autobus USING btree (placa);


--
-- TOC entry 3315 (class 1259 OID 24917)
-- Name: autobus_placa_60ad2cdf_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX autobus_placa_60ad2cdf_like ON public.autobus USING btree (placa varchar_pattern_ops);


--
-- TOC entry 3298 (class 1259 OID 24909)
-- Name: empresa_tra_activo_219b52_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX empresa_tra_activo_219b52_idx ON public.empresa_transporte USING btree (activo);


--
-- TOC entry 3299 (class 1259 OID 24908)
-- Name: empresa_tra_codigo_00500b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX empresa_tra_codigo_00500b_idx ON public.empresa_transporte USING btree (codigo);


--
-- TOC entry 3300 (class 1259 OID 24910)
-- Name: empresa_tra_nombre_62f3d0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX empresa_tra_nombre_62f3d0_idx ON public.empresa_transporte USING btree (nombre);


--
-- TOC entry 3301 (class 1259 OID 24907)
-- Name: empresa_transporte_codigo_1ff29b2f_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX empresa_transporte_codigo_1ff29b2f_like ON public.empresa_transporte USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3333 (class 1259 OID 24885)
-- Name: parada_activo_ab7555_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX parada_activo_ab7555_idx ON public.parada USING btree (activo);


--
-- TOC entry 3334 (class 1259 OID 24884)
-- Name: parada_latitud_9fd4c1_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX parada_latitud_9fd4c1_idx ON public.parada USING btree (latitud, longitud);


--
-- TOC entry 3337 (class 1259 OID 24937)
-- Name: parada_ruta_id_4defedba; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX parada_ruta_id_4defedba ON public.parada USING btree (ruta_id);


--
-- TOC entry 3338 (class 1259 OID 24883)
-- Name: parada_ruta_id_bc9f8c_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX parada_ruta_id_bc9f8c_idx ON public.parada USING btree (ruta_id, sentido, orden);


--
-- TOC entry 3318 (class 1259 OID 24878)
-- Name: piloto_documen_d18f9b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX piloto_documen_d18f9b_idx ON public.piloto USING btree (documento);


--
-- TOC entry 3319 (class 1259 OID 24877)
-- Name: piloto_empresa_313961_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX piloto_empresa_313961_idx ON public.piloto USING btree (empresa_id, activo);


--
-- TOC entry 3320 (class 1259 OID 24924)
-- Name: piloto_empresa_id_7f76b4b8; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX piloto_empresa_id_7f76b4b8 ON public.piloto USING btree (empresa_id);


--
-- TOC entry 3321 (class 1259 OID 24879)
-- Name: piloto_licenci_d891e1_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX piloto_licenci_d891e1_idx ON public.piloto USING btree (licencia_numero);


--
-- TOC entry 3372 (class 1259 OID 24904)
-- Name: posicion_au_autobus_7f713a_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_au_autobus_7f713a_idx ON public.posicion_autobus USING btree (autobus_id, capturado_en);


--
-- TOC entry 3373 (class 1259 OID 24906)
-- Name: posicion_au_captura_51ba03_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_au_captura_51ba03_idx ON public.posicion_autobus USING btree (capturado_en);


--
-- TOC entry 3374 (class 1259 OID 24905)
-- Name: posicion_au_latitud_e788f4_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_au_latitud_e788f4_idx ON public.posicion_autobus USING btree (latitud, longitud);


--
-- TOC entry 3375 (class 1259 OID 24903)
-- Name: posicion_au_viaje_i_cd7bf0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_au_viaje_i_cd7bf0_idx ON public.posicion_autobus USING btree (viaje_id, capturado_en);


--
-- TOC entry 3376 (class 1259 OID 25008)
-- Name: posicion_autobus_autobus_id_0b447cd8; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_autobus_autobus_id_0b447cd8 ON public.posicion_autobus USING btree (autobus_id);


--
-- TOC entry 3379 (class 1259 OID 25009)
-- Name: posicion_autobus_viaje_id_c2712f5b; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX posicion_autobus_viaje_id_c2712f5b ON public.posicion_autobus USING btree (viaje_id);


--
-- TOC entry 3324 (class 1259 OID 24881)
-- Name: ruta_codigo_711036_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_codigo_711036_idx ON public.ruta USING btree (codigo);


--
-- TOC entry 3325 (class 1259 OID 24930)
-- Name: ruta_codigo_8d8d3b25_like; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_codigo_8d8d3b25_like ON public.ruta USING btree (codigo varchar_pattern_ops);


--
-- TOC entry 3328 (class 1259 OID 24880)
-- Name: ruta_empresa_fefb6b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_empresa_fefb6b_idx ON public.ruta USING btree (empresa_id, activo);


--
-- TOC entry 3329 (class 1259 OID 24931)
-- Name: ruta_empresa_id_5e57d76a; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_empresa_id_5e57d76a ON public.ruta USING btree (empresa_id);


--
-- TOC entry 3350 (class 1259 OID 24893)
-- Name: ruta_geopun_latitud_c3fe61_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_geopun_latitud_c3fe61_idx ON public.ruta_geopunto USING btree (latitud, longitud);


--
-- TOC entry 3351 (class 1259 OID 24892)
-- Name: ruta_geopun_ruta_id_de1a1c_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_geopun_ruta_id_de1a1c_idx ON public.ruta_geopunto USING btree (ruta_id, orden);


--
-- TOC entry 3354 (class 1259 OID 24961)
-- Name: ruta_geopunto_ruta_id_14d38479; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_geopunto_ruta_id_14d38479 ON public.ruta_geopunto USING btree (ruta_id);


--
-- TOC entry 3330 (class 1259 OID 24882)
-- Name: ruta_nombre_20fd38_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX ruta_nombre_20fd38_idx ON public.ruta USING btree (nombre);


--
-- TOC entry 3357 (class 1259 OID 24896)
-- Name: viaje_autob_asignac_71f8ef_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autob_asignac_71f8ef_idx ON public.viaje_autobus USING btree (asignacion_id, numero_viaje);


--
-- TOC entry 3358 (class 1259 OID 24897)
-- Name: viaje_autob_autobus_e6ea94_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autob_autobus_e6ea94_idx ON public.viaje_autobus USING btree (autobus_id, inicio_en);


--
-- TOC entry 3359 (class 1259 OID 24899)
-- Name: viaje_autob_estado_0f24d0_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autob_estado_0f24d0_idx ON public.viaje_autobus USING btree (estado);


--
-- TOC entry 3360 (class 1259 OID 24900)
-- Name: viaje_autob_inicio__5ae81b_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autob_inicio__5ae81b_idx ON public.viaje_autobus USING btree (inicio_en, fin_en);


--
-- TOC entry 3361 (class 1259 OID 24898)
-- Name: viaje_autob_ruta_id_5f2ba8_idx; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autob_ruta_id_5f2ba8_idx ON public.viaje_autobus USING btree (ruta_id, inicio_en);


--
-- TOC entry 3362 (class 1259 OID 24992)
-- Name: viaje_autobus_asignacion_id_094b4304; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_asignacion_id_094b4304 ON public.viaje_autobus USING btree (asignacion_id);


--
-- TOC entry 3365 (class 1259 OID 24993)
-- Name: viaje_autobus_autobus_id_0d859c06; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_autobus_id_0d859c06 ON public.viaje_autobus USING btree (autobus_id);


--
-- TOC entry 3366 (class 1259 OID 24994)
-- Name: viaje_autobus_parada_fin_id_5655796e; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_parada_fin_id_5655796e ON public.viaje_autobus USING btree (parada_fin_id);


--
-- TOC entry 3367 (class 1259 OID 24995)
-- Name: viaje_autobus_parada_inicio_id_ebdbd2cc; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_parada_inicio_id_ebdbd2cc ON public.viaje_autobus USING btree (parada_inicio_id);


--
-- TOC entry 3368 (class 1259 OID 24996)
-- Name: viaje_autobus_piloto_id_5edaebf1; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_piloto_id_5edaebf1 ON public.viaje_autobus USING btree (piloto_id);


--
-- TOC entry 3371 (class 1259 OID 24997)
-- Name: viaje_autobus_ruta_id_fa1dd689; Type: INDEX; Schema: public; Owner: admin_user
--

CREATE INDEX viaje_autobus_ruta_id_fa1dd689 ON public.viaje_autobus USING btree (ruta_id);


--
-- TOC entry 3384 (class 2606 OID 24938)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_autobus_id_64395eef_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_autobus_id_64395eef_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3385 (class 2606 OID 24943)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_piloto_id_fd84a333_fk_piloto_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_piloto_id_fd84a333_fk_piloto_id FOREIGN KEY (piloto_id) REFERENCES public.piloto(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3386 (class 2606 OID 24948)
-- Name: asignacion_autobus_ruta asignacion_autobus_ruta_ruta_id_0cef946c_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.asignacion_autobus_ruta
    ADD CONSTRAINT asignacion_autobus_ruta_ruta_id_0cef946c_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3380 (class 2606 OID 24911)
-- Name: autobus autobus_empresa_id_0ae4a3fe_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.autobus
    ADD CONSTRAINT autobus_empresa_id_0ae4a3fe_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3383 (class 2606 OID 24932)
-- Name: parada parada_ruta_id_4defedba_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.parada
    ADD CONSTRAINT parada_ruta_id_4defedba_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3381 (class 2606 OID 24919)
-- Name: piloto piloto_empresa_id_7f76b4b8_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.piloto
    ADD CONSTRAINT piloto_empresa_id_7f76b4b8_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3394 (class 2606 OID 24998)
-- Name: posicion_autobus posicion_autobus_autobus_id_0b447cd8_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_autobus_id_0b447cd8_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3395 (class 2606 OID 25003)
-- Name: posicion_autobus posicion_autobus_viaje_id_c2712f5b_fk_viaje_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.posicion_autobus
    ADD CONSTRAINT posicion_autobus_viaje_id_c2712f5b_fk_viaje_autobus_id FOREIGN KEY (viaje_id) REFERENCES public.viaje_autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3382 (class 2606 OID 24925)
-- Name: ruta ruta_empresa_id_5e57d76a_fk_empresa_transporte_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta
    ADD CONSTRAINT ruta_empresa_id_5e57d76a_fk_empresa_transporte_id FOREIGN KEY (empresa_id) REFERENCES public.empresa_transporte(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3387 (class 2606 OID 24956)
-- Name: ruta_geopunto ruta_geopunto_ruta_id_14d38479_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.ruta_geopunto
    ADD CONSTRAINT ruta_geopunto_ruta_id_14d38479_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3388 (class 2606 OID 24962)
-- Name: viaje_autobus viaje_autobus_asignacion_id_094b4304_fk_asignacio; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_asignacion_id_094b4304_fk_asignacio FOREIGN KEY (asignacion_id) REFERENCES public.asignacion_autobus_ruta(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3389 (class 2606 OID 24967)
-- Name: viaje_autobus viaje_autobus_autobus_id_0d859c06_fk_autobus_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_autobus_id_0d859c06_fk_autobus_id FOREIGN KEY (autobus_id) REFERENCES public.autobus(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3390 (class 2606 OID 24972)
-- Name: viaje_autobus viaje_autobus_parada_fin_id_5655796e_fk_parada_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_parada_fin_id_5655796e_fk_parada_id FOREIGN KEY (parada_fin_id) REFERENCES public.parada(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3391 (class 2606 OID 24977)
-- Name: viaje_autobus viaje_autobus_parada_inicio_id_ebdbd2cc_fk_parada_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_parada_inicio_id_ebdbd2cc_fk_parada_id FOREIGN KEY (parada_inicio_id) REFERENCES public.parada(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3392 (class 2606 OID 24982)
-- Name: viaje_autobus viaje_autobus_piloto_id_5edaebf1_fk_piloto_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_piloto_id_5edaebf1_fk_piloto_id FOREIGN KEY (piloto_id) REFERENCES public.piloto(id) DEFERRABLE INITIALLY DEFERRED;


--
-- TOC entry 3393 (class 2606 OID 24987)
-- Name: viaje_autobus viaje_autobus_ruta_id_fa1dd689_fk_ruta_id; Type: FK CONSTRAINT; Schema: public; Owner: admin_user
--

ALTER TABLE ONLY public.viaje_autobus
    ADD CONSTRAINT viaje_autobus_ruta_id_fa1dd689_fk_ruta_id FOREIGN KEY (ruta_id) REFERENCES public.ruta(id) DEFERRABLE INITIALLY DEFERRED;


-- Completed on 2025-10-26 11:17:27 CST

--
-- PostgreSQL database dump complete
--

-- Completed on 2025-10-26 11:17:27 CST

--
-- PostgreSQL database cluster dump complete
--

