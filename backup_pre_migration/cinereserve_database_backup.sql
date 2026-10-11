--
-- PostgreSQL database dump
--

\restrict DHpsl2XgzJydy6DC4L1n08AusrV02qIlWy7s4smW3eaiaGKhZUhmjTNQBPiPAw2

-- Dumped from database version 18.6
-- Dumped by pg_dump version 18.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: prisma_contract; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA prisma_contract;


ALTER SCHEMA prisma_contract OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: contract; Type: TABLE; Schema: prisma_contract; Owner: postgres
--

CREATE TABLE prisma_contract.contract (
    core_hash text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    contract_json jsonb NOT NULL
);


ALTER TABLE prisma_contract.contract OWNER TO postgres;

--
-- Name: ledger; Type: TABLE; Schema: prisma_contract; Owner: postgres
--

CREATE TABLE prisma_contract.ledger (
    id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    space text NOT NULL,
    migration_name text NOT NULL,
    migration_hash text NOT NULL,
    origin_core_hash text,
    origin_profile_hash text,
    destination_core_hash text NOT NULL,
    destination_profile_hash text,
    operations jsonb NOT NULL
);


ALTER TABLE prisma_contract.ledger OWNER TO postgres;

--
-- Name: ledger_id_seq; Type: SEQUENCE; Schema: prisma_contract; Owner: postgres
--

CREATE SEQUENCE prisma_contract.ledger_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE prisma_contract.ledger_id_seq OWNER TO postgres;

--
-- Name: ledger_id_seq; Type: SEQUENCE OWNED BY; Schema: prisma_contract; Owner: postgres
--

ALTER SEQUENCE prisma_contract.ledger_id_seq OWNED BY prisma_contract.ledger.id;


--
-- Name: marker; Type: TABLE; Schema: prisma_contract; Owner: postgres
--

CREATE TABLE prisma_contract.marker (
    space text DEFAULT 'app'::text NOT NULL,
    core_hash text NOT NULL,
    profile_hash text NOT NULL,
    contract_json jsonb,
    canonical_version integer,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    app_tag text,
    meta jsonb DEFAULT '{}'::jsonb NOT NULL,
    invariants text[] DEFAULT '{}'::text[] NOT NULL
);


ALTER TABLE prisma_contract.marker OWNER TO postgres;

--
-- Name: Booking; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Booking" (
    "bookingId" text NOT NULL,
    "cinemaId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    "movieId" integer NOT NULL,
    "seatId" integer NOT NULL,
    "showId" integer NOT NULL,
    status text DEFAULT 'CONFIRMED'::text NOT NULL,
    "totalAmount" double precision NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "userId" integer
);


ALTER TABLE public."Booking" OWNER TO postgres;

--
-- Name: Booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Booking_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Booking_id_seq" OWNER TO postgres;

--
-- Name: Booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Booking_id_seq" OWNED BY public."Booking".id;


--
-- Name: Cinema; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Cinema" (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    location text NOT NULL,
    name text NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Cinema" OWNER TO postgres;

--
-- Name: Cinema_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Cinema_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Cinema_id_seq" OWNER TO postgres;

--
-- Name: Cinema_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Cinema_id_seq" OWNED BY public."Cinema".id;


--
-- Name: Movie; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Movie" (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    description text,
    duration text,
    genre text NOT NULL,
    id integer NOT NULL,
    image text,
    rating text,
    title text NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    cinemas json,
    languages json
);


ALTER TABLE public."Movie" OWNER TO postgres;

--
-- Name: Movie_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Movie_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Movie_id_seq" OWNER TO postgres;

--
-- Name: Movie_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Movie_id_seq" OWNED BY public."Movie".id;


--
-- Name: Seat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Seat" (
    "cinemaId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    id integer NOT NULL,
    "seatNumber" text NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Seat" OWNER TO postgres;

--
-- Name: Seat_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Seat_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Seat_id_seq" OWNER TO postgres;

--
-- Name: Seat_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Seat_id_seq" OWNED BY public."Seat".id;


--
-- Name: Show; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Show" (
    "cinemaId" integer NOT NULL,
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    date text NOT NULL,
    format text NOT NULL,
    id integer NOT NULL,
    "movieId" integer NOT NULL,
    "time" text NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public."Show" OWNER TO postgres;

--
-- Name: Show_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."Show_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."Show_id_seq" OWNER TO postgres;

--
-- Name: Show_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."Show_id_seq" OWNED BY public."Show".id;


--
-- Name: User; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."User" (
    "createdAt" timestamp with time zone DEFAULT now() NOT NULL,
    email text NOT NULL,
    id integer NOT NULL,
    name text,
    "updatedAt" timestamp with time zone NOT NULL,
    username text,
    password text NOT NULL
);


ALTER TABLE public."User" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public."User_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public."User_id_seq" OWNER TO postgres;

--
-- Name: User_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public."User_id_seq" OWNED BY public."User".id;


--
-- Name: ledger id; Type: DEFAULT; Schema: prisma_contract; Owner: postgres
--

ALTER TABLE ONLY prisma_contract.ledger ALTER COLUMN id SET DEFAULT nextval('prisma_contract.ledger_id_seq'::regclass);


--
-- Name: Booking id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking" ALTER COLUMN id SET DEFAULT nextval('public."Booking_id_seq"'::regclass);


--
-- Name: Cinema id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema" ALTER COLUMN id SET DEFAULT nextval('public."Cinema_id_seq"'::regclass);


--
-- Name: Movie id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie" ALTER COLUMN id SET DEFAULT nextval('public."Movie_id_seq"'::regclass);


--
-- Name: Seat id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat" ALTER COLUMN id SET DEFAULT nextval('public."Seat_id_seq"'::regclass);


--
-- Name: Show id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Show" ALTER COLUMN id SET DEFAULT nextval('public."Show_id_seq"'::regclass);


--
-- Name: User id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User" ALTER COLUMN id SET DEFAULT nextval('public."User_id_seq"'::regclass);


--
-- Data for Name: contract; Type: TABLE DATA; Schema: prisma_contract; Owner: postgres
--

