--
-- PostgreSQL database dump
--

\restrict YvcdLnzfzUihNFMw34T4mrsKj9dXV3z8UI9bOkNeXGn2lUJjf9b7JbO99xXdtpt

-- Dumped from database version 18.3 (Homebrew)
-- Dumped by pg_dump version 18.4 (Homebrew)

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
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

SET SESSION AUTHORIZATION DEFAULT;

ALTER TABLE public.categories DISABLE TRIGGER ALL;

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


ALTER TABLE public.categories ENABLE TRIGGER ALL;

--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.employees DISABLE TRIGGER ALL;

COPY public.employees (id, first_name, last_name, email, password, phone, role, created_at) FROM stdin;
3	Пётр	Продавцов	seller@swagsound.ru	$2a$10$YpUzzP0VoR0y.W5F8/z0Yeek6i0GUtT6CiNmOkURJ31Zhglwn/piu	+79003334455	SELLER	2026-05-15 01:05:40.524706
4	Grisha	Kokiev	kokiev2@gmail.com	$2a$10$a4W9xqFCg1oDq6VF3ULs3O2t6QyG7ON8oW32ZNi1ZhiItuoTrqNDi		ADMIN	2026-05-19 16:07:44.704105
5	Ярик	Дотер	kokiev252@gmail.com	$2a$10$83S.Mba.4qZv.ZO5B/gXC.0TLA7UaFp2qWOwfCYjN6LiAp.2iezhW		SELLER	2026-05-20 02:22:34.122819
2	Мария	Менеджерова	manager@swagsound.ru	$2a$10$nuno9XAnbrj9hjKGPMY0EuiKzLoCgNTcLswGfQLDA.3xbOTU2Z3ty	+79002223344	MANAGER	2026-05-15 01:05:40.524706
\.


ALTER TABLE public.employees ENABLE TRIGGER ALL;

--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

ALTER TABLE public.products DISABLE TRIGGER ALL;

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


ALTER TABLE public.products ENABLE TRIGGER ALL;

--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- Name: employees_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.employees_id_seq', 5, true);


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 41, true);


--
-- PostgreSQL database dump complete
--

\unrestrict YvcdLnzfzUihNFMw34T4mrsKj9dXV3z8UI9bOkNeXGn2lUJjf9b7JbO99xXdtpt

