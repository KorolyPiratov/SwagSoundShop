--
-- PostgreSQL database dump
--

\restrict sYez1zoG2AynkGHRs1xiy8IhHlK7C1zlPUfaObWBtkc6HfKV9sCK06mf8ajo1rw

-- Dumped from database version 18.3 (Homebrew)
-- Dumped by pg_dump version 18.4 (Homebrew)

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
-- Name: public; Type: SCHEMA; Schema: -; Owner: swaguser
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO swaguser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: cards; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.cards (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    last_four character varying(4) NOT NULL,
    holder_name character varying(255) NOT NULL,
    expiry character varying(5) NOT NULL,
    card_type character varying(20) NOT NULL,
    card_hash character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cards OWNER TO swaguser;

--
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_id_seq OWNER TO swaguser;

--
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- Name: cart; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.cart (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.cart OWNER TO swaguser;

--
-- Name: cart_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.cart_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_id_seq OWNER TO swaguser;

--
-- Name: cart_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.cart_id_seq OWNED BY public.cart.id;


--
-- Name: cart_items; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.cart_items (
    id bigint NOT NULL,
    cart_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.cart_items OWNER TO swaguser;

--
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.cart_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cart_items_id_seq OWNER TO swaguser;

--
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    parent_id bigint
);


ALTER TABLE public.categories OWNER TO swaguser;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_id_seq OWNER TO swaguser;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: customers; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.customers (
    id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    phone character varying(20),
    created_at timestamp without time zone DEFAULT now(),
    password character varying(255)
);


ALTER TABLE public.customers OWNER TO swaguser;

--
-- Name: customers_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customers_id_seq OWNER TO swaguser;

--
-- Name: customers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.customers_id_seq OWNED BY public.customers.id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.employees (
    id bigint NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    email character varying(255) NOT NULL,
    password character varying(255) NOT NULL,
    phone character varying(20),
    role character varying(20) NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.employees OWNER TO swaguser;

--
-- Name: employees_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.employees_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_id_seq OWNER TO swaguser;

--
-- Name: employees_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.employees_id_seq OWNED BY public.employees.id;


--
-- Name: favorites; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.favorites (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    product_id bigint NOT NULL,
    created_at timestamp without time zone DEFAULT now()
);


ALTER TABLE public.favorites OWNER TO swaguser;

--
-- Name: favorites_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.favorites_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.favorites_id_seq OWNER TO swaguser;

--
-- Name: favorites_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.favorites_id_seq OWNED BY public.favorites.id;


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


ALTER TABLE public.flyway_schema_history OWNER TO swaguser;

--
-- Name: order_items; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.order_items (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL,
    quantity integer NOT NULL,
    unit_price numeric(10,2) NOT NULL
);


ALTER TABLE public.order_items OWNER TO swaguser;

--
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO swaguser;

--
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.orders (
    id bigint NOT NULL,
    customer_id bigint NOT NULL,
    employee_id bigint,
    status character varying(20) DEFAULT 'NEW'::character varying NOT NULL,
    total_amount numeric(10,2) NOT NULL,
    order_date timestamp without time zone DEFAULT now()
);


ALTER TABLE public.orders OWNER TO swaguser;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.orders_id_seq OWNER TO swaguser;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.orders_id_seq OWNED BY public.orders.id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.payments (
    id bigint NOT NULL,
    order_id bigint NOT NULL,
    amount numeric(10,2) NOT NULL,
    method character varying(20) NOT NULL,
    status character varying(20) DEFAULT 'PENDING'::character varying NOT NULL,
    paid_at timestamp without time zone
);


ALTER TABLE public.payments OWNER TO swaguser;

--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_id_seq OWNER TO swaguser;

--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.payments_id_seq OWNED BY public.payments.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: swaguser
--

CREATE TABLE public.products (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    stock_quantity integer DEFAULT 0 NOT NULL,
    category_id bigint,
    created_at timestamp without time zone DEFAULT now(),
    image_url character varying(500)
);


ALTER TABLE public.products OWNER TO swaguser;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: swaguser
--

CREATE SEQUENCE public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.products_id_seq OWNER TO swaguser;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: swaguser
--

ALTER SEQUENCE public.products_id_seq OWNED BY public.products.id;


--
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- Name: cart id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart ALTER COLUMN id SET DEFAULT nextval('public.cart_id_seq'::regclass);


--
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: customers id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.customers ALTER COLUMN id SET DEFAULT nextval('public.customers_id_seq'::regclass);


--
-- Name: employees id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.employees ALTER COLUMN id SET DEFAULT nextval('public.employees_id_seq'::regclass);


--
-- Name: favorites id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.favorites ALTER COLUMN id SET DEFAULT nextval('public.favorites_id_seq'::regclass);


--
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- Name: orders id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
-- Name: payments id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.payments ALTER COLUMN id SET DEFAULT nextval('public.payments_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.products ALTER COLUMN id SET DEFAULT nextval('public.products_id_seq'::regclass);


--
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.cards (id, customer_id, last_four, holder_name, expiry, card_type, card_hash, created_at) FROM stdin;
3	7	0000	FHHFJSDJSDHG	00/00	OTHER	$2a$10$BmSXbw2HKoMhJ53eG.6pnOOW4kAPMUM8VcpoLvVYkfxWmboLsHVIu	2026-05-20 05:03:20.734835
\.


--
-- Data for Name: cart; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.cart (id, customer_id, created_at) FROM stdin;
\.


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.cart_items (id, cart_id, product_id, quantity) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.categories (id, name, description, parent_id) FROM stdin;
1	Гитары	Акустические и электрогитары	\N
2	Клавишные	Синтезаторы и пианино	\N
3	Ударные	Барабаны и перкуссия	\N
4	Аксессуары	Струны, медиаторы, стойки	\N
5	Акустические	Акустические гитары	1
6	Электрогитары	Электрогитары	1
7	Синтезаторы	Синтезаторы	2
8	Пианино	Цифровые пианино	2
\.


--
-- Data for Name: customers; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.customers (id, first_name, last_name, email, phone, created_at, password) FROM stdin;
1	Иван	Иванов	ivan@mail.ru	+79001234567	2026-05-18 02:24:17.918008	\N
2	Диана	Русаловская	rus@swag.com	+799998887766	2026-05-18 03:41:39.003742	\N
3	Grisha	Kokiev	kokiev252525@gmail.com	+89998887766	2026-05-18 14:19:23.07729	\N
5	Умар	Шабазов	umar@mail.ru	+79957779501	2026-05-18 14:55:06.756313	\N
6	Равиль	Свегер	Rav@mail.ru	+79001112233	2026-05-19 11:03:58.545449	$2a$10$1Ul17F7TeHIH9sw3zLAqJOXp7UC2DF0svFH8/ha1HIuGoWAEZ.Lr6
7	Диана	Русаловская	kokiev25@gmail.com	+79001112233	2026-05-19 11:18:25.224928	$2a$10$9eNfBR8c678089HG/RfSGeOtk33qPacOj54qq7y6D62EgXPk2D8y2
8	igor	gore	igor@mail.ru	+89998887766	2026-05-19 16:31:31.940759	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.employees (id, first_name, last_name, email, password, phone, role, created_at) FROM stdin;
3	Пётр	Продавцов	seller@swagsound.ru	$2a$10$YpUzzP0VoR0y.W5F8/z0Yeek6i0GUtT6CiNmOkURJ31Zhglwn/piu	+79003334455	SELLER	2026-05-15 01:05:40.524706
4	Grisha	Kokiev	kokiev2@gmail.com	$2a$10$a4W9xqFCg1oDq6VF3ULs3O2t6QyG7ON8oW32ZNi1ZhiItuoTrqNDi		ADMIN	2026-05-19 16:07:44.704105
5	Ярик	Дотер	kokiev252@gmail.com	$2a$10$83S.Mba.4qZv.ZO5B/gXC.0TLA7UaFp2qWOwfCYjN6LiAp.2iezhW		SELLER	2026-05-20 02:22:34.122819
2	Мария	Менеджерова	manager@swagsound.ru	$2a$10$nuno9XAnbrj9hjKGPMY0EuiKzLoCgNTcLswGfQLDA.3xbOTU2Z3ty	+79002223344	MANAGER	2026-05-15 01:05:40.524706
\.


--
-- Data for Name: favorites; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.favorites (id, customer_id, product_id, created_at) FROM stdin;
7	7	2	2026-05-20 23:29:22.869795
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	init schema	SQL	V1__init_schema.sql	-1804421519	swaguser	2026-05-15 01:05:40.4529	55	t
2	2	seed data	SQL	V2__seed_data.sql	-1124670208	swaguser	2026-05-15 01:05:40.521127	4	t
3	3	add customer auth	SQL	V3__add_customer_auth.sql	38314164	swaguser	2026-05-19 10:52:52.438686	31	t
4	4	add cards	SQL	V4__add_cards.sql	1952145099	swaguser	2026-05-20 04:52:55.431185	20	t
5	5	add product image	SQL	V5__add_product_image.sql	-1810708654	swaguser	2026-05-20 21:18:29.16828	14	t
\.


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.order_items (id, order_id, product_id, quantity, unit_price) FROM stdin;
1	1	1	1	89999.00
2	1	3	2	15999.00
3	2	4	1	55000.00
4	9	2	10	120000.00
5	10	4	1	55000.00
6	26	2	1	120000.00
7	27	5	6	45000.00
8	30	3	3	15999.00
9	32	1	1	89999.00
10	33	4	1	55000.00
11	34	1	2	89999.00
12	35	3	1	15999.00
13	36	1	1	89999.00
14	37	4	1	55000.00
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.orders (id, customer_id, employee_id, status, total_amount, order_date) FROM stdin;
10	3	\N	PAID	55000.00	2026-05-18 16:31:15.55247
26	3	\N	PAID	120000.00	2026-05-18 16:34:34.415979
27	3	\N	PAID	270000.00	2026-05-18 16:36:28.882859
32	7	\N	PAID	89999.00	2026-05-19 16:24:36.375434
1	1	\N	CANCELLED	121997.00	2026-05-18 02:24:31.16717
34	7	\N	PAID	179998.00	2026-05-20 04:28:51.805081
36	7	\N	PAID	89999.00	2026-05-20 04:55:02.591716
37	7	\N	PAID	55000.00	2026-05-20 12:43:32.232333
35	7	\N	PAID	15999.00	2026-05-20 04:32:18.599358
30	7	\N	PAID	47997.00	2026-05-19 16:11:02.082366
9	5	\N	PAID	1200000.00	2026-05-18 14:56:34.19394
2	3	\N	PAID	55000.00	2026-05-18 14:19:23.121727
33	8	\N	PAID	55000.00	2026-05-19 16:31:31.956643
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.payments (id, order_id, amount, method, status, paid_at) FROM stdin;
1	1	121997.00	CARD	PAID	2026-05-18 02:25:00.76786
2	9	1200000.00	CASH	PAID	2026-05-18 14:57:28.547899
3	2	55000.00	ONLINE	PAID	2026-05-18 14:57:41.38506
4	10	55000.00	CARD	PAID	2026-05-18 16:32:08.982038
5	26	120000.00	CARD	PAID	2026-05-18 16:34:45.017652
6	27	270000.00	CARD	PAID	2026-05-18 16:36:46.516165
7	32	89999.00	ONLINE	PAID	2026-05-19 23:38:49.529093
8	34	179998.00	ONLINE	PAID	2026-05-20 04:28:51.844753
10	36	89999.00	ONLINE	PAID	2026-05-20 04:55:02.608647
11	37	55000.00	ONLINE	PAID	2026-05-20 12:43:32.253527
13	30	47997.00	CASH	PAID	2026-05-20 20:14:28.552878
16	33	55000.00	CARD	PAID	2026-05-20 20:15:12.769936
\.


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: swaguser
--

COPY public.products (id, name, description, price, stock_quantity, category_id, created_at, image_url) FROM stdin;
26	Kawai ES120	Пианино с молоточковой механикой	52000.00	4	8	2026-05-20 05:40:17.069481	/uploads/product_26_1779311702428-019e473d-798a-763c-81ff-435c197ff540.jpeg
18	Squier Classic Vibe 70s	Доступная версия легендарного Telecaster	28000.00	6	6	2026-05-20 05:40:17.068654	/uploads/product_18_1779307396098-019e46fb-a930-7a2e-9186-8ec34dd1f4ae.jpg
14	Epiphone DR-100	Бюджетная акустическая гитара для новичков	99999.00	12	5	2026-05-20 05:40:17.061786	/uploads/product_14_1779305675146-019e46e1-927a-7061-8475-367fb7dea8d7.jpg
2	Gibson Les Paul	Легендарная электрогитара	120000.00	0	6	2026-05-15 01:05:40.524706	/uploads/product_2_1779307122385-019e46f7-a55b-755d-89a0-bd3b4b502c66.jpg
11	Fender CD-60S	Акустическая гитара с массивной верхней декой	22500.00	6	5	2026-05-20 05:40:17.061786	/uploads/product_11_5.jpg
12	Taylor Academy 10	Гитара для начинающих от легендарного бренда	38000.00	4	5	2026-05-20 05:40:17.061786	/uploads/product_12_4.jpg
16	PRS SE Custom 24	Гитара с широким диапазоном звучания	65000.00	5	6	2026-05-20 05:40:17.068654	/uploads/product_16_1779308254126-019e4708-c274-7544-9cc1-bf96b9326298.jpg
29	Korg B2	Пианино с естественно взвешенными клавишами	32000.00	7	8	2026-05-20 05:40:17.069481	/uploads/product_29_1779311197965-019e4735-d1d2-79b3-b87d-faef9f5fb09b.jpeg
3	Yamaha F310	Акустическая гитара для начинающих	15999.00	4	5	2026-05-15 01:05:40.524706	/uploads/product_3_2.jpg
13	Seagull S6 Original	Канадская акустика с кедровой декой	42000.00	3	5	2026-05-20 05:40:17.061786	/uploads/product_13_3.jpg
15	Gibson SG Standard	Классическая гитара с двойным рогом	135000.00	2	6	2026-05-20 05:40:17.068654	/uploads/product_15_1779307563876-019e46fe-2809-773b-bc78-8846d8c53214.jpg
10	Yamaha FG800	Народная акустическая гитара с ситкинской елью	18999.00	8	5	2026-05-20 05:40:17.061786	/uploads/product_10_1779305476694-019e46de-68fe-740f-bd35-ec04affbbd3f.jpg
17	Ibanez RG350DXZ	Скоростная гитара для металла и шреддинга	35000.00	7	6	2026-05-20 05:40:17.068654	/uploads/product_17_1779307726975-019e4700-e5aa-7bf4-93c1-cc5b7d5962a5.jpg
22	Moog Subsequent 25	Аналоговый синтезатор с легендарным звуком	145000.00	2	7	2026-05-20 05:40:17.069194	/uploads/product_22_1__1_.jpg
1	Fender Stratocaster	Классическая электрогитара	89999.00	0	6	2026-05-15 01:05:40.524706	/uploads/product_1_1779306618593-019e46ef-faad-7acd-8036-b148ca9b4152.jpg
19	ESP LTD EC-1000	Профессиональная гитара с активными датчиками	89000.00	3	6	2026-05-20 05:40:17.068654	/uploads/product_19_1779306725222-019e46f1-aacb-7bc8-a7a8-b57b483002f5.jpg
23	Yamaha MODX6	Синтезатор с FM и AWM2 движками	98000.00	3	7	2026-05-20 05:40:17.069194	/uploads/product_23_1779310374635-019e4729-4d8a-7956-a641-e98128f9311e.jpeg
24	Novation Bass Station II	Монофонический аналоговый синтезатор	48000.00	5	7	2026-05-20 05:40:17.069194	/uploads/product_24_1779310149046-019e4725-c607-7409-a73a-c41de4f039de.jpeg
21	Arturia MiniFreak	Полифонический гибридный синтезатор	62000.00	3	7	2026-05-20 05:40:17.069194	/uploads/product_21_1779310061515-019e4724-2e46-7855-a530-fff4602a0d6a.jpeg
20	Roland JD-Xi	Гибридный аналогово-цифровой синтезатор	55000.00	4	7	2026-05-20 05:40:17.069194	/uploads/product_20_1779310675361-019e472d-e7ac-7542-bb1e-0c5f248c7f07.jpeg
5	Korg Minilogue	Аналоговый синтезатор	45000.00	0	7	2026-05-15 01:05:40.524706	/uploads/product_5_1779310749628-019e472f-1773-78e9-ac1b-dc4f6b409098.jpeg
28	Nord Piano 4	Концертное пианино премиум класса	280000.00	2	8	2026-05-20 05:40:17.069481	/uploads/product_28_1779311338867-019e4738-03c2-7e87-a98b-5fb2155d2cca.jpeg
4	Roland FP-30	Цифровое пианино 88 клавиш	55000.00	0	8	2026-05-15 01:05:40.524706	/uploads/product_4_1779311444150-019e4739-a72b-73a2-9400-fe483f8d2102.jpeg
25	Yamaha P-125	Компактное цифровое пианино 88 клавиш	45000.00	5	8	2026-05-20 05:40:17.069481	/uploads/product_25_1779311533188-019e473a-f4c0-7d06-ac8b-3c8604816f94.jpeg
27	Casio PX-S3100	Тонкое пианино с 700 тембрами	38000.00	6	8	2026-05-20 05:40:17.069481	/uploads/product_27_1779311923907-019e4740-f817-787c-99a9-9ea4a92ddf4e.jpeg
36	Dunlop Tortex медиаторы	Набор из 12 медиаторов разной жёсткости	450.00	50	4	2026-05-20 05:40:17.070082	/uploads/product_36_1779313023402-019e4751-b970-7993-83a8-e5de8187e2af.jpeg
37	Ernie Ball Regular Slinky	Струны для электрогитары 010-046	850.00	40	4	2026-05-20 05:40:17.070082	/uploads/product_37_1779313582727-019e475a-5098-72c3-a51d-9ca79f8f41c7.jpg
39	Hercules GS415B	Стойка для гитары с авто-захватом	3500.00	15	4	2026-05-20 05:40:17.070082	/uploads/product_39_1779314249445-019e4764-5a57-7ed3-ad36-e77f1e58b413.jpeg
38	D'Addario EJ16	Струны для акустической гитары 012-053	950.00	35	4	2026-05-20 05:40:17.070082	/uploads/product_38_1779314155896-019e4762-e52e-72af-92c0-d35d9617691f.jpeg
40	Boss TU-3	Хроматический педальный тюнер	8500.00	12	4	2026-05-20 05:40:17.070082	/uploads/product_40_1779313960601-019e475f-ed5e-789e-9ce3-3241f492f2e2.jpg
41	Planet Waves уход за грифом	Набор для чистки и полировки гитары	1200.00	25	4	2026-05-20 05:40:17.070082	/uploads/product_41_1779314661537-019e476a-8651-71aa-9e77-e64107093bb6.jpeg
33	Meinl Cymbals HCS	Комплект тарелок для начинающих	12000.00	10	3	2026-05-20 05:40:17.069779	/uploads/product_33_1779315074000-019e4771-0991-7fb2-b46a-e1d048ca98fe.jpeg
35	Yamaha DTX432K	Компактная электронная установка	65000.00	4	3	2026-05-20 05:40:17.069779	/uploads/product_35_1779315575363-019e4778-af22-758f-813c-ef296d4d3f56.jpeg
31	Roland TD-07DMK	Электронная ударная установка	89000.00	2	3	2026-05-20 05:40:17.069779	/uploads/product_31_1779315685026-019e477a-6b85-77c9-bd00-a938ad0a6d93.jpeg
30	Pearl Export EXX	Полная ударная установка для начинающих	55000.00	3	3	2026-05-20 05:40:17.069779	/uploads/product_30_1779316118798-019e4780-0125-752f-891a-6da8fcfa0780.jpeg
34	DW Design Series	Ударная установка премиум класса	180000.00	1	3	2026-05-20 05:40:17.069779	/uploads/product_34_1779314861034-019e476d-c294-7b46-8121-6f1a371fd6ca.jpeg
32	Tama Imperialstar	Профессиональная акустическая установка	75000.00	2	3	2026-05-20 05:40:17.069779	/uploads/product_32_1779315497077-019e4777-4aad-7988-8c69-c32c4032b373.jpeg
\.


--
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.cards_id_seq', 3, true);


--
-- Name: cart_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.cart_id_seq', 1, false);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 1, false);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- Name: customers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.customers_id_seq', 8, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.employees_id_seq', 5, true);


--
-- Name: favorites_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.favorites_id_seq', 7, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.order_items_id_seq', 14, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.orders_id_seq', 37, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.payments_id_seq', 16, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: swaguser
--

SELECT pg_catalog.setval('public.products_id_seq', 41, true);


--
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- Name: cart cart_customer_id_key; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_customer_id_key UNIQUE (customer_id);


--
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- Name: cart cart_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: customers customers_email_key; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_email_key UNIQUE (email);


--
-- Name: customers customers_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.customers
    ADD CONSTRAINT customers_pkey PRIMARY KEY (id);


--
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (id);


--
-- Name: favorites favorites_customer_id_product_id_key; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_customer_id_product_id_key UNIQUE (customer_id, product_id);


--
-- Name: favorites favorites_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: payments payments_order_id_key; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_key UNIQUE (order_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: swaguser
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: cards cards_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: cart cart_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart
    ADD CONSTRAINT cart_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.cart(id);


--
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: categories categories_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.categories(id);


--
-- Name: favorites favorites_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: favorites favorites_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.favorites
    ADD CONSTRAINT favorites_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: order_items order_items_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: order_items order_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- Name: orders orders_customer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_customer_id_fkey FOREIGN KEY (customer_id) REFERENCES public.customers(id);


--
-- Name: orders orders_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(id);


--
-- Name: payments payments_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(id);


--
-- Name: products products_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: swaguser
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id);


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: user
--

ALTER DEFAULT PRIVILEGES FOR ROLE "user" IN SCHEMA public GRANT ALL ON TABLES TO swaguser;


--
-- PostgreSQL database dump complete
--

\unrestrict sYez1zoG2AynkGHRs1xiy8IhHlK7C1zlPUfaObWBtkc6HfKV9sCK06mf8ajo1rw
DO $$ BEGIN
  IF NOT EXISTS (SELECT FROM pg_roles WHERE rolname = 'user') THEN
    CREATE ROLE "user";
  END IF;
END $$;