COPY prisma_contract.contract (core_hash, created_at, contract_json) FROM stdin;
952ce2cae9764645008e3a33f232e38865f8d7415dd4b4a80a4a8101cff50d40	2026-10-07 22:22:47.354808+05:30	{"meta": {}, "roots": {"Seat": {"model": "Seat", "namespace": "public"}, "Show": {"model": "Show", "namespace": "public"}, "User": {"model": "User", "namespace": "public"}, "Movie": {"model": "Movie", "namespace": "public"}, "Cinema": {"model": "Cinema", "namespace": "public"}, "Booking": {"model": "Booking", "namespace": "public"}}, "domain": {"namespaces": {"public": {"models": {"Seat": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "seatNumber": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}}, "storage": {"table": "Seat", "fields": {"id": {"column": "id"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "seatNumber": {"column": "seatNumber"}}, "namespaceId": "public"}, "relations": {"cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["seatId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Show": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "date": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "time": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "format": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Show", "fields": {"id": {"column": "id"}, "date": {"column": "date"}, "time": {"column": "time"}, "format": {"column": "format"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["showId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "User": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "email": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "username": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "User", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "email": {"column": "email"}, "username": {"column": "username"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"bookings": {"on": {"localFields": ["id"], "targetFields": ["userId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Movie": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "genre": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "image": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "title": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "rating": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "duration": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "description": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}}, "storage": {"table": "Movie", "fields": {"id": {"column": "id"}, "genre": {"column": "genre"}, "image": {"column": "image"}, "title": {"column": "title"}, "rating": {"column": "rating"}, "duration": {"column": "duration"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "description": {"column": "description"}}, "namespaceId": "public"}, "relations": {"shows": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Cinema": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "location": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Cinema", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "location": {"column": "location"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"seats": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Seat", "namespace": "public"}, "cardinality": "1:N"}, "shows": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Booking": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "seatId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "showId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "status": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "userId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": true}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "bookingId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "totalAmount": {"many": false, "type": {"kind": "scalar", "codecId": "pg/float8@1"}, "nullable": false}}, "storage": {"table": "Booking", "fields": {"id": {"column": "id"}, "seatId": {"column": "seatId"}, "showId": {"column": "showId"}, "status": {"column": "status"}, "userId": {"column": "userId"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "bookingId": {"column": "bookingId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "totalAmount": {"column": "totalAmount"}}, "namespaceId": "public"}, "relations": {"seat": {"on": {"localFields": ["seatId"], "targetFields": ["id"]}, "to": {"model": "Seat", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "show": {"on": {"localFields": ["showId"], "targetFields": ["id"]}, "to": {"model": "Show", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "user": {"on": {"localFields": ["userId"], "targetFields": ["id"]}, "to": {"model": "User", "namespace": "public"}, "nullable": true, "cardinality": "N:1"}, "movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}}}}}}}, "target": "postgres", "storage": {"namespaces": {"public": {"id": "public", "entries": {"table": {"Seat": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "seatNumber": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}}, "indexes": [{"name": "Seat_cinemaId_idx_3adcf06e", "prefix": "Seat_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}], "uniques": [{"columns": ["cinemaId", "seatNumber"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["cinemaId"], "tableName": "Seat", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "Show": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "date": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "time": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "format": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [{"name": "Show_cinemaId_idx_3adcf06e", "prefix": "Show_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Show_movieId_idx_8cb9f9db", "prefix": "Show_movieId_idx", "unique": false, "columns": ["movieId"]}], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["movieId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "User": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "email": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "username": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["email"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Movie": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "genre": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "image": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "title": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "rating": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "duration": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "description": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}}, "indexes": [], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Cinema": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "location": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["name"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Booking": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "seatId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "showId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "status": {"many": false, "codecId": "pg/text@1", "default": {"kind": "literal", "value": "CONFIRMED"}, "dataType": "pg/text", "nullable": false}, "userId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": true}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "bookingId": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "totalAmount": {"many": false, "codecId": "pg/float8@1", "dataType": "pg/float8", "nullable": false}}, "indexes": [{"name": "Booking_cinemaId_idx_3adcf06e", "prefix": "Booking_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Booking_movieId_idx_8cb9f9db", "prefix": "Booking_movieId_idx", "unique": false, "columns": ["movieId"]}, {"name": "Booking_seatId_idx_3076c3cd", "prefix": "Booking_seatId_idx", "unique": false, "columns": ["seatId"]}, {"name": "Booking_showId_idx_32b6b4ec", "prefix": "Booking_showId_idx", "unique": false, "columns": ["showId"]}, {"name": "Booking_userId_idx_a489d58a", "prefix": "Booking_userId_idx", "unique": false, "columns": ["userId"]}], "uniques": [{"columns": ["bookingId"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["userId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "User", "namespaceId": "public"}}, {"source": {"columns": ["movieId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}, {"source": {"columns": ["showId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Show", "namespaceId": "public"}}, {"source": {"columns": ["seatId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Seat", "namespaceId": "public"}}]}}}}}, "storageHash": "952ce2cae9764645008e3a33f232e38865f8d7415dd4b4a80a4a8101cff50d40"}, "execution": {"mutations": {"defaults": [{"ref": {"entry": "Booking", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Cinema", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Movie", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Seat", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Show", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "User", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}]}, "executionHash": "243192d52a71b103be7ecb8fd21b75fabd2cb949bd989c8172b274d09d480c09"}, "extensions": {}, "profileHash": "3916f444a8a17ad749191acf9e08dad97d1a327b88c2f1d45d12f240296aa8b2", "capabilities": {"sql": {"enums": true, "lockOf": true, "lateral": true, "forShare": true, "forUpdate": true, "returning": true, "lockNowait": true, "scalarList": true, "lockSkipLocked": true, "checkConstraint": true, "defaultInInsert": true, "insertOnConflictSkip": true, "insertOnConflictWithoutTarget": true}, "postgres": {"limit": true, "jsonAgg": true, "lateral": true, "orderBy": true, "returning": true, "distinctOn": true, "forKeyShare": true, "forNoKeyUpdate": true}}, "targetFamily": "sql"}
52e70aa1b5501a4c793fa80c539bb9083a83cff637cdf69fa35341c54c0d206c	2026-10-08 00:02:59.915377+05:30	{"meta": {}, "roots": {"Seat": {"model": "Seat", "namespace": "public"}, "Show": {"model": "Show", "namespace": "public"}, "User": {"model": "User", "namespace": "public"}, "Movie": {"model": "Movie", "namespace": "public"}, "Cinema": {"model": "Cinema", "namespace": "public"}, "Booking": {"model": "Booking", "namespace": "public"}}, "domain": {"namespaces": {"public": {"models": {"Seat": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "seatNumber": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}}, "storage": {"table": "Seat", "fields": {"id": {"column": "id"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "seatNumber": {"column": "seatNumber"}}, "namespaceId": "public"}, "relations": {"cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["seatId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Show": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "date": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "time": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "format": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Show", "fields": {"id": {"column": "id"}, "date": {"column": "date"}, "time": {"column": "time"}, "format": {"column": "format"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["showId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "User": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "email": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "username": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "User", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "email": {"column": "email"}, "username": {"column": "username"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"bookings": {"on": {"localFields": ["id"], "targetFields": ["userId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Movie": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "genre": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "image": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "title": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "rating": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "cinemas": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "duration": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "languages": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "description": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}}, "storage": {"table": "Movie", "fields": {"id": {"column": "id"}, "genre": {"column": "genre"}, "image": {"column": "image"}, "title": {"column": "title"}, "rating": {"column": "rating"}, "cinemas": {"column": "cinemas"}, "duration": {"column": "duration"}, "createdAt": {"column": "createdAt"}, "languages": {"column": "languages"}, "updatedAt": {"column": "updatedAt"}, "description": {"column": "description"}}, "namespaceId": "public"}, "relations": {"shows": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Cinema": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "location": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Cinema", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "location": {"column": "location"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"seats": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Seat", "namespace": "public"}, "cardinality": "1:N"}, "shows": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Booking": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "seatId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "showId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "status": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "userId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": true}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "bookingId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "totalAmount": {"many": false, "type": {"kind": "scalar", "codecId": "pg/float8@1"}, "nullable": false}}, "storage": {"table": "Booking", "fields": {"id": {"column": "id"}, "seatId": {"column": "seatId"}, "showId": {"column": "showId"}, "status": {"column": "status"}, "userId": {"column": "userId"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "bookingId": {"column": "bookingId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "totalAmount": {"column": "totalAmount"}}, "namespaceId": "public"}, "relations": {"seat": {"on": {"localFields": ["seatId"], "targetFields": ["id"]}, "to": {"model": "Seat", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "show": {"on": {"localFields": ["showId"], "targetFields": ["id"]}, "to": {"model": "Show", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "user": {"on": {"localFields": ["userId"], "targetFields": ["id"]}, "to": {"model": "User", "namespace": "public"}, "nullable": true, "cardinality": "N:1"}, "movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}}}}}}}, "target": "postgres", "storage": {"namespaces": {"public": {"id": "public", "entries": {"table": {"Seat": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "seatNumber": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}}, "indexes": [{"name": "Seat_cinemaId_idx_3adcf06e", "prefix": "Seat_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}], "uniques": [{"columns": ["cinemaId", "seatNumber"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["cinemaId"], "tableName": "Seat", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "Show": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "date": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "time": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "format": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [{"name": "Show_cinemaId_idx_3adcf06e", "prefix": "Show_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Show_movieId_idx_8cb9f9db", "prefix": "Show_movieId_idx", "unique": false, "columns": ["movieId"]}], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["movieId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "User": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "email": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "username": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["email"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Movie": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "genre": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "image": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "title": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "rating": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "cinemas": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "duration": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "languages": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "description": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}}, "indexes": [], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Cinema": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "location": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["name"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Booking": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "seatId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "showId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "status": {"many": false, "codecId": "pg/text@1", "default": {"kind": "literal", "value": "CONFIRMED"}, "dataType": "pg/text", "nullable": false}, "userId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": true}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "bookingId": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "totalAmount": {"many": false, "codecId": "pg/float8@1", "dataType": "pg/float8", "nullable": false}}, "indexes": [{"name": "Booking_cinemaId_idx_3adcf06e", "prefix": "Booking_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Booking_movieId_idx_8cb9f9db", "prefix": "Booking_movieId_idx", "unique": false, "columns": ["movieId"]}, {"name": "Booking_seatId_idx_3076c3cd", "prefix": "Booking_seatId_idx", "unique": false, "columns": ["seatId"]}, {"name": "Booking_showId_idx_32b6b4ec", "prefix": "Booking_showId_idx", "unique": false, "columns": ["showId"]}, {"name": "Booking_userId_idx_a489d58a", "prefix": "Booking_userId_idx", "unique": false, "columns": ["userId"]}], "uniques": [{"columns": ["bookingId"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["userId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "User", "namespaceId": "public"}}, {"source": {"columns": ["movieId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}, {"source": {"columns": ["showId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Show", "namespaceId": "public"}}, {"source": {"columns": ["seatId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Seat", "namespaceId": "public"}}]}}}}}, "storageHash": "52e70aa1b5501a4c793fa80c539bb9083a83cff637cdf69fa35341c54c0d206c"}, "execution": {"mutations": {"defaults": [{"ref": {"entry": "Booking", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Cinema", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Movie", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Seat", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Show", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "User", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}]}, "executionHash": "243192d52a71b103be7ecb8fd21b75fabd2cb949bd989c8172b274d09d480c09"}, "extensions": {}, "profileHash": "3916f444a8a17ad749191acf9e08dad97d1a327b88c2f1d45d12f240296aa8b2", "capabilities": {"sql": {"enums": true, "lockOf": true, "lateral": true, "forShare": true, "forUpdate": true, "returning": true, "lockNowait": true, "scalarList": true, "lockSkipLocked": true, "checkConstraint": true, "defaultInInsert": true, "insertOnConflictSkip": true, "insertOnConflictWithoutTarget": true}, "postgres": {"limit": true, "jsonAgg": true, "lateral": true, "orderBy": true, "returning": true, "distinctOn": true, "forKeyShare": true, "forNoKeyUpdate": true}}, "targetFamily": "sql"}
92d1a0b09eba8d8c1176dc35bb2ecda5582fb172da65279083266f80d5521caf	2026-10-08 00:24:58.117574+05:30	{"meta": {}, "roots": {"Seat": {"model": "Seat", "namespace": "public"}, "Show": {"model": "Show", "namespace": "public"}, "User": {"model": "User", "namespace": "public"}, "Movie": {"model": "Movie", "namespace": "public"}, "Cinema": {"model": "Cinema", "namespace": "public"}, "Booking": {"model": "Booking", "namespace": "public"}}, "domain": {"namespaces": {"public": {"models": {"Seat": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "seatNumber": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}}, "storage": {"table": "Seat", "fields": {"id": {"column": "id"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "seatNumber": {"column": "seatNumber"}}, "namespaceId": "public"}, "relations": {"cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["seatId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Show": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "date": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "time": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "format": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Show", "fields": {"id": {"column": "id"}, "date": {"column": "date"}, "time": {"column": "time"}, "format": {"column": "format"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["showId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "User": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "email": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "username": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "User", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "email": {"column": "email"}, "username": {"column": "username"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"bookings": {"on": {"localFields": ["id"], "targetFields": ["userId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Movie": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "genre": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "image": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "title": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "rating": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "cinemas": {"many": false, "type": {"kind": "scalar", "codecId": "pg/json@1"}, "nullable": true}, "duration": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "languages": {"many": false, "type": {"kind": "scalar", "codecId": "pg/json@1"}, "nullable": true}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "description": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}}, "storage": {"table": "Movie", "fields": {"id": {"column": "id"}, "genre": {"column": "genre"}, "image": {"column": "image"}, "title": {"column": "title"}, "rating": {"column": "rating"}, "cinemas": {"column": "cinemas"}, "duration": {"column": "duration"}, "createdAt": {"column": "createdAt"}, "languages": {"column": "languages"}, "updatedAt": {"column": "updatedAt"}, "description": {"column": "description"}}, "namespaceId": "public"}, "relations": {"shows": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Cinema": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "location": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Cinema", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "location": {"column": "location"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"seats": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Seat", "namespace": "public"}, "cardinality": "1:N"}, "shows": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Booking": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "seatId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "showId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "status": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "userId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": true}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "bookingId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "totalAmount": {"many": false, "type": {"kind": "scalar", "codecId": "pg/float8@1"}, "nullable": false}}, "storage": {"table": "Booking", "fields": {"id": {"column": "id"}, "seatId": {"column": "seatId"}, "showId": {"column": "showId"}, "status": {"column": "status"}, "userId": {"column": "userId"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "bookingId": {"column": "bookingId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "totalAmount": {"column": "totalAmount"}}, "namespaceId": "public"}, "relations": {"seat": {"on": {"localFields": ["seatId"], "targetFields": ["id"]}, "to": {"model": "Seat", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "show": {"on": {"localFields": ["showId"], "targetFields": ["id"]}, "to": {"model": "Show", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "user": {"on": {"localFields": ["userId"], "targetFields": ["id"]}, "to": {"model": "User", "namespace": "public"}, "nullable": true, "cardinality": "N:1"}, "movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}}}}}}}, "target": "postgres", "storage": {"namespaces": {"public": {"id": "public", "entries": {"table": {"Seat": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "seatNumber": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}}, "indexes": [{"name": "Seat_cinemaId_idx_3adcf06e", "prefix": "Seat_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}], "uniques": [{"columns": ["cinemaId", "seatNumber"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["cinemaId"], "tableName": "Seat", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "Show": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "date": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "time": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "format": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [{"name": "Show_cinemaId_idx_3adcf06e", "prefix": "Show_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Show_movieId_idx_8cb9f9db", "prefix": "Show_movieId_idx", "unique": false, "columns": ["movieId"]}], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["movieId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "User": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "email": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "username": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["email"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Movie": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "genre": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "image": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "title": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "rating": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "cinemas": {"many": false, "codecId": "pg/json@1", "dataType": "pg/json", "nullable": true}, "duration": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "languages": {"many": false, "codecId": "pg/json@1", "dataType": "pg/json", "nullable": true}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "description": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}}, "indexes": [], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Cinema": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "location": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["name"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Booking": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "seatId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "showId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "status": {"many": false, "codecId": "pg/text@1", "default": {"kind": "literal", "value": "CONFIRMED"}, "dataType": "pg/text", "nullable": false}, "userId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": true}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "bookingId": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "totalAmount": {"many": false, "codecId": "pg/float8@1", "dataType": "pg/float8", "nullable": false}}, "indexes": [{"name": "Booking_cinemaId_idx_3adcf06e", "prefix": "Booking_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Booking_movieId_idx_8cb9f9db", "prefix": "Booking_movieId_idx", "unique": false, "columns": ["movieId"]}, {"name": "Booking_seatId_idx_3076c3cd", "prefix": "Booking_seatId_idx", "unique": false, "columns": ["seatId"]}, {"name": "Booking_showId_idx_32b6b4ec", "prefix": "Booking_showId_idx", "unique": false, "columns": ["showId"]}, {"name": "Booking_userId_idx_a489d58a", "prefix": "Booking_userId_idx", "unique": false, "columns": ["userId"]}], "uniques": [{"columns": ["bookingId"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["userId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "User", "namespaceId": "public"}}, {"source": {"columns": ["movieId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}, {"source": {"columns": ["showId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Show", "namespaceId": "public"}}, {"source": {"columns": ["seatId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Seat", "namespaceId": "public"}}]}}}}}, "storageHash": "92d1a0b09eba8d8c1176dc35bb2ecda5582fb172da65279083266f80d5521caf"}, "execution": {"mutations": {"defaults": [{"ref": {"entry": "Booking", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Cinema", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Movie", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Seat", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Show", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "User", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}]}, "executionHash": "243192d52a71b103be7ecb8fd21b75fabd2cb949bd989c8172b274d09d480c09"}, "extensions": {}, "profileHash": "3916f444a8a17ad749191acf9e08dad97d1a327b88c2f1d45d12f240296aa8b2", "capabilities": {"sql": {"enums": true, "lockOf": true, "lateral": true, "forShare": true, "forUpdate": true, "returning": true, "lockNowait": true, "scalarList": true, "lockSkipLocked": true, "checkConstraint": true, "defaultInInsert": true, "insertOnConflictSkip": true, "insertOnConflictWithoutTarget": true}, "postgres": {"limit": true, "jsonAgg": true, "lateral": true, "orderBy": true, "returning": true, "distinctOn": true, "forKeyShare": true, "forNoKeyUpdate": true}}, "targetFamily": "sql"}
9e43861eb009dab0746ef3bebfe790526b0a561277ce4eb13ceb753f8297592b	2026-10-09 01:48:37.064169+05:30	{"meta": {}, "roots": {"Seat": {"model": "Seat", "namespace": "public"}, "Show": {"model": "Show", "namespace": "public"}, "User": {"model": "User", "namespace": "public"}, "Movie": {"model": "Movie", "namespace": "public"}, "Cinema": {"model": "Cinema", "namespace": "public"}, "Booking": {"model": "Booking", "namespace": "public"}}, "domain": {"namespaces": {"public": {"models": {"Seat": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "seatNumber": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}}, "storage": {"table": "Seat", "fields": {"id": {"column": "id"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "seatNumber": {"column": "seatNumber"}}, "namespaceId": "public"}, "relations": {"cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["seatId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Show": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "date": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "time": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "format": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Show", "fields": {"id": {"column": "id"}, "date": {"column": "date"}, "time": {"column": "time"}, "format": {"column": "format"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["showId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "User": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "email": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "password": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "username": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "User", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "email": {"column": "email"}, "password": {"column": "password"}, "username": {"column": "username"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"bookings": {"on": {"localFields": ["id"], "targetFields": ["userId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Movie": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "genre": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "image": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "title": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "rating": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "cinemas": {"many": false, "type": {"kind": "scalar", "codecId": "pg/json@1"}, "nullable": true}, "duration": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "languages": {"many": false, "type": {"kind": "scalar", "codecId": "pg/json@1"}, "nullable": true}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "description": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": true}}, "storage": {"table": "Movie", "fields": {"id": {"column": "id"}, "genre": {"column": "genre"}, "image": {"column": "image"}, "title": {"column": "title"}, "rating": {"column": "rating"}, "cinemas": {"column": "cinemas"}, "duration": {"column": "duration"}, "createdAt": {"column": "createdAt"}, "languages": {"column": "languages"}, "updatedAt": {"column": "updatedAt"}, "description": {"column": "description"}}, "namespaceId": "public"}, "relations": {"shows": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["movieId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Cinema": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "name": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "location": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}}, "storage": {"table": "Cinema", "fields": {"id": {"column": "id"}, "name": {"column": "name"}, "location": {"column": "location"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}}, "namespaceId": "public"}, "relations": {"seats": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Seat", "namespace": "public"}, "cardinality": "1:N"}, "shows": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Show", "namespace": "public"}, "cardinality": "1:N"}, "bookings": {"on": {"localFields": ["id"], "targetFields": ["cinemaId"]}, "to": {"model": "Booking", "namespace": "public"}, "cardinality": "1:N"}}}, "Booking": {"fields": {"id": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "seatId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "showId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "status": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "userId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": true}, "movieId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "cinemaId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/int4@1"}, "nullable": false}, "bookingId": {"many": false, "type": {"kind": "scalar", "codecId": "pg/text@1"}, "nullable": false}, "createdAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "updatedAt": {"many": false, "type": {"kind": "scalar", "codecId": "pg/timestamptz-string@1"}, "nullable": false}, "totalAmount": {"many": false, "type": {"kind": "scalar", "codecId": "pg/float8@1"}, "nullable": false}}, "storage": {"table": "Booking", "fields": {"id": {"column": "id"}, "seatId": {"column": "seatId"}, "showId": {"column": "showId"}, "status": {"column": "status"}, "userId": {"column": "userId"}, "movieId": {"column": "movieId"}, "cinemaId": {"column": "cinemaId"}, "bookingId": {"column": "bookingId"}, "createdAt": {"column": "createdAt"}, "updatedAt": {"column": "updatedAt"}, "totalAmount": {"column": "totalAmount"}}, "namespaceId": "public"}, "relations": {"seat": {"on": {"localFields": ["seatId"], "targetFields": ["id"]}, "to": {"model": "Seat", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "show": {"on": {"localFields": ["showId"], "targetFields": ["id"]}, "to": {"model": "Show", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "user": {"on": {"localFields": ["userId"], "targetFields": ["id"]}, "to": {"model": "User", "namespace": "public"}, "nullable": true, "cardinality": "N:1"}, "movie": {"on": {"localFields": ["movieId"], "targetFields": ["id"]}, "to": {"model": "Movie", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}, "cinema": {"on": {"localFields": ["cinemaId"], "targetFields": ["id"]}, "to": {"model": "Cinema", "namespace": "public"}, "nullable": false, "cardinality": "N:1"}}}}}}}, "target": "postgres", "storage": {"namespaces": {"public": {"id": "public", "entries": {"table": {"Seat": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "seatNumber": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}}, "indexes": [{"name": "Seat_cinemaId_idx_3adcf06e", "prefix": "Seat_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}], "uniques": [{"columns": ["cinemaId", "seatNumber"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["cinemaId"], "tableName": "Seat", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "Show": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "date": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "time": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "format": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [{"name": "Show_cinemaId_idx_3adcf06e", "prefix": "Show_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Show_movieId_idx_8cb9f9db", "prefix": "Show_movieId_idx", "unique": false, "columns": ["movieId"]}], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["movieId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Show", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}]}, "User": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "email": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "password": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "username": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["email"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Movie": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "genre": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "image": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "title": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "rating": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "cinemas": {"many": false, "codecId": "pg/json@1", "dataType": "pg/json", "nullable": true}, "duration": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "languages": {"many": false, "codecId": "pg/json@1", "dataType": "pg/json", "nullable": true}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "description": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": true}}, "indexes": [], "uniques": [], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Cinema": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "name": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "location": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}}, "indexes": [], "uniques": [{"columns": ["name"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": []}, "Booking": {"columns": {"id": {"many": false, "codecId": "pg/int4@1", "default": {"kind": "function", "expression": "autoincrement()"}, "dataType": "pg/int4", "nullable": false}, "seatId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "showId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "status": {"many": false, "codecId": "pg/text@1", "default": {"kind": "literal", "value": "CONFIRMED"}, "dataType": "pg/text", "nullable": false}, "userId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": true}, "movieId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "cinemaId": {"many": false, "codecId": "pg/int4@1", "dataType": "pg/int4", "nullable": false}, "bookingId": {"many": false, "codecId": "pg/text@1", "dataType": "pg/text", "nullable": false}, "createdAt": {"many": false, "codecId": "pg/timestamptz-string@1", "default": {"kind": "function", "expression": "now()"}, "dataType": "pg/timestamptz", "nullable": false}, "updatedAt": {"many": false, "codecId": "pg/timestamptz-string@1", "dataType": "pg/timestamptz", "nullable": false}, "totalAmount": {"many": false, "codecId": "pg/float8@1", "dataType": "pg/float8", "nullable": false}}, "indexes": [{"name": "Booking_cinemaId_idx_3adcf06e", "prefix": "Booking_cinemaId_idx", "unique": false, "columns": ["cinemaId"]}, {"name": "Booking_movieId_idx_8cb9f9db", "prefix": "Booking_movieId_idx", "unique": false, "columns": ["movieId"]}, {"name": "Booking_seatId_idx_3076c3cd", "prefix": "Booking_seatId_idx", "unique": false, "columns": ["seatId"]}, {"name": "Booking_showId_idx_32b6b4ec", "prefix": "Booking_showId_idx", "unique": false, "columns": ["showId"]}, {"name": "Booking_userId_idx_a489d58a", "prefix": "Booking_userId_idx", "unique": false, "columns": ["userId"]}], "uniques": [{"columns": ["bookingId"]}], "primaryKey": {"columns": ["id"]}, "foreignKeys": [{"source": {"columns": ["userId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "User", "namespaceId": "public"}}, {"source": {"columns": ["movieId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Movie", "namespaceId": "public"}}, {"source": {"columns": ["cinemaId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Cinema", "namespaceId": "public"}}, {"source": {"columns": ["showId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Show", "namespaceId": "public"}}, {"source": {"columns": ["seatId"], "tableName": "Booking", "namespaceId": "public"}, "target": {"columns": ["id"], "tableName": "Seat", "namespaceId": "public"}}]}}}}}, "storageHash": "9e43861eb009dab0746ef3bebfe790526b0a561277ce4eb13ceb753f8297592b"}, "execution": {"mutations": {"defaults": [{"ref": {"entry": "Booking", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Cinema", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Movie", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Seat", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "Show", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}, {"ref": {"entry": "User", "field": "updatedAt", "namespace": "public"}, "onCreate": {"id": "timestampNow", "kind": "generator"}, "onUpdate": {"id": "timestampNow", "kind": "generator"}}]}, "executionHash": "243192d52a71b103be7ecb8fd21b75fabd2cb949bd989c8172b274d09d480c09"}, "extensions": {}, "profileHash": "3916f444a8a17ad749191acf9e08dad97d1a327b88c2f1d45d12f240296aa8b2", "capabilities": {"sql": {"enums": true, "lockOf": true, "lateral": true, "forShare": true, "forUpdate": true, "returning": true, "lockNowait": true, "scalarList": true, "lockSkipLocked": true, "checkConstraint": true, "defaultInInsert": true, "insertOnConflictSkip": true, "insertOnConflictWithoutTarget": true}, "postgres": {"limit": true, "jsonAgg": true, "lateral": true, "orderBy": true, "returning": true, "distinctOn": true, "forKeyShare": true, "forNoKeyUpdate": true}}, "targetFamily": "sql"}
\.


--
-- Data for Name: ledger; Type: TABLE DATA; Schema: prisma_contract; Owner: postgres
--

COPY prisma_contract.ledger (id, created_at, space, migration_name, migration_hash, origin_core_hash, origin_profile_hash, destination_core_hash, destination_profile_hash, operations) FROM stdin;
1	2026-10-07 22:22:47.354808+05:30	app		952ce2cae9764645008e3a33f232e38865f8d7415dd4b4a80a4a8101cff50d40		\N	952ce2cae9764645008e3a33f232e38865f8d7415dd4b4a80a4a8101cff50d40	\N	[{"id": "table.Booking", "label": "Create table \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"Booking\\" (\\n  \\"bookingId\\" text NOT NULL,\\n  \\"cinemaId\\" int4 NOT NULL,\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"movieId\\" int4 NOT NULL,\\n  \\"seatId\\" int4 NOT NULL,\\n  \\"showId\\" int4 NOT NULL,\\n  \\"status\\" text DEFAULT 'CONFIRMED' NOT NULL,\\n  \\"totalAmount\\" float8 NOT NULL,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  \\"userId\\" int4,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"Booking\\""}], "summary": "Creates table \\"Booking\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking\\""], "description": "ensure table \\"Booking\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking\\""], "description": "verify table \\"Booking\\" exists"}], "operationClass": "additive"}, {"id": "table.Cinema", "label": "Create table \\"Cinema\\"", "target": {"id": "postgres", "details": {"name": "Cinema", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"Cinema\\" (\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"location\\" text NOT NULL,\\n  \\"name\\" text NOT NULL,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"Cinema\\""}], "summary": "Creates table \\"Cinema\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Cinema\\""], "description": "ensure table \\"Cinema\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Cinema\\""], "description": "verify table \\"Cinema\\" exists"}], "operationClass": "additive"}, {"id": "table.Movie", "label": "Create table \\"Movie\\"", "target": {"id": "postgres", "details": {"name": "Movie", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"Movie\\" (\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"description\\" text,\\n  \\"duration\\" text,\\n  \\"genre\\" text NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"image\\" text,\\n  \\"rating\\" text,\\n  \\"title\\" text NOT NULL,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"Movie\\""}], "summary": "Creates table \\"Movie\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Movie\\""], "description": "ensure table \\"Movie\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Movie\\""], "description": "verify table \\"Movie\\" exists"}], "operationClass": "additive"}, {"id": "table.Seat", "label": "Create table \\"Seat\\"", "target": {"id": "postgres", "details": {"name": "Seat", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"Seat\\" (\\n  \\"cinemaId\\" int4 NOT NULL,\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"seatNumber\\" text NOT NULL,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"Seat\\""}], "summary": "Creates table \\"Seat\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Seat\\""], "description": "ensure table \\"Seat\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Seat\\""], "description": "verify table \\"Seat\\" exists"}], "operationClass": "additive"}, {"id": "table.Show", "label": "Create table \\"Show\\"", "target": {"id": "postgres", "details": {"name": "Show", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"Show\\" (\\n  \\"cinemaId\\" int4 NOT NULL,\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"date\\" text NOT NULL,\\n  \\"format\\" text NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"movieId\\" int4 NOT NULL,\\n  \\"time\\" text NOT NULL,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"Show\\""}], "summary": "Creates table \\"Show\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show\\""], "description": "ensure table \\"Show\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show\\""], "description": "verify table \\"Show\\" exists"}], "operationClass": "additive"}, {"id": "table.User", "label": "Create table \\"User\\"", "target": {"id": "postgres", "details": {"name": "User", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "CREATE TABLE \\"public\\".\\"User\\" (\\n  \\"createdAt\\" timestamptz DEFAULT (now()) NOT NULL,\\n  \\"email\\" text NOT NULL,\\n  \\"id\\" SERIAL NOT NULL,\\n  \\"name\\" text,\\n  \\"updatedAt\\" timestamptz NOT NULL,\\n  \\"username\\" text,\\n  PRIMARY KEY (\\"id\\")\\n)", "params": [], "description": "create table \\"User\\""}], "summary": "Creates table \\"User\\"", "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"User\\""], "description": "ensure table \\"User\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"User\\""], "description": "verify table \\"User\\" exists"}], "operationClass": "additive"}, {"id": "unique.Booking.Booking_bookingId_key", "label": "Add unique constraint on \\"Booking\\" (bookingId)", "target": {"id": "postgres", "details": {"name": "Booking_bookingId_key", "table": "Booking", "schema": "public", "objectType": "unique"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\" ADD CONSTRAINT \\"Booking_bookingId_key\\" UNIQUE (\\"bookingId\\")", "description": "add unique constraint \\"Booking_bookingId_key\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_bookingId_key", "public", "\\"public\\".\\"Booking\\""], "description": "ensure constraint \\"Booking_bookingId_key\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_bookingId_key", "public", "\\"public\\".\\"Booking\\""], "description": "verify constraint \\"Booking_bookingId_key\\" exists"}], "operationClass": "additive"}, {"id": "unique.Cinema.Cinema_name_key", "label": "Add unique constraint on \\"Cinema\\" (name)", "target": {"id": "postgres", "details": {"name": "Cinema_name_key", "table": "Cinema", "schema": "public", "objectType": "unique"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Cinema\\" ADD CONSTRAINT \\"Cinema_name_key\\" UNIQUE (\\"name\\")", "description": "add unique constraint \\"Cinema_name_key\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Cinema_name_key", "public", "\\"public\\".\\"Cinema\\""], "description": "ensure constraint \\"Cinema_name_key\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Cinema_name_key", "public", "\\"public\\".\\"Cinema\\""], "description": "verify constraint \\"Cinema_name_key\\" exists"}], "operationClass": "additive"}, {"id": "unique.Seat.Seat_cinemaId_seatNumber_key", "label": "Add unique constraint on \\"Seat\\" (cinemaId, seatNumber)", "target": {"id": "postgres", "details": {"name": "Seat_cinemaId_seatNumber_key", "table": "Seat", "schema": "public", "objectType": "unique"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Seat\\" ADD CONSTRAINT \\"Seat_cinemaId_seatNumber_key\\" UNIQUE (\\"cinemaId\\", \\"seatNumber\\")", "description": "add unique constraint \\"Seat_cinemaId_seatNumber_key\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Seat_cinemaId_seatNumber_key", "public", "\\"public\\".\\"Seat\\""], "description": "ensure constraint \\"Seat_cinemaId_seatNumber_key\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Seat_cinemaId_seatNumber_key", "public", "\\"public\\".\\"Seat\\""], "description": "verify constraint \\"Seat_cinemaId_seatNumber_key\\" exists"}], "operationClass": "additive"}, {"id": "unique.User.User_email_key", "label": "Add unique constraint on \\"User\\" (email)", "target": {"id": "postgres", "details": {"name": "User_email_key", "table": "User", "schema": "public", "objectType": "unique"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"User\\" ADD CONSTRAINT \\"User_email_key\\" UNIQUE (\\"email\\")", "description": "add unique constraint \\"User_email_key\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["User_email_key", "public", "\\"public\\".\\"User\\""], "description": "ensure constraint \\"User_email_key\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["User_email_key", "public", "\\"public\\".\\"User\\""], "description": "verify constraint \\"User_email_key\\" exists"}], "operationClass": "additive"}, {"id": "index.Booking.Booking_cinemaId_idx_3adcf06e", "label": "Create index \\"Booking_cinemaId_idx_3adcf06e\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_cinemaId_idx_3adcf06e", "table": "Booking", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Booking_cinemaId_idx_3adcf06e\\" ON \\"public\\".\\"Booking\\" (\\"cinemaId\\")", "params": [], "description": "create index \\"Booking_cinemaId_idx_3adcf06e\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_cinemaId_idx_3adcf06e\\""], "description": "ensure index \\"Booking_cinemaId_idx_3adcf06e\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_cinemaId_idx_3adcf06e\\""], "description": "verify index \\"Booking_cinemaId_idx_3adcf06e\\" exists"}], "operationClass": "additive"}, {"id": "index.Booking.Booking_movieId_idx_8cb9f9db", "label": "Create index \\"Booking_movieId_idx_8cb9f9db\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_movieId_idx_8cb9f9db", "table": "Booking", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Booking_movieId_idx_8cb9f9db\\" ON \\"public\\".\\"Booking\\" (\\"movieId\\")", "params": [], "description": "create index \\"Booking_movieId_idx_8cb9f9db\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_movieId_idx_8cb9f9db\\""], "description": "ensure index \\"Booking_movieId_idx_8cb9f9db\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_movieId_idx_8cb9f9db\\""], "description": "verify index \\"Booking_movieId_idx_8cb9f9db\\" exists"}], "operationClass": "additive"}, {"id": "index.Booking.Booking_seatId_idx_3076c3cd", "label": "Create index \\"Booking_seatId_idx_3076c3cd\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_seatId_idx_3076c3cd", "table": "Booking", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Booking_seatId_idx_3076c3cd\\" ON \\"public\\".\\"Booking\\" (\\"seatId\\")", "params": [], "description": "create index \\"Booking_seatId_idx_3076c3cd\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_seatId_idx_3076c3cd\\""], "description": "ensure index \\"Booking_seatId_idx_3076c3cd\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_seatId_idx_3076c3cd\\""], "description": "verify index \\"Booking_seatId_idx_3076c3cd\\" exists"}], "operationClass": "additive"}, {"id": "index.Booking.Booking_showId_idx_32b6b4ec", "label": "Create index \\"Booking_showId_idx_32b6b4ec\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_showId_idx_32b6b4ec", "table": "Booking", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Booking_showId_idx_32b6b4ec\\" ON \\"public\\".\\"Booking\\" (\\"showId\\")", "params": [], "description": "create index \\"Booking_showId_idx_32b6b4ec\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_showId_idx_32b6b4ec\\""], "description": "ensure index \\"Booking_showId_idx_32b6b4ec\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_showId_idx_32b6b4ec\\""], "description": "verify index \\"Booking_showId_idx_32b6b4ec\\" exists"}], "operationClass": "additive"}, {"id": "index.Booking.Booking_userId_idx_a489d58a", "label": "Create index \\"Booking_userId_idx_a489d58a\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_userId_idx_a489d58a", "table": "Booking", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Booking_userId_idx_a489d58a\\" ON \\"public\\".\\"Booking\\" (\\"userId\\")", "params": [], "description": "create index \\"Booking_userId_idx_a489d58a\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_userId_idx_a489d58a\\""], "description": "ensure index \\"Booking_userId_idx_a489d58a\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Booking_userId_idx_a489d58a\\""], "description": "verify index \\"Booking_userId_idx_a489d58a\\" exists"}], "operationClass": "additive"}, {"id": "index.Seat.Seat_cinemaId_idx_3adcf06e", "label": "Create index \\"Seat_cinemaId_idx_3adcf06e\\" on \\"Seat\\"", "target": {"id": "postgres", "details": {"name": "Seat_cinemaId_idx_3adcf06e", "table": "Seat", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Seat_cinemaId_idx_3adcf06e\\" ON \\"public\\".\\"Seat\\" (\\"cinemaId\\")", "params": [], "description": "create index \\"Seat_cinemaId_idx_3adcf06e\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Seat_cinemaId_idx_3adcf06e\\""], "description": "ensure index \\"Seat_cinemaId_idx_3adcf06e\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Seat_cinemaId_idx_3adcf06e\\""], "description": "verify index \\"Seat_cinemaId_idx_3adcf06e\\" exists"}], "operationClass": "additive"}, {"id": "index.Show.Show_cinemaId_idx_3adcf06e", "label": "Create index \\"Show_cinemaId_idx_3adcf06e\\" on \\"Show\\"", "target": {"id": "postgres", "details": {"name": "Show_cinemaId_idx_3adcf06e", "table": "Show", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Show_cinemaId_idx_3adcf06e\\" ON \\"public\\".\\"Show\\" (\\"cinemaId\\")", "params": [], "description": "create index \\"Show_cinemaId_idx_3adcf06e\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show_cinemaId_idx_3adcf06e\\""], "description": "ensure index \\"Show_cinemaId_idx_3adcf06e\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show_cinemaId_idx_3adcf06e\\""], "description": "verify index \\"Show_cinemaId_idx_3adcf06e\\" exists"}], "operationClass": "additive"}, {"id": "index.Show.Show_movieId_idx_8cb9f9db", "label": "Create index \\"Show_movieId_idx_8cb9f9db\\" on \\"Show\\"", "target": {"id": "postgres", "details": {"name": "Show_movieId_idx_8cb9f9db", "table": "Show", "schema": "public", "objectType": "index"}}, "execute": [{"sql": "CREATE INDEX \\"Show_movieId_idx_8cb9f9db\\" ON \\"public\\".\\"Show\\" (\\"movieId\\")", "params": [], "description": "create index \\"Show_movieId_idx_8cb9f9db\\""}], "precheck": [{"sql": "SELECT (to_regclass($1)) IS NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show_movieId_idx_8cb9f9db\\""], "description": "ensure index \\"Show_movieId_idx_8cb9f9db\\" does not exist"}], "postcheck": [{"sql": "SELECT (to_regclass($1)) IS NOT NULL AS \\"result\\"", "params": ["\\"public\\".\\"Show_movieId_idx_8cb9f9db\\""], "description": "verify index \\"Show_movieId_idx_8cb9f9db\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Booking.Booking_userId_fkey", "label": "Add foreign key \\"Booking_userId_fkey\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_userId_fkey", "table": "Booking", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\"\\nADD CONSTRAINT \\"Booking_userId_fkey\\"\\nFOREIGN KEY (\\"userId\\")\\nREFERENCES \\"public\\".\\"User\\" (\\"id\\")", "description": "add FK \\"Booking_userId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_userId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "ensure FK \\"Booking_userId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_userId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "verify FK \\"Booking_userId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Booking.Booking_movieId_fkey", "label": "Add foreign key \\"Booking_movieId_fkey\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_movieId_fkey", "table": "Booking", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\"\\nADD CONSTRAINT \\"Booking_movieId_fkey\\"\\nFOREIGN KEY (\\"movieId\\")\\nREFERENCES \\"public\\".\\"Movie\\" (\\"id\\")", "description": "add FK \\"Booking_movieId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_movieId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "ensure FK \\"Booking_movieId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_movieId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "verify FK \\"Booking_movieId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Booking.Booking_cinemaId_fkey", "label": "Add foreign key \\"Booking_cinemaId_fkey\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_cinemaId_fkey", "table": "Booking", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\"\\nADD CONSTRAINT \\"Booking_cinemaId_fkey\\"\\nFOREIGN KEY (\\"cinemaId\\")\\nREFERENCES \\"public\\".\\"Cinema\\" (\\"id\\")", "description": "add FK \\"Booking_cinemaId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_cinemaId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "ensure FK \\"Booking_cinemaId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_cinemaId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "verify FK \\"Booking_cinemaId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Booking.Booking_showId_fkey", "label": "Add foreign key \\"Booking_showId_fkey\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_showId_fkey", "table": "Booking", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\"\\nADD CONSTRAINT \\"Booking_showId_fkey\\"\\nFOREIGN KEY (\\"showId\\")\\nREFERENCES \\"public\\".\\"Show\\" (\\"id\\")", "description": "add FK \\"Booking_showId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_showId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "ensure FK \\"Booking_showId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_showId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "verify FK \\"Booking_showId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Booking.Booking_seatId_fkey", "label": "Add foreign key \\"Booking_seatId_fkey\\" on \\"Booking\\"", "target": {"id": "postgres", "details": {"name": "Booking_seatId_fkey", "table": "Booking", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Booking\\"\\nADD CONSTRAINT \\"Booking_seatId_fkey\\"\\nFOREIGN KEY (\\"seatId\\")\\nREFERENCES \\"public\\".\\"Seat\\" (\\"id\\")", "description": "add FK \\"Booking_seatId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_seatId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "ensure FK \\"Booking_seatId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Booking_seatId_fkey", "public", "\\"public\\".\\"Booking\\""], "description": "verify FK \\"Booking_seatId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Seat.Seat_cinemaId_fkey", "label": "Add foreign key \\"Seat_cinemaId_fkey\\" on \\"Seat\\"", "target": {"id": "postgres", "details": {"name": "Seat_cinemaId_fkey", "table": "Seat", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Seat\\"\\nADD CONSTRAINT \\"Seat_cinemaId_fkey\\"\\nFOREIGN KEY (\\"cinemaId\\")\\nREFERENCES \\"public\\".\\"Cinema\\" (\\"id\\")", "description": "add FK \\"Seat_cinemaId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Seat_cinemaId_fkey", "public", "\\"public\\".\\"Seat\\""], "description": "ensure FK \\"Seat_cinemaId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Seat_cinemaId_fkey", "public", "\\"public\\".\\"Seat\\""], "description": "verify FK \\"Seat_cinemaId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Show.Show_movieId_fkey", "label": "Add foreign key \\"Show_movieId_fkey\\" on \\"Show\\"", "target": {"id": "postgres", "details": {"name": "Show_movieId_fkey", "table": "Show", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Show\\"\\nADD CONSTRAINT \\"Show_movieId_fkey\\"\\nFOREIGN KEY (\\"movieId\\")\\nREFERENCES \\"public\\".\\"Movie\\" (\\"id\\")", "description": "add FK \\"Show_movieId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Show_movieId_fkey", "public", "\\"public\\".\\"Show\\""], "description": "ensure FK \\"Show_movieId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Show_movieId_fkey", "public", "\\"public\\".\\"Show\\""], "description": "verify FK \\"Show_movieId_fkey\\" exists"}], "operationClass": "additive"}, {"id": "foreignKey.Show.Show_cinemaId_fkey", "label": "Add foreign key \\"Show_cinemaId_fkey\\" on \\"Show\\"", "target": {"id": "postgres", "details": {"name": "Show_cinemaId_fkey", "table": "Show", "schema": "public", "objectType": "foreignKey"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Show\\"\\nADD CONSTRAINT \\"Show_cinemaId_fkey\\"\\nFOREIGN KEY (\\"cinemaId\\")\\nREFERENCES \\"public\\".\\"Cinema\\" (\\"id\\")", "description": "add FK \\"Show_cinemaId_fkey\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Show_cinemaId_fkey", "public", "\\"public\\".\\"Show\\""], "description": "ensure FK \\"Show_cinemaId_fkey\\" does not exist"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_constraint\\" AS \\"c\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"connamespace\\" WHERE (\\"c\\".\\"conname\\" = $1 AND \\"n\\".\\"nspname\\" = $2 AND \\"c\\".\\"conrelid\\" = to_regclass($3))) AS \\"result\\"", "params": ["Show_cinemaId_fkey", "public", "\\"public\\".\\"Show\\""], "description": "verify FK \\"Show_cinemaId_fkey\\" exists"}], "operationClass": "additive"}]
2	2026-10-08 00:02:59.915377+05:30	app		52e70aa1b5501a4c793fa80c539bb9083a83cff637cdf69fa35341c54c0d206c	952ce2cae9764645008e3a33f232e38865f8d7415dd4b4a80a4a8101cff50d40	\N	52e70aa1b5501a4c793fa80c539bb9083a83cff637cdf69fa35341c54c0d206c	\N	[{"id": "column.public.Movie.cinemas", "label": "Add column \\"cinemas\\" to \\"Movie\\"", "target": {"id": "postgres", "details": {"name": "cinemas", "table": "Movie", "schema": "public", "objectType": "column"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Movie\\" ADD COLUMN \\"cinemas\\" text", "description": "add column \\"cinemas\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "cinemas"], "description": "ensure column \\"cinemas\\" is missing"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "cinemas"], "description": "verify column \\"cinemas\\" exists"}], "operationClass": "additive"}, {"id": "column.public.Movie.languages", "label": "Add column \\"languages\\" to \\"Movie\\"", "target": {"id": "postgres", "details": {"name": "languages", "table": "Movie", "schema": "public", "objectType": "column"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Movie\\" ADD COLUMN \\"languages\\" text", "description": "add column \\"languages\\""}], "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "languages"], "description": "ensure column \\"languages\\" is missing"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "languages"], "description": "verify column \\"languages\\" exists"}], "operationClass": "additive"}]
3	2026-10-08 00:24:58.117574+05:30	app		92d1a0b09eba8d8c1176dc35bb2ecda5582fb172da65279083266f80d5521caf	52e70aa1b5501a4c793fa80c539bb9083a83cff637cdf69fa35341c54c0d206c	\N	92d1a0b09eba8d8c1176dc35bb2ecda5582fb172da65279083266f80d5521caf	\N	[{"id": "alterType.Movie.cinemas", "meta": {"warning": "TABLE_REWRITE"}, "label": "Alter type of \\"Movie\\".\\"cinemas\\" to json", "target": {"id": "postgres", "details": {"name": "cinemas", "table": "Movie", "schema": "public", "objectType": "column"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Movie\\" ALTER COLUMN \\"cinemas\\" TYPE json USING \\"cinemas\\"::json", "description": "alter type of \\"cinemas\\""}], "precheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "cinemas"], "description": "ensure column \\"cinemas\\" exists"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_attribute\\" AS \\"a\\" INNER JOIN \\"pg_class\\" AS \\"c\\" ON \\"c\\".\\"oid\\" = \\"a\\".\\"attrelid\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"relnamespace\\" WHERE (\\"n\\".\\"nspname\\" = $1 AND \\"c\\".\\"relname\\" = $2 AND \\"a\\".\\"attname\\" = $3 AND (format_type(\\"a\\".\\"atttypid\\", \\"a\\".\\"atttypmod\\")) = $4 AND NOT (\\"a\\".\\"attisdropped\\"))) AS \\"result\\"", "params": ["public", "Movie", "cinemas", "json"], "description": "verify column \\"cinemas\\" has type \\"json\\""}], "operationClass": "destructive"}, {"id": "alterType.Movie.languages", "meta": {"warning": "TABLE_REWRITE"}, "label": "Alter type of \\"Movie\\".\\"languages\\" to json", "target": {"id": "postgres", "details": {"name": "languages", "table": "Movie", "schema": "public", "objectType": "column"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"Movie\\" ALTER COLUMN \\"languages\\" TYPE json USING \\"languages\\"::json", "description": "alter type of \\"languages\\""}], "precheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "Movie", "languages"], "description": "ensure column \\"languages\\" exists"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"pg_attribute\\" AS \\"a\\" INNER JOIN \\"pg_class\\" AS \\"c\\" ON \\"c\\".\\"oid\\" = \\"a\\".\\"attrelid\\" INNER JOIN \\"pg_namespace\\" AS \\"n\\" ON \\"n\\".\\"oid\\" = \\"c\\".\\"relnamespace\\" WHERE (\\"n\\".\\"nspname\\" = $1 AND \\"c\\".\\"relname\\" = $2 AND \\"a\\".\\"attname\\" = $3 AND (format_type(\\"a\\".\\"atttypid\\", \\"a\\".\\"atttypmod\\")) = $4 AND NOT (\\"a\\".\\"attisdropped\\"))) AS \\"result\\"", "params": ["public", "Movie", "languages", "json"], "description": "verify column \\"languages\\" has type \\"json\\""}], "operationClass": "destructive"}]
4	2026-10-09 01:48:37.064169+05:30	app		9e43861eb009dab0746ef3bebfe790526b0a561277ce4eb13ceb753f8297592b	92d1a0b09eba8d8c1176dc35bb2ecda5582fb172da65279083266f80d5521caf	\N	9e43861eb009dab0746ef3bebfe790526b0a561277ce4eb13ceb753f8297592b	\N	[{"id": "column.User.password", "label": "Add column password to User", "target": {"id": "postgres", "details": {"name": "User", "schema": "public", "objectType": "table"}}, "execute": [{"sql": "ALTER TABLE \\"public\\".\\"User\\" ADD COLUMN \\"password\\" text DEFAULT ('') NOT NULL", "description": "add column \\"password\\""}, {"sql": "ALTER TABLE \\"public\\".\\"User\\" ALTER COLUMN \\"password\\" DROP DEFAULT", "description": "drop temporary default from column \\"password\\""}], "summary": "Adds column password to table User", "precheck": [{"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "User", "password"], "description": "ensure column \\"password\\" is missing"}], "postcheck": [{"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3)) AS \\"result\\"", "params": ["public", "User", "password"], "description": "verify column \\"password\\" exists"}, {"sql": "SELECT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3 AND \\"is_nullable\\" = $4)) AS \\"result\\"", "params": ["public", "User", "password", "NO"], "description": "verify column \\"password\\" is NOT NULL"}, {"sql": "SELECT NOT EXISTS (SELECT 1 AS \\"one\\" FROM \\"information_schema\\".\\"columns\\" WHERE (\\"table_schema\\" = $1 AND \\"table_name\\" = $2 AND \\"column_name\\" = $3 AND \\"column_default\\" IS NOT NULL)) AS \\"result\\"", "params": ["public", "User", "password"], "description": "verify column \\"password\\" has no default after temporary default removal"}], "operationClass": "additive"}]
\.


--
-- Data for Name: marker; Type: TABLE DATA; Schema: prisma_contract; Owner: postgres
--

COPY prisma_contract.marker (space, core_hash, profile_hash, contract_json, canonical_version, updated_at, app_tag, meta, invariants) FROM stdin;
app	9e43861eb009dab0746ef3bebfe790526b0a561277ce4eb13ceb753f8297592b	3916f444a8a17ad749191acf9e08dad97d1a327b88c2f1d45d12f240296aa8b2	\N	\N	2026-10-09 01:48:37.064169+05:30	\N	{}	{}
\.


--
-- Data for Name: Booking; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Booking" ("bookingId", "cinemaId", "createdAt", id, "movieId", "seatId", "showId", status, "totalAmount", "updatedAt", "userId") FROM stdin;
CR785299-G4	3	2026-10-08 22:31:35.439199+05:30	1	1	108	9	CANCELLED	290	2026-10-09 00:32:59.889+05:30	1
CR734722-G6	3	2026-10-08 22:53:38.555241+05:30	2	1	110	3	CONFIRMED	290	2026-10-08 22:53:38.55+05:30	1
CR892178-G7	3	2026-10-08 22:58:29.864054+05:30	3	1	111	79	CONFIRMED	540	2026-10-08 22:58:29.861+05:30	1
CR892178-G6	3	2026-10-08 22:58:29.875803+05:30	4	1	110	79	CONFIRMED	540	2026-10-08 22:58:29.873+05:30	1
CR162295-D5	3	2026-10-08 23:16:19.475606+05:30	5	1	85	9	CONFIRMED	540	2026-10-08 23:16:19.468+05:30	1
CR162295-D6	3	2026-10-08 23:16:19.486227+05:30	6	1	86	9	CONFIRMED	540	2026-10-08 23:16:19.482+05:30	1
CR969115-G1	3	2026-10-08 23:20:01.730746+05:30	7	1	105	95	CONFIRMED	290	2026-10-08 23:20:01.726+05:30	1
CR837701-G5	3	2026-10-08 23:37:21.208436+05:30	8	1	109	9	CONFIRMED	290	2026-10-08 23:37:21.191+05:30	1
CR123456-G5	3	2026-10-09 00:45:34.501969+05:30	9	1	109	9	CANCELLED	290	2026-10-09 00:46:55.436+05:30	1
CR943044-G8	2	2026-10-09 00:48:41.233675+05:30	10	1	56	94	CONFIRMED	540	2026-10-09 00:48:41.227+05:30	1
CR943044-G7	2	2026-10-09 00:48:41.242973+05:30	11	1	55	94	CONFIRMED	540	2026-10-09 00:48:41.239+05:30	1
CR832139-A1	2	2026-10-09 01:01:30.921976+05:30	12	1	1	94	CANCELLED	640	2026-10-09 01:03:50.742+05:30	1
CR832139-A2	2	2026-10-09 01:01:30.9269+05:30	13	1	2	94	CANCELLED	640	2026-10-09 01:03:50.746+05:30	1
CR470819-C4	3	2026-10-09 12:02:51.956007+05:30	14	1	76	83	CONFIRMED	790	2026-10-09 12:02:51.939+05:30	1
CR470819-C3	3	2026-10-09 12:02:51.987629+05:30	15	1	75	83	CONFIRMED	790	2026-10-09 12:02:51.98+05:30	1
CR452247-G1	3	2026-10-09 12:16:32.106724+05:30	16	1	105	83	CONFIRMED	290	2026-10-09 12:16:32.105+05:30	1
CR934957-G2	2	2026-10-09 20:04:48.278164+05:30	49	1	50	82	CONFIRMED	640	2026-10-09 20:04:48.266+05:30	1
CR934957-G1	2	2026-10-09 20:04:48.299871+05:30	50	1	49	82	CONFIRMED	640	2026-10-09 20:04:48.294+05:30	1
CR971200-E8	2	2026-10-09 20:12:06.216427+05:30	51	1	40	82	CONFIRMED	790	2026-10-09 20:12:06.211+05:30	1
CR971200-E7	2	2026-10-09 20:12:06.226912+05:30	52	1	39	82	CONFIRMED	790	2026-10-09 20:12:06.222+05:30	1
CR614457-A3	2	2026-10-09 20:18:25.391075+05:30	53	1	3	82	CONFIRMED	660	2026-10-09 20:18:25.387+05:30	1
CR614457-A4	2	2026-10-09 20:18:25.407196+05:30	54	1	4	82	CONFIRMED	660	2026-10-09 20:18:25.403+05:30	1
CR333817-C4	2	2026-10-09 20:29:04.663686+05:30	55	1	20	82	CONFIRMED	640	2026-10-09 20:29:04.654+05:30	1
CR333817-C5	2	2026-10-09 20:29:04.675655+05:30	56	1	21	82	CONFIRMED	640	2026-10-09 20:29:04.671+05:30	1
CR936937-A1	2	2026-10-09 20:33:56.294513+05:30	57	1	1	82	CONFIRMED	290	2026-10-09 20:33:56.289+05:30	1
CR193052-A2	2	2026-10-09 20:40:30.41634+05:30	58	1	2	82	CONFIRMED	290	2026-10-09 20:40:30.407+05:30	1
CR928265-D1	2	2026-10-10 10:54:33.529259+05:30	59	1	25	82	CANCELLED	390	2026-10-10 10:55:55.816+05:30	1
\.


--
-- Data for Name: Cinema; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Cinema" ("createdAt", id, location, name, "updatedAt") FROM stdin;
2026-10-08 01:04:26.094341+05:30	2	Gachibowli, Hyderabad	AMB Cinemas	2026-10-08 01:04:26.094341+05:30
2026-10-08 01:04:26.094341+05:30	3	Gachibowli, Hyderabad	PVR Atrium	2026-10-08 01:04:26.094341+05:30
2026-10-08 01:04:26.094341+05:30	4	Gachibowli, Hyderabad	PVR Preston	2026-10-08 01:04:26.094341+05:30
2026-10-08 01:04:26.094341+05:30	5	Madhapur, Hyderabad	PVR Inorbit	2026-10-08 01:04:26.094341+05:30
2026-10-08 01:04:26.094341+05:30	6	Kukatpally, Hyderabad	ALLU Cinemas	2026-10-08 01:04:26.094341+05:30
\.


--
-- Data for Name: Movie; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Movie" ("createdAt", description, duration, genre, id, image, rating, title, "updatedAt", cinemas, languages) FROM stdin;
2026-10-07 23:39:14.078625+05:30	A new king protects Wakanda.	2h 14m	Action	5	/movies/black-panther.jpeg	7.3	Black Panther	2026-10-08 23:47:41.323+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.080092+05:30	A group of heroes protects the galaxy.	2h 1m	Adventure	6	/movies/guardians-of-the-galaxy.jpeg	8.0	Guardians of the Galaxy	2026-10-08 23:47:41.327+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.081975+05:30	A thief becomes a superhero with a shrinking suit.	1h 57m	Adventure	7	/movies/ant-man.jpg	7.2	Ant-Man	2026-10-08 23:47:41.33+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.083618+05:30	The Avengers battle Thanos.	2h 29m	Action	8	/movies/avengers-infinity-war.jpg	8.4	Avengers: Infinity War	2026-10-08 23:47:41.333+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.085208+05:30	The Avengers attempt to undo the snap.	3h 2m	Action	9	/movies/Avengers-Endgame.jpg	8.4	Avengers: Endgame	2026-10-08 23:47:41.337+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.08693+05:30	Explorers travel through space searching for a new home.	2h 49m	Sci-Fi	10	/movies/interstellar.jpg	8.7	Interstellar	2026-10-08 23:47:41.34+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.088392+05:30	Batman faces the Joker.	2h 32m	Action	11	/movies/the-dark-knight.jpg	9.0	The Dark Knight	2026-10-08 23:47:41.345+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.090221+05:30	An unforgettable night at the cinema.	2h	Drama	12	/movies/cinema-night.jpeg	7.5	Cinema Night	2026-10-08 23:47:41.353+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.091658+05:30	A powerful emotional journey.	2h 10m	Drama	13	/movies/the-last-journey.jpeg	7.6	The Last Journey	2026-10-08 23:47:41.359+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.092986+05:30	A mysterious story unfolds in the city at midnight.	2h 5m	Thriller	14	/movies/midnight-city.jpg	7.8	Midnight City	2026-10-08 23:47:41.365+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.094269+05:30	An expedition travels beyond Earth.	2h 20m	Sci-Fi	15	/movies/beyond-earth.jpeg	8.1	Beyond Earth	2026-10-08 23:47:41.371+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.095543+05:30	A thrilling adventure begins.	2h 15m	Adventure	16	/movies/the-adventure.jpg	7.7	The Adventure	2026-10-08 23:47:41.377+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.066124+05:30	A brilliant surgeon discovers the mystic arts.	1h 55m	Action	1	/movies/doctor-strange.jpg	7.5	Doctor Strange	2026-10-08 23:47:41.297+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.073411+05:30	Tony Stark builds a powerful armored suit.	2h 6m	Action	2	/movies/iron-man.jpeg	7.9	Iron Man	2026-10-08 23:47:41.311+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.075354+05:30	Thor faces a powerful new threat.	2h 10m	Action	3	/movies/thor.jpeg	7.9	Thor: Ragnarok	2026-10-08 23:47:41.315+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
2026-10-07 23:39:14.077075+05:30	Spider-Man faces villains from different worlds.	2h 28m	Action	4	/movies/spider-man.jpeg	8.2	Spider-Man: No Way Home	2026-10-08 23:47:41.319+05:30	["AMB Cinemas","PVR Atrium","PVR Preston","PVR Inorbit"]	["English","Hindi","Telugu"]
\.


--
-- Data for Name: Seat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Seat" ("cinemaId", "createdAt", id, "seatNumber", "updatedAt") FROM stdin;
2	2026-10-08 22:08:59.79547+05:30	1	A1	2026-10-08 22:08:59.784+05:30
2	2026-10-08 22:08:59.813735+05:30	2	A2	2026-10-08 22:08:59.807+05:30
2	2026-10-08 22:08:59.819921+05:30	3	A3	2026-10-08 22:08:59.813+05:30
2	2026-10-08 22:08:59.826342+05:30	4	A4	2026-10-08 22:08:59.82+05:30
2	2026-10-08 22:08:59.832038+05:30	5	A5	2026-10-08 22:08:59.826+05:30
2	2026-10-08 22:08:59.837015+05:30	6	A6	2026-10-08 22:08:59.831+05:30
2	2026-10-08 22:08:59.841888+05:30	7	A7	2026-10-08 22:08:59.836+05:30
2	2026-10-08 22:08:59.847459+05:30	8	A8	2026-10-08 22:08:59.841+05:30
2	2026-10-08 22:08:59.852378+05:30	9	B1	2026-10-08 22:08:59.846+05:30
2	2026-10-08 22:08:59.857132+05:30	10	B2	2026-10-08 22:08:59.851+05:30
2	2026-10-08 22:08:59.861805+05:30	11	B3	2026-10-08 22:08:59.856+05:30
2	2026-10-08 22:08:59.866701+05:30	12	B4	2026-10-08 22:08:59.86+05:30
2	2026-10-08 22:08:59.871281+05:30	13	B5	2026-10-08 22:08:59.865+05:30
2	2026-10-08 22:08:59.876243+05:30	14	B6	2026-10-08 22:08:59.87+05:30
2	2026-10-08 22:08:59.882327+05:30	15	B7	2026-10-08 22:08:59.876+05:30
2	2026-10-08 22:08:59.886955+05:30	16	B8	2026-10-08 22:08:59.881+05:30
2	2026-10-08 22:08:59.891223+05:30	17	C1	2026-10-08 22:08:59.885+05:30
2	2026-10-08 22:08:59.89531+05:30	18	C2	2026-10-08 22:08:59.889+05:30
2	2026-10-08 22:08:59.899602+05:30	19	C3	2026-10-08 22:08:59.894+05:30
2	2026-10-08 22:08:59.904131+05:30	20	C4	2026-10-08 22:08:59.898+05:30
2	2026-10-08 22:08:59.908556+05:30	21	C5	2026-10-08 22:08:59.902+05:30
2	2026-10-08 22:08:59.912991+05:30	22	C6	2026-10-08 22:08:59.907+05:30
2	2026-10-08 22:08:59.917374+05:30	23	C7	2026-10-08 22:08:59.911+05:30
2	2026-10-08 22:08:59.922335+05:30	24	C8	2026-10-08 22:08:59.916+05:30
2	2026-10-08 22:08:59.928187+05:30	25	D1	2026-10-08 22:08:59.922+05:30
2	2026-10-08 22:08:59.932842+05:30	26	D2	2026-10-08 22:08:59.927+05:30
2	2026-10-08 22:08:59.937476+05:30	27	D3	2026-10-08 22:08:59.931+05:30
2	2026-10-08 22:08:59.942073+05:30	28	D4	2026-10-08 22:08:59.936+05:30
2	2026-10-08 22:08:59.946542+05:30	29	D5	2026-10-08 22:08:59.941+05:30
2	2026-10-08 22:08:59.950758+05:30	30	D6	2026-10-08 22:08:59.945+05:30
2	2026-10-08 22:08:59.955399+05:30	31	D7	2026-10-08 22:08:59.949+05:30
2	2026-10-08 22:08:59.958955+05:30	32	D8	2026-10-08 22:08:59.953+05:30
2	2026-10-08 22:08:59.962806+05:30	33	E1	2026-10-08 22:08:59.957+05:30
2	2026-10-08 22:08:59.966771+05:30	34	E2	2026-10-08 22:08:59.961+05:30
2	2026-10-08 22:08:59.970476+05:30	35	E3	2026-10-08 22:08:59.964+05:30
2	2026-10-08 22:08:59.97303+05:30	36	E4	2026-10-08 22:08:59.967+05:30
2	2026-10-08 22:08:59.975387+05:30	37	E5	2026-10-08 22:08:59.97+05:30
2	2026-10-08 22:08:59.977782+05:30	38	E6	2026-10-08 22:08:59.972+05:30
2	2026-10-08 22:08:59.979923+05:30	39	E7	2026-10-08 22:08:59.974+05:30
2	2026-10-08 22:08:59.982068+05:30	40	E8	2026-10-08 22:08:59.977+05:30
2	2026-10-08 22:08:59.984305+05:30	41	F1	2026-10-08 22:08:59.979+05:30
2	2026-10-08 22:08:59.986685+05:30	42	F2	2026-10-08 22:08:59.981+05:30
2	2026-10-08 22:08:59.990421+05:30	43	F3	2026-10-08 22:08:59.984+05:30
2	2026-10-08 22:08:59.993532+05:30	44	F4	2026-10-08 22:08:59.988+05:30
2	2026-10-08 22:08:59.996936+05:30	45	F5	2026-10-08 22:08:59.991+05:30
2	2026-10-08 22:08:59.999558+05:30	46	F6	2026-10-08 22:08:59.994+05:30
2	2026-10-08 22:09:00.004494+05:30	47	F7	2026-10-08 22:08:59.998+05:30
2	2026-10-08 22:09:00.008855+05:30	48	F8	2026-10-08 22:09:00.003+05:30
2	2026-10-08 22:09:00.011954+05:30	49	G1	2026-10-08 22:09:00.006+05:30
2	2026-10-08 22:09:00.014831+05:30	50	G2	2026-10-08 22:09:00.009+05:30
2	2026-10-08 22:09:00.017738+05:30	51	G3	2026-10-08 22:09:00.012+05:30
2	2026-10-08 22:09:00.020574+05:30	52	G4	2026-10-08 22:09:00.015+05:30
2	2026-10-08 22:09:00.022944+05:30	53	G5	2026-10-08 22:09:00.017+05:30
2	2026-10-08 22:09:00.02527+05:30	54	G6	2026-10-08 22:09:00.02+05:30
2	2026-10-08 22:09:00.028106+05:30	55	G7	2026-10-08 22:09:00.022+05:30
2	2026-10-08 22:09:00.030789+05:30	56	G8	2026-10-08 22:09:00.025+05:30
3	2026-10-08 22:09:00.033335+05:30	57	A1	2026-10-08 22:09:00.028+05:30
3	2026-10-08 22:09:00.035498+05:30	58	A2	2026-10-08 22:09:00.03+05:30
3	2026-10-08 22:09:00.037874+05:30	59	A3	2026-10-08 22:09:00.032+05:30
3	2026-10-08 22:09:00.040017+05:30	60	A4	2026-10-08 22:09:00.034+05:30
3	2026-10-08 22:09:00.042164+05:30	61	A5	2026-10-08 22:09:00.037+05:30
3	2026-10-08 22:09:00.044405+05:30	62	A6	2026-10-08 22:09:00.039+05:30
3	2026-10-08 22:09:00.046856+05:30	63	A7	2026-10-08 22:09:00.041+05:30
3	2026-10-08 22:09:00.049972+05:30	64	A8	2026-10-08 22:09:00.044+05:30
3	2026-10-08 22:09:00.052789+05:30	65	B1	2026-10-08 22:09:00.047+05:30
3	2026-10-08 22:09:00.055027+05:30	66	B2	2026-10-08 22:09:00.049+05:30
3	2026-10-08 22:09:00.057248+05:30	67	B3	2026-10-08 22:09:00.052+05:30
3	2026-10-08 22:09:00.059646+05:30	68	B4	2026-10-08 22:09:00.054+05:30
3	2026-10-08 22:09:00.06235+05:30	69	B5	2026-10-08 22:09:00.057+05:30
3	2026-10-08 22:09:00.064989+05:30	70	B6	2026-10-08 22:09:00.059+05:30
3	2026-10-08 22:09:00.067663+05:30	71	B7	2026-10-08 22:09:00.062+05:30
3	2026-10-08 22:09:00.070369+05:30	72	B8	2026-10-08 22:09:00.065+05:30
3	2026-10-08 22:09:00.072659+05:30	73	C1	2026-10-08 22:09:00.067+05:30
3	2026-10-08 22:09:00.0749+05:30	74	C2	2026-10-08 22:09:00.069+05:30
3	2026-10-08 22:09:00.077057+05:30	75	C3	2026-10-08 22:09:00.071+05:30
3	2026-10-08 22:09:00.079394+05:30	76	C4	2026-10-08 22:09:00.074+05:30
3	2026-10-08 22:09:00.081666+05:30	77	C5	2026-10-08 22:09:00.076+05:30
3	2026-10-08 22:09:00.084077+05:30	78	C6	2026-10-08 22:09:00.078+05:30
3	2026-10-08 22:09:00.086638+05:30	79	C7	2026-10-08 22:09:00.081+05:30
3	2026-10-08 22:09:00.089968+05:30	80	C8	2026-10-08 22:09:00.084+05:30
3	2026-10-08 22:09:00.093596+05:30	81	D1	2026-10-08 22:09:00.088+05:30
3	2026-10-08 22:09:00.097584+05:30	82	D2	2026-10-08 22:09:00.091+05:30
3	2026-10-08 22:09:00.101203+05:30	83	D3	2026-10-08 22:09:00.095+05:30
3	2026-10-08 22:09:00.104549+05:30	84	D4	2026-10-08 22:09:00.099+05:30
3	2026-10-08 22:09:00.107901+05:30	85	D5	2026-10-08 22:09:00.102+05:30
3	2026-10-08 22:09:00.111368+05:30	86	D6	2026-10-08 22:09:00.105+05:30
3	2026-10-08 22:09:00.114374+05:30	87	D7	2026-10-08 22:09:00.109+05:30
3	2026-10-08 22:09:00.117457+05:30	88	D8	2026-10-08 22:09:00.112+05:30
3	2026-10-08 22:09:00.120395+05:30	89	E1	2026-10-08 22:09:00.115+05:30
3	2026-10-08 22:09:00.122943+05:30	90	E2	2026-10-08 22:09:00.117+05:30
3	2026-10-08 22:09:00.125187+05:30	91	E3	2026-10-08 22:09:00.12+05:30
3	2026-10-08 22:09:00.127577+05:30	92	E4	2026-10-08 22:09:00.122+05:30
3	2026-10-08 22:09:00.129679+05:30	93	E5	2026-10-08 22:09:00.124+05:30
3	2026-10-08 22:09:00.131737+05:30	94	E6	2026-10-08 22:09:00.126+05:30
3	2026-10-08 22:09:00.135002+05:30	95	E7	2026-10-08 22:09:00.129+05:30
3	2026-10-08 22:09:00.138465+05:30	96	E8	2026-10-08 22:09:00.133+05:30
3	2026-10-08 22:09:00.142268+05:30	97	F1	2026-10-08 22:09:00.136+05:30
3	2026-10-08 22:09:00.145031+05:30	98	F2	2026-10-08 22:09:00.139+05:30
3	2026-10-08 22:09:00.147527+05:30	99	F3	2026-10-08 22:09:00.142+05:30
3	2026-10-08 22:09:00.149996+05:30	100	F4	2026-10-08 22:09:00.144+05:30
3	2026-10-08 22:09:00.153233+05:30	101	F5	2026-10-08 22:09:00.147+05:30
3	2026-10-08 22:09:00.15627+05:30	102	F6	2026-10-08 22:09:00.15+05:30
3	2026-10-08 22:09:00.160027+05:30	103	F7	2026-10-08 22:09:00.154+05:30
3	2026-10-08 22:09:00.164784+05:30	104	F8	2026-10-08 22:09:00.159+05:30
3	2026-10-08 22:09:00.167737+05:30	105	G1	2026-10-08 22:09:00.162+05:30
3	2026-10-08 22:09:00.171175+05:30	106	G2	2026-10-08 22:09:00.165+05:30
3	2026-10-08 22:09:00.173721+05:30	107	G3	2026-10-08 22:09:00.168+05:30
3	2026-10-08 22:09:00.176152+05:30	108	G4	2026-10-08 22:09:00.17+05:30
3	2026-10-08 22:09:00.178352+05:30	109	G5	2026-10-08 22:09:00.173+05:30
3	2026-10-08 22:09:00.180823+05:30	110	G6	2026-10-08 22:09:00.175+05:30
3	2026-10-08 22:09:00.182926+05:30	111	G7	2026-10-08 22:09:00.177+05:30
3	2026-10-08 22:09:00.184919+05:30	112	G8	2026-10-08 22:09:00.179+05:30
4	2026-10-08 22:09:00.187031+05:30	113	A1	2026-10-08 22:09:00.182+05:30
4	2026-10-08 22:09:00.189028+05:30	114	A2	2026-10-08 22:09:00.184+05:30
4	2026-10-08 22:09:00.191881+05:30	115	A3	2026-10-08 22:09:00.186+05:30
4	2026-10-08 22:09:00.194004+05:30	116	A4	2026-10-08 22:09:00.188+05:30
4	2026-10-08 22:09:00.196046+05:30	117	A5	2026-10-08 22:09:00.191+05:30
4	2026-10-08 22:09:00.198048+05:30	118	A6	2026-10-08 22:09:00.192+05:30
4	2026-10-08 22:09:00.200361+05:30	119	A7	2026-10-08 22:09:00.195+05:30
4	2026-10-08 22:09:00.202452+05:30	120	A8	2026-10-08 22:09:00.197+05:30
4	2026-10-08 22:09:00.204541+05:30	121	B1	2026-10-08 22:09:00.199+05:30
4	2026-10-08 22:09:00.206828+05:30	122	B2	2026-10-08 22:09:00.201+05:30
4	2026-10-08 22:09:00.209763+05:30	123	B3	2026-10-08 22:09:00.204+05:30
4	2026-10-08 22:09:00.21278+05:30	124	B4	2026-10-08 22:09:00.207+05:30
4	2026-10-08 22:09:00.215539+05:30	125	B5	2026-10-08 22:09:00.21+05:30
4	2026-10-08 22:09:00.21836+05:30	126	B6	2026-10-08 22:09:00.213+05:30
4	2026-10-08 22:09:00.221289+05:30	127	B7	2026-10-08 22:09:00.216+05:30
4	2026-10-08 22:09:00.224159+05:30	128	B8	2026-10-08 22:09:00.218+05:30
4	2026-10-08 22:09:00.226684+05:30	129	C1	2026-10-08 22:09:00.221+05:30
4	2026-10-08 22:09:00.229948+05:30	130	C2	2026-10-08 22:09:00.224+05:30
4	2026-10-08 22:09:00.23314+05:30	131	C3	2026-10-08 22:09:00.227+05:30
4	2026-10-08 22:09:00.236576+05:30	132	C4	2026-10-08 22:09:00.231+05:30
4	2026-10-08 22:09:00.240122+05:30	133	C5	2026-10-08 22:09:00.234+05:30
4	2026-10-08 22:09:00.242991+05:30	134	C6	2026-10-08 22:09:00.237+05:30
4	2026-10-08 22:09:00.245393+05:30	135	C7	2026-10-08 22:09:00.24+05:30
4	2026-10-08 22:09:00.247751+05:30	136	C8	2026-10-08 22:09:00.242+05:30
4	2026-10-08 22:09:00.250379+05:30	137	D1	2026-10-08 22:09:00.245+05:30
4	2026-10-08 22:09:00.254122+05:30	138	D2	2026-10-08 22:09:00.248+05:30
4	2026-10-08 22:09:00.256229+05:30	139	D3	2026-10-08 22:09:00.251+05:30
4	2026-10-08 22:09:00.258323+05:30	140	D4	2026-10-08 22:09:00.253+05:30
4	2026-10-08 22:09:00.260345+05:30	141	D5	2026-10-08 22:09:00.255+05:30
4	2026-10-08 22:09:00.262279+05:30	142	D6	2026-10-08 22:09:00.257+05:30
4	2026-10-08 22:09:00.264184+05:30	143	D7	2026-10-08 22:09:00.259+05:30
4	2026-10-08 22:09:00.266094+05:30	144	D8	2026-10-08 22:09:00.261+05:30
4	2026-10-08 22:09:00.26835+05:30	145	E1	2026-10-08 22:09:00.263+05:30
4	2026-10-08 22:09:00.270761+05:30	146	E2	2026-10-08 22:09:00.265+05:30
4	2026-10-08 22:09:00.273084+05:30	147	E3	2026-10-08 22:09:00.267+05:30
4	2026-10-08 22:09:00.275195+05:30	148	E4	2026-10-08 22:09:00.27+05:30
4	2026-10-08 22:09:00.276969+05:30	149	E5	2026-10-08 22:09:00.271+05:30
4	2026-10-08 22:09:00.278857+05:30	150	E6	2026-10-08 22:09:00.273+05:30
4	2026-10-08 22:09:00.280693+05:30	151	E7	2026-10-08 22:09:00.275+05:30
4	2026-10-08 22:09:00.282625+05:30	152	E8	2026-10-08 22:09:00.277+05:30
4	2026-10-08 22:09:00.284745+05:30	153	F1	2026-10-08 22:09:00.279+05:30
4	2026-10-08 22:09:00.286905+05:30	154	F2	2026-10-08 22:09:00.281+05:30
4	2026-10-08 22:09:00.288976+05:30	155	F3	2026-10-08 22:09:00.283+05:30
4	2026-10-08 22:09:00.290964+05:30	156	F4	2026-10-08 22:09:00.285+05:30
4	2026-10-08 22:09:00.292948+05:30	157	F5	2026-10-08 22:09:00.287+05:30
4	2026-10-08 22:09:00.294832+05:30	158	F6	2026-10-08 22:09:00.289+05:30
4	2026-10-08 22:09:00.296716+05:30	159	F7	2026-10-08 22:09:00.291+05:30
4	2026-10-08 22:09:00.299861+05:30	160	F8	2026-10-08 22:09:00.294+05:30
4	2026-10-08 22:09:00.303211+05:30	161	G1	2026-10-08 22:09:00.297+05:30
4	2026-10-08 22:09:00.306309+05:30	162	G2	2026-10-08 22:09:00.301+05:30
4	2026-10-08 22:09:00.308852+05:30	163	G3	2026-10-08 22:09:00.303+05:30
4	2026-10-08 22:09:00.311239+05:30	164	G4	2026-10-08 22:09:00.306+05:30
4	2026-10-08 22:09:00.313412+05:30	165	G5	2026-10-08 22:09:00.308+05:30
4	2026-10-08 22:09:00.315556+05:30	166	G6	2026-10-08 22:09:00.31+05:30
4	2026-10-08 22:09:00.31812+05:30	167	G7	2026-10-08 22:09:00.313+05:30
4	2026-10-08 22:09:00.320502+05:30	168	G8	2026-10-08 22:09:00.315+05:30
5	2026-10-08 22:09:00.32258+05:30	169	A1	2026-10-08 22:09:00.317+05:30
5	2026-10-08 22:09:00.32476+05:30	170	A2	2026-10-08 22:09:00.319+05:30
5	2026-10-08 22:09:00.326753+05:30	171	A3	2026-10-08 22:09:00.321+05:30
5	2026-10-08 22:09:00.329077+05:30	172	A4	2026-10-08 22:09:00.323+05:30
5	2026-10-08 22:09:00.331022+05:30	173	A5	2026-10-08 22:09:00.326+05:30
5	2026-10-08 22:09:00.333342+05:30	174	A6	2026-10-08 22:09:00.328+05:30
5	2026-10-08 22:09:00.335513+05:30	175	A7	2026-10-08 22:09:00.33+05:30
5	2026-10-08 22:09:00.337445+05:30	176	A8	2026-10-08 22:09:00.332+05:30
5	2026-10-08 22:09:00.339342+05:30	177	B1	2026-10-08 22:09:00.334+05:30
5	2026-10-08 22:09:00.341246+05:30	178	B2	2026-10-08 22:09:00.336+05:30
5	2026-10-08 22:09:00.343135+05:30	179	B3	2026-10-08 22:09:00.338+05:30
5	2026-10-08 22:09:00.345059+05:30	180	B4	2026-10-08 22:09:00.34+05:30
5	2026-10-08 22:09:00.346933+05:30	181	B5	2026-10-08 22:09:00.341+05:30
5	2026-10-08 22:09:00.349135+05:30	182	B6	2026-10-08 22:09:00.344+05:30
5	2026-10-08 22:09:00.351034+05:30	183	B7	2026-10-08 22:09:00.345+05:30
5	2026-10-08 22:09:00.353156+05:30	184	B8	2026-10-08 22:09:00.348+05:30
5	2026-10-08 22:09:00.35519+05:30	185	C1	2026-10-08 22:09:00.35+05:30
5	2026-10-08 22:09:00.357163+05:30	186	C2	2026-10-08 22:09:00.352+05:30
5	2026-10-08 22:09:00.359026+05:30	187	C3	2026-10-08 22:09:00.354+05:30
5	2026-10-08 22:09:00.360878+05:30	188	C4	2026-10-08 22:09:00.355+05:30
5	2026-10-08 22:09:00.362709+05:30	189	C5	2026-10-08 22:09:00.357+05:30
5	2026-10-08 22:09:00.36514+05:30	190	C6	2026-10-08 22:09:00.36+05:30
5	2026-10-08 22:09:00.367205+05:30	191	C7	2026-10-08 22:09:00.362+05:30
5	2026-10-08 22:09:00.369574+05:30	192	C8	2026-10-08 22:09:00.364+05:30
5	2026-10-08 22:09:00.371744+05:30	193	D1	2026-10-08 22:09:00.366+05:30
5	2026-10-08 22:09:00.374967+05:30	194	D2	2026-10-08 22:09:00.369+05:30
5	2026-10-08 22:09:00.37833+05:30	195	D3	2026-10-08 22:09:00.372+05:30
5	2026-10-08 22:09:00.380902+05:30	196	D4	2026-10-08 22:09:00.375+05:30
5	2026-10-08 22:09:00.38329+05:30	197	D5	2026-10-08 22:09:00.378+05:30
5	2026-10-08 22:09:00.385706+05:30	198	D6	2026-10-08 22:09:00.38+05:30
5	2026-10-08 22:09:00.387903+05:30	199	D7	2026-10-08 22:09:00.382+05:30
5	2026-10-08 22:09:00.389874+05:30	200	D8	2026-10-08 22:09:00.384+05:30
5	2026-10-08 22:09:00.391854+05:30	201	E1	2026-10-08 22:09:00.386+05:30
5	2026-10-08 22:09:00.394005+05:30	202	E2	2026-10-08 22:09:00.388+05:30
5	2026-10-08 22:09:00.401673+05:30	203	E3	2026-10-08 22:09:00.396+05:30
5	2026-10-08 22:09:00.405445+05:30	204	E4	2026-10-08 22:09:00.399+05:30
5	2026-10-08 22:09:00.408819+05:30	205	E5	2026-10-08 22:09:00.403+05:30
5	2026-10-08 22:09:00.412198+05:30	206	E6	2026-10-08 22:09:00.407+05:30
5	2026-10-08 22:09:00.414797+05:30	207	E7	2026-10-08 22:09:00.409+05:30
5	2026-10-08 22:09:00.417284+05:30	208	E8	2026-10-08 22:09:00.412+05:30
5	2026-10-08 22:09:00.41953+05:30	209	F1	2026-10-08 22:09:00.414+05:30
5	2026-10-08 22:09:00.421673+05:30	210	F2	2026-10-08 22:09:00.416+05:30
5	2026-10-08 22:09:00.424445+05:30	211	F3	2026-10-08 22:09:00.419+05:30
5	2026-10-08 22:09:00.427384+05:30	212	F4	2026-10-08 22:09:00.422+05:30
5	2026-10-08 22:09:00.430017+05:30	213	F5	2026-10-08 22:09:00.424+05:30
5	2026-10-08 22:09:00.432451+05:30	214	F6	2026-10-08 22:09:00.427+05:30
5	2026-10-08 22:09:00.434592+05:30	215	F7	2026-10-08 22:09:00.429+05:30
5	2026-10-08 22:09:00.437813+05:30	216	F8	2026-10-08 22:09:00.432+05:30
5	2026-10-08 22:09:00.440424+05:30	217	G1	2026-10-08 22:09:00.435+05:30
5	2026-10-08 22:09:00.442846+05:30	218	G2	2026-10-08 22:09:00.437+05:30
5	2026-10-08 22:09:00.445065+05:30	219	G3	2026-10-08 22:09:00.439+05:30
5	2026-10-08 22:09:00.447375+05:30	220	G4	2026-10-08 22:09:00.442+05:30
5	2026-10-08 22:09:00.449858+05:30	221	G5	2026-10-08 22:09:00.444+05:30
5	2026-10-08 22:09:00.452551+05:30	222	G6	2026-10-08 22:09:00.447+05:30
5	2026-10-08 22:09:00.454886+05:30	223	G7	2026-10-08 22:09:00.449+05:30
5	2026-10-08 22:09:00.456985+05:30	224	G8	2026-10-08 22:09:00.451+05:30
\.


--
-- Data for Name: Show; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Show" ("cinemaId", "createdAt", date, format, id, "movieId", "time", "updatedAt") FROM stdin;
2	2026-10-08 01:08:12.432634+05:30	2026-10-10	2D	2	1	10:00 AM	2026-10-08 01:08:12.314+05:30
3	2026-10-08 01:08:12.44114+05:30	2026-10-10	3D	3	1	1:30 PM	2026-10-08 01:08:12.437+05:30
2	2026-10-08 01:08:12.443138+05:30	2026-10-10	2D	4	2	4:30 PM	2026-10-08 01:08:12.44+05:30
3	2026-10-08 01:08:12.444996+05:30	2026-10-10	IMAX	5	2	7:30 PM	2026-10-08 01:08:12.441+05:30
4	2026-10-08 01:08:12.446906+05:30	2026-10-11	2D	6	3	10:00 AM	2026-10-08 01:08:12.443+05:30
5	2026-10-08 01:08:12.448663+05:30	2026-10-11	4DX	7	4	4:30 PM	2026-10-08 01:08:12.445+05:30
2	2026-10-08 21:04:58.890636+05:30	2026-10-23	2D	8	1	10:00 AM	2026-10-08 21:04:58.717+05:30
3	2026-10-08 21:04:58.916365+05:30	2026-10-23	3D	9	1	1:30 PM	2026-10-08 21:04:58.914+05:30
4	2026-10-08 21:04:58.919521+05:30	2026-10-23	IMAX	10	1	4:30 PM	2026-10-08 21:04:58.917+05:30
5	2026-10-08 21:04:58.922737+05:30	2026-10-23	4DX	11	1	7:30 PM	2026-10-08 21:04:58.92+05:30
2	2026-10-08 21:04:58.927488+05:30	2026-10-23	2D	12	2	10:00 AM	2026-10-08 21:04:58.923+05:30
3	2026-10-08 21:04:58.93034+05:30	2026-10-23	3D	13	2	1:30 PM	2026-10-08 21:04:58.928+05:30
4	2026-10-08 21:04:58.934243+05:30	2026-10-23	IMAX	14	2	4:30 PM	2026-10-08 21:04:58.931+05:30
5	2026-10-08 21:04:58.937329+05:30	2026-10-23	4DX	15	2	7:30 PM	2026-10-08 21:04:58.935+05:30
2	2026-10-08 21:04:58.940185+05:30	2026-10-23	2D	16	3	10:00 AM	2026-10-08 21:04:58.938+05:30
3	2026-10-08 21:04:58.944449+05:30	2026-10-23	3D	17	3	1:30 PM	2026-10-08 21:04:58.941+05:30
4	2026-10-08 21:04:58.956619+05:30	2026-10-23	IMAX	18	3	4:30 PM	2026-10-08 21:04:58.953+05:30
5	2026-10-08 21:04:58.961491+05:30	2026-10-23	4DX	19	3	7:30 PM	2026-10-08 21:04:58.958+05:30
2	2026-10-08 21:04:58.968584+05:30	2026-10-23	2D	20	4	10:00 AM	2026-10-08 21:04:58.963+05:30
3	2026-10-08 21:04:58.978129+05:30	2026-10-23	3D	21	4	1:30 PM	2026-10-08 21:04:58.972+05:30
4	2026-10-08 21:04:58.984727+05:30	2026-10-23	IMAX	22	4	4:30 PM	2026-10-08 21:04:58.981+05:30
5	2026-10-08 21:04:58.988603+05:30	2026-10-23	4DX	23	4	7:30 PM	2026-10-08 21:04:58.985+05:30
2	2026-10-08 21:04:58.99305+05:30	2026-10-23	2D	24	5	10:00 AM	2026-10-08 21:04:58.99+05:30
3	2026-10-08 21:04:58.995901+05:30	2026-10-23	3D	25	5	1:30 PM	2026-10-08 21:04:58.993+05:30
4	2026-10-08 21:04:58.998235+05:30	2026-10-23	IMAX	26	5	4:30 PM	2026-10-08 21:04:58.996+05:30
5	2026-10-08 21:04:59.001703+05:30	2026-10-23	4DX	27	5	7:30 PM	2026-10-08 21:04:58.999+05:30
2	2026-10-08 21:04:59.005062+05:30	2026-10-23	2D	28	6	10:00 AM	2026-10-08 21:04:59.002+05:30
3	2026-10-08 21:04:59.008695+05:30	2026-10-23	3D	29	6	1:30 PM	2026-10-08 21:04:59.006+05:30
4	2026-10-08 21:04:59.010966+05:30	2026-10-23	IMAX	30	6	4:30 PM	2026-10-08 21:04:59.009+05:30
5	2026-10-08 21:04:59.013612+05:30	2026-10-23	4DX	31	6	7:30 PM	2026-10-08 21:04:59.011+05:30
2	2026-10-08 21:04:59.016989+05:30	2026-10-23	2D	32	7	10:00 AM	2026-10-08 21:04:59.014+05:30
3	2026-10-08 21:04:59.020349+05:30	2026-10-23	3D	33	7	1:30 PM	2026-10-08 21:04:59.018+05:30
4	2026-10-08 21:04:59.025077+05:30	2026-10-23	IMAX	34	7	4:30 PM	2026-10-08 21:04:59.022+05:30
5	2026-10-08 21:04:59.028771+05:30	2026-10-23	4DX	35	7	7:30 PM	2026-10-08 21:04:59.026+05:30
2	2026-10-08 21:04:59.031775+05:30	2026-10-23	2D	36	8	10:00 AM	2026-10-08 21:04:59.029+05:30
3	2026-10-08 21:04:59.034875+05:30	2026-10-23	3D	37	8	1:30 PM	2026-10-08 21:04:59.032+05:30
4	2026-10-08 21:04:59.038805+05:30	2026-10-23	IMAX	38	8	4:30 PM	2026-10-08 21:04:59.036+05:30
5	2026-10-08 21:04:59.041888+05:30	2026-10-23	4DX	39	8	7:30 PM	2026-10-08 21:04:59.039+05:30
2	2026-10-08 21:04:59.044347+05:30	2026-10-23	2D	40	9	10:00 AM	2026-10-08 21:04:59.042+05:30
3	2026-10-08 21:04:59.046714+05:30	2026-10-23	3D	41	9	1:30 PM	2026-10-08 21:04:59.044+05:30
4	2026-10-08 21:04:59.052516+05:30	2026-10-23	IMAX	42	9	4:30 PM	2026-10-08 21:04:59.049+05:30
5	2026-10-08 21:04:59.058235+05:30	2026-10-23	4DX	43	9	7:30 PM	2026-10-08 21:04:59.054+05:30
2	2026-10-08 21:04:59.060491+05:30	2026-10-23	2D	44	10	10:00 AM	2026-10-08 21:04:59.058+05:30
3	2026-10-08 21:04:59.062357+05:30	2026-10-23	3D	45	10	1:30 PM	2026-10-08 21:04:59.06+05:30
4	2026-10-08 21:04:59.06421+05:30	2026-10-23	IMAX	46	10	4:30 PM	2026-10-08 21:04:59.062+05:30
5	2026-10-08 21:04:59.067208+05:30	2026-10-23	4DX	47	10	7:30 PM	2026-10-08 21:04:59.064+05:30
2	2026-10-08 21:04:59.06979+05:30	2026-10-23	2D	48	11	10:00 AM	2026-10-08 21:04:59.068+05:30
3	2026-10-08 21:04:59.072964+05:30	2026-10-23	3D	49	11	1:30 PM	2026-10-08 21:04:59.07+05:30
4	2026-10-08 21:04:59.074726+05:30	2026-10-23	IMAX	50	11	4:30 PM	2026-10-08 21:04:59.073+05:30
5	2026-10-08 21:04:59.076356+05:30	2026-10-23	4DX	51	11	7:30 PM	2026-10-08 21:04:59.074+05:30
2	2026-10-08 21:04:59.078057+05:30	2026-10-23	2D	52	12	10:00 AM	2026-10-08 21:04:59.076+05:30
3	2026-10-08 21:04:59.079801+05:30	2026-10-23	3D	53	12	1:30 PM	2026-10-08 21:04:59.078+05:30
4	2026-10-08 21:04:59.081901+05:30	2026-10-23	IMAX	54	12	4:30 PM	2026-10-08 21:04:59.08+05:30
5	2026-10-08 21:04:59.084647+05:30	2026-10-23	4DX	55	12	7:30 PM	2026-10-08 21:04:59.082+05:30
2	2026-10-08 21:04:59.088157+05:30	2026-10-23	2D	56	13	10:00 AM	2026-10-08 21:04:59.085+05:30
3	2026-10-08 21:04:59.090601+05:30	2026-10-23	3D	57	13	1:30 PM	2026-10-08 21:04:59.088+05:30
4	2026-10-08 21:04:59.092971+05:30	2026-10-23	IMAX	58	13	4:30 PM	2026-10-08 21:04:59.091+05:30
5	2026-10-08 21:04:59.095881+05:30	2026-10-23	4DX	59	13	7:30 PM	2026-10-08 21:04:59.093+05:30
2	2026-10-08 21:04:59.098646+05:30	2026-10-23	2D	60	14	10:00 AM	2026-10-08 21:04:59.097+05:30
3	2026-10-08 21:04:59.100946+05:30	2026-10-23	3D	61	14	1:30 PM	2026-10-08 21:04:59.099+05:30
4	2026-10-08 21:04:59.103597+05:30	2026-10-23	IMAX	62	14	4:30 PM	2026-10-08 21:04:59.101+05:30
5	2026-10-08 21:04:59.106982+05:30	2026-10-23	4DX	63	14	7:30 PM	2026-10-08 21:04:59.105+05:30
2	2026-10-08 21:04:59.11009+05:30	2026-10-23	2D	64	15	10:00 AM	2026-10-08 21:04:59.107+05:30
3	2026-10-08 21:04:59.112136+05:30	2026-10-23	3D	65	15	1:30 PM	2026-10-08 21:04:59.11+05:30
4	2026-10-08 21:04:59.114508+05:30	2026-10-23	IMAX	66	15	4:30 PM	2026-10-08 21:04:59.112+05:30
5	2026-10-08 21:04:59.11974+05:30	2026-10-23	4DX	67	15	7:30 PM	2026-10-08 21:04:59.117+05:30
2	2026-10-08 21:04:59.124181+05:30	2026-10-23	2D	68	16	10:00 AM	2026-10-08 21:04:59.121+05:30
3	2026-10-08 21:04:59.12676+05:30	2026-10-23	3D	69	16	1:30 PM	2026-10-08 21:04:59.125+05:30
4	2026-10-08 21:04:59.129788+05:30	2026-10-23	IMAX	70	16	4:30 PM	2026-10-08 21:04:59.127+05:30
5	2026-10-08 21:04:59.131872+05:30	2026-10-23	4DX	71	16	7:30 PM	2026-10-08 21:04:59.13+05:30
4	2026-10-08 22:57:15.665008+05:30	2026-10-10	IMAX	72	1	4:30 PM	2026-10-08 22:57:15.657+05:30
5	2026-10-08 22:57:15.684177+05:30	2026-10-10	4DX	73	1	7:30 PM	2026-10-08 22:57:15.682+05:30
2	2026-10-08 22:57:15.691691+05:30	2026-10-11	2D	74	1	10:00 AM	2026-10-08 22:57:15.689+05:30
3	2026-10-08 22:57:15.714105+05:30	2026-10-11	3D	75	1	1:30 PM	2026-10-08 22:57:15.704+05:30
4	2026-10-08 22:57:15.743437+05:30	2026-10-11	IMAX	76	1	4:30 PM	2026-10-08 22:57:15.739+05:30
5	2026-10-08 22:57:15.756529+05:30	2026-10-11	4DX	77	1	7:30 PM	2026-10-08 22:57:15.754+05:30
2	2026-10-08 22:57:15.767132+05:30	2026-10-12	2D	78	1	10:00 AM	2026-10-08 22:57:15.764+05:30
3	2026-10-08 22:57:15.776204+05:30	2026-10-12	3D	79	1	1:30 PM	2026-10-08 22:57:15.772+05:30
4	2026-10-08 22:57:15.787998+05:30	2026-10-12	IMAX	80	1	4:30 PM	2026-10-08 22:57:15.786+05:30
5	2026-10-08 22:57:15.796403+05:30	2026-10-12	4DX	81	1	7:30 PM	2026-10-08 22:57:15.794+05:30
2	2026-10-08 22:57:15.802873+05:30	2026-10-13	2D	82	1	10:00 AM	2026-10-08 22:57:15.801+05:30
3	2026-10-08 22:57:15.808612+05:30	2026-10-13	3D	83	1	1:30 PM	2026-10-08 22:57:15.807+05:30
4	2026-10-08 22:57:15.814713+05:30	2026-10-13	IMAX	84	1	4:30 PM	2026-10-08 22:57:15.813+05:30
5	2026-10-08 22:57:15.819724+05:30	2026-10-13	4DX	85	1	7:30 PM	2026-10-08 22:57:15.818+05:30
2	2026-10-08 22:57:15.825613+05:30	2026-10-14	2D	86	1	10:00 AM	2026-10-08 22:57:15.823+05:30
3	2026-10-08 22:57:15.831045+05:30	2026-10-14	3D	87	1	1:30 PM	2026-10-08 22:57:15.829+05:30
4	2026-10-08 22:57:15.834926+05:30	2026-10-14	IMAX	88	1	4:30 PM	2026-10-08 22:57:15.833+05:30
5	2026-10-08 22:57:15.839735+05:30	2026-10-14	4DX	89	1	7:30 PM	2026-10-08 22:57:15.838+05:30
2	2026-10-08 22:57:15.846003+05:30	2026-10-15	2D	90	1	10:00 AM	2026-10-08 22:57:15.844+05:30
3	2026-10-08 22:57:15.850538+05:30	2026-10-15	3D	91	1	1:30 PM	2026-10-08 22:57:15.849+05:30
4	2026-10-08 22:57:15.854352+05:30	2026-10-15	IMAX	92	1	4:30 PM	2026-10-08 22:57:15.853+05:30
5	2026-10-08 22:57:15.859164+05:30	2026-10-15	4DX	93	1	7:30 PM	2026-10-08 22:57:15.858+05:30
2	2026-10-08 22:57:15.863845+05:30	2026-10-16	2D	94	1	10:00 AM	2026-10-08 22:57:15.862+05:30
3	2026-10-08 22:57:15.867597+05:30	2026-10-16	3D	95	1	1:30 PM	2026-10-08 22:57:15.866+05:30
4	2026-10-08 22:57:15.87379+05:30	2026-10-16	IMAX	96	1	4:30 PM	2026-10-08 22:57:15.872+05:30
5	2026-10-08 22:57:15.878372+05:30	2026-10-16	4DX	97	1	7:30 PM	2026-10-08 22:57:15.877+05:30
2	2026-10-08 22:57:15.883024+05:30	2026-10-17	2D	98	1	10:00 AM	2026-10-08 22:57:15.881+05:30
3	2026-10-08 22:57:15.8863+05:30	2026-10-17	3D	99	1	1:30 PM	2026-10-08 22:57:15.885+05:30
4	2026-10-08 22:57:15.889653+05:30	2026-10-17	IMAX	100	1	4:30 PM	2026-10-08 22:57:15.888+05:30
5	2026-10-08 22:57:15.894483+05:30	2026-10-17	4DX	101	1	7:30 PM	2026-10-08 22:57:15.893+05:30
2	2026-10-08 22:57:15.897941+05:30	2026-10-18	2D	102	1	10:00 AM	2026-10-08 22:57:15.897+05:30
3	2026-10-08 22:57:15.901319+05:30	2026-10-18	3D	103	1	1:30 PM	2026-10-08 22:57:15.9+05:30
4	2026-10-08 22:57:15.904421+05:30	2026-10-18	IMAX	104	1	4:30 PM	2026-10-08 22:57:15.903+05:30
5	2026-10-08 22:57:15.908154+05:30	2026-10-18	4DX	105	1	7:30 PM	2026-10-08 22:57:15.906+05:30
2	2026-10-08 22:57:15.912147+05:30	2026-10-19	2D	106	1	10:00 AM	2026-10-08 22:57:15.911+05:30
3	2026-10-08 22:57:15.914939+05:30	2026-10-19	3D	107	1	1:30 PM	2026-10-08 22:57:15.914+05:30
4	2026-10-08 22:57:15.917741+05:30	2026-10-19	IMAX	108	1	4:30 PM	2026-10-08 22:57:15.917+05:30
5	2026-10-08 22:57:15.920582+05:30	2026-10-19	4DX	109	1	7:30 PM	2026-10-08 22:57:15.919+05:30
2	2026-10-08 22:57:15.92425+05:30	2026-10-20	2D	110	1	10:00 AM	2026-10-08 22:57:15.922+05:30
3	2026-10-08 22:57:15.929223+05:30	2026-10-20	3D	111	1	1:30 PM	2026-10-08 22:57:15.927+05:30
4	2026-10-08 22:57:15.933255+05:30	2026-10-20	IMAX	112	1	4:30 PM	2026-10-08 22:57:15.932+05:30
5	2026-10-08 22:57:15.937528+05:30	2026-10-20	4DX	113	1	7:30 PM	2026-10-08 22:57:15.936+05:30
2	2026-10-08 22:57:15.941526+05:30	2026-10-21	2D	114	1	10:00 AM	2026-10-08 22:57:15.94+05:30
3	2026-10-08 22:57:15.945345+05:30	2026-10-21	3D	115	1	1:30 PM	2026-10-08 22:57:15.944+05:30
4	2026-10-08 22:57:15.949079+05:30	2026-10-21	IMAX	116	1	4:30 PM	2026-10-08 22:57:15.948+05:30
5	2026-10-08 22:57:15.95171+05:30	2026-10-21	4DX	117	1	7:30 PM	2026-10-08 22:57:15.951+05:30
2	2026-10-08 22:57:15.954641+05:30	2026-10-22	2D	118	1	10:00 AM	2026-10-08 22:57:15.953+05:30
3	2026-10-08 22:57:15.959691+05:30	2026-10-22	3D	119	1	1:30 PM	2026-10-08 22:57:15.958+05:30
4	2026-10-08 22:57:15.964359+05:30	2026-10-22	IMAX	120	1	4:30 PM	2026-10-08 22:57:15.963+05:30
5	2026-10-08 22:57:15.968456+05:30	2026-10-22	4DX	121	1	7:30 PM	2026-10-08 22:57:15.967+05:30
2	2026-10-08 22:57:15.983366+05:30	2026-10-10	2D	122	2	10:00 AM	2026-10-08 22:57:15.982+05:30
3	2026-10-08 22:57:15.986718+05:30	2026-10-10	3D	123	2	1:30 PM	2026-10-08 22:57:15.985+05:30
4	2026-10-08 22:57:15.990282+05:30	2026-10-10	IMAX	124	2	4:30 PM	2026-10-08 22:57:15.989+05:30
5	2026-10-08 22:57:15.994896+05:30	2026-10-10	4DX	125	2	7:30 PM	2026-10-08 22:57:15.994+05:30
2	2026-10-08 22:57:15.998516+05:30	2026-10-11	2D	126	2	10:00 AM	2026-10-08 22:57:15.997+05:30
3	2026-10-08 22:57:16.004081+05:30	2026-10-11	3D	127	2	1:30 PM	2026-10-08 22:57:16.002+05:30
4	2026-10-08 22:57:16.0134+05:30	2026-10-11	IMAX	128	2	4:30 PM	2026-10-08 22:57:16.011+05:30
5	2026-10-08 22:57:16.019457+05:30	2026-10-11	4DX	129	2	7:30 PM	2026-10-08 22:57:16.018+05:30
2	2026-10-08 22:57:16.027343+05:30	2026-10-12	2D	130	2	10:00 AM	2026-10-08 22:57:16.025+05:30
3	2026-10-08 22:57:16.032328+05:30	2026-10-12	3D	131	2	1:30 PM	2026-10-08 22:57:16.031+05:30
4	2026-10-08 22:57:16.036052+05:30	2026-10-12	IMAX	132	2	4:30 PM	2026-10-08 22:57:16.035+05:30
5	2026-10-08 22:57:16.041295+05:30	2026-10-12	4DX	133	2	7:30 PM	2026-10-08 22:57:16.039+05:30
2	2026-10-08 22:57:16.045938+05:30	2026-10-13	2D	134	2	10:00 AM	2026-10-08 22:57:16.044+05:30
3	2026-10-08 22:57:16.049682+05:30	2026-10-13	3D	135	2	1:30 PM	2026-10-08 22:57:16.048+05:30
4	2026-10-08 22:57:16.052937+05:30	2026-10-13	IMAX	136	2	4:30 PM	2026-10-08 22:57:16.052+05:30
5	2026-10-08 22:57:16.056415+05:30	2026-10-13	4DX	137	2	7:30 PM	2026-10-08 22:57:16.055+05:30
2	2026-10-08 22:57:16.062152+05:30	2026-10-14	2D	138	2	10:00 AM	2026-10-08 22:57:16.061+05:30
3	2026-10-08 22:57:16.065555+05:30	2026-10-14	3D	139	2	1:30 PM	2026-10-08 22:57:16.064+05:30
4	2026-10-08 22:57:16.068961+05:30	2026-10-14	IMAX	140	2	4:30 PM	2026-10-08 22:57:16.067+05:30
5	2026-10-08 22:57:16.072362+05:30	2026-10-14	4DX	141	2	7:30 PM	2026-10-08 22:57:16.071+05:30
2	2026-10-08 22:57:16.077557+05:30	2026-10-15	2D	142	2	10:00 AM	2026-10-08 22:57:16.076+05:30
3	2026-10-08 22:57:16.082448+05:30	2026-10-15	3D	143	2	1:30 PM	2026-10-08 22:57:16.081+05:30
4	2026-10-08 22:57:16.085888+05:30	2026-10-15	IMAX	144	2	4:30 PM	2026-10-08 22:57:16.084+05:30
5	2026-10-08 22:57:16.088844+05:30	2026-10-15	4DX	145	2	7:30 PM	2026-10-08 22:57:16.088+05:30
2	2026-10-08 22:57:16.093133+05:30	2026-10-16	2D	146	2	10:00 AM	2026-10-08 22:57:16.091+05:30
3	2026-10-08 22:57:16.096396+05:30	2026-10-16	3D	147	2	1:30 PM	2026-10-08 22:57:16.095+05:30
4	2026-10-08 22:57:16.098798+05:30	2026-10-16	IMAX	148	2	4:30 PM	2026-10-08 22:57:16.098+05:30
5	2026-10-08 22:57:16.101238+05:30	2026-10-16	4DX	149	2	7:30 PM	2026-10-08 22:57:16.1+05:30
2	2026-10-08 22:57:16.104562+05:30	2026-10-17	2D	150	2	10:00 AM	2026-10-08 22:57:16.103+05:30
3	2026-10-08 22:57:16.108424+05:30	2026-10-17	3D	151	2	1:30 PM	2026-10-08 22:57:16.107+05:30
4	2026-10-08 22:57:16.112481+05:30	2026-10-17	IMAX	152	2	4:30 PM	2026-10-08 22:57:16.111+05:30
5	2026-10-08 22:57:16.11603+05:30	2026-10-17	4DX	153	2	7:30 PM	2026-10-08 22:57:16.115+05:30
2	2026-10-08 22:57:16.119418+05:30	2026-10-18	2D	154	2	10:00 AM	2026-10-08 22:57:16.118+05:30
3	2026-10-08 22:57:16.122727+05:30	2026-10-18	3D	155	2	1:30 PM	2026-10-08 22:57:16.122+05:30
4	2026-10-08 22:57:16.126766+05:30	2026-10-18	IMAX	156	2	4:30 PM	2026-10-08 22:57:16.126+05:30
5	2026-10-08 22:57:16.130256+05:30	2026-10-18	4DX	157	2	7:30 PM	2026-10-08 22:57:16.129+05:30
2	2026-10-08 22:57:16.133106+05:30	2026-10-19	2D	158	2	10:00 AM	2026-10-08 22:57:16.132+05:30
3	2026-10-08 22:57:16.135432+05:30	2026-10-19	3D	159	2	1:30 PM	2026-10-08 22:57:16.134+05:30
4	2026-10-08 22:57:16.137784+05:30	2026-10-19	IMAX	160	2	4:30 PM	2026-10-08 22:57:16.137+05:30
5	2026-10-08 22:57:16.142006+05:30	2026-10-19	4DX	161	2	7:30 PM	2026-10-08 22:57:16.14+05:30
2	2026-10-08 22:57:16.144902+05:30	2026-10-20	2D	162	2	10:00 AM	2026-10-08 22:57:16.144+05:30
3	2026-10-08 22:57:16.147527+05:30	2026-10-20	3D	163	2	1:30 PM	2026-10-08 22:57:16.146+05:30
4	2026-10-08 22:57:16.150401+05:30	2026-10-20	IMAX	164	2	4:30 PM	2026-10-08 22:57:16.149+05:30
5	2026-10-08 22:57:16.153435+05:30	2026-10-20	4DX	165	2	7:30 PM	2026-10-08 22:57:16.152+05:30
2	2026-10-08 22:57:16.15624+05:30	2026-10-21	2D	166	2	10:00 AM	2026-10-08 22:57:16.155+05:30
3	2026-10-08 22:57:16.160897+05:30	2026-10-21	3D	167	2	1:30 PM	2026-10-08 22:57:16.159+05:30
4	2026-10-08 22:57:16.164605+05:30	2026-10-21	IMAX	168	2	4:30 PM	2026-10-08 22:57:16.163+05:30
5	2026-10-08 22:57:16.167782+05:30	2026-10-21	4DX	169	2	7:30 PM	2026-10-08 22:57:16.166+05:30
2	2026-10-08 22:57:16.171116+05:30	2026-10-22	2D	170	2	10:00 AM	2026-10-08 22:57:16.17+05:30
3	2026-10-08 22:57:16.175576+05:30	2026-10-22	3D	171	2	1:30 PM	2026-10-08 22:57:16.174+05:30
4	2026-10-08 22:57:16.179035+05:30	2026-10-22	IMAX	172	2	4:30 PM	2026-10-08 22:57:16.178+05:30
5	2026-10-08 22:57:16.182024+05:30	2026-10-22	4DX	173	2	7:30 PM	2026-10-08 22:57:16.181+05:30
2	2026-10-08 22:57:16.191373+05:30	2026-10-10	2D	174	3	10:00 AM	2026-10-08 22:57:16.19+05:30
3	2026-10-08 22:57:16.195841+05:30	2026-10-10	3D	175	3	1:30 PM	2026-10-08 22:57:16.194+05:30
4	2026-10-08 22:57:16.198906+05:30	2026-10-10	IMAX	176	3	4:30 PM	2026-10-08 22:57:16.198+05:30
5	2026-10-08 22:57:16.201824+05:30	2026-10-10	4DX	177	3	7:30 PM	2026-10-08 22:57:16.201+05:30
2	2026-10-08 22:57:16.205398+05:30	2026-10-11	2D	178	3	10:00 AM	2026-10-08 22:57:16.204+05:30
3	2026-10-08 22:57:16.209853+05:30	2026-10-11	3D	179	3	1:30 PM	2026-10-08 22:57:16.208+05:30
4	2026-10-08 22:57:16.213436+05:30	2026-10-11	IMAX	180	3	4:30 PM	2026-10-08 22:57:16.212+05:30
5	2026-10-08 22:57:16.216697+05:30	2026-10-11	4DX	181	3	7:30 PM	2026-10-08 22:57:16.215+05:30
2	2026-10-08 22:57:16.219874+05:30	2026-10-12	2D	182	3	10:00 AM	2026-10-08 22:57:16.219+05:30
3	2026-10-08 22:57:16.224091+05:30	2026-10-12	3D	183	3	1:30 PM	2026-10-08 22:57:16.222+05:30
4	2026-10-08 22:57:16.228212+05:30	2026-10-12	IMAX	184	3	4:30 PM	2026-10-08 22:57:16.227+05:30
5	2026-10-08 22:57:16.232313+05:30	2026-10-12	4DX	185	3	7:30 PM	2026-10-08 22:57:16.231+05:30
2	2026-10-08 22:57:16.235497+05:30	2026-10-13	2D	186	3	10:00 AM	2026-10-08 22:57:16.234+05:30
3	2026-10-08 22:57:16.238922+05:30	2026-10-13	3D	187	3	1:30 PM	2026-10-08 22:57:16.237+05:30
4	2026-10-08 22:57:16.244148+05:30	2026-10-13	IMAX	188	3	4:30 PM	2026-10-08 22:57:16.243+05:30
5	2026-10-08 22:57:16.248681+05:30	2026-10-13	4DX	189	3	7:30 PM	2026-10-08 22:57:16.247+05:30
2	2026-10-08 22:57:16.252729+05:30	2026-10-14	2D	190	3	10:00 AM	2026-10-08 22:57:16.251+05:30
3	2026-10-08 22:57:16.256379+05:30	2026-10-14	3D	191	3	1:30 PM	2026-10-08 22:57:16.255+05:30
4	2026-10-08 22:57:16.262014+05:30	2026-10-14	IMAX	192	3	4:30 PM	2026-10-08 22:57:16.26+05:30
5	2026-10-08 22:57:16.267245+05:30	2026-10-14	4DX	193	3	7:30 PM	2026-10-08 22:57:16.266+05:30
2	2026-10-08 22:57:16.272746+05:30	2026-10-15	2D	194	3	10:00 AM	2026-10-08 22:57:16.271+05:30
3	2026-10-08 22:57:16.278609+05:30	2026-10-15	3D	195	3	1:30 PM	2026-10-08 22:57:16.277+05:30
4	2026-10-08 22:57:16.282093+05:30	2026-10-15	IMAX	196	3	4:30 PM	2026-10-08 22:57:16.281+05:30
5	2026-10-08 22:57:16.285207+05:30	2026-10-15	4DX	197	3	7:30 PM	2026-10-08 22:57:16.284+05:30
2	2026-10-08 22:57:16.288878+05:30	2026-10-16	2D	198	3	10:00 AM	2026-10-08 22:57:16.288+05:30
3	2026-10-08 22:57:16.293304+05:30	2026-10-16	3D	199	3	1:30 PM	2026-10-08 22:57:16.292+05:30
4	2026-10-08 22:57:16.298154+05:30	2026-10-16	IMAX	200	3	4:30 PM	2026-10-08 22:57:16.297+05:30
5	2026-10-08 22:57:16.302128+05:30	2026-10-16	4DX	201	3	7:30 PM	2026-10-08 22:57:16.3+05:30
2	2026-10-08 22:57:16.305625+05:30	2026-10-17	2D	202	3	10:00 AM	2026-10-08 22:57:16.304+05:30
3	2026-10-08 22:57:16.310574+05:30	2026-10-17	3D	203	3	1:30 PM	2026-10-08 22:57:16.309+05:30
4	2026-10-08 22:57:16.314187+05:30	2026-10-17	IMAX	204	3	4:30 PM	2026-10-08 22:57:16.313+05:30
5	2026-10-08 22:57:16.317785+05:30	2026-10-17	4DX	205	3	7:30 PM	2026-10-08 22:57:16.316+05:30
2	2026-10-08 22:57:16.321226+05:30	2026-10-18	2D	206	3	10:00 AM	2026-10-08 22:57:16.32+05:30
3	2026-10-08 22:57:16.32587+05:30	2026-10-18	3D	207	3	1:30 PM	2026-10-08 22:57:16.324+05:30
4	2026-10-08 22:57:16.329649+05:30	2026-10-18	IMAX	208	3	4:30 PM	2026-10-08 22:57:16.328+05:30
5	2026-10-08 22:57:16.33302+05:30	2026-10-18	4DX	209	3	7:30 PM	2026-10-08 22:57:16.331+05:30
2	2026-10-08 22:57:16.336234+05:30	2026-10-19	2D	210	3	10:00 AM	2026-10-08 22:57:16.335+05:30
3	2026-10-08 22:57:16.339726+05:30	2026-10-19	3D	211	3	1:30 PM	2026-10-08 22:57:16.338+05:30
4	2026-10-08 22:57:16.344399+05:30	2026-10-19	IMAX	212	3	4:30 PM	2026-10-08 22:57:16.343+05:30
5	2026-10-08 22:57:16.3476+05:30	2026-10-19	4DX	213	3	7:30 PM	2026-10-08 22:57:16.346+05:30
2	2026-10-08 22:57:16.357913+05:30	2026-10-20	2D	214	3	10:00 AM	2026-10-08 22:57:16.356+05:30
3	2026-10-08 22:57:16.36141+05:30	2026-10-20	3D	215	3	1:30 PM	2026-10-08 22:57:16.36+05:30
4	2026-10-08 22:57:16.364727+05:30	2026-10-20	IMAX	216	3	4:30 PM	2026-10-08 22:57:16.363+05:30
5	2026-10-08 22:57:16.367773+05:30	2026-10-20	4DX	217	3	7:30 PM	2026-10-08 22:57:16.367+05:30
2	2026-10-08 22:57:16.371674+05:30	2026-10-21	2D	218	3	10:00 AM	2026-10-08 22:57:16.37+05:30
3	2026-10-08 22:57:16.376013+05:30	2026-10-21	3D	219	3	1:30 PM	2026-10-08 22:57:16.375+05:30
4	2026-10-08 22:57:16.37973+05:30	2026-10-21	IMAX	220	3	4:30 PM	2026-10-08 22:57:16.378+05:30
5	2026-10-08 22:57:16.383484+05:30	2026-10-21	4DX	221	3	7:30 PM	2026-10-08 22:57:16.382+05:30
2	2026-10-08 22:57:16.386795+05:30	2026-10-22	2D	222	3	10:00 AM	2026-10-08 22:57:16.385+05:30
3	2026-10-08 22:57:16.391195+05:30	2026-10-22	3D	223	3	1:30 PM	2026-10-08 22:57:16.389+05:30
4	2026-10-08 22:57:16.394753+05:30	2026-10-22	IMAX	224	3	4:30 PM	2026-10-08 22:57:16.393+05:30
5	2026-10-08 22:57:16.399915+05:30	2026-10-22	4DX	225	3	7:30 PM	2026-10-08 22:57:16.398+05:30
2	2026-10-08 22:57:16.410732+05:30	2026-10-10	2D	226	4	10:00 AM	2026-10-08 22:57:16.409+05:30
3	2026-10-08 22:57:16.41555+05:30	2026-10-10	3D	227	4	1:30 PM	2026-10-08 22:57:16.414+05:30
4	2026-10-08 22:57:16.419863+05:30	2026-10-10	IMAX	228	4	4:30 PM	2026-10-08 22:57:16.418+05:30
5	2026-10-08 22:57:16.424702+05:30	2026-10-10	4DX	229	4	7:30 PM	2026-10-08 22:57:16.423+05:30
2	2026-10-08 22:57:16.429333+05:30	2026-10-11	2D	230	4	10:00 AM	2026-10-08 22:57:16.428+05:30
3	2026-10-08 22:57:16.433077+05:30	2026-10-11	3D	231	4	1:30 PM	2026-10-08 22:57:16.432+05:30
4	2026-10-08 22:57:16.437213+05:30	2026-10-11	IMAX	232	4	4:30 PM	2026-10-08 22:57:16.436+05:30
5	2026-10-08 22:57:16.442172+05:30	2026-10-11	4DX	233	4	7:30 PM	2026-10-08 22:57:16.44+05:30
2	2026-10-08 22:57:16.446742+05:30	2026-10-12	2D	234	4	10:00 AM	2026-10-08 22:57:16.445+05:30
3	2026-10-08 22:57:16.45069+05:30	2026-10-12	3D	235	4	1:30 PM	2026-10-08 22:57:16.449+05:30
4	2026-10-08 22:57:16.454662+05:30	2026-10-12	IMAX	236	4	4:30 PM	2026-10-08 22:57:16.453+05:30
5	2026-10-08 22:57:16.459817+05:30	2026-10-12	4DX	237	4	7:30 PM	2026-10-08 22:57:16.458+05:30
2	2026-10-08 22:57:16.463594+05:30	2026-10-13	2D	238	4	10:00 AM	2026-10-08 22:57:16.462+05:30
3	2026-10-08 22:57:16.467885+05:30	2026-10-13	3D	239	4	1:30 PM	2026-10-08 22:57:16.466+05:30
4	2026-10-08 22:57:16.472274+05:30	2026-10-13	IMAX	240	4	4:30 PM	2026-10-08 22:57:16.471+05:30
5	2026-10-08 22:57:16.476817+05:30	2026-10-13	4DX	241	4	7:30 PM	2026-10-08 22:57:16.475+05:30
2	2026-10-08 22:57:16.480893+05:30	2026-10-14	2D	242	4	10:00 AM	2026-10-08 22:57:16.479+05:30
3	2026-10-08 22:57:16.48683+05:30	2026-10-14	3D	243	4	1:30 PM	2026-10-08 22:57:16.485+05:30
4	2026-10-08 22:57:16.490882+05:30	2026-10-14	IMAX	244	4	4:30 PM	2026-10-08 22:57:16.489+05:30
5	2026-10-08 22:57:16.494821+05:30	2026-10-14	4DX	245	4	7:30 PM	2026-10-08 22:57:16.493+05:30
2	2026-10-08 22:57:16.498273+05:30	2026-10-15	2D	246	4	10:00 AM	2026-10-08 22:57:16.497+05:30
3	2026-10-08 22:57:16.502118+05:30	2026-10-15	3D	247	4	1:30 PM	2026-10-08 22:57:16.501+05:30
4	2026-10-08 22:57:16.505769+05:30	2026-10-15	IMAX	248	4	4:30 PM	2026-10-08 22:57:16.504+05:30
5	2026-10-08 22:57:16.509261+05:30	2026-10-15	4DX	249	4	7:30 PM	2026-10-08 22:57:16.508+05:30
2	2026-10-08 22:57:16.51286+05:30	2026-10-16	2D	250	4	10:00 AM	2026-10-08 22:57:16.511+05:30
3	2026-10-08 22:57:16.516102+05:30	2026-10-16	3D	251	4	1:30 PM	2026-10-08 22:57:16.515+05:30
4	2026-10-08 22:57:16.519198+05:30	2026-10-16	IMAX	252	4	4:30 PM	2026-10-08 22:57:16.518+05:30
5	2026-10-08 22:57:16.522299+05:30	2026-10-16	4DX	253	4	7:30 PM	2026-10-08 22:57:16.521+05:30
2	2026-10-08 22:57:16.526212+05:30	2026-10-17	2D	254	4	10:00 AM	2026-10-08 22:57:16.524+05:30
3	2026-10-08 22:57:16.530684+05:30	2026-10-17	3D	255	4	1:30 PM	2026-10-08 22:57:16.529+05:30
4	2026-10-08 22:57:16.534337+05:30	2026-10-17	IMAX	256	4	4:30 PM	2026-10-08 22:57:16.533+05:30
5	2026-10-08 22:57:16.53795+05:30	2026-10-17	4DX	257	4	7:30 PM	2026-10-08 22:57:16.537+05:30
2	2026-10-08 22:57:16.541955+05:30	2026-10-18	2D	258	4	10:00 AM	2026-10-08 22:57:16.54+05:30
3	2026-10-08 22:57:16.546962+05:30	2026-10-18	3D	259	4	1:30 PM	2026-10-08 22:57:16.545+05:30
4	2026-10-08 22:57:16.551672+05:30	2026-10-18	IMAX	260	4	4:30 PM	2026-10-08 22:57:16.549+05:30
5	2026-10-08 22:57:16.556761+05:30	2026-10-18	4DX	261	4	7:30 PM	2026-10-08 22:57:16.555+05:30
2	2026-10-08 22:57:16.561922+05:30	2026-10-19	2D	262	4	10:00 AM	2026-10-08 22:57:16.56+05:30
3	2026-10-08 22:57:16.566188+05:30	2026-10-19	3D	263	4	1:30 PM	2026-10-08 22:57:16.565+05:30
4	2026-10-08 22:57:16.569553+05:30	2026-10-19	IMAX	264	4	4:30 PM	2026-10-08 22:57:16.568+05:30
5	2026-10-08 22:57:16.574009+05:30	2026-10-19	4DX	265	4	7:30 PM	2026-10-08 22:57:16.572+05:30
2	2026-10-08 22:57:16.578972+05:30	2026-10-20	2D	266	4	10:00 AM	2026-10-08 22:57:16.577+05:30
3	2026-10-08 22:57:16.584195+05:30	2026-10-20	3D	267	4	1:30 PM	2026-10-08 22:57:16.582+05:30
4	2026-10-08 22:57:16.589406+05:30	2026-10-20	IMAX	268	4	4:30 PM	2026-10-08 22:57:16.587+05:30
5	2026-10-08 22:57:16.594709+05:30	2026-10-20	4DX	269	4	7:30 PM	2026-10-08 22:57:16.593+05:30
2	2026-10-08 22:57:16.600013+05:30	2026-10-21	2D	270	4	10:00 AM	2026-10-08 22:57:16.598+05:30
3	2026-10-08 22:57:16.605282+05:30	2026-10-21	3D	271	4	1:30 PM	2026-10-08 22:57:16.603+05:30
4	2026-10-08 22:57:16.609771+05:30	2026-10-21	IMAX	272	4	4:30 PM	2026-10-08 22:57:16.608+05:30
5	2026-10-08 22:57:16.616491+05:30	2026-10-21	4DX	273	4	7:30 PM	2026-10-08 22:57:16.614+05:30
2	2026-10-08 22:57:16.621847+05:30	2026-10-22	2D	274	4	10:00 AM	2026-10-08 22:57:16.62+05:30
3	2026-10-08 22:57:16.627452+05:30	2026-10-22	3D	275	4	1:30 PM	2026-10-08 22:57:16.625+05:30
4	2026-10-08 22:57:16.633+05:30	2026-10-22	IMAX	276	4	4:30 PM	2026-10-08 22:57:16.631+05:30
5	2026-10-08 22:57:16.637949+05:30	2026-10-22	4DX	277	4	7:30 PM	2026-10-08 22:57:16.636+05:30
2	2026-10-08 22:57:16.654899+05:30	2026-10-10	2D	278	5	10:00 AM	2026-10-08 22:57:16.653+05:30
3	2026-10-08 22:57:16.660804+05:30	2026-10-10	3D	279	5	1:30 PM	2026-10-08 22:57:16.659+05:30
4	2026-10-08 22:57:16.666011+05:30	2026-10-10	IMAX	280	5	4:30 PM	2026-10-08 22:57:16.664+05:30
5	2026-10-08 22:57:16.67143+05:30	2026-10-10	4DX	281	5	7:30 PM	2026-10-08 22:57:16.669+05:30
2	2026-10-08 22:57:16.677064+05:30	2026-10-11	2D	282	5	10:00 AM	2026-10-08 22:57:16.675+05:30
3	2026-10-08 22:57:16.68195+05:30	2026-10-11	3D	283	5	1:30 PM	2026-10-08 22:57:16.68+05:30
4	2026-10-08 22:57:16.687651+05:30	2026-10-11	IMAX	284	5	4:30 PM	2026-10-08 22:57:16.686+05:30
5	2026-10-08 22:57:16.693807+05:30	2026-10-11	4DX	285	5	7:30 PM	2026-10-08 22:57:16.692+05:30
2	2026-10-08 22:57:16.699223+05:30	2026-10-12	2D	286	5	10:00 AM	2026-10-08 22:57:16.697+05:30
3	2026-10-08 22:57:16.704401+05:30	2026-10-12	3D	287	5	1:30 PM	2026-10-08 22:57:16.703+05:30
4	2026-10-08 22:57:16.709533+05:30	2026-10-12	IMAX	288	5	4:30 PM	2026-10-08 22:57:16.708+05:30
5	2026-10-08 22:57:16.714443+05:30	2026-10-12	4DX	289	5	7:30 PM	2026-10-08 22:57:16.712+05:30
2	2026-10-08 22:57:16.719703+05:30	2026-10-13	2D	290	5	10:00 AM	2026-10-08 22:57:16.718+05:30
3	2026-10-08 22:57:16.725207+05:30	2026-10-13	3D	291	5	1:30 PM	2026-10-08 22:57:16.723+05:30
4	2026-10-08 22:57:16.730397+05:30	2026-10-13	IMAX	292	5	4:30 PM	2026-10-08 22:57:16.729+05:30
5	2026-10-08 22:57:16.735376+05:30	2026-10-13	4DX	293	5	7:30 PM	2026-10-08 22:57:16.734+05:30
2	2026-10-08 22:57:16.740787+05:30	2026-10-14	2D	294	5	10:00 AM	2026-10-08 22:57:16.739+05:30
3	2026-10-08 22:57:16.746217+05:30	2026-10-14	3D	295	5	1:30 PM	2026-10-08 22:57:16.744+05:30
4	2026-10-08 22:57:16.751502+05:30	2026-10-14	IMAX	296	5	4:30 PM	2026-10-08 22:57:16.75+05:30
5	2026-10-08 22:57:16.756785+05:30	2026-10-14	4DX	297	5	7:30 PM	2026-10-08 22:57:16.755+05:30
2	2026-10-08 22:57:16.762254+05:30	2026-10-15	2D	298	5	10:00 AM	2026-10-08 22:57:16.76+05:30
3	2026-10-08 22:57:16.767536+05:30	2026-10-15	3D	299	5	1:30 PM	2026-10-08 22:57:16.766+05:30
4	2026-10-08 22:57:16.77255+05:30	2026-10-15	IMAX	300	5	4:30 PM	2026-10-08 22:57:16.771+05:30
5	2026-10-08 22:57:16.777869+05:30	2026-10-15	4DX	301	5	7:30 PM	2026-10-08 22:57:16.776+05:30
2	2026-10-08 22:57:16.7831+05:30	2026-10-16	2D	302	5	10:00 AM	2026-10-08 22:57:16.781+05:30
3	2026-10-08 22:57:16.788175+05:30	2026-10-16	3D	303	5	1:30 PM	2026-10-08 22:57:16.786+05:30
4	2026-10-08 22:57:16.793392+05:30	2026-10-16	IMAX	304	5	4:30 PM	2026-10-08 22:57:16.792+05:30
5	2026-10-08 22:57:16.798771+05:30	2026-10-16	4DX	305	5	7:30 PM	2026-10-08 22:57:16.797+05:30
2	2026-10-08 22:57:16.804103+05:30	2026-10-17	2D	306	5	10:00 AM	2026-10-08 22:57:16.802+05:30
3	2026-10-08 22:57:16.809325+05:30	2026-10-17	3D	307	5	1:30 PM	2026-10-08 22:57:16.808+05:30
4	2026-10-08 22:57:16.815129+05:30	2026-10-17	IMAX	308	5	4:30 PM	2026-10-08 22:57:16.813+05:30
5	2026-10-08 22:57:16.820624+05:30	2026-10-17	4DX	309	5	7:30 PM	2026-10-08 22:57:16.819+05:30
2	2026-10-08 22:57:16.825603+05:30	2026-10-18	2D	310	5	10:00 AM	2026-10-08 22:57:16.824+05:30
3	2026-10-08 22:57:16.830696+05:30	2026-10-18	3D	311	5	1:30 PM	2026-10-08 22:57:16.829+05:30
4	2026-10-08 22:57:16.835532+05:30	2026-10-18	IMAX	312	5	4:30 PM	2026-10-08 22:57:16.834+05:30
5	2026-10-08 22:57:16.840806+05:30	2026-10-18	4DX	313	5	7:30 PM	2026-10-08 22:57:16.839+05:30
2	2026-10-08 22:57:16.847097+05:30	2026-10-19	2D	314	5	10:00 AM	2026-10-08 22:57:16.845+05:30
3	2026-10-08 22:57:16.853206+05:30	2026-10-19	3D	315	5	1:30 PM	2026-10-08 22:57:16.851+05:30
4	2026-10-08 22:57:16.860232+05:30	2026-10-19	IMAX	316	5	4:30 PM	2026-10-08 22:57:16.857+05:30
5	2026-10-08 22:57:16.871668+05:30	2026-10-19	4DX	317	5	7:30 PM	2026-10-08 22:57:16.869+05:30
2	2026-10-08 22:57:16.882352+05:30	2026-10-20	2D	318	5	10:00 AM	2026-10-08 22:57:16.88+05:30
3	2026-10-08 22:57:16.889533+05:30	2026-10-20	3D	319	5	1:30 PM	2026-10-08 22:57:16.887+05:30
4	2026-10-08 22:57:16.893685+05:30	2026-10-20	IMAX	320	5	4:30 PM	2026-10-08 22:57:16.892+05:30
5	2026-10-08 22:57:16.89768+05:30	2026-10-20	4DX	321	5	7:30 PM	2026-10-08 22:57:16.896+05:30
2	2026-10-08 22:57:16.901755+05:30	2026-10-21	2D	322	5	10:00 AM	2026-10-08 22:57:16.9+05:30
3	2026-10-08 22:57:16.905478+05:30	2026-10-21	3D	323	5	1:30 PM	2026-10-08 22:57:16.904+05:30
4	2026-10-08 22:57:16.909664+05:30	2026-10-21	IMAX	324	5	4:30 PM	2026-10-08 22:57:16.908+05:30
5	2026-10-08 22:57:16.914557+05:30	2026-10-21	4DX	325	5	7:30 PM	2026-10-08 22:57:16.913+05:30
2	2026-10-08 22:57:16.918957+05:30	2026-10-22	2D	326	5	10:00 AM	2026-10-08 22:57:16.917+05:30
3	2026-10-08 22:57:16.923839+05:30	2026-10-22	3D	327	5	1:30 PM	2026-10-08 22:57:16.922+05:30
4	2026-10-08 22:57:16.929006+05:30	2026-10-22	IMAX	328	5	4:30 PM	2026-10-08 22:57:16.927+05:30
5	2026-10-08 22:57:16.933533+05:30	2026-10-22	4DX	329	5	7:30 PM	2026-10-08 22:57:16.932+05:30
2	2026-10-08 22:57:16.945694+05:30	2026-10-10	2D	330	6	10:00 AM	2026-10-08 22:57:16.944+05:30
3	2026-10-08 22:57:16.949648+05:30	2026-10-10	3D	331	6	1:30 PM	2026-10-08 22:57:16.948+05:30
4	2026-10-08 22:57:16.953084+05:30	2026-10-10	IMAX	332	6	4:30 PM	2026-10-08 22:57:16.952+05:30
5	2026-10-08 22:57:16.957413+05:30	2026-10-10	4DX	333	6	7:30 PM	2026-10-08 22:57:16.956+05:30
2	2026-10-08 22:57:16.961922+05:30	2026-10-11	2D	334	6	10:00 AM	2026-10-08 22:57:16.96+05:30
3	2026-10-08 22:57:16.968025+05:30	2026-10-11	3D	335	6	1:30 PM	2026-10-08 22:57:16.966+05:30
4	2026-10-08 22:57:16.97114+05:30	2026-10-11	IMAX	336	6	4:30 PM	2026-10-08 22:57:16.97+05:30
5	2026-10-08 22:57:16.974309+05:30	2026-10-11	4DX	337	6	7:30 PM	2026-10-08 22:57:16.973+05:30
2	2026-10-08 22:57:16.978136+05:30	2026-10-12	2D	338	6	10:00 AM	2026-10-08 22:57:16.977+05:30
3	2026-10-08 22:57:16.984195+05:30	2026-10-12	3D	339	6	1:30 PM	2026-10-08 22:57:16.983+05:30
4	2026-10-08 22:57:16.987355+05:30	2026-10-12	IMAX	340	6	4:30 PM	2026-10-08 22:57:16.986+05:30
5	2026-10-08 22:57:16.990832+05:30	2026-10-12	4DX	341	6	7:30 PM	2026-10-08 22:57:16.99+05:30
2	2026-10-08 22:57:16.99493+05:30	2026-10-13	2D	342	6	10:00 AM	2026-10-08 22:57:16.993+05:30
3	2026-10-08 22:57:17.000483+05:30	2026-10-13	3D	343	6	1:30 PM	2026-10-08 22:57:16.999+05:30
4	2026-10-08 22:57:17.003667+05:30	2026-10-13	IMAX	344	6	4:30 PM	2026-10-08 22:57:17.002+05:30
5	2026-10-08 22:57:17.007091+05:30	2026-10-13	4DX	345	6	7:30 PM	2026-10-08 22:57:17.006+05:30
2	2026-10-08 22:57:17.011362+05:30	2026-10-14	2D	346	6	10:00 AM	2026-10-08 22:57:17.01+05:30
3	2026-10-08 22:57:17.01689+05:30	2026-10-14	3D	347	6	1:30 PM	2026-10-08 22:57:17.015+05:30
4	2026-10-08 22:57:17.020329+05:30	2026-10-14	IMAX	348	6	4:30 PM	2026-10-08 22:57:17.019+05:30
5	2026-10-08 22:57:17.023557+05:30	2026-10-14	4DX	349	6	7:30 PM	2026-10-08 22:57:17.022+05:30
2	2026-10-08 22:57:17.027225+05:30	2026-10-15	2D	350	6	10:00 AM	2026-10-08 22:57:17.026+05:30
3	2026-10-08 22:57:17.032853+05:30	2026-10-15	3D	351	6	1:30 PM	2026-10-08 22:57:17.031+05:30
4	2026-10-08 22:57:17.037111+05:30	2026-10-15	IMAX	352	6	4:30 PM	2026-10-08 22:57:17.036+05:30
5	2026-10-08 22:57:17.040989+05:30	2026-10-15	4DX	353	6	7:30 PM	2026-10-08 22:57:17.039+05:30
2	2026-10-08 22:57:17.044547+05:30	2026-10-16	2D	354	6	10:00 AM	2026-10-08 22:57:17.043+05:30
3	2026-10-08 22:57:17.050211+05:30	2026-10-16	3D	355	6	1:30 PM	2026-10-08 22:57:17.048+05:30
4	2026-10-08 22:57:17.053274+05:30	2026-10-16	IMAX	356	6	4:30 PM	2026-10-08 22:57:17.052+05:30
5	2026-10-08 22:57:17.056945+05:30	2026-10-16	4DX	357	6	7:30 PM	2026-10-08 22:57:17.055+05:30
2	2026-10-08 22:57:17.060924+05:30	2026-10-17	2D	358	6	10:00 AM	2026-10-08 22:57:17.06+05:30
3	2026-10-08 22:57:17.066472+05:30	2026-10-17	3D	359	6	1:30 PM	2026-10-08 22:57:17.064+05:30
4	2026-10-08 22:57:17.070293+05:30	2026-10-17	IMAX	360	6	4:30 PM	2026-10-08 22:57:17.069+05:30
5	2026-10-08 22:57:17.073574+05:30	2026-10-17	4DX	361	6	7:30 PM	2026-10-08 22:57:17.072+05:30
2	2026-10-08 22:57:17.08328+05:30	2026-10-18	2D	362	6	10:00 AM	2026-10-08 22:57:17.082+05:30
3	2026-10-08 22:57:17.087073+05:30	2026-10-18	3D	363	6	1:30 PM	2026-10-08 22:57:17.086+05:30
4	2026-10-08 22:57:17.090044+05:30	2026-10-18	IMAX	364	6	4:30 PM	2026-10-08 22:57:17.089+05:30
5	2026-10-08 22:57:17.09419+05:30	2026-10-18	4DX	365	6	7:30 PM	2026-10-08 22:57:17.093+05:30
2	2026-10-08 22:57:17.099564+05:30	2026-10-19	2D	366	6	10:00 AM	2026-10-08 22:57:17.098+05:30
3	2026-10-08 22:57:17.10253+05:30	2026-10-19	3D	367	6	1:30 PM	2026-10-08 22:57:17.101+05:30
4	2026-10-08 22:57:17.105696+05:30	2026-10-19	IMAX	368	6	4:30 PM	2026-10-08 22:57:17.104+05:30
5	2026-10-08 22:57:17.109234+05:30	2026-10-19	4DX	369	6	7:30 PM	2026-10-08 22:57:17.108+05:30
2	2026-10-08 22:57:17.114467+05:30	2026-10-20	2D	370	6	10:00 AM	2026-10-08 22:57:17.113+05:30
3	2026-10-08 22:57:17.119281+05:30	2026-10-20	3D	371	6	1:30 PM	2026-10-08 22:57:17.118+05:30
4	2026-10-08 22:57:17.123549+05:30	2026-10-20	IMAX	372	6	4:30 PM	2026-10-08 22:57:17.122+05:30
5	2026-10-08 22:57:17.128542+05:30	2026-10-20	4DX	373	6	7:30 PM	2026-10-08 22:57:17.127+05:30
2	2026-10-08 22:57:17.134531+05:30	2026-10-21	2D	374	6	10:00 AM	2026-10-08 22:57:17.133+05:30
3	2026-10-08 22:57:17.139622+05:30	2026-10-21	3D	375	6	1:30 PM	2026-10-08 22:57:17.138+05:30
4	2026-10-08 22:57:17.143734+05:30	2026-10-21	IMAX	376	6	4:30 PM	2026-10-08 22:57:17.142+05:30
5	2026-10-08 22:57:17.147661+05:30	2026-10-21	4DX	377	6	7:30 PM	2026-10-08 22:57:17.146+05:30
2	2026-10-08 22:57:17.152293+05:30	2026-10-22	2D	378	6	10:00 AM	2026-10-08 22:57:17.151+05:30
3	2026-10-08 22:57:17.159593+05:30	2026-10-22	3D	379	6	1:30 PM	2026-10-08 22:57:17.158+05:30
4	2026-10-08 22:57:17.16487+05:30	2026-10-22	IMAX	380	6	4:30 PM	2026-10-08 22:57:17.163+05:30
5	2026-10-08 22:57:17.169858+05:30	2026-10-22	4DX	381	6	7:30 PM	2026-10-08 22:57:17.168+05:30
2	2026-10-08 22:57:17.184927+05:30	2026-10-10	2D	382	7	10:00 AM	2026-10-08 22:57:17.183+05:30
3	2026-10-08 22:57:17.188745+05:30	2026-10-10	3D	383	7	1:30 PM	2026-10-08 22:57:17.187+05:30
4	2026-10-08 22:57:17.193864+05:30	2026-10-10	IMAX	384	7	4:30 PM	2026-10-08 22:57:17.192+05:30
5	2026-10-08 22:57:17.198041+05:30	2026-10-10	4DX	385	7	7:30 PM	2026-10-08 22:57:17.197+05:30
2	2026-10-08 22:57:17.202377+05:30	2026-10-11	2D	386	7	10:00 AM	2026-10-08 22:57:17.201+05:30
3	2026-10-08 22:57:17.2063+05:30	2026-10-11	3D	387	7	1:30 PM	2026-10-08 22:57:17.205+05:30
4	2026-10-08 22:57:17.210297+05:30	2026-10-11	IMAX	388	7	4:30 PM	2026-10-08 22:57:17.209+05:30
5	2026-10-08 22:57:17.214217+05:30	2026-10-11	4DX	389	7	7:30 PM	2026-10-08 22:57:17.213+05:30
2	2026-10-08 22:57:17.218099+05:30	2026-10-12	2D	390	7	10:00 AM	2026-10-08 22:57:17.217+05:30
3	2026-10-08 22:57:17.221859+05:30	2026-10-12	3D	391	7	1:30 PM	2026-10-08 22:57:17.22+05:30
4	2026-10-08 22:57:17.225744+05:30	2026-10-12	IMAX	392	7	4:30 PM	2026-10-08 22:57:17.224+05:30
5	2026-10-08 22:57:17.229521+05:30	2026-10-12	4DX	393	7	7:30 PM	2026-10-08 22:57:17.228+05:30
2	2026-10-08 22:57:17.233172+05:30	2026-10-13	2D	394	7	10:00 AM	2026-10-08 22:57:17.232+05:30
3	2026-10-08 22:57:17.236825+05:30	2026-10-13	3D	395	7	1:30 PM	2026-10-08 22:57:17.235+05:30
4	2026-10-08 22:57:17.241004+05:30	2026-10-13	IMAX	396	7	4:30 PM	2026-10-08 22:57:17.24+05:30
5	2026-10-08 22:57:17.245442+05:30	2026-10-13	4DX	397	7	7:30 PM	2026-10-08 22:57:17.244+05:30
2	2026-10-08 22:57:17.249434+05:30	2026-10-14	2D	398	7	10:00 AM	2026-10-08 22:57:17.248+05:30
3	2026-10-08 22:57:17.253264+05:30	2026-10-14	3D	399	7	1:30 PM	2026-10-08 22:57:17.252+05:30
4	2026-10-08 22:57:17.257564+05:30	2026-10-14	IMAX	400	7	4:30 PM	2026-10-08 22:57:17.256+05:30
5	2026-10-08 22:57:17.261492+05:30	2026-10-14	4DX	401	7	7:30 PM	2026-10-08 22:57:17.26+05:30
2	2026-10-08 22:57:17.264671+05:30	2026-10-15	2D	402	7	10:00 AM	2026-10-08 22:57:17.263+05:30
3	2026-10-08 22:57:17.267538+05:30	2026-10-15	3D	403	7	1:30 PM	2026-10-08 22:57:17.266+05:30
4	2026-10-08 22:57:17.270215+05:30	2026-10-15	IMAX	404	7	4:30 PM	2026-10-08 22:57:17.269+05:30
5	2026-10-08 22:57:17.272984+05:30	2026-10-15	4DX	405	7	7:30 PM	2026-10-08 22:57:17.272+05:30
2	2026-10-08 22:57:17.275722+05:30	2026-10-16	2D	406	7	10:00 AM	2026-10-08 22:57:17.275+05:30
3	2026-10-08 22:57:17.278312+05:30	2026-10-16	3D	407	7	1:30 PM	2026-10-08 22:57:17.277+05:30
4	2026-10-08 22:57:17.280736+05:30	2026-10-16	IMAX	408	7	4:30 PM	2026-10-08 22:57:17.279+05:30
5	2026-10-08 22:57:17.284079+05:30	2026-10-16	4DX	409	7	7:30 PM	2026-10-08 22:57:17.283+05:30
2	2026-10-08 22:57:17.286794+05:30	2026-10-17	2D	410	7	10:00 AM	2026-10-08 22:57:17.286+05:30
3	2026-10-08 22:57:17.289234+05:30	2026-10-17	3D	411	7	1:30 PM	2026-10-08 22:57:17.288+05:30
4	2026-10-08 22:57:17.291396+05:30	2026-10-17	IMAX	412	7	4:30 PM	2026-10-08 22:57:17.29+05:30
5	2026-10-08 22:57:17.29388+05:30	2026-10-17	4DX	413	7	7:30 PM	2026-10-08 22:57:17.292+05:30
2	2026-10-08 22:57:17.296379+05:30	2026-10-18	2D	414	7	10:00 AM	2026-10-08 22:57:17.295+05:30
3	2026-10-08 22:57:17.29875+05:30	2026-10-18	3D	415	7	1:30 PM	2026-10-08 22:57:17.297+05:30
4	2026-10-08 22:57:17.301052+05:30	2026-10-18	IMAX	416	7	4:30 PM	2026-10-08 22:57:17.3+05:30
5	2026-10-08 22:57:17.303736+05:30	2026-10-18	4DX	417	7	7:30 PM	2026-10-08 22:57:17.302+05:30
2	2026-10-08 22:57:17.30628+05:30	2026-10-19	2D	418	7	10:00 AM	2026-10-08 22:57:17.305+05:30
3	2026-10-08 22:57:17.309299+05:30	2026-10-19	3D	419	7	1:30 PM	2026-10-08 22:57:17.308+05:30
4	2026-10-08 22:57:17.312953+05:30	2026-10-19	IMAX	420	7	4:30 PM	2026-10-08 22:57:17.311+05:30
5	2026-10-08 22:57:17.315563+05:30	2026-10-19	4DX	421	7	7:30 PM	2026-10-08 22:57:17.314+05:30
2	2026-10-08 22:57:17.317999+05:30	2026-10-20	2D	422	7	10:00 AM	2026-10-08 22:57:17.317+05:30
3	2026-10-08 22:57:17.320657+05:30	2026-10-20	3D	423	7	1:30 PM	2026-10-08 22:57:17.319+05:30
4	2026-10-08 22:57:17.323101+05:30	2026-10-20	IMAX	424	7	4:30 PM	2026-10-08 22:57:17.322+05:30
5	2026-10-08 22:57:17.325827+05:30	2026-10-20	4DX	425	7	7:30 PM	2026-10-08 22:57:17.324+05:30
2	2026-10-08 22:57:17.328444+05:30	2026-10-21	2D	426	7	10:00 AM	2026-10-08 22:57:17.327+05:30
3	2026-10-08 22:57:17.331049+05:30	2026-10-21	3D	427	7	1:30 PM	2026-10-08 22:57:17.33+05:30
4	2026-10-08 22:57:17.333796+05:30	2026-10-21	IMAX	428	7	4:30 PM	2026-10-08 22:57:17.332+05:30
5	2026-10-08 22:57:17.336466+05:30	2026-10-21	4DX	429	7	7:30 PM	2026-10-08 22:57:17.335+05:30
2	2026-10-08 22:57:17.339075+05:30	2026-10-22	2D	430	7	10:00 AM	2026-10-08 22:57:17.338+05:30
3	2026-10-08 22:57:17.341422+05:30	2026-10-22	3D	431	7	1:30 PM	2026-10-08 22:57:17.34+05:30
4	2026-10-08 22:57:17.344547+05:30	2026-10-22	IMAX	432	7	4:30 PM	2026-10-08 22:57:17.343+05:30
5	2026-10-08 22:57:17.347835+05:30	2026-10-22	4DX	433	7	7:30 PM	2026-10-08 22:57:17.346+05:30
2	2026-10-08 22:57:17.356037+05:30	2026-10-10	2D	434	8	10:00 AM	2026-10-08 22:57:17.355+05:30
3	2026-10-08 22:57:17.359258+05:30	2026-10-10	3D	435	8	1:30 PM	2026-10-08 22:57:17.358+05:30
4	2026-10-08 22:57:17.362399+05:30	2026-10-10	IMAX	436	8	4:30 PM	2026-10-08 22:57:17.361+05:30
5	2026-10-08 22:57:17.366453+05:30	2026-10-10	4DX	437	8	7:30 PM	2026-10-08 22:57:17.365+05:30
2	2026-10-08 22:57:17.370576+05:30	2026-10-11	2D	438	8	10:00 AM	2026-10-08 22:57:17.369+05:30
3	2026-10-08 22:57:17.374648+05:30	2026-10-11	3D	439	8	1:30 PM	2026-10-08 22:57:17.373+05:30
4	2026-10-08 22:57:17.378338+05:30	2026-10-11	IMAX	440	8	4:30 PM	2026-10-08 22:57:17.377+05:30
5	2026-10-08 22:57:17.382526+05:30	2026-10-11	4DX	441	8	7:30 PM	2026-10-08 22:57:17.381+05:30
2	2026-10-08 22:57:17.386791+05:30	2026-10-12	2D	442	8	10:00 AM	2026-10-08 22:57:17.385+05:30
3	2026-10-08 22:57:17.390988+05:30	2026-10-12	3D	443	8	1:30 PM	2026-10-08 22:57:17.389+05:30
4	2026-10-08 22:57:17.395061+05:30	2026-10-12	IMAX	444	8	4:30 PM	2026-10-08 22:57:17.394+05:30
5	2026-10-08 22:57:17.399886+05:30	2026-10-12	4DX	445	8	7:30 PM	2026-10-08 22:57:17.398+05:30
2	2026-10-08 22:57:17.403918+05:30	2026-10-13	2D	446	8	10:00 AM	2026-10-08 22:57:17.402+05:30
3	2026-10-08 22:57:17.408489+05:30	2026-10-13	3D	447	8	1:30 PM	2026-10-08 22:57:17.407+05:30
4	2026-10-08 22:57:17.412953+05:30	2026-10-13	IMAX	448	8	4:30 PM	2026-10-08 22:57:17.411+05:30
5	2026-10-08 22:57:17.418055+05:30	2026-10-13	4DX	449	8	7:30 PM	2026-10-08 22:57:17.416+05:30
2	2026-10-08 22:57:17.423204+05:30	2026-10-14	2D	450	8	10:00 AM	2026-10-08 22:57:17.422+05:30
3	2026-10-08 22:57:17.42772+05:30	2026-10-14	3D	451	8	1:30 PM	2026-10-08 22:57:17.426+05:30
4	2026-10-08 22:57:17.432378+05:30	2026-10-14	IMAX	452	8	4:30 PM	2026-10-08 22:57:17.431+05:30
5	2026-10-08 22:57:17.436976+05:30	2026-10-14	4DX	453	8	7:30 PM	2026-10-08 22:57:17.435+05:30
2	2026-10-08 22:57:17.441771+05:30	2026-10-15	2D	454	8	10:00 AM	2026-10-08 22:57:17.44+05:30
3	2026-10-08 22:57:17.446432+05:30	2026-10-15	3D	455	8	1:30 PM	2026-10-08 22:57:17.445+05:30
4	2026-10-08 22:57:17.450994+05:30	2026-10-15	IMAX	456	8	4:30 PM	2026-10-08 22:57:17.449+05:30
5	2026-10-08 22:57:17.455016+05:30	2026-10-15	4DX	457	8	7:30 PM	2026-10-08 22:57:17.454+05:30
2	2026-10-08 22:57:17.460206+05:30	2026-10-16	2D	458	8	10:00 AM	2026-10-08 22:57:17.458+05:30
3	2026-10-08 22:57:17.465419+05:30	2026-10-16	3D	459	8	1:30 PM	2026-10-08 22:57:17.463+05:30
4	2026-10-08 22:57:17.470982+05:30	2026-10-16	IMAX	460	8	4:30 PM	2026-10-08 22:57:17.469+05:30
5	2026-10-08 22:57:17.475801+05:30	2026-10-16	4DX	461	8	7:30 PM	2026-10-08 22:57:17.474+05:30
2	2026-10-08 22:57:17.479652+05:30	2026-10-17	2D	462	8	10:00 AM	2026-10-08 22:57:17.478+05:30
3	2026-10-08 22:57:17.4834+05:30	2026-10-17	3D	463	8	1:30 PM	2026-10-08 22:57:17.482+05:30
4	2026-10-08 22:57:17.487097+05:30	2026-10-17	IMAX	464	8	4:30 PM	2026-10-08 22:57:17.486+05:30
5	2026-10-08 22:57:17.490973+05:30	2026-10-17	4DX	465	8	7:30 PM	2026-10-08 22:57:17.489+05:30
2	2026-10-08 22:57:17.494816+05:30	2026-10-18	2D	466	8	10:00 AM	2026-10-08 22:57:17.494+05:30
3	2026-10-08 22:57:17.498076+05:30	2026-10-18	3D	467	8	1:30 PM	2026-10-08 22:57:17.497+05:30
4	2026-10-08 22:57:17.500882+05:30	2026-10-18	IMAX	468	8	4:30 PM	2026-10-08 22:57:17.499+05:30
5	2026-10-08 22:57:17.503441+05:30	2026-10-18	4DX	469	8	7:30 PM	2026-10-08 22:57:17.502+05:30
2	2026-10-08 22:57:17.506317+05:30	2026-10-19	2D	470	8	10:00 AM	2026-10-08 22:57:17.505+05:30
3	2026-10-08 22:57:17.509092+05:30	2026-10-19	3D	471	8	1:30 PM	2026-10-08 22:57:17.508+05:30
4	2026-10-08 22:57:17.511933+05:30	2026-10-19	IMAX	472	8	4:30 PM	2026-10-08 22:57:17.51+05:30
5	2026-10-08 22:57:17.516525+05:30	2026-10-19	4DX	473	8	7:30 PM	2026-10-08 22:57:17.515+05:30
2	2026-10-08 22:57:17.520175+05:30	2026-10-20	2D	474	8	10:00 AM	2026-10-08 22:57:17.519+05:30
3	2026-10-08 22:57:17.523435+05:30	2026-10-20	3D	475	8	1:30 PM	2026-10-08 22:57:17.522+05:30
4	2026-10-08 22:57:17.526925+05:30	2026-10-20	IMAX	476	8	4:30 PM	2026-10-08 22:57:17.526+05:30
5	2026-10-08 22:57:17.529615+05:30	2026-10-20	4DX	477	8	7:30 PM	2026-10-08 22:57:17.529+05:30
2	2026-10-08 22:57:17.532256+05:30	2026-10-21	2D	478	8	10:00 AM	2026-10-08 22:57:17.531+05:30
3	2026-10-08 22:57:17.535085+05:30	2026-10-21	3D	479	8	1:30 PM	2026-10-08 22:57:17.534+05:30
4	2026-10-08 22:57:17.538804+05:30	2026-10-21	IMAX	480	8	4:30 PM	2026-10-08 22:57:17.537+05:30
5	2026-10-08 22:57:17.542745+05:30	2026-10-21	4DX	481	8	7:30 PM	2026-10-08 22:57:17.541+05:30
2	2026-10-08 22:57:17.54673+05:30	2026-10-22	2D	482	8	10:00 AM	2026-10-08 22:57:17.545+05:30
3	2026-10-08 22:57:17.551347+05:30	2026-10-22	3D	483	8	1:30 PM	2026-10-08 22:57:17.55+05:30
4	2026-10-08 22:57:17.555617+05:30	2026-10-22	IMAX	484	8	4:30 PM	2026-10-08 22:57:17.554+05:30
5	2026-10-08 22:57:17.559337+05:30	2026-10-22	4DX	485	8	7:30 PM	2026-10-08 22:57:17.558+05:30
2	2026-10-08 22:57:17.568447+05:30	2026-10-10	2D	486	9	10:00 AM	2026-10-08 22:57:17.567+05:30
3	2026-10-08 22:57:17.573208+05:30	2026-10-10	3D	487	9	1:30 PM	2026-10-08 22:57:17.572+05:30
4	2026-10-08 22:57:17.577158+05:30	2026-10-10	IMAX	488	9	4:30 PM	2026-10-08 22:57:17.576+05:30
5	2026-10-08 22:57:17.58086+05:30	2026-10-10	4DX	489	9	7:30 PM	2026-10-08 22:57:17.58+05:30
2	2026-10-08 22:57:17.584428+05:30	2026-10-11	2D	490	9	10:00 AM	2026-10-08 22:57:17.583+05:30
3	2026-10-08 22:57:17.589164+05:30	2026-10-11	3D	491	9	1:30 PM	2026-10-08 22:57:17.587+05:30
4	2026-10-08 22:57:17.595051+05:30	2026-10-11	IMAX	492	9	4:30 PM	2026-10-08 22:57:17.593+05:30
5	2026-10-08 22:57:17.598955+05:30	2026-10-11	4DX	493	9	7:30 PM	2026-10-08 22:57:17.598+05:30
2	2026-10-08 22:57:17.602941+05:30	2026-10-12	2D	494	9	10:00 AM	2026-10-08 22:57:17.601+05:30
3	2026-10-08 22:57:17.607183+05:30	2026-10-12	3D	495	9	1:30 PM	2026-10-08 22:57:17.606+05:30
4	2026-10-08 22:57:17.611276+05:30	2026-10-12	IMAX	496	9	4:30 PM	2026-10-08 22:57:17.61+05:30
5	2026-10-08 22:57:17.614987+05:30	2026-10-12	4DX	497	9	7:30 PM	2026-10-08 22:57:17.613+05:30
2	2026-10-08 22:57:17.617987+05:30	2026-10-13	2D	498	9	10:00 AM	2026-10-08 22:57:17.617+05:30
3	2026-10-08 22:57:17.620994+05:30	2026-10-13	3D	499	9	1:30 PM	2026-10-08 22:57:17.62+05:30
4	2026-10-08 22:57:17.623749+05:30	2026-10-13	IMAX	500	9	4:30 PM	2026-10-08 22:57:17.623+05:30
5	2026-10-08 22:57:17.627258+05:30	2026-10-13	4DX	501	9	7:30 PM	2026-10-08 22:57:17.626+05:30
2	2026-10-08 22:57:17.631223+05:30	2026-10-14	2D	502	9	10:00 AM	2026-10-08 22:57:17.63+05:30
3	2026-10-08 22:57:17.635327+05:30	2026-10-14	3D	503	9	1:30 PM	2026-10-08 22:57:17.634+05:30
4	2026-10-08 22:57:17.639618+05:30	2026-10-14	IMAX	504	9	4:30 PM	2026-10-08 22:57:17.638+05:30
5	2026-10-08 22:57:17.643996+05:30	2026-10-14	4DX	505	9	7:30 PM	2026-10-08 22:57:17.642+05:30
2	2026-10-08 22:57:17.647536+05:30	2026-10-15	2D	506	9	10:00 AM	2026-10-08 22:57:17.646+05:30
3	2026-10-08 22:57:17.650699+05:30	2026-10-15	3D	507	9	1:30 PM	2026-10-08 22:57:17.649+05:30
4	2026-10-08 22:57:17.653639+05:30	2026-10-15	IMAX	508	9	4:30 PM	2026-10-08 22:57:17.652+05:30
5	2026-10-08 22:57:17.660028+05:30	2026-10-15	4DX	509	9	7:30 PM	2026-10-08 22:57:17.658+05:30
2	2026-10-08 22:57:17.665591+05:30	2026-10-16	2D	510	9	10:00 AM	2026-10-08 22:57:17.664+05:30
3	2026-10-08 22:57:17.683126+05:30	2026-10-16	3D	511	9	1:30 PM	2026-10-08 22:57:17.681+05:30
4	2026-10-08 22:57:17.687972+05:30	2026-10-16	IMAX	512	9	4:30 PM	2026-10-08 22:57:17.686+05:30
5	2026-10-08 22:57:17.692029+05:30	2026-10-16	4DX	513	9	7:30 PM	2026-10-08 22:57:17.691+05:30
2	2026-10-08 22:57:17.696396+05:30	2026-10-17	2D	514	9	10:00 AM	2026-10-08 22:57:17.695+05:30
3	2026-10-08 22:57:17.700071+05:30	2026-10-17	3D	515	9	1:30 PM	2026-10-08 22:57:17.699+05:30
4	2026-10-08 22:57:17.703747+05:30	2026-10-17	IMAX	516	9	4:30 PM	2026-10-08 22:57:17.702+05:30
5	2026-10-08 22:57:17.707352+05:30	2026-10-17	4DX	517	9	7:30 PM	2026-10-08 22:57:17.706+05:30
2	2026-10-08 22:57:17.711399+05:30	2026-10-18	2D	518	9	10:00 AM	2026-10-08 22:57:17.71+05:30
3	2026-10-08 22:57:17.715585+05:30	2026-10-18	3D	519	9	1:30 PM	2026-10-08 22:57:17.714+05:30
4	2026-10-08 22:57:17.719966+05:30	2026-10-18	IMAX	520	9	4:30 PM	2026-10-08 22:57:17.718+05:30
5	2026-10-08 22:57:17.723672+05:30	2026-10-18	4DX	521	9	7:30 PM	2026-10-08 22:57:17.722+05:30
2	2026-10-08 22:57:17.727072+05:30	2026-10-19	2D	522	9	10:00 AM	2026-10-08 22:57:17.726+05:30
3	2026-10-08 22:57:17.731488+05:30	2026-10-19	3D	523	9	1:30 PM	2026-10-08 22:57:17.73+05:30
4	2026-10-08 22:57:17.735168+05:30	2026-10-19	IMAX	524	9	4:30 PM	2026-10-08 22:57:17.734+05:30
5	2026-10-08 22:57:17.73901+05:30	2026-10-19	4DX	525	9	7:30 PM	2026-10-08 22:57:17.738+05:30
2	2026-10-08 22:57:17.742274+05:30	2026-10-20	2D	526	9	10:00 AM	2026-10-08 22:57:17.741+05:30
3	2026-10-08 22:57:17.747076+05:30	2026-10-20	3D	527	9	1:30 PM	2026-10-08 22:57:17.745+05:30
4	2026-10-08 22:57:17.751352+05:30	2026-10-20	IMAX	528	9	4:30 PM	2026-10-08 22:57:17.75+05:30
5	2026-10-08 22:57:17.755178+05:30	2026-10-20	4DX	529	9	7:30 PM	2026-10-08 22:57:17.754+05:30
2	2026-10-08 22:57:17.759208+05:30	2026-10-21	2D	530	9	10:00 AM	2026-10-08 22:57:17.758+05:30
3	2026-10-08 22:57:17.763081+05:30	2026-10-21	3D	531	9	1:30 PM	2026-10-08 22:57:17.762+05:30
4	2026-10-08 22:57:17.766551+05:30	2026-10-21	IMAX	532	9	4:30 PM	2026-10-08 22:57:17.765+05:30
5	2026-10-08 22:57:17.770713+05:30	2026-10-21	4DX	533	9	7:30 PM	2026-10-08 22:57:17.769+05:30
2	2026-10-08 22:57:17.775675+05:30	2026-10-22	2D	534	9	10:00 AM	2026-10-08 22:57:17.774+05:30
3	2026-10-08 22:57:17.780125+05:30	2026-10-22	3D	535	9	1:30 PM	2026-10-08 22:57:17.779+05:30
4	2026-10-08 22:57:17.785244+05:30	2026-10-22	IMAX	536	9	4:30 PM	2026-10-08 22:57:17.784+05:30
5	2026-10-08 22:57:17.790583+05:30	2026-10-22	4DX	537	9	7:30 PM	2026-10-08 22:57:17.789+05:30
2	2026-10-08 22:57:17.804104+05:30	2026-10-10	2D	538	10	10:00 AM	2026-10-08 22:57:17.803+05:30
3	2026-10-08 22:57:17.808577+05:30	2026-10-10	3D	539	10	1:30 PM	2026-10-08 22:57:17.807+05:30
4	2026-10-08 22:57:17.81295+05:30	2026-10-10	IMAX	540	10	4:30 PM	2026-10-08 22:57:17.811+05:30
5	2026-10-08 22:57:17.81722+05:30	2026-10-10	4DX	541	10	7:30 PM	2026-10-08 22:57:17.816+05:30
2	2026-10-08 22:57:17.821893+05:30	2026-10-11	2D	542	10	10:00 AM	2026-10-08 22:57:17.82+05:30
3	2026-10-08 22:57:17.826167+05:30	2026-10-11	3D	543	10	1:30 PM	2026-10-08 22:57:17.825+05:30
4	2026-10-08 22:57:17.832511+05:30	2026-10-11	IMAX	544	10	4:30 PM	2026-10-08 22:57:17.83+05:30
5	2026-10-08 22:57:17.837002+05:30	2026-10-11	4DX	545	10	7:30 PM	2026-10-08 22:57:17.835+05:30
2	2026-10-08 22:57:17.840753+05:30	2026-10-12	2D	546	10	10:00 AM	2026-10-08 22:57:17.839+05:30
3	2026-10-08 22:57:17.845363+05:30	2026-10-12	3D	547	10	1:30 PM	2026-10-08 22:57:17.844+05:30
4	2026-10-08 22:57:17.849185+05:30	2026-10-12	IMAX	548	10	4:30 PM	2026-10-08 22:57:17.848+05:30
5	2026-10-08 22:57:17.853197+05:30	2026-10-12	4DX	549	10	7:30 PM	2026-10-08 22:57:17.852+05:30
2	2026-10-08 22:57:17.857437+05:30	2026-10-13	2D	550	10	10:00 AM	2026-10-08 22:57:17.856+05:30
3	2026-10-08 22:57:17.86232+05:30	2026-10-13	3D	551	10	1:30 PM	2026-10-08 22:57:17.861+05:30
4	2026-10-08 22:57:17.868469+05:30	2026-10-13	IMAX	552	10	4:30 PM	2026-10-08 22:57:17.867+05:30
5	2026-10-08 22:57:17.872877+05:30	2026-10-13	4DX	553	10	7:30 PM	2026-10-08 22:57:17.871+05:30
2	2026-10-08 22:57:17.878192+05:30	2026-10-14	2D	554	10	10:00 AM	2026-10-08 22:57:17.876+05:30
3	2026-10-08 22:57:17.884282+05:30	2026-10-14	3D	555	10	1:30 PM	2026-10-08 22:57:17.883+05:30
4	2026-10-08 22:57:17.889038+05:30	2026-10-14	IMAX	556	10	4:30 PM	2026-10-08 22:57:17.888+05:30
5	2026-10-08 22:57:17.893437+05:30	2026-10-14	4DX	557	10	7:30 PM	2026-10-08 22:57:17.892+05:30
2	2026-10-08 22:57:17.899484+05:30	2026-10-15	2D	558	10	10:00 AM	2026-10-08 22:57:17.897+05:30
3	2026-10-08 22:57:17.905328+05:30	2026-10-15	3D	559	10	1:30 PM	2026-10-08 22:57:17.904+05:30
4	2026-10-08 22:57:17.909471+05:30	2026-10-15	IMAX	560	10	4:30 PM	2026-10-08 22:57:17.908+05:30
5	2026-10-08 22:57:17.914801+05:30	2026-10-15	4DX	561	10	7:30 PM	2026-10-08 22:57:17.913+05:30
2	2026-10-08 22:57:17.920111+05:30	2026-10-16	2D	562	10	10:00 AM	2026-10-08 22:57:17.919+05:30
3	2026-10-08 22:57:17.925634+05:30	2026-10-16	3D	563	10	1:30 PM	2026-10-08 22:57:17.924+05:30
4	2026-10-08 22:57:17.929968+05:30	2026-10-16	IMAX	564	10	4:30 PM	2026-10-08 22:57:17.928+05:30
5	2026-10-08 22:57:17.933812+05:30	2026-10-16	4DX	565	10	7:30 PM	2026-10-08 22:57:17.932+05:30
2	2026-10-08 22:57:17.937846+05:30	2026-10-17	2D	566	10	10:00 AM	2026-10-08 22:57:17.936+05:30
3	2026-10-08 22:57:17.942175+05:30	2026-10-17	3D	567	10	1:30 PM	2026-10-08 22:57:17.941+05:30
4	2026-10-08 22:57:17.946091+05:30	2026-10-17	IMAX	568	10	4:30 PM	2026-10-08 22:57:17.945+05:30
5	2026-10-08 22:57:17.949839+05:30	2026-10-17	4DX	569	10	7:30 PM	2026-10-08 22:57:17.949+05:30
2	2026-10-08 22:57:17.953626+05:30	2026-10-18	2D	570	10	10:00 AM	2026-10-08 22:57:17.952+05:30
3	2026-10-08 22:57:17.957383+05:30	2026-10-18	3D	571	10	1:30 PM	2026-10-08 22:57:17.956+05:30
4	2026-10-08 22:57:17.961266+05:30	2026-10-18	IMAX	572	10	4:30 PM	2026-10-08 22:57:17.96+05:30
5	2026-10-08 22:57:17.965022+05:30	2026-10-18	4DX	573	10	7:30 PM	2026-10-08 22:57:17.964+05:30
2	2026-10-08 22:57:17.96924+05:30	2026-10-19	2D	574	10	10:00 AM	2026-10-08 22:57:17.968+05:30
3	2026-10-08 22:57:17.973687+05:30	2026-10-19	3D	575	10	1:30 PM	2026-10-08 22:57:17.972+05:30
4	2026-10-08 22:57:17.977562+05:30	2026-10-19	IMAX	576	10	4:30 PM	2026-10-08 22:57:17.976+05:30
5	2026-10-08 22:57:17.981372+05:30	2026-10-19	4DX	577	10	7:30 PM	2026-10-08 22:57:17.98+05:30
2	2026-10-08 22:57:17.984987+05:30	2026-10-20	2D	578	10	10:00 AM	2026-10-08 22:57:17.984+05:30
3	2026-10-08 22:57:17.988557+05:30	2026-10-20	3D	579	10	1:30 PM	2026-10-08 22:57:17.987+05:30
4	2026-10-08 22:57:17.992902+05:30	2026-10-20	IMAX	580	10	4:30 PM	2026-10-08 22:57:17.991+05:30
5	2026-10-08 22:57:17.996574+05:30	2026-10-20	4DX	581	10	7:30 PM	2026-10-08 22:57:17.995+05:30
2	2026-10-08 22:57:18.002738+05:30	2026-10-21	2D	582	10	10:00 AM	2026-10-08 22:57:17.999+05:30
3	2026-10-08 22:57:18.008114+05:30	2026-10-21	3D	583	10	1:30 PM	2026-10-08 22:57:18.007+05:30
4	2026-10-08 22:57:18.012097+05:30	2026-10-21	IMAX	584	10	4:30 PM	2026-10-08 22:57:18.011+05:30
5	2026-10-08 22:57:18.015947+05:30	2026-10-21	4DX	585	10	7:30 PM	2026-10-08 22:57:18.015+05:30
2	2026-10-08 22:57:18.01976+05:30	2026-10-22	2D	586	10	10:00 AM	2026-10-08 22:57:18.018+05:30
3	2026-10-08 22:57:18.024125+05:30	2026-10-22	3D	587	10	1:30 PM	2026-10-08 22:57:18.022+05:30
4	2026-10-08 22:57:18.028079+05:30	2026-10-22	IMAX	588	10	4:30 PM	2026-10-08 22:57:18.027+05:30
5	2026-10-08 22:57:18.031936+05:30	2026-10-22	4DX	589	10	7:30 PM	2026-10-08 22:57:18.031+05:30
2	2026-10-08 22:57:18.04247+05:30	2026-10-10	2D	590	11	10:00 AM	2026-10-08 22:57:18.041+05:30
3	2026-10-08 22:57:18.046274+05:30	2026-10-10	3D	591	11	1:30 PM	2026-10-08 22:57:18.045+05:30
4	2026-10-08 22:57:18.050358+05:30	2026-10-10	IMAX	592	11	4:30 PM	2026-10-08 22:57:18.049+05:30
5	2026-10-08 22:57:18.054113+05:30	2026-10-10	4DX	593	11	7:30 PM	2026-10-08 22:57:18.053+05:30
2	2026-10-08 22:57:18.058906+05:30	2026-10-11	2D	594	11	10:00 AM	2026-10-08 22:57:18.057+05:30
3	2026-10-08 22:57:18.062385+05:30	2026-10-11	3D	595	11	1:30 PM	2026-10-08 22:57:18.061+05:30
4	2026-10-08 22:57:18.066101+05:30	2026-10-11	IMAX	596	11	4:30 PM	2026-10-08 22:57:18.065+05:30
5	2026-10-08 22:57:18.069875+05:30	2026-10-11	4DX	597	11	7:30 PM	2026-10-08 22:57:18.069+05:30
2	2026-10-08 22:57:18.073577+05:30	2026-10-12	2D	598	11	10:00 AM	2026-10-08 22:57:18.072+05:30
3	2026-10-08 22:57:18.077217+05:30	2026-10-12	3D	599	11	1:30 PM	2026-10-08 22:57:18.076+05:30
4	2026-10-08 22:57:18.080942+05:30	2026-10-12	IMAX	600	11	4:30 PM	2026-10-08 22:57:18.08+05:30
5	2026-10-08 22:57:18.084617+05:30	2026-10-12	4DX	601	11	7:30 PM	2026-10-08 22:57:18.083+05:30
2	2026-10-08 22:57:18.088288+05:30	2026-10-13	2D	602	11	10:00 AM	2026-10-08 22:57:18.087+05:30
3	2026-10-08 22:57:18.09177+05:30	2026-10-13	3D	603	11	1:30 PM	2026-10-08 22:57:18.09+05:30
4	2026-10-08 22:57:18.094614+05:30	2026-10-13	IMAX	604	11	4:30 PM	2026-10-08 22:57:18.093+05:30
5	2026-10-08 22:57:18.097411+05:30	2026-10-13	4DX	605	11	7:30 PM	2026-10-08 22:57:18.096+05:30
2	2026-10-08 22:57:18.100296+05:30	2026-10-14	2D	606	11	10:00 AM	2026-10-08 22:57:18.099+05:30
3	2026-10-08 22:57:18.103047+05:30	2026-10-14	3D	607	11	1:30 PM	2026-10-08 22:57:18.101+05:30
4	2026-10-08 22:57:18.10667+05:30	2026-10-14	IMAX	608	11	4:30 PM	2026-10-08 22:57:18.105+05:30
5	2026-10-08 22:57:18.109751+05:30	2026-10-14	4DX	609	11	7:30 PM	2026-10-08 22:57:18.109+05:30
2	2026-10-08 22:57:18.112456+05:30	2026-10-15	2D	610	11	10:00 AM	2026-10-08 22:57:18.111+05:30
3	2026-10-08 22:57:18.114844+05:30	2026-10-15	3D	611	11	1:30 PM	2026-10-08 22:57:18.114+05:30
4	2026-10-08 22:57:18.117952+05:30	2026-10-15	IMAX	612	11	4:30 PM	2026-10-08 22:57:18.117+05:30
5	2026-10-08 22:57:18.121297+05:30	2026-10-15	4DX	613	11	7:30 PM	2026-10-08 22:57:18.12+05:30
2	2026-10-08 22:57:18.124251+05:30	2026-10-16	2D	614	11	10:00 AM	2026-10-08 22:57:18.123+05:30
3	2026-10-08 22:57:18.127032+05:30	2026-10-16	3D	615	11	1:30 PM	2026-10-08 22:57:18.126+05:30
4	2026-10-08 22:57:18.129611+05:30	2026-10-16	IMAX	616	11	4:30 PM	2026-10-08 22:57:18.128+05:30
5	2026-10-08 22:57:18.131992+05:30	2026-10-16	4DX	617	11	7:30 PM	2026-10-08 22:57:18.131+05:30
2	2026-10-08 22:57:18.13435+05:30	2026-10-17	2D	618	11	10:00 AM	2026-10-08 22:57:18.133+05:30
3	2026-10-08 22:57:18.136697+05:30	2026-10-17	3D	619	11	1:30 PM	2026-10-08 22:57:18.135+05:30
4	2026-10-08 22:57:18.139273+05:30	2026-10-17	IMAX	620	11	4:30 PM	2026-10-08 22:57:18.138+05:30
5	2026-10-08 22:57:18.142114+05:30	2026-10-17	4DX	621	11	7:30 PM	2026-10-08 22:57:18.141+05:30
2	2026-10-08 22:57:18.144493+05:30	2026-10-18	2D	622	11	10:00 AM	2026-10-08 22:57:18.143+05:30
3	2026-10-08 22:57:18.146789+05:30	2026-10-18	3D	623	11	1:30 PM	2026-10-08 22:57:18.145+05:30
4	2026-10-08 22:57:18.149064+05:30	2026-10-18	IMAX	624	11	4:30 PM	2026-10-08 22:57:18.148+05:30
5	2026-10-08 22:57:18.151334+05:30	2026-10-18	4DX	625	11	7:30 PM	2026-10-08 22:57:18.15+05:30
2	2026-10-08 22:57:18.153599+05:30	2026-10-19	2D	626	11	10:00 AM	2026-10-08 22:57:18.152+05:30
3	2026-10-08 22:57:18.155565+05:30	2026-10-19	3D	627	11	1:30 PM	2026-10-08 22:57:18.155+05:30
4	2026-10-08 22:57:18.158097+05:30	2026-10-19	IMAX	628	11	4:30 PM	2026-10-08 22:57:18.157+05:30
5	2026-10-08 22:57:18.161308+05:30	2026-10-19	4DX	629	11	7:30 PM	2026-10-08 22:57:18.16+05:30
2	2026-10-08 22:57:18.16492+05:30	2026-10-20	2D	630	11	10:00 AM	2026-10-08 22:57:18.164+05:30
3	2026-10-08 22:57:18.168916+05:30	2026-10-20	3D	631	11	1:30 PM	2026-10-08 22:57:18.168+05:30
4	2026-10-08 22:57:18.172225+05:30	2026-10-20	IMAX	632	11	4:30 PM	2026-10-08 22:57:18.171+05:30
5	2026-10-08 22:57:18.175778+05:30	2026-10-20	4DX	633	11	7:30 PM	2026-10-08 22:57:18.174+05:30
2	2026-10-08 22:57:18.178737+05:30	2026-10-21	2D	634	11	10:00 AM	2026-10-08 22:57:18.177+05:30
3	2026-10-08 22:57:18.181432+05:30	2026-10-21	3D	635	11	1:30 PM	2026-10-08 22:57:18.18+05:30
4	2026-10-08 22:57:18.183946+05:30	2026-10-21	IMAX	636	11	4:30 PM	2026-10-08 22:57:18.183+05:30
5	2026-10-08 22:57:18.186259+05:30	2026-10-21	4DX	637	11	7:30 PM	2026-10-08 22:57:18.185+05:30
2	2026-10-08 22:57:18.188651+05:30	2026-10-22	2D	638	11	10:00 AM	2026-10-08 22:57:18.187+05:30
3	2026-10-08 22:57:18.190903+05:30	2026-10-22	3D	639	11	1:30 PM	2026-10-08 22:57:18.19+05:30
4	2026-10-08 22:57:18.193529+05:30	2026-10-22	IMAX	640	11	4:30 PM	2026-10-08 22:57:18.192+05:30
5	2026-10-08 22:57:18.196577+05:30	2026-10-22	4DX	641	11	7:30 PM	2026-10-08 22:57:18.195+05:30
2	2026-10-08 22:57:18.206667+05:30	2026-10-10	2D	642	12	10:00 AM	2026-10-08 22:57:18.205+05:30
3	2026-10-08 22:57:18.212088+05:30	2026-10-10	3D	643	12	1:30 PM	2026-10-08 22:57:18.21+05:30
4	2026-10-08 22:57:18.215573+05:30	2026-10-10	IMAX	644	12	4:30 PM	2026-10-08 22:57:18.214+05:30
5	2026-10-08 22:57:18.219027+05:30	2026-10-10	4DX	645	12	7:30 PM	2026-10-08 22:57:18.218+05:30
2	2026-10-08 22:57:18.22288+05:30	2026-10-11	2D	646	12	10:00 AM	2026-10-08 22:57:18.221+05:30
3	2026-10-08 22:57:18.225911+05:30	2026-10-11	3D	647	12	1:30 PM	2026-10-08 22:57:18.225+05:30
4	2026-10-08 22:57:18.229202+05:30	2026-10-11	IMAX	648	12	4:30 PM	2026-10-08 22:57:18.227+05:30
5	2026-10-08 22:57:18.232075+05:30	2026-10-11	4DX	649	12	7:30 PM	2026-10-08 22:57:18.231+05:30
2	2026-10-08 22:57:18.234852+05:30	2026-10-12	2D	650	12	10:00 AM	2026-10-08 22:57:18.234+05:30
3	2026-10-08 22:57:18.238062+05:30	2026-10-12	3D	651	12	1:30 PM	2026-10-08 22:57:18.237+05:30
4	2026-10-08 22:57:18.241853+05:30	2026-10-12	IMAX	652	12	4:30 PM	2026-10-08 22:57:18.24+05:30
5	2026-10-08 22:57:18.245474+05:30	2026-10-12	4DX	653	12	7:30 PM	2026-10-08 22:57:18.244+05:30
2	2026-10-08 22:57:18.249132+05:30	2026-10-13	2D	654	12	10:00 AM	2026-10-08 22:57:18.248+05:30
3	2026-10-08 22:57:18.253316+05:30	2026-10-13	3D	655	12	1:30 PM	2026-10-08 22:57:18.252+05:30
4	2026-10-08 22:57:18.256973+05:30	2026-10-13	IMAX	656	12	4:30 PM	2026-10-08 22:57:18.256+05:30
5	2026-10-08 22:57:18.26056+05:30	2026-10-13	4DX	657	12	7:30 PM	2026-10-08 22:57:18.259+05:30
2	2026-10-08 22:57:18.264043+05:30	2026-10-14	2D	658	12	10:00 AM	2026-10-08 22:57:18.263+05:30
3	2026-10-08 22:57:18.26777+05:30	2026-10-14	3D	659	12	1:30 PM	2026-10-08 22:57:18.266+05:30
4	2026-10-08 22:57:18.271106+05:30	2026-10-14	IMAX	660	12	4:30 PM	2026-10-08 22:57:18.27+05:30
5	2026-10-08 22:57:18.274094+05:30	2026-10-14	4DX	661	12	7:30 PM	2026-10-08 22:57:18.273+05:30
2	2026-10-08 22:57:18.281992+05:30	2026-10-15	2D	662	12	10:00 AM	2026-10-08 22:57:18.281+05:30
3	2026-10-08 22:57:18.28599+05:30	2026-10-15	3D	663	12	1:30 PM	2026-10-08 22:57:18.285+05:30
4	2026-10-08 22:57:18.28923+05:30	2026-10-15	IMAX	664	12	4:30 PM	2026-10-08 22:57:18.288+05:30
5	2026-10-08 22:57:18.292946+05:30	2026-10-15	4DX	665	12	7:30 PM	2026-10-08 22:57:18.292+05:30
2	2026-10-08 22:57:18.296533+05:30	2026-10-16	2D	666	12	10:00 AM	2026-10-08 22:57:18.295+05:30
3	2026-10-08 22:57:18.300141+05:30	2026-10-16	3D	667	12	1:30 PM	2026-10-08 22:57:18.299+05:30
4	2026-10-08 22:57:18.303843+05:30	2026-10-16	IMAX	668	12	4:30 PM	2026-10-08 22:57:18.303+05:30
5	2026-10-08 22:57:18.307662+05:30	2026-10-16	4DX	669	12	7:30 PM	2026-10-08 22:57:18.306+05:30
2	2026-10-08 22:57:18.311789+05:30	2026-10-17	2D	670	12	10:00 AM	2026-10-08 22:57:18.31+05:30
3	2026-10-08 22:57:18.316105+05:30	2026-10-17	3D	671	12	1:30 PM	2026-10-08 22:57:18.314+05:30
4	2026-10-08 22:57:18.320634+05:30	2026-10-17	IMAX	672	12	4:30 PM	2026-10-08 22:57:18.319+05:30
5	2026-10-08 22:57:18.324669+05:30	2026-10-17	4DX	673	12	7:30 PM	2026-10-08 22:57:18.323+05:30
2	2026-10-08 22:57:18.328408+05:30	2026-10-18	2D	674	12	10:00 AM	2026-10-08 22:57:18.327+05:30
3	2026-10-08 22:57:18.332997+05:30	2026-10-18	3D	675	12	1:30 PM	2026-10-08 22:57:18.331+05:30
4	2026-10-08 22:57:18.338597+05:30	2026-10-18	IMAX	676	12	4:30 PM	2026-10-08 22:57:18.337+05:30
5	2026-10-08 22:57:18.351251+05:30	2026-10-18	4DX	677	12	7:30 PM	2026-10-08 22:57:18.344+05:30
2	2026-10-08 22:57:18.356718+05:30	2026-10-19	2D	678	12	10:00 AM	2026-10-08 22:57:18.355+05:30
3	2026-10-08 22:57:18.365705+05:30	2026-10-19	3D	679	12	1:30 PM	2026-10-08 22:57:18.364+05:30
4	2026-10-08 22:57:18.375388+05:30	2026-10-19	IMAX	680	12	4:30 PM	2026-10-08 22:57:18.373+05:30
5	2026-10-08 22:57:18.384231+05:30	2026-10-19	4DX	681	12	7:30 PM	2026-10-08 22:57:18.383+05:30
2	2026-10-08 22:57:18.388598+05:30	2026-10-20	2D	682	12	10:00 AM	2026-10-08 22:57:18.387+05:30
3	2026-10-08 22:57:18.392771+05:30	2026-10-20	3D	683	12	1:30 PM	2026-10-08 22:57:18.391+05:30
4	2026-10-08 22:57:18.397168+05:30	2026-10-20	IMAX	684	12	4:30 PM	2026-10-08 22:57:18.396+05:30
5	2026-10-08 22:57:18.403468+05:30	2026-10-20	4DX	685	12	7:30 PM	2026-10-08 22:57:18.402+05:30
2	2026-10-08 22:57:18.408775+05:30	2026-10-21	2D	686	12	10:00 AM	2026-10-08 22:57:18.407+05:30
3	2026-10-08 22:57:18.41882+05:30	2026-10-21	3D	687	12	1:30 PM	2026-10-08 22:57:18.415+05:30
4	2026-10-08 22:57:18.44612+05:30	2026-10-21	IMAX	688	12	4:30 PM	2026-10-08 22:57:18.436+05:30
5	2026-10-08 22:57:18.451057+05:30	2026-10-21	4DX	689	12	7:30 PM	2026-10-08 22:57:18.45+05:30
2	2026-10-08 22:57:18.46054+05:30	2026-10-22	2D	690	12	10:00 AM	2026-10-08 22:57:18.455+05:30
3	2026-10-08 22:57:18.465163+05:30	2026-10-22	3D	691	12	1:30 PM	2026-10-08 22:57:18.463+05:30
4	2026-10-08 22:57:18.551031+05:30	2026-10-22	IMAX	692	12	4:30 PM	2026-10-08 22:57:18.55+05:30
5	2026-10-08 22:57:18.577154+05:30	2026-10-22	4DX	693	12	7:30 PM	2026-10-08 22:57:18.576+05:30
2	2026-10-08 22:57:18.590421+05:30	2026-10-10	2D	694	13	10:00 AM	2026-10-08 22:57:18.589+05:30
3	2026-10-08 22:57:18.595762+05:30	2026-10-10	3D	695	13	1:30 PM	2026-10-08 22:57:18.594+05:30
4	2026-10-08 22:57:18.598966+05:30	2026-10-10	IMAX	696	13	4:30 PM	2026-10-08 22:57:18.598+05:30
5	2026-10-08 22:57:18.602423+05:30	2026-10-10	4DX	697	13	7:30 PM	2026-10-08 22:57:18.601+05:30
2	2026-10-08 22:57:18.609135+05:30	2026-10-11	2D	698	13	10:00 AM	2026-10-08 22:57:18.607+05:30
3	2026-10-08 22:57:18.61671+05:30	2026-10-11	3D	699	13	1:30 PM	2026-10-08 22:57:18.615+05:30
4	2026-10-08 22:57:18.621693+05:30	2026-10-11	IMAX	700	13	4:30 PM	2026-10-08 22:57:18.62+05:30
5	2026-10-08 22:57:18.626422+05:30	2026-10-11	4DX	701	13	7:30 PM	2026-10-08 22:57:18.625+05:30
2	2026-10-08 22:57:18.632207+05:30	2026-10-12	2D	702	13	10:00 AM	2026-10-08 22:57:18.631+05:30
3	2026-10-08 22:57:18.635096+05:30	2026-10-12	3D	703	13	1:30 PM	2026-10-08 22:57:18.634+05:30
4	2026-10-08 22:57:18.637737+05:30	2026-10-12	IMAX	704	13	4:30 PM	2026-10-08 22:57:18.637+05:30
5	2026-10-08 22:57:18.643022+05:30	2026-10-12	4DX	705	13	7:30 PM	2026-10-08 22:57:18.641+05:30
2	2026-10-08 22:57:18.648084+05:30	2026-10-13	2D	706	13	10:00 AM	2026-10-08 22:57:18.647+05:30
3	2026-10-08 22:57:18.650848+05:30	2026-10-13	3D	707	13	1:30 PM	2026-10-08 22:57:18.65+05:30
4	2026-10-08 22:57:18.653594+05:30	2026-10-13	IMAX	708	13	4:30 PM	2026-10-08 22:57:18.652+05:30
5	2026-10-08 22:57:18.657452+05:30	2026-10-13	4DX	709	13	7:30 PM	2026-10-08 22:57:18.656+05:30
2	2026-10-08 22:57:18.660329+05:30	2026-10-14	2D	710	13	10:00 AM	2026-10-08 22:57:18.659+05:30
3	2026-10-08 22:57:18.664138+05:30	2026-10-14	3D	711	13	1:30 PM	2026-10-08 22:57:18.663+05:30
4	2026-10-08 22:57:18.666789+05:30	2026-10-14	IMAX	712	13	4:30 PM	2026-10-08 22:57:18.666+05:30
5	2026-10-08 22:57:18.66982+05:30	2026-10-14	4DX	713	13	7:30 PM	2026-10-08 22:57:18.668+05:30
2	2026-10-08 22:57:18.672829+05:30	2026-10-15	2D	714	13	10:00 AM	2026-10-08 22:57:18.671+05:30
3	2026-10-08 22:57:18.676867+05:30	2026-10-15	3D	715	13	1:30 PM	2026-10-08 22:57:18.676+05:30
4	2026-10-08 22:57:18.68003+05:30	2026-10-15	IMAX	716	13	4:30 PM	2026-10-08 22:57:18.679+05:30
5	2026-10-08 22:57:18.684241+05:30	2026-10-15	4DX	717	13	7:30 PM	2026-10-08 22:57:18.683+05:30
2	2026-10-08 22:57:18.686904+05:30	2026-10-16	2D	718	13	10:00 AM	2026-10-08 22:57:18.686+05:30
3	2026-10-08 22:57:18.68927+05:30	2026-10-16	3D	719	13	1:30 PM	2026-10-08 22:57:18.688+05:30
4	2026-10-08 22:57:18.694945+05:30	2026-10-16	IMAX	720	13	4:30 PM	2026-10-08 22:57:18.692+05:30
5	2026-10-08 22:57:18.69924+05:30	2026-10-16	4DX	721	13	7:30 PM	2026-10-08 22:57:18.698+05:30
2	2026-10-08 22:57:18.70308+05:30	2026-10-17	2D	722	13	10:00 AM	2026-10-08 22:57:18.701+05:30
3	2026-10-08 22:57:18.706644+05:30	2026-10-17	3D	723	13	1:30 PM	2026-10-08 22:57:18.705+05:30
4	2026-10-08 22:57:18.711314+05:30	2026-10-17	IMAX	724	13	4:30 PM	2026-10-08 22:57:18.709+05:30
5	2026-10-08 22:57:18.714998+05:30	2026-10-17	4DX	725	13	7:30 PM	2026-10-08 22:57:18.714+05:30
2	2026-10-08 22:57:18.717513+05:30	2026-10-18	2D	726	13	10:00 AM	2026-10-08 22:57:18.716+05:30
3	2026-10-08 22:57:18.720198+05:30	2026-10-18	3D	727	13	1:30 PM	2026-10-08 22:57:18.719+05:30
4	2026-10-08 22:57:18.722995+05:30	2026-10-18	IMAX	728	13	4:30 PM	2026-10-08 22:57:18.722+05:30
5	2026-10-08 22:57:18.727445+05:30	2026-10-18	4DX	729	13	7:30 PM	2026-10-08 22:57:18.726+05:30
2	2026-10-08 22:57:18.731202+05:30	2026-10-19	2D	730	13	10:00 AM	2026-10-08 22:57:18.73+05:30
3	2026-10-08 22:57:18.734015+05:30	2026-10-19	3D	731	13	1:30 PM	2026-10-08 22:57:18.733+05:30
4	2026-10-08 22:57:18.736653+05:30	2026-10-19	IMAX	732	13	4:30 PM	2026-10-08 22:57:18.735+05:30
5	2026-10-08 22:57:18.739885+05:30	2026-10-19	4DX	733	13	7:30 PM	2026-10-08 22:57:18.738+05:30
2	2026-10-08 22:57:18.743362+05:30	2026-10-20	2D	734	13	10:00 AM	2026-10-08 22:57:18.742+05:30
3	2026-10-08 22:57:18.747327+05:30	2026-10-20	3D	735	13	1:30 PM	2026-10-08 22:57:18.746+05:30
4	2026-10-08 22:57:18.751647+05:30	2026-10-20	IMAX	736	13	4:30 PM	2026-10-08 22:57:18.75+05:30
5	2026-10-08 22:57:18.754144+05:30	2026-10-20	4DX	737	13	7:30 PM	2026-10-08 22:57:18.753+05:30
2	2026-10-08 22:57:18.758522+05:30	2026-10-21	2D	738	13	10:00 AM	2026-10-08 22:57:18.757+05:30
3	2026-10-08 22:57:18.763207+05:30	2026-10-21	3D	739	13	1:30 PM	2026-10-08 22:57:18.762+05:30
4	2026-10-08 22:57:18.766058+05:30	2026-10-21	IMAX	740	13	4:30 PM	2026-10-08 22:57:18.765+05:30
5	2026-10-08 22:57:18.768708+05:30	2026-10-21	4DX	741	13	7:30 PM	2026-10-08 22:57:18.768+05:30
2	2026-10-08 22:57:18.771326+05:30	2026-10-22	2D	742	13	10:00 AM	2026-10-08 22:57:18.77+05:30
3	2026-10-08 22:57:18.774451+05:30	2026-10-22	3D	743	13	1:30 PM	2026-10-08 22:57:18.773+05:30
4	2026-10-08 22:57:18.778834+05:30	2026-10-22	IMAX	744	13	4:30 PM	2026-10-08 22:57:18.778+05:30
5	2026-10-08 22:57:18.781555+05:30	2026-10-22	4DX	745	13	7:30 PM	2026-10-08 22:57:18.78+05:30
2	2026-10-08 22:57:18.788423+05:30	2026-10-10	2D	746	14	10:00 AM	2026-10-08 22:57:18.787+05:30
3	2026-10-08 22:57:18.791999+05:30	2026-10-10	3D	747	14	1:30 PM	2026-10-08 22:57:18.79+05:30
4	2026-10-08 22:57:18.795503+05:30	2026-10-10	IMAX	748	14	4:30 PM	2026-10-08 22:57:18.794+05:30
5	2026-10-08 22:57:18.798288+05:30	2026-10-10	4DX	749	14	7:30 PM	2026-10-08 22:57:18.797+05:30
2	2026-10-08 22:57:18.801659+05:30	2026-10-11	2D	750	14	10:00 AM	2026-10-08 22:57:18.8+05:30
3	2026-10-08 22:57:18.804876+05:30	2026-10-11	3D	751	14	1:30 PM	2026-10-08 22:57:18.804+05:30
4	2026-10-08 22:57:18.808221+05:30	2026-10-11	IMAX	752	14	4:30 PM	2026-10-08 22:57:18.807+05:30
5	2026-10-08 22:57:18.811228+05:30	2026-10-11	4DX	753	14	7:30 PM	2026-10-08 22:57:18.81+05:30
2	2026-10-08 22:57:18.814018+05:30	2026-10-12	2D	754	14	10:00 AM	2026-10-08 22:57:18.813+05:30
3	2026-10-08 22:57:18.816731+05:30	2026-10-12	3D	755	14	1:30 PM	2026-10-08 22:57:18.816+05:30
4	2026-10-08 22:57:18.819343+05:30	2026-10-12	IMAX	756	14	4:30 PM	2026-10-08 22:57:18.818+05:30
5	2026-10-08 22:57:18.822024+05:30	2026-10-12	4DX	757	14	7:30 PM	2026-10-08 22:57:18.821+05:30
2	2026-10-08 22:57:18.8267+05:30	2026-10-13	2D	758	14	10:00 AM	2026-10-08 22:57:18.825+05:30
3	2026-10-08 22:57:18.830464+05:30	2026-10-13	3D	759	14	1:30 PM	2026-10-08 22:57:18.829+05:30
4	2026-10-08 22:57:18.833591+05:30	2026-10-13	IMAX	760	14	4:30 PM	2026-10-08 22:57:18.832+05:30
5	2026-10-08 22:57:18.836687+05:30	2026-10-13	4DX	761	14	7:30 PM	2026-10-08 22:57:18.836+05:30
2	2026-10-08 22:57:18.840484+05:30	2026-10-14	2D	762	14	10:00 AM	2026-10-08 22:57:18.839+05:30
3	2026-10-08 22:57:18.844712+05:30	2026-10-14	3D	763	14	1:30 PM	2026-10-08 22:57:18.843+05:30
4	2026-10-08 22:57:18.847474+05:30	2026-10-14	IMAX	764	14	4:30 PM	2026-10-08 22:57:18.846+05:30
5	2026-10-08 22:57:18.850575+05:30	2026-10-14	4DX	765	14	7:30 PM	2026-10-08 22:57:18.849+05:30
2	2026-10-08 22:57:18.853268+05:30	2026-10-15	2D	766	14	10:00 AM	2026-10-08 22:57:18.852+05:30
3	2026-10-08 22:57:18.856007+05:30	2026-10-15	3D	767	14	1:30 PM	2026-10-08 22:57:18.855+05:30
4	2026-10-08 22:57:18.859832+05:30	2026-10-15	IMAX	768	14	4:30 PM	2026-10-08 22:57:18.858+05:30
5	2026-10-08 22:57:18.863504+05:30	2026-10-15	4DX	769	14	7:30 PM	2026-10-08 22:57:18.862+05:30
2	2026-10-08 22:57:18.866721+05:30	2026-10-16	2D	770	14	10:00 AM	2026-10-08 22:57:18.865+05:30
3	2026-10-08 22:57:18.870924+05:30	2026-10-16	3D	771	14	1:30 PM	2026-10-08 22:57:18.87+05:30
4	2026-10-08 22:57:18.877805+05:30	2026-10-16	IMAX	772	14	4:30 PM	2026-10-08 22:57:18.876+05:30
5	2026-10-08 22:57:18.882151+05:30	2026-10-16	4DX	773	14	7:30 PM	2026-10-08 22:57:18.881+05:30
2	2026-10-08 22:57:18.88507+05:30	2026-10-17	2D	774	14	10:00 AM	2026-10-08 22:57:18.884+05:30
3	2026-10-08 22:57:18.888133+05:30	2026-10-17	3D	775	14	1:30 PM	2026-10-08 22:57:18.887+05:30
4	2026-10-08 22:57:18.892806+05:30	2026-10-17	IMAX	776	14	4:30 PM	2026-10-08 22:57:18.891+05:30
5	2026-10-08 22:57:18.896414+05:30	2026-10-17	4DX	777	14	7:30 PM	2026-10-08 22:57:18.895+05:30
2	2026-10-08 22:57:18.898968+05:30	2026-10-18	2D	778	14	10:00 AM	2026-10-08 22:57:18.898+05:30
3	2026-10-08 22:57:18.901413+05:30	2026-10-18	3D	779	14	1:30 PM	2026-10-08 22:57:18.9+05:30
4	2026-10-08 22:57:18.904084+05:30	2026-10-18	IMAX	780	14	4:30 PM	2026-10-08 22:57:18.903+05:30
5	2026-10-08 22:57:18.908476+05:30	2026-10-18	4DX	781	14	7:30 PM	2026-10-08 22:57:18.907+05:30
2	2026-10-08 22:57:18.911457+05:30	2026-10-19	2D	782	14	10:00 AM	2026-10-08 22:57:18.91+05:30
3	2026-10-08 22:57:18.914265+05:30	2026-10-19	3D	783	14	1:30 PM	2026-10-08 22:57:18.913+05:30
4	2026-10-08 22:57:18.917093+05:30	2026-10-19	IMAX	784	14	4:30 PM	2026-10-08 22:57:18.916+05:30
5	2026-10-08 22:57:18.91979+05:30	2026-10-19	4DX	785	14	7:30 PM	2026-10-08 22:57:18.919+05:30
2	2026-10-08 22:57:18.922936+05:30	2026-10-20	2D	786	14	10:00 AM	2026-10-08 22:57:18.922+05:30
3	2026-10-08 22:57:18.926906+05:30	2026-10-20	3D	787	14	1:30 PM	2026-10-08 22:57:18.926+05:30
4	2026-10-08 22:57:18.92965+05:30	2026-10-20	IMAX	788	14	4:30 PM	2026-10-08 22:57:18.928+05:30
5	2026-10-08 22:57:18.932618+05:30	2026-10-20	4DX	789	14	7:30 PM	2026-10-08 22:57:18.931+05:30
2	2026-10-08 22:57:18.935106+05:30	2026-10-21	2D	790	14	10:00 AM	2026-10-08 22:57:18.934+05:30
3	2026-10-08 22:57:18.937867+05:30	2026-10-21	3D	791	14	1:30 PM	2026-10-08 22:57:18.937+05:30
4	2026-10-08 22:57:18.941849+05:30	2026-10-21	IMAX	792	14	4:30 PM	2026-10-08 22:57:18.94+05:30
5	2026-10-08 22:57:18.945007+05:30	2026-10-21	4DX	793	14	7:30 PM	2026-10-08 22:57:18.944+05:30
2	2026-10-08 22:57:18.948984+05:30	2026-10-22	2D	794	14	10:00 AM	2026-10-08 22:57:18.947+05:30
3	2026-10-08 22:57:18.95307+05:30	2026-10-22	3D	795	14	1:30 PM	2026-10-08 22:57:18.952+05:30
4	2026-10-08 22:57:18.957706+05:30	2026-10-22	IMAX	796	14	4:30 PM	2026-10-08 22:57:18.956+05:30
5	2026-10-08 22:57:18.962418+05:30	2026-10-22	4DX	797	14	7:30 PM	2026-10-08 22:57:18.961+05:30
2	2026-10-08 22:57:18.976186+05:30	2026-10-10	2D	798	15	10:00 AM	2026-10-08 22:57:18.975+05:30
3	2026-10-08 22:57:18.980186+05:30	2026-10-10	3D	799	15	1:30 PM	2026-10-08 22:57:18.979+05:30
4	2026-10-08 22:57:18.983858+05:30	2026-10-10	IMAX	800	15	4:30 PM	2026-10-08 22:57:18.983+05:30
5	2026-10-08 22:57:18.988186+05:30	2026-10-10	4DX	801	15	7:30 PM	2026-10-08 22:57:18.987+05:30
2	2026-10-08 22:57:18.992453+05:30	2026-10-11	2D	802	15	10:00 AM	2026-10-08 22:57:18.991+05:30
3	2026-10-08 22:57:18.996278+05:30	2026-10-11	3D	803	15	1:30 PM	2026-10-08 22:57:18.995+05:30
4	2026-10-08 22:57:19.000007+05:30	2026-10-11	IMAX	804	15	4:30 PM	2026-10-08 22:57:18.999+05:30
5	2026-10-08 22:57:19.003509+05:30	2026-10-11	4DX	805	15	7:30 PM	2026-10-08 22:57:19.002+05:30
2	2026-10-08 22:57:19.007443+05:30	2026-10-12	2D	806	15	10:00 AM	2026-10-08 22:57:19.006+05:30
3	2026-10-08 22:57:19.011095+05:30	2026-10-12	3D	807	15	1:30 PM	2026-10-08 22:57:19.01+05:30
4	2026-10-08 22:57:19.014571+05:30	2026-10-12	IMAX	808	15	4:30 PM	2026-10-08 22:57:19.013+05:30
5	2026-10-08 22:57:19.018052+05:30	2026-10-12	4DX	809	15	7:30 PM	2026-10-08 22:57:19.017+05:30
2	2026-10-08 22:57:19.021596+05:30	2026-10-13	2D	810	15	10:00 AM	2026-10-08 22:57:19.02+05:30
3	2026-10-08 22:57:19.025845+05:30	2026-10-13	3D	811	15	1:30 PM	2026-10-08 22:57:19.024+05:30
4	2026-10-08 22:57:19.030022+05:30	2026-10-13	IMAX	812	15	4:30 PM	2026-10-08 22:57:19.028+05:30
5	2026-10-08 22:57:19.033953+05:30	2026-10-13	4DX	813	15	7:30 PM	2026-10-08 22:57:19.033+05:30
2	2026-10-08 22:57:19.042217+05:30	2026-10-14	2D	814	15	10:00 AM	2026-10-08 22:57:19.041+05:30
3	2026-10-08 22:57:19.046227+05:30	2026-10-14	3D	815	15	1:30 PM	2026-10-08 22:57:19.045+05:30
4	2026-10-08 22:57:19.051007+05:30	2026-10-14	IMAX	816	15	4:30 PM	2026-10-08 22:57:19.05+05:30
5	2026-10-08 22:57:19.055165+05:30	2026-10-14	4DX	817	15	7:30 PM	2026-10-08 22:57:19.054+05:30
2	2026-10-08 22:57:19.059536+05:30	2026-10-15	2D	818	15	10:00 AM	2026-10-08 22:57:19.058+05:30
3	2026-10-08 22:57:19.063584+05:30	2026-10-15	3D	819	15	1:30 PM	2026-10-08 22:57:19.062+05:30
4	2026-10-08 22:57:19.067147+05:30	2026-10-15	IMAX	820	15	4:30 PM	2026-10-08 22:57:19.066+05:30
5	2026-10-08 22:57:19.070941+05:30	2026-10-15	4DX	821	15	7:30 PM	2026-10-08 22:57:19.07+05:30
2	2026-10-08 22:57:19.074808+05:30	2026-10-16	2D	822	15	10:00 AM	2026-10-08 22:57:19.074+05:30
3	2026-10-08 22:57:19.078535+05:30	2026-10-16	3D	823	15	1:30 PM	2026-10-08 22:57:19.077+05:30
4	2026-10-08 22:57:19.081411+05:30	2026-10-16	IMAX	824	15	4:30 PM	2026-10-08 22:57:19.08+05:30
5	2026-10-08 22:57:19.083918+05:30	2026-10-16	4DX	825	15	7:30 PM	2026-10-08 22:57:19.083+05:30
2	2026-10-08 22:57:19.086506+05:30	2026-10-17	2D	826	15	10:00 AM	2026-10-08 22:57:19.085+05:30
3	2026-10-08 22:57:19.089135+05:30	2026-10-17	3D	827	15	1:30 PM	2026-10-08 22:57:19.088+05:30
4	2026-10-08 22:57:19.092146+05:30	2026-10-17	IMAX	828	15	4:30 PM	2026-10-08 22:57:19.091+05:30
5	2026-10-08 22:57:19.094453+05:30	2026-10-17	4DX	829	15	7:30 PM	2026-10-08 22:57:19.093+05:30
2	2026-10-08 22:57:19.096631+05:30	2026-10-18	2D	830	15	10:00 AM	2026-10-08 22:57:19.096+05:30
3	2026-10-08 22:57:19.098766+05:30	2026-10-18	3D	831	15	1:30 PM	2026-10-08 22:57:19.098+05:30
4	2026-10-08 22:57:19.100833+05:30	2026-10-18	IMAX	832	15	4:30 PM	2026-10-08 22:57:19.1+05:30
5	2026-10-08 22:57:19.103185+05:30	2026-10-18	4DX	833	15	7:30 PM	2026-10-08 22:57:19.102+05:30
2	2026-10-08 22:57:19.105273+05:30	2026-10-19	2D	834	15	10:00 AM	2026-10-08 22:57:19.104+05:30
3	2026-10-08 22:57:19.108113+05:30	2026-10-19	3D	835	15	1:30 PM	2026-10-08 22:57:19.107+05:30
4	2026-10-08 22:57:19.110736+05:30	2026-10-19	IMAX	836	15	4:30 PM	2026-10-08 22:57:19.11+05:30
5	2026-10-08 22:57:19.112978+05:30	2026-10-19	4DX	837	15	7:30 PM	2026-10-08 22:57:19.112+05:30
2	2026-10-08 22:57:19.115525+05:30	2026-10-20	2D	838	15	10:00 AM	2026-10-08 22:57:19.114+05:30
3	2026-10-08 22:57:19.117945+05:30	2026-10-20	3D	839	15	1:30 PM	2026-10-08 22:57:19.117+05:30
4	2026-10-08 22:57:19.120139+05:30	2026-10-20	IMAX	840	15	4:30 PM	2026-10-08 22:57:19.119+05:30
5	2026-10-08 22:57:19.122276+05:30	2026-10-20	4DX	841	15	7:30 PM	2026-10-08 22:57:19.121+05:30
2	2026-10-08 22:57:19.125195+05:30	2026-10-21	2D	842	15	10:00 AM	2026-10-08 22:57:19.124+05:30
3	2026-10-08 22:57:19.127448+05:30	2026-10-21	3D	843	15	1:30 PM	2026-10-08 22:57:19.126+05:30
4	2026-10-08 22:57:19.129578+05:30	2026-10-21	IMAX	844	15	4:30 PM	2026-10-08 22:57:19.129+05:30
5	2026-10-08 22:57:19.131632+05:30	2026-10-21	4DX	845	15	7:30 PM	2026-10-08 22:57:19.131+05:30
2	2026-10-08 22:57:19.133776+05:30	2026-10-22	2D	846	15	10:00 AM	2026-10-08 22:57:19.133+05:30
3	2026-10-08 22:57:19.135914+05:30	2026-10-22	3D	847	15	1:30 PM	2026-10-08 22:57:19.135+05:30
4	2026-10-08 22:57:19.137937+05:30	2026-10-22	IMAX	848	15	4:30 PM	2026-10-08 22:57:19.137+05:30
5	2026-10-08 22:57:19.140784+05:30	2026-10-22	4DX	849	15	7:30 PM	2026-10-08 22:57:19.14+05:30
2	2026-10-08 22:57:19.147521+05:30	2026-10-10	2D	850	16	10:00 AM	2026-10-08 22:57:19.146+05:30
3	2026-10-08 22:57:19.149775+05:30	2026-10-10	3D	851	16	1:30 PM	2026-10-08 22:57:19.149+05:30
4	2026-10-08 22:57:19.151844+05:30	2026-10-10	IMAX	852	16	4:30 PM	2026-10-08 22:57:19.151+05:30
5	2026-10-08 22:57:19.153869+05:30	2026-10-10	4DX	853	16	7:30 PM	2026-10-08 22:57:19.153+05:30
2	2026-10-08 22:57:19.156301+05:30	2026-10-11	2D	854	16	10:00 AM	2026-10-08 22:57:19.155+05:30
3	2026-10-08 22:57:19.158593+05:30	2026-10-11	3D	855	16	1:30 PM	2026-10-08 22:57:19.158+05:30
4	2026-10-08 22:57:19.160686+05:30	2026-10-11	IMAX	856	16	4:30 PM	2026-10-08 22:57:19.16+05:30
5	2026-10-08 22:57:19.162807+05:30	2026-10-11	4DX	857	16	7:30 PM	2026-10-08 22:57:19.162+05:30
2	2026-10-08 22:57:19.164827+05:30	2026-10-12	2D	858	16	10:00 AM	2026-10-08 22:57:19.164+05:30
3	2026-10-08 22:57:19.166903+05:30	2026-10-12	3D	859	16	1:30 PM	2026-10-08 22:57:19.166+05:30
4	2026-10-08 22:57:19.169032+05:30	2026-10-12	IMAX	860	16	4:30 PM	2026-10-08 22:57:19.168+05:30
5	2026-10-08 22:57:19.171757+05:30	2026-10-12	4DX	861	16	7:30 PM	2026-10-08 22:57:19.171+05:30
2	2026-10-08 22:57:19.175063+05:30	2026-10-13	2D	862	16	10:00 AM	2026-10-08 22:57:19.174+05:30
3	2026-10-08 22:57:19.178084+05:30	2026-10-13	3D	863	16	1:30 PM	2026-10-08 22:57:19.177+05:30
4	2026-10-08 22:57:19.180672+05:30	2026-10-13	IMAX	864	16	4:30 PM	2026-10-08 22:57:19.179+05:30
5	2026-10-08 22:57:19.183024+05:30	2026-10-13	4DX	865	16	7:30 PM	2026-10-08 22:57:19.182+05:30
2	2026-10-08 22:57:19.185114+05:30	2026-10-14	2D	866	16	10:00 AM	2026-10-08 22:57:19.184+05:30
3	2026-10-08 22:57:19.187226+05:30	2026-10-14	3D	867	16	1:30 PM	2026-10-08 22:57:19.186+05:30
4	2026-10-08 22:57:19.189805+05:30	2026-10-14	IMAX	868	16	4:30 PM	2026-10-08 22:57:19.189+05:30
5	2026-10-08 22:57:19.192094+05:30	2026-10-14	4DX	869	16	7:30 PM	2026-10-08 22:57:19.191+05:30
2	2026-10-08 22:57:19.194169+05:30	2026-10-15	2D	870	16	10:00 AM	2026-10-08 22:57:19.193+05:30
3	2026-10-08 22:57:19.197211+05:30	2026-10-15	3D	871	16	1:30 PM	2026-10-08 22:57:19.196+05:30
4	2026-10-08 22:57:19.200358+05:30	2026-10-15	IMAX	872	16	4:30 PM	2026-10-08 22:57:19.199+05:30
5	2026-10-08 22:57:19.202906+05:30	2026-10-15	4DX	873	16	7:30 PM	2026-10-08 22:57:19.202+05:30
2	2026-10-08 22:57:19.206171+05:30	2026-10-16	2D	874	16	10:00 AM	2026-10-08 22:57:19.205+05:30
3	2026-10-08 22:57:19.209619+05:30	2026-10-16	3D	875	16	1:30 PM	2026-10-08 22:57:19.209+05:30
4	2026-10-08 22:57:19.212079+05:30	2026-10-16	IMAX	876	16	4:30 PM	2026-10-08 22:57:19.211+05:30
5	2026-10-08 22:57:19.216075+05:30	2026-10-16	4DX	877	16	7:30 PM	2026-10-08 22:57:19.215+05:30
2	2026-10-08 22:57:19.218192+05:30	2026-10-17	2D	878	16	10:00 AM	2026-10-08 22:57:19.217+05:30
3	2026-10-08 22:57:19.220482+05:30	2026-10-17	3D	879	16	1:30 PM	2026-10-08 22:57:19.219+05:30
4	2026-10-08 22:57:19.222894+05:30	2026-10-17	IMAX	880	16	4:30 PM	2026-10-08 22:57:19.222+05:30
5	2026-10-08 22:57:19.22488+05:30	2026-10-17	4DX	881	16	7:30 PM	2026-10-08 22:57:19.224+05:30
2	2026-10-08 22:57:19.226912+05:30	2026-10-18	2D	882	16	10:00 AM	2026-10-08 22:57:19.226+05:30
3	2026-10-08 22:57:19.22892+05:30	2026-10-18	3D	883	16	1:30 PM	2026-10-08 22:57:19.228+05:30
4	2026-10-08 22:57:19.232285+05:30	2026-10-18	IMAX	884	16	4:30 PM	2026-10-08 22:57:19.231+05:30
5	2026-10-08 22:57:19.236225+05:30	2026-10-18	4DX	885	16	7:30 PM	2026-10-08 22:57:19.235+05:30
2	2026-10-08 22:57:19.240463+05:30	2026-10-19	2D	886	16	10:00 AM	2026-10-08 22:57:19.239+05:30
3	2026-10-08 22:57:19.244301+05:30	2026-10-19	3D	887	16	1:30 PM	2026-10-08 22:57:19.243+05:30
4	2026-10-08 22:57:19.247958+05:30	2026-10-19	IMAX	888	16	4:30 PM	2026-10-08 22:57:19.247+05:30
5	2026-10-08 22:57:19.251399+05:30	2026-10-19	4DX	889	16	7:30 PM	2026-10-08 22:57:19.25+05:30
2	2026-10-08 22:57:19.25504+05:30	2026-10-20	2D	890	16	10:00 AM	2026-10-08 22:57:19.254+05:30
3	2026-10-08 22:57:19.25892+05:30	2026-10-20	3D	891	16	1:30 PM	2026-10-08 22:57:19.258+05:30
4	2026-10-08 22:57:19.262223+05:30	2026-10-20	IMAX	892	16	4:30 PM	2026-10-08 22:57:19.261+05:30
5	2026-10-08 22:57:19.265212+05:30	2026-10-20	4DX	893	16	7:30 PM	2026-10-08 22:57:19.264+05:30
2	2026-10-08 22:57:19.267787+05:30	2026-10-21	2D	894	16	10:00 AM	2026-10-08 22:57:19.267+05:30
3	2026-10-08 22:57:19.270277+05:30	2026-10-21	3D	895	16	1:30 PM	2026-10-08 22:57:19.269+05:30
4	2026-10-08 22:57:19.273104+05:30	2026-10-21	IMAX	896	16	4:30 PM	2026-10-08 22:57:19.272+05:30
5	2026-10-08 22:57:19.275916+05:30	2026-10-21	4DX	897	16	7:30 PM	2026-10-08 22:57:19.275+05:30
2	2026-10-08 22:57:19.27825+05:30	2026-10-22	2D	898	16	10:00 AM	2026-10-08 22:57:19.277+05:30
3	2026-10-08 22:57:19.280359+05:30	2026-10-22	3D	899	16	1:30 PM	2026-10-08 22:57:19.279+05:30
4	2026-10-08 22:57:19.282396+05:30	2026-10-22	IMAX	900	16	4:30 PM	2026-10-08 22:57:19.281+05:30
5	2026-10-08 22:57:19.284687+05:30	2026-10-22	4DX	901	16	7:30 PM	2026-10-08 22:57:19.284+05:30
\.


--
-- Data for Name: User; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."User" ("createdAt", email, id, name, "updatedAt", username, password) FROM stdin;
2026-10-09 02:10:30.270516+05:30	sushanth123@gmail.com	1	Sushanth	2026-10-09 02:10:30.263+05:30	\N	sushanth123
\.


--
-- Name: ledger_id_seq; Type: SEQUENCE SET; Schema: prisma_contract; Owner: postgres
--

SELECT pg_catalog.setval('prisma_contract.ledger_id_seq', 4, true);


--
-- Name: Booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Booking_id_seq"', 59, true);


--
-- Name: Cinema_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Cinema_id_seq"', 6, true);


--
-- Name: Movie_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Movie_id_seq"', 16, true);


--
-- Name: Seat_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Seat_id_seq"', 224, true);


--
-- Name: Show_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."Show_id_seq"', 901, true);


--
-- Name: User_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public."User_id_seq"', 1, true);


--
-- Name: contract contract_pkey; Type: CONSTRAINT; Schema: prisma_contract; Owner: postgres
--

ALTER TABLE ONLY prisma_contract.contract
    ADD CONSTRAINT contract_pkey PRIMARY KEY (core_hash);


--
-- Name: ledger ledger_pkey; Type: CONSTRAINT; Schema: prisma_contract; Owner: postgres
--

ALTER TABLE ONLY prisma_contract.ledger
    ADD CONSTRAINT ledger_pkey PRIMARY KEY (id);


--
-- Name: marker marker_pkey; Type: CONSTRAINT; Schema: prisma_contract; Owner: postgres
--

ALTER TABLE ONLY prisma_contract.marker
    ADD CONSTRAINT marker_pkey PRIMARY KEY (space);


--
-- Name: Booking Booking_bookingId_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_bookingId_key" UNIQUE ("bookingId");


--
-- Name: Booking Booking_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_pkey" PRIMARY KEY (id);


--
-- Name: Cinema Cinema_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema"
    ADD CONSTRAINT "Cinema_name_key" UNIQUE (name);


--
-- Name: Cinema Cinema_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Cinema"
    ADD CONSTRAINT "Cinema_pkey" PRIMARY KEY (id);


--
-- Name: Movie Movie_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Movie"
    ADD CONSTRAINT "Movie_pkey" PRIMARY KEY (id);


--
-- Name: Seat Seat_cinemaId_seatNumber_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_cinemaId_seatNumber_key" UNIQUE ("cinemaId", "seatNumber");


--
-- Name: Seat Seat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_pkey" PRIMARY KEY (id);


--
-- Name: Show Show_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Show"
    ADD CONSTRAINT "Show_pkey" PRIMARY KEY (id);


--
-- Name: User User_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_email_key" UNIQUE (email);


--
-- Name: User User_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."User"
    ADD CONSTRAINT "User_pkey" PRIMARY KEY (id);


--
-- Name: Booking_cinemaId_idx_3adcf06e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Booking_cinemaId_idx_3adcf06e" ON public."Booking" USING btree ("cinemaId");


--
-- Name: Booking_movieId_idx_8cb9f9db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Booking_movieId_idx_8cb9f9db" ON public."Booking" USING btree ("movieId");


--
-- Name: Booking_seatId_idx_3076c3cd; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Booking_seatId_idx_3076c3cd" ON public."Booking" USING btree ("seatId");


--
-- Name: Booking_showId_idx_32b6b4ec; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Booking_showId_idx_32b6b4ec" ON public."Booking" USING btree ("showId");


--
-- Name: Booking_userId_idx_a489d58a; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Booking_userId_idx_a489d58a" ON public."Booking" USING btree ("userId");


--
-- Name: Seat_cinemaId_idx_3adcf06e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Seat_cinemaId_idx_3adcf06e" ON public."Seat" USING btree ("cinemaId");


--
-- Name: Show_cinemaId_idx_3adcf06e; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Show_cinemaId_idx_3adcf06e" ON public."Show" USING btree ("cinemaId");


--
-- Name: Show_movieId_idx_8cb9f9db; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Show_movieId_idx_8cb9f9db" ON public."Show" USING btree ("movieId");


--
-- Name: Booking Booking_cinemaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES public."Cinema"(id);


--
-- Name: Booking Booking_movieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES public."Movie"(id);


--
-- Name: Booking Booking_seatId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_seatId_fkey" FOREIGN KEY ("seatId") REFERENCES public."Seat"(id);


--
-- Name: Booking Booking_showId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_showId_fkey" FOREIGN KEY ("showId") REFERENCES public."Show"(id);


--
-- Name: Booking Booking_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Booking"
    ADD CONSTRAINT "Booking_userId_fkey" FOREIGN KEY ("userId") REFERENCES public."User"(id);


--
-- Name: Seat Seat_cinemaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Seat"
    ADD CONSTRAINT "Seat_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES public."Cinema"(id);


--
-- Name: Show Show_cinemaId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Show"
    ADD CONSTRAINT "Show_cinemaId_fkey" FOREIGN KEY ("cinemaId") REFERENCES public."Cinema"(id);


--
-- Name: Show Show_movieId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Show"
    ADD CONSTRAINT "Show_movieId_fkey" FOREIGN KEY ("movieId") REFERENCES public."Movie"(id);


--
-- PostgreSQL database dump complete
--

\unrestrict DHpsl2XgzJydy6DC4L1n08AusrV02qIlWy7s4smW3eaiaGKhZUhmjTNQBPiPAw2

