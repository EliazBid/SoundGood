--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

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
-- Data for Name: instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instrument (id, brand, availability, name_of_instrument, rental_price) FROM stdin;
1	BrandA	t	Guitar	50
2	BrandB	t	Piano	100
3	BrandC	f	Violin	70
\.


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.category (instrument_id, category) FROM stdin;
1	String
2	Keyboard
3	String
\.


--
-- Data for Name: person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person (id, person_number, first_name, last_name, zip, street, city) FROM stdin;
1	1234567890123	John	Doe	12345	Main St	Anytown
2	9876543210987	Jane	Smith	54321	Broadway	Othertown
3	5678901234567	Alice	Johnson	67890	Oak St	Somewhere
\.


--
-- Data for Name: contact_person; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.contact_person (person_id, email, phone_number) FROM stdin;
1	contact@example.com	111-111-1111
2	info@example.com	222-222-2222
\.


--
-- Data for Name: instructor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instructor (id, teaches_ensemble, person_id) FROM stdin;
1	t	1
2	f	2
3	t	3
\.


--
-- Data for Name: date_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.date_availability (instructor_id, start_time, end_time) FROM stdin;
1	2023-12-05 08:00:00	2023-12-05 10:00:00
3	2023-12-07 14:00:00	2023-12-07 16:00:00
\.


--
-- Data for Name: email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.email (id, email) FROM stdin;
1	email1@example.com
2	email2@example.com
3	email3@example.com
\.


--
-- Data for Name: lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lesson (id, location, time_slot, minimum_enrollment, price, payment, instructor_id) FROM stdin;
1	Studio A	2023-12-05 09:00:00	3	80	1	1
2	Studio B	2023-12-07 15:00:00	2	120	1	3
3	Studio C	2023-12-10 10:00:00	4	90	1	3
\.


--
-- Data for Name: ensemble; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ensemble (lesson_id, target_genre, maximum_enrollment) FROM stdin;
1	Rock	5
2	Classical	8
3	Jazz	6
\.


--
-- Data for Name: skill; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.skill (skill_id, skill_level) FROM stdin;
1	Beginner
2	Intermediate
3	Advanced
\.


--
-- Data for Name: group_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_lesson (lesson_id, skill_id) FROM stdin;
1	2
2	3
3	1
\.


--
-- Data for Name: group_lesson_instrument; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_lesson_instrument (lesson_id, instrument) FROM stdin;
1	Guitar
2	Piano
3	Saxophone
\.


--
-- Data for Name: individual_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.individual_lesson (lesson_id, instrument, skill_id) FROM stdin;
1	Violin	1
2	Piano	3
3	Trumpet	2
\.


--
-- Data for Name: instruments_played; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.instruments_played (instructor_id, instrument) FROM stdin;
1	Guitar
3	Piano
\.


--
-- Data for Name: person_email; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_email (email_id, person_id) FROM stdin;
1	1
2	2
3	3
\.


--
-- Data for Name: person_lesson; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_lesson (person_id, lesson_id) FROM stdin;
1	1
2	2
3	3
\.


--
-- Data for Name: phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.phone (id, phone_number) FROM stdin;
1	123-456-7890
2	987-654-3210
3	555-555-5555
\.


--
-- Data for Name: person_phone; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.person_phone (phone_id, person_id) FROM stdin;
1	1
2	2
3	3
\.


--
-- Data for Name: rental; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rental (id, return_date, person_id, instrument_id) FROM stdin;
1	2023-12-01 00:00:00	1	1
2	2023-11-30 00:00:00	2	2
3	2023-12-03 00:00:00	3	3
\.


--
-- Data for Name: sibling; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sibling (person_id, sibling) FROM stdin;
1	2
\.


--
-- Name: email_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.email_id_seq', 3, true);


--
-- Name: instructor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instructor_id_seq', 3, true);


--
-- Name: instrument_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.instrument_id_seq', 3, true);


--
-- Name: lesson_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lesson_id_seq', 3, true);


--
-- Name: person_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.person_id_seq', 3, true);


--
-- Name: phone_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.phone_id_seq', 3, true);


--
-- Name: rental_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rental_id_seq', 3, true);


--
-- Name: skill_skill_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.skill_skill_id_seq', 3, true);


--
-- PostgreSQL database dump complete
--

