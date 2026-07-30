-- Generato da scripts/audit-eea-tvv-continuity.mjs.
-- Contiene soltanto intervalli nuovi, non gia accorpati dalla potenza esatta.

COPY mvp.eea_historical_display_ranges_v1 (
  range_id,
  seed_model_id,
  brand,
  model,
  year_from,
  year_to,
  fuel_type,
  hybrid_type,
  display_power_cv,
  minimum_tvv_coverage,
  member_count,
  thermal_consumption_min,
  thermal_consumption_max,
  electric_consumption_min,
  electric_consumption_max,
  confidence,
  source_name,
  source_url
) FROM stdin;
eea_tvv_range_60395b8e5f4c1e8db40b6927	7	Alfa Romeo	Giulia	2017	2019	petrol	none	200	0.7918	3	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5aef52621f6d70e8c6d32b26	7	Alfa Romeo	Giulia	2018	2020	diesel	none	210	0.9209	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	10	Audi	A1	2014	2017	petrol	none	124	1	6	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1d03ec58f7824f6366c938c8	10	Audi	A1	2015	2016	petrol	none	84	1	2	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_26fb6fbb8abe0650ab66f280	99	Audi	A3	2013	2015	petrol	none	124	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2f6d9ae6acd9074439fb1266	136	Audi	A8	2013	2017	diesel	none	260	1	7	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4627fd59d6a2ee2cfec23148	89	Audi	Q5	2011	2013	petrol	none	271	1	3	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_474987bcfb8e7a10c1c9349e	38	BMW	1 Series	2019	2021	petrol	none	138	0.9331	4	5.6	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a8bfdf6b3a155b7767b10c33	98	BMW	2 Series	2018	2019	petrol	none	138	0.9537	2	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d740b8c411bb20e8ac68cc2f	14	BMW	3 Series	2011	2012	diesel	none	203	0.8	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02439da09670aa4d10f0874a	64	BMW	5 Series	2011	2014	diesel	none	202	0.75	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6d4916b2b8c27420eec09114	57	BMW	X1	2019	2021	petrol	none	138	0.9246	4	5.4	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b11e8aa882a96a730d578f5a	9	BMW	X2	2018	2021	petrol	none	139	0.8604	5	5.6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_77e930e6a41efaed2131fcf7	194	Citroen	Berlingo	2011	2015	diesel	none	113	0.7273	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	92	Citroen	C1	2012	2019	petrol	none	69	0.7368	11	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	16	Citroen	C3	2011	2013	diesel	none	91	0.7083	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f8743bab5c4230e4315b9fc9	16	Citroen	C3	2012	2014	diesel	none	113	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6655a00a3c62232d5a939640	16	Citroen	C3	2016	2019	petrol	none	82	0.8	5	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e23e6f6d8642d30010323c86	16	Citroen	C3	2016	2019	diesel	none	100	0.75	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee00b9eb6cb9856d86a75813	54	Citroen	C3 Aircross	2018	2020	diesel	none	101	1	5	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_75127c19c6086b5d85294f1f	54	Citroen	C3 Aircross	2018	2019	petrol	none	83	1	3	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c61df263ace92e65c34a076	82	Citroen	C4	2011	2015	diesel	none	113	0.7273	7	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b4e7d841ff0ad94ddad303bb	95	Citroen	C4 Picasso	2011	2012	diesel	none	110	0.8085	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_41dde69ec2bd01304ddd2961	95	Citroen	C4 Picasso	2013	2019	diesel	none	118	0.7879	10	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	145	Citroen	C5	2011	2015	diesel	none	113	1	6	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_311ebf69301475fec5bf02cb	67	Dacia	Duster	2011	2017	diesel	none	109	0.7333	13	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_974d0249b65f60742ca9f138	67	Dacia	Duster	2014	2015	lpg	none	104	1	2	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a2cf46c582d7e9ac2927d6da	67	Dacia	Duster	2019	2022	diesel	none	115	0.771	6	4.3	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_17b77d51d8995dff8a745491	149	Dacia	Lodgy	2012	2019	diesel	none	108	0.7407	10	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_259e0bbadc7e15bcb6d151f9	119	Dacia	Logan	2011	2015	diesel	none	89	0.7692	7	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4287a69d88a83076f80d98cd	119	Dacia	Logan	2011	2013	lpg	none	83	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38aa482787a7ab62e182b767	119	Dacia	Logan	2011	2012	petrol	none	85	1	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3709a34d72c84d7162d6d703	119	Dacia	Logan	2013	2015	lpg	none	74	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_339c3efda01206410a85f130	119	Dacia	Logan	2014	2015	petrol	none	74	0.8571	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7cb86e141acf1a62fa23c379	68	Dacia	Sandero	2011	2014	diesel	none	89	0.9091	6	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fe32ff0cfffd58c229e9192b	68	Dacia	Sandero	2014	2017	petrol	none	74	0.8421	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02f248cdbf099188f64174f8	68	Dacia	Sandero	2014	2015	lpg	none	74	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2adcd06e5d9cc06214133ba0	85	Fiat	500	2011	2015	petrol	none	85	0.9	8	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b1976e7409ec42570867e758	85	Fiat	500	2013	2015	petrol	none	103	0.7975	4	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c037c75c52b3442f460b5846	85	Fiat	500	2014	2016	diesel	none	76	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d8606a060e74dedb91c89081	88	Fiat	500X	2015	2017	petrol	none	139	0.8696	4	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ae406e6179efa3eeafc23b75	88	Fiat	500X	2019	2022	petrol	none	150	0.8816	5	5.9	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e98d4e557390049ac531704a	18	Fiat	Panda	2012	2017	petrol	none	86	0.7857	11	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_620cfced874bf2dd6c510036	58	Fiat	Punto	2011	2015	petrol	none	68	0.8304	8	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a110b590ebdfe68515a11a0	150	Fiat	Qubo	2012	2014	petrol	none	74	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a99f9840940fb9f20325132e	56	Fiat	Tipo	2019	2021	petrol	none	96	0.942	4	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	185	Ford	B-Max	2012	2018	petrol	none	103	0.7308	13	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b8e4e9a76a131007a9163aa7	176	Ford	C-Max	2011	2019	diesel	none	118	0.732	11	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68dc824b0a3c598a4c21d996	176	Ford	C-Max	2011	2016	petrol	none	103	1	7	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	96	Ford	Fiesta	2011	2017	diesel	none	73	0.7727	10	3.5	3.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bcd08b1667780fbdd35aa82d	96	Ford	Fiesta	2011	2015	petrol	none	101	0.75	9	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_654d6c8205214589e951be40	96	Ford	Fiesta	2011	2014	petrol	none	81	0.7813	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3e5ce6836ad254cec5d4cc04	96	Ford	Fiesta	2015	2017	petrol	none	81	0.75	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a8a32eb5317af04d2eaeb443	96	Ford	Fiesta	2017	2021	petrol	none	73	0.7441	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dab00250fdf1c19313482d09	61	Ford	Focus	2011	2018	diesel	none	118	0.7326	12	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_46d4d1eda91a56a9cb272522	61	Ford	Focus	2011	2014	petrol	none	103	0.7778	6	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2e810533cf760faa40ea99ac	52	Ford	Kuga	2011	2015	diesel	none	139	0.9091	5	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0c9efe9e5aff611d5098c378	52	Ford	Kuga	2014	2016	diesel	none	118	0.8333	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d5225cadde5eb8370f6caeff	52	Ford	Kuga	2022	2024	petrol	hybrid	152	0.8645	4	5.1	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fc4f446efa3f7d29bd45ac75	164	Ford	Mondeo	2012	2016	diesel	none	117	0.7059	6	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_350fc92884b00b617bae8537	164	Ford	Mondeo	2017	2018	petrol	none	163	1	2	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	200	Ford	Mustang	2018	2021	petrol	none	291	0.8281	4	9	9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2f7e2437e124e82a385fff10	200	Ford	Mustang	2021	2024	petrol	none	448	0.7826	5	11.3	12.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0ca31f504852a28e0fb8b8c8	186	Ford	S-Max	2018	2019	petrol	none	163	1	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c3f84c69e6369b89efc8d9c7	76	Hyundai	i10	2011	2022	petrol	none	68	0.7	14	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_923ddabb5d2d439d985de53b	76	Hyundai	i10	2023	2024	petrol	none	66	0.9995	3	5.1	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_51842b9b01c626365c99cae5	307	Hyundai	i30	2012	2018	petrol	none	100	0.7105	9	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ca997e9f6e05950b1c225434	314	Hyundai	Ioniq 5	2021	2022	electric	electric	73	1	3	\N	\N	16.8	17.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f7512dfa6d425ce2784f9769	44	Jeep	Renegade	2019	2022	petrol	none	150	0.7263	5	5.9	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	318	Kia	Ceed	2012	2017	petrol	none	100	0.7143	7	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cdce12a12268c97f28303552	318	Kia	Ceed	2019	2021	lpg	none	100	0.9976	4	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_daefa926387cd565c9f84c5c	318	Kia	Ceed	2020	2021	petrol	none	100	0.9718	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_37ed148a7389ff4b35e88be6	101	Kia	Picanto	2023	2024	petrol	none	66	0.9934	3	5.1	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3f32eda92652669e360df934	215	Kia	Rio	2012	2016	petrol	none	85	0.8	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_361c2f4383be5d4cf773ba0b	1	Lancia	Ypsilon	2011	2015	petrol	none	85	1	7	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6fe7492008c05b1f436dcfbc	256	Land Rover	Range Rover Sport	2011	2012	diesel	none	246	1	3	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a719fe65f74c25b09e83df2e	296	Mazda	3	2011	2019	petrol	none	102	0.7	10	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a04896489d6c50307c6942e4	279	Mazda	6	2011	2014	diesel	none	177	0.8636	5	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c15cfd1988b3db87797b265e	279	Mazda	6	2017	2022	petrol	none	194	1	6	6.5	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_58a3f63301e0f25f57e9c546	219	Mazda	CX-3	2017	2019	petrol	none	121	0.8889	4	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0bde2d27bd065fb942fa18f4	222	Mazda	CX-5	2014	2016	petrol	none	163	0.75	6	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_785450072dcb1a57a9d5a2cb	295	Mazda	MX-5	2016	2020	petrol	none	131	0.75	7	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6340b81761ba6a066b1b3671	30	Mercedes-Benz	A-Class	2023	2024	petrol/electric	plug_in_hybrid	162	0.9989	3	6	6	17.1	18.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_665e402e72979657bbc39347	81	Mercedes-Benz	B-Class	2023	2024	petrol/electric	plug_in_hybrid	162	0.9826	3	6.1	6.1	17.4	18.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7116268db5091f1f0e99593c	104	Mercedes-Benz	C-Class	2013	2015	diesel	none	118	1	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c6a980d82aa86b8b6970aa55	84	Mercedes-Benz	CLA	2022	2024	petrol/electric	plug_in_hybrid	162	0.9783	4	6.2	6.3	15.3	18	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59fa1128f1dd4a81571c093c	80	Mercedes-Benz	GLA	2023	2024	petrol/electric	plug_in_hybrid	162	1	3	6.8	6.8	18.1	19.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68e7d3109a70d0c0469c420d	201	Mercedes-Benz	GLE	2020	2023	diesel/electric	plug_in_hybrid	195	0.8715	5	6.4	6.4	26.5	28.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_48ec7b43dea9218d9797b2fd	218	Mitsubishi	ASX	2013	2019	diesel	none	115	0.7143	9	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_757f3717a0e3dba8a826c688	66	Nissan	Juke	2011	2022	petrol	none	116	0.7	21	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_51e414e2cc1974a20ec984da	66	Nissan	Juke	2015	2017	petrol	none	215	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4303482c02f8ddae1f2a02f8	28	Nissan	Micra	2017	2021	petrol	none	91	0.7839	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_687bbdd942d9af15b7883122	28	Nissan	Micra	2020	2023	lpg	none	91	0.9971	5	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0e0ffeccf38a903828ddf6fd	148	Nissan	Note	2011	2012	diesel	none	88	1	2	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_559b6eaaae506bc499bb3563	53	Nissan	Qashqai	2011	2014	petrol	none	116	0.8125	5	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e0d9ea241db8d09795dbd47a	53	Nissan	Qashqai	2019	2021	petrol	none	159	0.9621	3	5.5	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2c9c3f679381cac1598e8257	183	Nissan	X-Trail	2018	2019	petrol	none	161	1	2	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7d9fe4e71ca55a0acd3866fa	183	Nissan	X-Trail	2020	2022	petrol	none	159	0.7421	4	6.4	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_393460d8e624c0cc477da99e	151	Opel	Adam	2013	2018	petrol	none	88	0.8679	10	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_eab82410a2a63290cb341141	169	Opel	Agila	2011	2015	petrol	none	68	1	6	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_73ca051a6b522c74e1e2018a	48	Opel	Astra	2011	2014	petrol	none	118	0.8	5	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e5b03d53ea2f05ffb08d553a	48	Opel	Astra	2012	2014	diesel	none	163	0.8571	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	48	Opel	Astra	2015	2018	petrol	none	104	0.8615	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_04d3f30c184f1c25dacd3e81	48	Opel	Astra	2019	2020	petrol	none	148	1	2	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	15	Opel	Corsa	2011	2014	petrol	none	87	0.7204	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a1e212a15cfb7fd0d708690d	157	Peugeot	108	2015	2019	petrol	none	70	0.7857	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	102	Peugeot	2008	2015	2021	diesel	none	101	0.8	8	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_52116adf0c63104421d10a95	102	Peugeot	2008	2018	2019	petrol	none	83	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3b350087301e33cd15058cee	105	Peugeot	208	2015	2019	diesel	none	100	0.75	6	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e656e276f25b572581f5f2c4	105	Peugeot	208	2017	2019	petrol	none	83	0.8	4	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_88fb2c885612239a85baaddc	87	Peugeot	3008	2011	2015	diesel	none	113	0.88	7	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2f654bf35da7bc1e1df9331	87	Peugeot	3008	2016	2020	diesel	none	179	0.8752	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_85971cbb19569e2a15d7aff9	51	Peugeot	308	2012	2018	diesel	none	116	0.7143	13	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_669af85fe64e0605a1224b68	51	Peugeot	308	2015	2019	diesel	none	100	0.7012	6	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0376bb285f6ad39ce74a94e8	51	Peugeot	308	2015	2017	diesel	none	180	1	4	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4bee0f86234b7dbd8536b465	40	Peugeot	5008	2011	2014	diesel	none	113	0.7674	6	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2a30dccae59deaccf7aa557	40	Peugeot	5008	2018	2020	diesel	none	178	0.7555	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68243d18a3fd622cab76d223	107	Peugeot	Partner	2011	2016	diesel	none	91	0.7	9	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_48433074bc1a43216a967bdb	107	Peugeot	Partner	2011	2015	diesel	none	112	0.7826	8	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1a584ca50aecc7da95473899	77	Renault	Captur	2013	2017	petrol	none	119	1	7	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d20657a78815a2e94a5f5ee1	6	Renault	Clio	2011	2021	diesel	none	88	0.7364	15	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_99ed4627729f7fde82c3f5bc	6	Renault	Clio	2011	2014	petrol	none	74	0.7115	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_afca1500d011b0a54f1fd0b0	6	Renault	Clio	2011	2012	petrol	none	102	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c5396cbd34b0fa3228e43ef	6	Renault	Clio	2012	2017	lpg	none	73	0.8333	8	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee2aa8ff2288250d841851d7	6	Renault	Clio	2013	2017	petrol	none	119	1	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_80d0ce3c49fbaaa4c0904154	6	Renault	Clio	2015	2021	petrol	none	74	0.7971	9	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02d57f2ad1ecb9326eb7965a	6	Renault	Clio	2020	2022	petrol	none	66	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bf4f845e4e81e29a8f6368c4	123	Renault	Kangoo	2011	2015	diesel	none	109	0.7895	6	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_64c40eebe417efbfdc364a3d	123	Renault	Kangoo	2011	2012	diesel	none	89	0.9375	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_047c81ee7a7828f26c10c052	26	Renault	Megane	2011	2013	petrol	none	131	0.8537	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	26	Renault	Megane	2012	2013	diesel	none	162	1	2	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b91f1ad326d18e33799c688d	179	Renault	Modus	2011	2013	petrol	none	103	0.7778	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3ca128b74722127bd3f4bca0	27	Renault	Twingo	2014	2022	petrol	none	69	0.9413	14	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d8409f3e3e794d2717c71355	27	Renault	Twingo	2018	2020	petrol	none	91	0.9972	4	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e0ed180f4aaa34686852446c	120	Renault	Zoe	2017	2019	electric	electric	90	0.7273	6	\N	\N	13.3	14.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_060eab61f56173ecbed3c2da	71	Seat	Ibiza	2014	2017	petrol	none	88	0.9375	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	36	Seat	Leon	2014	2016	petrol	none	124	0.9	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_13374503e601cc823d5524f9	41	Skoda	Fabia	2014	2017	petrol	none	88	0.75	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fcfa89654ad250e22a423b28	223	Skoda	Superb	2018	2020	diesel	none	121	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7a255b5be155a44519487280	240	Suzuki	Jimny	2011	2018	petrol	none	85	0.75	10	6.8	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7658befce6581ea88d7aafa1	63	Tesla	Model 3	2019	2020	electric	electric	210	0.8549	4	\N	\N	13.2	13.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_805f5b1c828eeb99a5eb5522	63	Tesla	Model 3	2022	2023	electric	electric	210	0.7265	4	\N	\N	13.2	13.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c314eb91005a3f446b8d8965	286	Tesla	Model S	2019	2020	electric	electric	243	0.8889	4	\N	\N	17.5	17.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c2bcaee26b58a35889240c54	225	Tesla	Model X	2019	2021	electric	electric	243	1	5	\N	\N	19.1	19.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_29d1a4f35d58e622b4dd9364	83	Tesla	Model Y	2022	2023	electric	electric	210	0.9883	4	\N	\N	15.7	15.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	147	Toyota	Auris	2012	2013	diesel	none	125	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2a5498533f84aa8ab75824e	124	Toyota	Avensis	2011	2013	diesel	none	125	0.8	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ddec42aa3efd253bc3d17a82	86	Toyota	Aygo	2013	2014	petrol	none	69	0.9375	2	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4889bb6723fb0a18a3f15b8e	86	Toyota	Aygo	2016	2019	petrol	none	70	0.7368	5	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a7c84c6b4c9a49b25ecb9d01	134	Toyota	Verso	2013	2014	diesel	none	125	0.75	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_da341fdd8155dd711b988db6	55	Toyota	Yaris	2017	2019	petrol	none	71	0.7619	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_10a936c429c05cdb98bcd673	202	Volkswagen	Caddy	2014	2016	petrol	none	85	1	4	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_40672c0c94857aefca0088f3	202	Volkswagen	Caddy	2023	2024	petrol	none	115	0.9583	3	6.6	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_83ced3db4202e310ba851f54	100	Volkswagen	Golf	2014	2016	petrol	none	124	0.9231	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2ddf3bbdc18538a5b3de5055	74	Volkswagen	Passat	2013	2017	petrol	none	124	0.75	5	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_875c7ffb98c648352078455d	74	Volkswagen	Passat	2020	2021	diesel	none	121	1	2	4	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2d396b1671f9e0fa1b594ae4	59	Volkswagen	Polo	2011	2017	petrol	none	88	0.75	10	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bcde49674783397645a53d96	5	Volkswagen	Tiguan	2014	2017	petrol	none	124	0.8571	6	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c467f1a50571bfa1d11d1a9d	72	Volkswagen	Up!	2018	2022	electric	electric	83	0.8	5	\N	\N	11.7	12.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_335be9fc901d1f0a152c232d	285	Volvo	C40	2023	2024	electric	electric	409	0.7778	2	\N	\N	17.5	17.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0355ac59f0d7576bfb0e1443	220	Volvo	S60	2013	2015	petrol	none	151	1	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e4c0dd8895125c5a54c24373	237	Volvo	V40	2012	2017	petrol	none	151	1	6	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3d41e0d33039a7a4bb8b9018	237	Volvo	V40	2013	2017	petrol	none	121	1	6	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_373aa7f4b2ab593107b925e7	262	Volvo	V60	2013	2017	petrol	none	151	1	6	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5b57841b9ca0dccdbfff958a	247	Volvo	XC60	2017	2019	petrol	none	251	0.7143	3	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_75aa7c985fcedba80ba8b190	244	Volvo	XC90	2017	2018	petrol	none	252	1	2	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
\.

COPY mvp.eea_historical_display_range_members_v1 (
  range_id,
  historical_version_id
) FROM stdin;
eea_tvv_range_60395b8e5f4c1e8db40b6927	eea_hist_3f0cf2a6c23f03d7ca6523db
eea_tvv_range_60395b8e5f4c1e8db40b6927	eea_hist_cc631c0a910580015cd55711
eea_tvv_range_60395b8e5f4c1e8db40b6927	eea_hist_145ee2301ae151c8e2d44fe5
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_0e286274585228a6de51edfa
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_67783415046721b30aa20d24
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_fcac44552ae8cd4ca88de384
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_fcd8d1a591c150f32400b7f2
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_f75e6c552a74eea147ce6c72
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_8c38fb1d570091ab17892e8a
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_145a4bc9c9fe87aa0c9699e5
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_167fb5d40b27ff0aec6755de
eea_tvv_range_f5887ea2b7b813ae00cc5f6c	eea_hist_e2b563f7e02374c2d918b4c9
eea_tvv_range_1d03ec58f7824f6366c938c8	eea_hist_b33da03d2f83006d8e25b06e
eea_tvv_range_1d03ec58f7824f6366c938c8	eea_hist_48945fe2c2710fb2eb29451e
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_a83a4018fd8be4ad3dcb582b
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_66b6effb1d7ced8126e3774b
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_9005687cfc9c545a42d58e0a
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_36ac611a82388a602b21e4e4
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_4f51cf417cb2d20d3a33fd39
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_ca18ec417ae77fd318d365ea
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_e63f8b5f0a490e3d3b76cc8b
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_f8c9e0cf75ecb3762820b2d4
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_6a80643c0cfe5c6a117896b9
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_6e859ee5c8db5874f7fa6018
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_324d3dc4467101eaa30c9246
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_2b4ff320556ad29715ac257f
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_9ff4c6a3a77a319bfb3237fb
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_1be181d03ad03cd42bb0bd35
eea_tvv_range_474987bcfb8e7a10c1c9349e	eea_hist_4a4adaf04f0a66a087906ffd
eea_tvv_range_474987bcfb8e7a10c1c9349e	eea_hist_0eb4c91138fb1c961e987043
eea_tvv_range_474987bcfb8e7a10c1c9349e	eea_hist_a17341e3cf3ea038e49d04c1
eea_tvv_range_474987bcfb8e7a10c1c9349e	eea_hist_477a7db1aa0dd285ebf25d8e
eea_tvv_range_a8bfdf6b3a155b7767b10c33	eea_hist_a328f29579ad29368909646d
eea_tvv_range_a8bfdf6b3a155b7767b10c33	eea_hist_92984ac8f2da5721f6065c7f
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_4cc1f053504e71ed32f25e3a
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_e98c3f093beeb52009bbf709
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_e91e966cf89c7fb83c42aec7
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_34ac4ee0d2a907c6d5029321
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_974b5a40f5144b0aee04a923
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_51993f0c04ddc88803c13c50
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_f9de3a9054a57ac88431d8c2
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_3e7b4b6feafb21b93c317436
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_311603413727461c9c28e7e9
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_be4a39dec4e8d93d8671bc95
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_7bb43bc205827f43c8416dff
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_d94f3bf0c8a3b8a4e012ed2c
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_0a7e3dc5984d05c9baba1724
eea_tvv_range_b11e8aa882a96a730d578f5a	eea_hist_46011f472e48202bf587eafc
eea_tvv_range_b11e8aa882a96a730d578f5a	eea_hist_219c2ae08c64cdbb7d16874d
eea_tvv_range_b11e8aa882a96a730d578f5a	eea_hist_86d84943384e03c506cbd832
eea_tvv_range_b11e8aa882a96a730d578f5a	eea_hist_d50e3a75e855394347a65fea
eea_tvv_range_b11e8aa882a96a730d578f5a	eea_hist_0a917f5808d925b859debb05
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_6d0fd816a44fbb6e380702ed
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_558db80529fc0a65bd44fe1e
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_5f43c439333d8f981aa16416
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_9dffc7fe7a2e469e216d96da
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_c210db3ab65492f202a2306d
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_c30d2ae46b6d80013d5b9e1c
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_369bd901ee6c26c24eee9f95
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_42cc9a1f0dfd0583b2849e09
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_b1ce10921a32a082e4ec5aa2
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_ab4cd52e7ebc58ae90e326e7
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_8c655ad5d89baca5213eb6aa
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_0bd37ae04d0da24cb5cd5c08
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_03cd59df0fb24f21da47d2ea
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_1ac65eae12771d9201ab021f
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_85a9cd230bc417023677df92
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_a531705eafda3630af37a80a
eea_tvv_range_b339aaffdbe9d4b35a9b8dbc	eea_hist_b01d0e2458f0128424a70153
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_92f00b32ae13aa98e5f6d386
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_f9955e53e99af8beb1481f14
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_ac612754973441a4b97cc0b7
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_d39a3c89183d26e9d34435ec
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_77575bfd717eccab8c6c3b75
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_c5afd3eda3688bb6435c4c83
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_622992e2ce8dfa0850a53a52
eea_tvv_range_6655a00a3c62232d5a939640	eea_hist_d38acb8ac9c6a2e7f0f98e84
eea_tvv_range_6655a00a3c62232d5a939640	eea_hist_6fb80c45e4ff7bb76fd74667
eea_tvv_range_6655a00a3c62232d5a939640	eea_hist_5d96ca04d7bc8ed5e329b6b9
eea_tvv_range_6655a00a3c62232d5a939640	eea_hist_30f562c243ec5353e09a1a04
eea_tvv_range_6655a00a3c62232d5a939640	eea_hist_316964e54d1835a0a856f8c2
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_99f133769ee2418a6b9b677c
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_2e2b187af754d2d971d94110
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_272e2e615f80fc1730968fae
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_1b1f6f152346c8034eebec8f
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_be25fa0af61fe02ef64bec5b
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_875223fec2cc46f7215190ce
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_dee736c604d657e559bcc237
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_c909ba4a63a6b9fe00defb2f
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_b00fdb9bc72bc4f4ec7ed3ac
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_4ac139ff0dcd4de22fbf82a9
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_2c4d0a72cf5e74ef5d9ac86d
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_b83c7e5e74b7d9b0576ec763
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_420a4d299de9f75b67c6dc3c
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_6183f3e6dd067a7255b0be7d
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_9a175887a44efe3b9e183c58
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_613abb88b2b064996edc790e
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_e0388fa7e5e65b732ae190d2
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_440af561aef86c0dcd7b86b6
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_ab8953e4858fa6c1e4b41155
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_8246057a23e933ce7001c2ec
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_e5c6e82498757b3da1314d97
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_ba9e5b64befa319ad69b78db
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_22ad587f278b76e5871a1332
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_1c0a3b95477338bf54a20306
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_00884fbb4e0578e9ce3caad3
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_d4a6798e6d73994fde2f5faa
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_93b279ed317a286efd06acf2
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_c26125fb09225c4e60bee2c6
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_2780ff980c30c989978dba01
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_967171c56bfaea9b52d5069e
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_490444b9e8f091682b5894a2
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_1233742464932afc52cbbef6
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_17912ef9a72d00cdc685d463
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_c85cd22c967a8e57a9114ab3
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_29398cb55e883450c1a5826b
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_174a94f3498f2645367cbf5f
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_98a81016ea25d43a99c9197d
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_38599bfc173f28f0d9e2a85d
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_c0ec31bf413e3af384d0b029
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_6b6227efcf00f4f3593f3428
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_36ca52fe963e15fc5603181d
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_08f17be18872f6931a6bc52c
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_4d6e292b270f243d3de1a313
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_f52836c26eb6bdde7b978d8e
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_914636878874deeac6bd3c13
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_d58304bd803c57e7c449f3c3
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_08e5bb188e3c3ce25d8d6018
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_a42778d47dee55ed0db7ef3b
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_00e59194b58e98e489f1c9cb
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_a2b23b58e2bbb0993802a6ed
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_2900fa60ba0a4fcc94f27548
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_96c413fe20a8128562caae18
eea_tvv_range_974d0249b65f60742ca9f138	eea_hist_d50b08635dfc9d8f1f35165e
eea_tvv_range_974d0249b65f60742ca9f138	eea_hist_92720d641ae769a70a7d95df
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_7199389830168c6baa9f26d4
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_7d441acdc84f36a3734a0a3a
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_1a08ba898ede7fa0d5fd3e5e
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_894e1b24856c9c3f0a7e92ce
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_4d09102ec280cb408e435ddb
eea_tvv_range_a2cf46c582d7e9ac2927d6da	eea_hist_044e3c95d40241f1412a0bab
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_538bf6a80a498a725e805a2f
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_1dac0955b36d2bfc07b89e95
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_31a55eb79d3a325b4f9ad709
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_89aa640c8b8923bfcf4c3c59
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_b5e47b4165e1a449f1d26983
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_cda91b0a8b62acd08e82064e
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_b63f658b121f0ea7628d39d8
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_9f89f7e18a1556323d99c03f
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_851bc790b866825fbd646728
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_ced2a737a3478683ef61ac4e
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_78a94840d886a1c4d8e87ec3
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_6d178be58d3f76af5fc8d9b2
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_aec33f1b470f54f281cebf59
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_380955b0709adc0bcf51e239
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_462484e665fe6428bca31f13
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_fd1ee3c1eb8360ca9da5cd4e
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_70b20d78377dc25ee1c35503
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_530e0621c7851af45a85f4f0
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_522dead5f2d6dc7e6d980a65
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_829bdf49d3431e8519ca0214
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_042a4d8765f57c8787dab2e2
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_dfd2050ba3c88de425d79ede
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_37687c80c826a6f1215e1a28
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_16a9f06aa69f29bc9bb0c3dd
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_e27c46529289494db915fe84
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_669bbe8b614c6cebf5860955
eea_tvv_range_339c3efda01206410a85f130	eea_hist_52dbbf2a6f5c9f2d813c29c3
eea_tvv_range_339c3efda01206410a85f130	eea_hist_c3585e2ae33c4bec1efa6f0e
eea_tvv_range_339c3efda01206410a85f130	eea_hist_a235e27ce12f848020af60c3
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_4087a02b11f59e3d13e6a1cf
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_78aca96875216df35f743151
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_b8d78ca5dc8295aa31115211
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_efb63e13cafe1f3d7379fc1a
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_98de38843862364ebdd82906
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_538b426d7566a1630c82714e
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_25b4340a61066c2fa259ed09
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_75f5a6932e64ff5bf9884838
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_eaec5a7c51fc0352777d9dd1
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_478af6d8bef8d5d6f24b5064
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_12220e61b6a346ae9e9297ea
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_0a0c408549e5bcb4943b980d
eea_tvv_range_02f248cdbf099188f64174f8	eea_hist_1f9e8fdc4f2c53e70ffa88d7
eea_tvv_range_02f248cdbf099188f64174f8	eea_hist_70d6a9f52c42579b19fc36cc
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_24ebea2c53a3d7f56bb0090d
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_72b703e77474b8b66152b77e
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_cb2c5206ea1cb85a2d656873
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_770db33df5518bd18b4f59b1
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_512f1758b5383670de4bd218
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_544eafd0d059f73a49e25773
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_ce1a200d57f223b5456c8748
eea_tvv_range_2adcd06e5d9cc06214133ba0	eea_hist_edbe26a33dcf5021bec16a53
eea_tvv_range_b1976e7409ec42570867e758	eea_hist_995a84aa384f9db7b6184ab0
eea_tvv_range_b1976e7409ec42570867e758	eea_hist_548b184ca27ea2ccceab85b3
eea_tvv_range_b1976e7409ec42570867e758	eea_hist_e1c6206c6e87383cf0e454ff
eea_tvv_range_b1976e7409ec42570867e758	eea_hist_72bb602c6af6ea8909a24020
eea_tvv_range_c037c75c52b3442f460b5846	eea_hist_fa1f489ab4870b40d29e58ce
eea_tvv_range_c037c75c52b3442f460b5846	eea_hist_e0818e5ba31e9405bb81b36a
eea_tvv_range_c037c75c52b3442f460b5846	eea_hist_819558e1890d069c731ab8f1
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_d06654e52c53973471706e9b
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_393e4fb988e975e6cd1955d2
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_389653b1e37a0491b8f90876
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_c63e019733d107abb7b5a78b
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f839564d0071a7b75859f6da
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f08b44bfeb33e1696c892194
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f24bce5ecf285b9aa2757330
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_568b48ae00c162beeb599766
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_42c7d9c36dbe8465b686f385
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_a1747498457ea8b54e7db94d
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_d979eb77c04f0e7a33e84975
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_91000d1eedb8ef44b8ff212e
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_28428b1a0c0fea4bc27326e4
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_5b3752a37d8bb4eb071cd955
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_e3edb52c98c2da1ddeecf423
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_95245c767278e71e1e5115e7
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_516092183bcd2d3b82c8bcc2
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_1bfce224ff1bfdb8b1a4abc2
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_5ee11db9244bfe75bd5fdc05
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_29fee27d108ec6dcb1da7581
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_6b7a86427f6917c3b0a026ae
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_03dc19c642e73a56f9ee4c6c
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_cb21a1450acfba3cfbe4346b
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_fd91aa3033dd7273feee7b92
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_d29bb9f8008629f85a7187c7
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_fcfd088adc767a3fc6037849
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_cdfbdfca76726e8cd6b5a9a8
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_a6f2de41c5a8e3ce1e10674f
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_fb5bcdb368887498a6e6ec2d
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_5d02fa64a6dc18f0acf4e1c6
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_d804cb5483f2186dd5943c0c
eea_tvv_range_a99f9840940fb9f20325132e	eea_hist_aef7ef9e34cf767c73d6229f
eea_tvv_range_a99f9840940fb9f20325132e	eea_hist_4db9598b7246569d1d9da50b
eea_tvv_range_a99f9840940fb9f20325132e	eea_hist_203298b54fdc336d3f6baab9
eea_tvv_range_a99f9840940fb9f20325132e	eea_hist_3f52eadf0c5ddd250fb36482
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_a17f2c47e0e414c29f2d872e
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_821911d9495a44a3be9288f1
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_2a307b04fc6122cfe303416f
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_ef0c9b78c102e774374b4ab1
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_bf45761b45d28b2133947364
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_09e0e39e9a3a7a8e62e1000a
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_c08380997ca2687afaef58f7
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_93df6f3b0eead6ab5417c0e5
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_a5b0346b08079504eb6c3679
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_35732b852e0162cebad020e4
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_d800dfc1b059d81e363431bb
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_0655a42477f0618d24968c68
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_467f903961921d179adda708
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_1d9e88207ef2e62996368a43
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_036f4aedfbb4afda67b382bd
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_4bc21afd962bada0b7d83d70
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_1236ae2a935a4cbc3c84a203
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_c1e8efa68ccd9ae92bfdc9b6
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_485b3dc55b10fc0bfde06525
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_bc051aa81a037d970fd26a2b
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_e600ed1290f609f0906dd97c
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_d4097bf4bc5a764823ecc2e6
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_4c47c0bd2d35c7e7b87253d6
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_9235df873ac76e8dfc8d7533
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_fe900a0bbebccbece8b122b4
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_13280f13c94e376700715479
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_74cdbe73e155b5357c5e18b3
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_1d469ec73466d1fa2e57c0e6
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_78a7b3281f557d6da72eccf7
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_5ee8a78b882753fb4769b1f9
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_0ac87de9851c290a037217ff
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_9dc568616ae50287715bf937
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_31b86adefa0004f2327416b0
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_dd2b859aff338c6701204954
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_ec0f0d854822d2916538bfb8
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_98b95d4127fbe72bcfb6b8b5
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_f3371a6e235488a9835db338
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_75f4f596f93016963b8367e2
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_d12f9928ffb4d37beabe2e01
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_3848d65115b072e404206c5c
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_6ad117ead871679d451af848
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_7df9f8f876032ea62ef57713
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_744454debed67b9dc513e5c0
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_c5d35b37a46b86b594e1bc51
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_f786ec97a1ef8276647e8342
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_1315ecdc1e086a2e3e14d13a
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_902c4aca7b3583770e2b8278
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_e5c9ffe306d62d8a3541bd89
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_7d8778b470befeb48fc0726a
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_31a2e14087497dc86ef0b5d6
eea_tvv_range_654d6c8205214589e951be40	eea_hist_f69454d71a6dba20d9169275
eea_tvv_range_654d6c8205214589e951be40	eea_hist_6c78db5f64412c86cd501c9b
eea_tvv_range_654d6c8205214589e951be40	eea_hist_365fb3cf2e86166a51884b40
eea_tvv_range_654d6c8205214589e951be40	eea_hist_7b13ad247c686badc44dda17
eea_tvv_range_654d6c8205214589e951be40	eea_hist_d90388dc8ea6b25c1772805d
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_97fdbb4cd3512ba6c809af66
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_a5e2b5574cb268cf4a113238
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_449c350695b0e4d7eea30115
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_1d037ff0bf20bc411e0cef13
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_5f49a765c7380e0ae161b928
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_6014f081e5dad9632149f4b5
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_678caed63f1569bd4aa8db8f
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_3749d0a723c9e8f6ffcaa21f
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_7042d39d384aebf3c7c3e9ef
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f5fa759c1409cdcb0fd213f4
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_ac6d13d7232494c317d8686f
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f667d905f12e1f05f2c82ef5
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_1c6418d752aa07c82c9416e3
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_4ff5a286c9fbf97ec046f527
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_80f855a601476366251831a0
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_c577a46daf6f7d695f53bab0
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_6de7ff4ab8f33d8e0ca04875
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_5bd4fa7513fde1275576da46
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_23c46f3c1b3e8cb1d72f2691
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_3613a3ea8ef204c31b2a1355
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f60906e87da76603b1d1b7ce
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_3ddaaf8f8b30a7824e2afe47
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_7551a28541425e3ffd7bf507
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_bc4890f11ea5319c76d91b3a
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_c3fa3f49c78955d8e1d8158d
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_3db522257d8d03a13910045a
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_c33391e31656a34d55f93f00
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_08c8aff30c3042ab1d9d0f06
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_4e7857d7418ba25c3f3f89c0
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_d1fc0ec5c526a6e544f4455f
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_783180bfbb52cce139f28148
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_d114a8a1bc0021aae8a25acb
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_34f570d6507dae4848477661
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_3ea6f549309983c9a9fe33ca
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_2f82846f352960ca584e0274
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_432db1d3b036fb654b370516
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_e84e1d520cac9fd585556c03
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_4bf54af900f38e39ba04eb71
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_a2d43cc3b82d3940a87ed0e2
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_9bae53470e5bcce0e55496cf
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_95450df0372f115456477e12
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_3bfde5c21fcfdfc3ecdfd337
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_f589786b4fb4de2586663ad9
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_674404ce1904fbaab6323296
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_2c272d7e960d8752cfa86b1a
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_c43ff8163606eefe8e586a48
eea_tvv_range_350fc92884b00b617bae8537	eea_hist_6085d2da6dc554c83481a5ce
eea_tvv_range_350fc92884b00b617bae8537	eea_hist_b27d37a52140c44edee85e35
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_ad93e936f0ad6255a8d8aa78
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_7d963da7b1578ba49a29acfe
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_78efd10ae1ef6495826fa1a7
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_a990450f100e51679cf5334b
eea_tvv_range_2f7e2437e124e82a385fff10	eea_hist_0cf76268906d180f81bfaaf9
eea_tvv_range_2f7e2437e124e82a385fff10	eea_hist_61d609e95b4cb3c1daef762e
eea_tvv_range_2f7e2437e124e82a385fff10	eea_hist_7afefedb138af53bc3f42326
eea_tvv_range_2f7e2437e124e82a385fff10	eea_hist_b5b92f9f2f927cfa1285803c
eea_tvv_range_2f7e2437e124e82a385fff10	eea_hist_970f72cc591cb0b33d0fb885
eea_tvv_range_0ca31f504852a28e0fb8b8c8	eea_hist_5ad00882f90d07cc1dc280d6
eea_tvv_range_0ca31f504852a28e0fb8b8c8	eea_hist_6ec3d6c9cfbee0173e9b534e
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_51f3f292a9450ced4c1e96d0
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_b99e5cecf95372538c7c1fcc
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_331719ac5526e8193749a3c3
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d0889d2ebad5d364f3e58f45
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_2b1c55df8042ca9f443a8a23
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_3481548cb5d50e8fe7df46b2
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_99d434989c8d4dde0cdc28a5
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_bd084f7cec2c1d787fa25aa9
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_284a7b71d2460a0baf355cdb
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d1e8543cdef6b6703f0dc571
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d535dba59679dd8df6d9dd5e
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_df0efe7d42d98532b76d3516
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_e370bb67b1439b683664d6bf
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_f3a02ae5a816b7e292d8f06d
eea_tvv_range_923ddabb5d2d439d985de53b	eea_hist_bcdc5bf3eac9df3fff2915f2
eea_tvv_range_923ddabb5d2d439d985de53b	eea_hist_a4dd014a3bd1d2ec52eaf4b2
eea_tvv_range_923ddabb5d2d439d985de53b	eea_hist_ce9d81b5b7ab8b35efa543a9
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_c250c072b73fbf99d56b994b
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_26497c95f9f7935f46af0880
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_a97e0b73ce3fcf5b2b3ffad2
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_33fc841dbe557b218cc68e51
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_894405077e4177db8ec60ffb
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_f4aa4db8867857e26996d856
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_0eee8f47302ff0b7a5e1df10
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_53f7cf0b5df636ca093521c2
eea_tvv_range_51842b9b01c626365c99cae5	eea_hist_9be6561c2724700dcaa74ca4
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_34a0dd3a0561cd85851cd4e0
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_7f8f8fccb7854dd6941bcad7
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_96d059c1fcdc8b5f0e4ea1d7
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_b26cc6ef5dadb15a816f0cf2
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_97243597a8f0bf14f6f81393
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_8016913958886579714e767a
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_7b345e88a92d9b73b9b21585
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_872423e846d87edd86e5444e
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_0da117f2344306277fbd2c1b
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_a8f81b6e2c2a1a26da361414
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_fdec54594726b57725bb25cc
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_10a877189d7331bf1a8849c0
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_d451fc23010a9cb6b4ae9b1b
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_6e8e102b62370a9318c14a03
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_6b0eb7139f69fdf1e0b284eb
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_d7801068ee15c0cce82fdc9f
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_249e631423b5d729464aa53c
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_66d870e257a7dd724a20dd92
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_d9d1bec9171142253ac37f0d
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_ca563c55fba2c38627af5609
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_6fb7ded38190650516e99662
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_5d018713a7e0cdc48422541e
eea_tvv_range_37ed148a7389ff4b35e88be6	eea_hist_7b9f45fdc367c1db05bfb0a3
eea_tvv_range_37ed148a7389ff4b35e88be6	eea_hist_805ec969fa2db340fc23b817
eea_tvv_range_37ed148a7389ff4b35e88be6	eea_hist_df63eb2b53e8d78f08bf264f
eea_tvv_range_3f32eda92652669e360df934	eea_hist_aff4e89562c9227777c25167
eea_tvv_range_3f32eda92652669e360df934	eea_hist_3a7ee4b6783b24c0decf53fc
eea_tvv_range_3f32eda92652669e360df934	eea_hist_f25689707286cd7f5970c241
eea_tvv_range_3f32eda92652669e360df934	eea_hist_5bb15d3fd1694ef0edb15e90
eea_tvv_range_3f32eda92652669e360df934	eea_hist_dff969a57a7e3f2db5c52200
eea_tvv_range_3f32eda92652669e360df934	eea_hist_8786a3d1f5732a664a55b77b
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_589d143536fb3083ab337efd
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_c350eec0750bc93cd340085f
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_d3c74f5b0ae0d52903b3a1ee
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_8cc70a65112d531bf6038057
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_ef6d1802437ad8ff65ca9a17
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_29c184bd3005cadd4f0c9779
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_1afef27174e1ebde6e613818
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_6a8e3c9e86c9fcb5d3878d6c
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_30a76bd32cf44a1f4d4f2a6a
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_fc584a656ba888eeca3b0ea1
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_287fd4d5bb9a0d81ca9053e8
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_007e28a7cd4cd02686c4f88b
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_0aeb5bf0ffe3609cea8fd9ab
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_f01d1bced1525e01f7c62f4f
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_f8b0e39be4b0b2302f141bcb
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_72694e33b2e8b0fc5cb554d9
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_835893ddfadadf83ef687de5
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_0a0ed3796bdbf1028b9efd14
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_33d7c06c771b484dd9e10270
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_93421e616e9903cb611141b3
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_dc247bcb54f182c2b488641d
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_e47eee3d61e9abcd540cf9ad
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_ca5210b0647280081fcdfe08
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_f353cc822aebf657a79b9d32
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_d96214563c558055eb62d99d
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_30cfec02de21e9c30fb3db99
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_80b0a1225434c86c63336334
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_dfa3f3e18cb05ea1445d24d3
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_17994d1ec2c34314f568b382
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_616a409af9f57808fed5be22
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_9dd18af51019bef46d20d99a
eea_tvv_range_58a3f63301e0f25f57e9c546	eea_hist_beaf0a1dd99852ef6d0be176
eea_tvv_range_58a3f63301e0f25f57e9c546	eea_hist_eb36ff603908aea80e9b61f8
eea_tvv_range_58a3f63301e0f25f57e9c546	eea_hist_2be58e33ba69814e4a9a73bd
eea_tvv_range_58a3f63301e0f25f57e9c546	eea_hist_598b12446626a93c141b1036
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_8b5634639e7f470aa7796078
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_d113fb0a743f06551cb41ed4
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_9fa8d0d1babe636e8959feba
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_14008bd5bcf1aae7dff7a740
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_412956fe464fc58fc9900986
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_e882a83ae603e8e558a0c461
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_0d933193c20f3d712b55c9b3
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_e13b9a2ce5a91a613538204f
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_fe2510ae18a180ce85bc460b
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_1bd22433526d26ae7374bbc4
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_d8d76d0c4dc158afb404f25a
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_b51860dc593c9739a7ed63a9
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_b0744e2b997294bea79ef665
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_9919d5c510b661936d40dce4
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_3350328c312099be2460a8ac
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_7de358a937b4bfc6e00d9f7b
eea_tvv_range_665e402e72979657bbc39347	eea_hist_ed055af22794be51b0f86860
eea_tvv_range_665e402e72979657bbc39347	eea_hist_a04bc29e146bacd0e882e956
eea_tvv_range_665e402e72979657bbc39347	eea_hist_8b8b94d0c0fe4f5f62e5fd32
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_a726e706602e0cc915568030
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_d4788cfdbd36c00cb7523b63
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_55f7204a2616744b65bd9b02
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_e3c0f0e69fe49453072bdeef
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_ab3ce4be8d489f153f00da9d
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_be9747306572e9de33ddc3c3
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_22e55eb1c8bef75e925ccd9c
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_d86f1f9e708c54d3e7c182a4
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_e0d5e9055e1e502fb1faf2b3
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_e624375f48fba46fe4e95626
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_3eca0039c8cbd5117a52c7d5
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_06bebd96391f57c24ffa466d
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_c7ce3571e594a21953a777d6
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_266f1c5c131bbc5140226625
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_67719ac08142c9ca5adf3d36
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_208758c648cf149a4835ad8d
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_94fb4ef86661b0d43493809b
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_00dab6dabd1685ec04631441
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_63f49d531756e1bd5f6fcdd0
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_e950192e62d110c1fffb42b4
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_c67ff276b144beac8a251109
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_f8e5e5775748ca4f4564e244
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_374409292dcb2102222ba693
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_27cf1b2e6bab36edbd3f6b2d
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_e5f0f2d9fdcc9377704bd8e3
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7ce5a54779acbdd56d3e5c1b
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_6e0af0c90d2f3e77099395f4
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_d7042e14ff1a8841e54e3913
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_44e09e02c7462823ad55ca8e
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_0be3e3c5a5811bf6ddd1c087
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_bb5edc8a459a386832471dd0
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7a3fb54c90722187493a2276
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_cea0fbc7d8db071578190321
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_eca9b6e92def37cfa958500b
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_ae10161a286c3d581f22ea44
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_2aabdce848571f1be3c88295
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_5c7b4c62a7691f962e21a2ff
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_c3ab697e79247335858b2616
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_0581a89c327bd0cb0a6a039a
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_551474f6476ac38ec092e266
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_17141dca5c61db549324f6cc
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_32588dd47b34acd4c91ce8cc
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7b91aae36fffb9fb7554a62c
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_e1c65ce14da1b4480349493c
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_08a640381d828a852b5f170b
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_e2d8c2a4ed6a985219af7be0
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_77843368d2696f01b7c227fc
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_3baf2800c57ea9441d711cb3
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_546a9d551edeba73d16eb864
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_fcbb79e52102ab12695c97ed
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_70b41e54ca34f29e537a3d20
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_95554c7754e9884c1b2cbf5a
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_ab704644e5ad9cbfdf26cb4f
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_f8d6cf2b3f6ad21c4873c382
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_15d5644288650e64692a3a0d
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_9dc4d98733c16c7ad75172f3
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_358c7b5b9f12c070798c06dd
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_960f079ce47a6c2eec4b54fb
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_accd132b1691eca9b1c43d9e
eea_tvv_range_0e0ffeccf38a903828ddf6fd	eea_hist_fba36ada862acbc32ae158a7
eea_tvv_range_0e0ffeccf38a903828ddf6fd	eea_hist_f20d99da04bd13ddc21c2d87
eea_tvv_range_559b6eaaae506bc499bb3563	eea_hist_7ba5cf62545ea8243779fc40
eea_tvv_range_559b6eaaae506bc499bb3563	eea_hist_37b0da010f9e51cf14a1d626
eea_tvv_range_559b6eaaae506bc499bb3563	eea_hist_6ab0d1aa6629392df83ed80a
eea_tvv_range_559b6eaaae506bc499bb3563	eea_hist_6165f699ec597f11b3015f5b
eea_tvv_range_559b6eaaae506bc499bb3563	eea_hist_54d857c4302a2ab74ebd685c
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_8d5c34f8471b6af3f7e5fc57
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_64020436e34d4dd22c08c20a
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_ebcb65e979dcb6f1d7087204
eea_tvv_range_2c9c3f679381cac1598e8257	eea_hist_66ee717b74cd31a83f392264
eea_tvv_range_2c9c3f679381cac1598e8257	eea_hist_e537e1c7f8cb535cd66ec69d
eea_tvv_range_7d9fe4e71ca55a0acd3866fa	eea_hist_a7900c93e9229f7a3a30d71e
eea_tvv_range_7d9fe4e71ca55a0acd3866fa	eea_hist_a231f4bb3db86810461eb2d4
eea_tvv_range_7d9fe4e71ca55a0acd3866fa	eea_hist_59dbf1192f04dddc13e41fe8
eea_tvv_range_7d9fe4e71ca55a0acd3866fa	eea_hist_077fd0f52c8d419c21439cfc
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_1b5a10416a631711853d2f6b
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ee0e3e8364b4587a2a8a627e
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_3cf69b206c5c6e95c3dbe9ab
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_4f3f1906d27e49275b78064e
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_009fca4955b29f84a0f34dd6
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ed48a7c3a97ed7063947521e
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ab6a731102242b7cbdf1e5a7
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_48caf88610ef8be885753d39
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_771f8946efa72dd02ba1aeab
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_16f60243454fbedccb9c242d
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_594f87a31c0746967b832840
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_21da2ae8db16ef6dbe1d1d23
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_1b03c988a9c9e38b47345b86
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_81fa80a9adf281de5fe7dc1a
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_5db3689e9631baf16a2613ba
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_44acadddc482b91b3e15a42e
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_3b4dcc4a2715dabe80cf92af
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_63fdfcf56af0bddb7955f786
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_7094e26e7bf6d504668c555c
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_0a8c571c28250db7662aa0a1
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_1bf460b5b678b2c68c2e20d0
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_ac84dfecf3ec584c305a0291
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_c817f078be39c3eaa52ef9e6
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_5f3359df1c95e759207ebe1d
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_32cab830415e40debb953d67
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_be76edec3905f44c906bac3e
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_16e94a8f121882c5e692e023
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_9fe269b20e0bd6c037b65e9b
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_7e98a3562107a16d13205a09
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_8111c9cadb4b1a53d2e6636a
eea_tvv_range_04d3f30c184f1c25dacd3e81	eea_hist_2ba88a17006e25576b5fde83
eea_tvv_range_04d3f30c184f1c25dacd3e81	eea_hist_2b3decdf434826861733eed3
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_d00c05b1104be25e5790e6fa
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_5e2cb2799258897b0196a954
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_4fbafa282b1af30b7f9e397b
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_dc76872d2dc2db7afa09cbcd
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_706956190129ad094548715c
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_f351e31c3263ea702e306c52
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_3377403eeff0cb624e624ac3
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_e8de0ef095e2b6d9d016260e
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_513489b329e5a0c5f27e0e8c
eea_tvv_range_a1e212a15cfb7fd0d708690d	eea_hist_b03cad9c85ffd2040cac3090
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_88dd42a61e6660afb8436874
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_d0ea3ee3132dfc0b318bc8d5
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_7bfdc80d4c0559ed4e33b97a
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_b1f0b25cc38633e270dbab92
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_5937fa67e6f27cc9435a0e24
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_6aaed96dc407a648716f0b9b
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_d3985857683a331433420e81
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_9ab196bb9298eb0ba59238dd
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_13ee6f40de16d9eed41ade10
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_6387bc8a03d1255ede0b39e2
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_d5c02498473aaab647608740
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_5a55600dd411ae9db5534899
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_ea423560eeb1c482642b2329
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_e8339da28887ee5ed1616e33
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_a3d305301f357ba15c70ef69
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_8d585e3662dbdf083181292e
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_74c4faa71351980798a0b533
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_474cd278a6bebb35683fe334
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_25fe69b749412f035fe2aef4
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_4e81c8a039f397841552825b
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_e1457da6b78a562da2a78d27
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_2882289901633b7bb5bf9fcb
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_a73d645be35cc8bdcda5ae2b
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_7f326645d413de4754de500b
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_3e5ae2edbe413b49bc055dec
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_e8a4afc210873f461712a05e
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_820a8cc67a104e1b009baa51
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_a8c9872a9b41782c090103ce
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_b15daab18667327ea1410dfd
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_a5e5cf77a10bb441243a4771
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_404672efc3cd5c95b1ecd5d4
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_0069e8630d0ee8d7979711c8
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_cce585ea61e98c2fa60bf0fd
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_fca831a822ffd7a1039974e5
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_91a41bf5e1f574d416b67d72
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_369f06259c20ab93461ff5cb
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_faad314316225e0990f07802
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_df63cbe71a25569f64b11996
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_74f93801a2fde2135fd1b1dc
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_e9f37ae0cbf0ab70b2eb3eaf
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_58d7858ac2a4aace73c09005
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_f43170bf57037b27d7bfd61d
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_790af063fb2759cd678c300e
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_bd9ee72cb9b700a7d5885a74
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_fdfb2706688fc257f5871fef
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_58f04a531f9944694f4a5524
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_269d0b85fcfd6de0d9221fb5
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_c207a3d8f1cf525db1cab8e5
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_7faf9afb970a4c7f07fc07ce
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_5cbf5e130766656e64c4d789
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_b8aae6c7b287834fe53a5706
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_4c0bb255f089d1f2ec337aa1
eea_tvv_range_669af85fe64e0605a1224b68	eea_hist_f67bc64f03ee54bf61d07782
eea_tvv_range_0376bb285f6ad39ce74a94e8	eea_hist_8a1cf31d4ccd78a0166ebcb2
eea_tvv_range_0376bb285f6ad39ce74a94e8	eea_hist_34e36a0efbdbe4ef86051a02
eea_tvv_range_0376bb285f6ad39ce74a94e8	eea_hist_7971a712b9da67155563c2ab
eea_tvv_range_0376bb285f6ad39ce74a94e8	eea_hist_c4daebb9301afcb344a7b7ea
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_b2624e22d784ac01c761c20b
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_c1531fc7ea824bbd5014d533
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_0bc3e255bb10d7e5391cc0de
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_effe14862028ec1ade2e6681
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_bbf2cdd41b321292f79a85b4
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_9aa963eb35055103bee210c6
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_f758bb5dc15002b33ded0d38
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_5345225df32dfb66f721d447
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_e25e1cd06b6a95f0987ac179
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_77c8bbd5bd9fc79b11100298
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_d47c2f8297e1356952943c0f
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_9530d0247094315c2f9ccb58
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_c255e5da90562c6b82210499
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_2b934e3914a7b3cf36df684d
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_02fbd8d683c96a026a453731
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_78037de22c1b245deaba0bdf
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_639752036991ccf6cd3133ea
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_b4f5988f4294f005ebc56dd4
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_ef31d01113107bee7d9ac12e
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_9e547fadc45c64a1b05609fd
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_d7af0e2c895627b1f6a86fa6
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_633790e54b1287c0717da6f5
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_c4cfc259914c7ff1538be9df
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_74e4387dbdea38cb2fe3e4d6
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_47e98cc5b414b7e8e60a3dd0
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_c80242e8a40044e695bbc163
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_35dff40db5af83f91a4fa5a3
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_6b01b0646dcf0de061fad35b
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_6de021c04c68fb7a514e7779
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_70818488ea7c2c7d9f1e4aa0
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_7bee83f3014580df3198b774
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_cb14b031888d4a6755add8c5
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_53f1e5805f38d75f410689da
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_11a3d2f89a8093ef22caa268
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_ff7dbfe55a87cf3ebe440577
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_bc8436415f725fd45bfb6e80
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_5d4112eb837515e8c59d08ac
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_2649f7f3598195d6023f228d
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_85dacb0fb57c5660c35f831f
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_fb78cd5f2fd76043cb3c261b
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e483953cca8a0412681b9e1a
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e92fd88c77af0cb30a33159f
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e59dc9119480adee62010f85
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_df912dba1fdd0e9864f5776d
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_9d35de6b1ca4e3a9da67c78f
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_aaff8479d34df2eb817594a9
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_991df7648c415876cfa8fd30
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_470f7aee27e56c4b987feaae
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_6f88d72d2b68e5adadcf4cbc
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_6b0c843f85dd8e9a8a7a7a39
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_a8899348726e9dc11668fd9a
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_573c844893509ccd5c9317b4
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_8844f9774f3ac00b70dca523
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_d9e5fc9e5989fcfd67aa65c7
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_d00c8866f509848077788ade
eea_tvv_range_afca1500d011b0a54f1fd0b0	eea_hist_b71f1dadc116dfd2f153f8ae
eea_tvv_range_afca1500d011b0a54f1fd0b0	eea_hist_c5c304e55c7addc6c9fcd196
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_c0ad36510f9f6fd027ba4d32
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_02930cab8de9df15a2cbf1c6
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_eedd1e2abc5e226adfb7d0df
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_45ad5283f9d90f3a5415b43e
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_68c1ce98494151c88d1c907b
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_515d59fc6d858e408cdec1b4
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_dcdc11905663f6ed068357e5
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_09b8224a732942ec5bd0d0f7
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_3e25c73c8631383b1c028e98
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_232adc941ea2da2f7d18cea2
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_c9165374a3f1fc4225c77db4
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_d6d4fa153c975801cb16cd34
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_da944e79cc6a41ba571fef54
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_b043e9a1c76911d909cd03c3
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_c34d66bd4622a855d2983870
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_17672b03c927eb780b2c4e14
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_5492cde17208e309cdc33e6e
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_76ffded8379c63f6afe7c786
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_7cab24c57a7dd3bd920d640f
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_b06e86d2fbbbc4a43167ce50
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_7e50073f32dee1ac9ef641aa
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_d8bb16a5b990aa29a6284940
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_24b8e8d0dce4fab8c96aa492
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_917550a27b742aff483473f5
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_c9ddf5237e8b59791f6ea0ad
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_d8a7de17dafa3475bedb05a2
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_c6888bd633e674923682d65b
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_f35dd8be096088ff2366c642
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_220422de7332e4f2b0d59454
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_232fbf232b64e06c93642c16
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_5d4e0903e354654f3bd4480c
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_275279c8fdffea080377622d
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_0c3181cb2bb195de469a8bfd
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_7c84a54818703202b8ad07ba
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_7d89fd589c1c819c724a53a0
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_b3ff36f3b92fe34f6d62a747
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_0f9f207341dce79f6ce10a29
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_2d64b4b73195fa2aac31fe2a
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	eea_hist_3788a50e23c54b8c46a2b767
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	eea_hist_525856816b628cb6f4cce4e0
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_41e83bf4e8506d1452130f4e
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_c7513a781da9e95d81fb7940
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_66e1e1830663a95451e78e1f
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_46a40a1bb8723baef8a3f7d1
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_932759086bb0f54cffa78540
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_481f346a2a03ec666bb20282
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_ef105c3969bdadfdd4bcc7f9
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_47a5a16dae48d53f2fcf262d
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_777c913d580ab6df0562f70a
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_b258f18faa7f1cde9ab651c3
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_944ffb525d8158c39524b5a7
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_2af4b1b453d8cd52466cb53d
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_6d749d76c6cd10f2f87839d4
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_76d281df7c02a2bbc40be2f0
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_e72fd127e31f9c082cb98ce9
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_87bc0927b34966ce4f4f43e4
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_b2ae10b279429854e6c66948
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_64ad36a5907aae9cff52c978
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_d086b6897585d208d0b1d018
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_2ce9d43759ba47464c269760
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_a889227a91539c7e9ea27515
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_e6c753e91475f0be07d18b5b
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_5ed8d53bd7ed5addb719343d
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_2575f05146d0bbb0fc5989be
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_f56bf4af1e201d92c3b59567
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_a33137f3d9bbbbd2d3a96b27
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_885374e82b52812ef8e35b3d
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_d8d075c2ff92798f6a4f7e06
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_e36fcb592335f567c78cbece
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_0e1b2ad903cca7fad2013dc3
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_9c749d227e6db738ce845186
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_c0ffbae15696a58c15d31e10
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_40ee68fc074806d24b041e7f
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_12c8e4dc3c8ff348e4eb6b2f
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_bb40dab2a1f6a01a6c481224
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_b3a116c51109b14e50299f66
eea_tvv_range_13374503e601cc823d5524f9	eea_hist_887c9e10eddabc8ef0bc0862
eea_tvv_range_13374503e601cc823d5524f9	eea_hist_6162188c60b5c360603ae935
eea_tvv_range_13374503e601cc823d5524f9	eea_hist_65be3e122702c352eb3e1d1e
eea_tvv_range_13374503e601cc823d5524f9	eea_hist_e2fcfa54ff85f1d148672087
eea_tvv_range_13374503e601cc823d5524f9	eea_hist_4a3291a9f13caf10d28c43c7
eea_tvv_range_fcfa89654ad250e22a423b28	eea_hist_abfa04c433c8544e2de4c8b0
eea_tvv_range_fcfa89654ad250e22a423b28	eea_hist_0dfa41bb3db2b8f9ed78b727
eea_tvv_range_fcfa89654ad250e22a423b28	eea_hist_c7e1ccde91f6191210c696fd
eea_tvv_range_7a255b5be155a44519487280	eea_hist_02045200ff798c9e7f521fcf
eea_tvv_range_7a255b5be155a44519487280	eea_hist_3fb3d3af6a00349e2e3f4695
eea_tvv_range_7a255b5be155a44519487280	eea_hist_25d8bf0538baa7ba37a6dc37
eea_tvv_range_7a255b5be155a44519487280	eea_hist_a846934e138e971851fb10a1
eea_tvv_range_7a255b5be155a44519487280	eea_hist_af9f32edc4b5babf090d85f6
eea_tvv_range_7a255b5be155a44519487280	eea_hist_848262bc1dcf11f0195835ef
eea_tvv_range_7a255b5be155a44519487280	eea_hist_0dc8a326a43b61e1128f1ccb
eea_tvv_range_7a255b5be155a44519487280	eea_hist_259286a46c200108ef2634e9
eea_tvv_range_7a255b5be155a44519487280	eea_hist_d49416798c457d3a089143be
eea_tvv_range_7a255b5be155a44519487280	eea_hist_dc8cc454758ddd7aabfe3747
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_678d0dc7583277059cec7817
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_921da1511844f4532f9e15ae
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_56f42788575e75ab8e1458af
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_cea6a3f20c82d0f8b4e78971
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_7d551ec5b2a515f09ab97037
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_61a0205c230e9a829f52852d
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_8736b5eb601dcd34032bfac6
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_b88c5454700f4198e3833126
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_644d66343c35ccca02bd7a12
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_9ed63aaf1a19014616542d4e
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_a80319f1808c0fbdee409006
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_2e4f9db7253e1446f1bfb07d
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_785d100368718cb2b1faa778
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_c2bf2ee1059af795590e7d8c
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_e4bd4f8542f3494ec7e2b386
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_91c47a6887814d25040b5b0c
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_3faa864a9b7930595252aea3
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_7852e57b4282d08703b89c5e
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_f95cb4d99e8955c74f84c4a9
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_f4f67baf049abdae0ac993af
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_6f51333909860ad122b86f03
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	eea_hist_d9427132f9adf1909b1eb985
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	eea_hist_ea8332d9496a8f03e931d1a2
eea_tvv_range_e2a5498533f84aa8ab75824e	eea_hist_fd97a74b9c2c90a6c5ceefb0
eea_tvv_range_e2a5498533f84aa8ab75824e	eea_hist_5688792e9fec904454e4477d
eea_tvv_range_e2a5498533f84aa8ab75824e	eea_hist_a1ca47e1cc54e52687a21b4d
eea_tvv_range_e2a5498533f84aa8ab75824e	eea_hist_7941c0e679d4c58a87b9fe67
eea_tvv_range_ddec42aa3efd253bc3d17a82	eea_hist_3acd19b2256ffafefc95d636
eea_tvv_range_ddec42aa3efd253bc3d17a82	eea_hist_c0ae6c1dffe7f212c654db35
eea_tvv_range_4889bb6723fb0a18a3f15b8e	eea_hist_b917423963d2f64e9553b7f9
eea_tvv_range_4889bb6723fb0a18a3f15b8e	eea_hist_a037e9e2450394176b2268e4
eea_tvv_range_4889bb6723fb0a18a3f15b8e	eea_hist_d62f0f39e77412c3b4730dd6
eea_tvv_range_4889bb6723fb0a18a3f15b8e	eea_hist_c97a9a7cdd7d6c5ed63720d8
eea_tvv_range_4889bb6723fb0a18a3f15b8e	eea_hist_6e8f1bb1344f65b7e9d7978b
eea_tvv_range_a7c84c6b4c9a49b25ecb9d01	eea_hist_c8ed4e1c45d597678e9d33ce
eea_tvv_range_a7c84c6b4c9a49b25ecb9d01	eea_hist_9dbda84972c541a704952ece
eea_tvv_range_a7c84c6b4c9a49b25ecb9d01	eea_hist_05bb8bb2673547bb7758020d
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_b0361f88298698d36fdc0277
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_27f15bcb45f304fdc27d758a
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_f10320cb21fa89e6a57e7b1d
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_ed691f0df2cef4982d64b729
eea_tvv_range_10a936c429c05cdb98bcd673	eea_hist_41b753db058d4d826f1e91e0
eea_tvv_range_10a936c429c05cdb98bcd673	eea_hist_25d43c7febc573eb3907dbbd
eea_tvv_range_10a936c429c05cdb98bcd673	eea_hist_31c5ad756daacebb39497746
eea_tvv_range_10a936c429c05cdb98bcd673	eea_hist_3045f53c4fc74146fc599612
eea_tvv_range_40672c0c94857aefca0088f3	eea_hist_52f634fe99c055870615eb4e
eea_tvv_range_40672c0c94857aefca0088f3	eea_hist_df5301fa7b7d92b4bab535b9
eea_tvv_range_40672c0c94857aefca0088f3	eea_hist_0d581a7e526273260f369395
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_888b104e69e1dc3b5ae79ee6
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_f2c5d163d686c2bd09b830af
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_45a98effadafbb699fa2aa18
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_81d6fb2f2535244e5b92a3cd
eea_tvv_range_2ddf3bbdc18538a5b3de5055	eea_hist_299612ab66f03eae9c33fb35
eea_tvv_range_2ddf3bbdc18538a5b3de5055	eea_hist_39b91a700687e53eb7aeb1f2
eea_tvv_range_2ddf3bbdc18538a5b3de5055	eea_hist_1feb79cbb3e514d255cfac4b
eea_tvv_range_2ddf3bbdc18538a5b3de5055	eea_hist_f725b36200f64b7cbf7c1868
eea_tvv_range_2ddf3bbdc18538a5b3de5055	eea_hist_c933fa1222335343cc71f451
eea_tvv_range_875c7ffb98c648352078455d	eea_hist_ac9ad039f01a90d932b4f661
eea_tvv_range_875c7ffb98c648352078455d	eea_hist_5f9b5dc5fcf2378d16a8b371
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_3299512b6317992051cf7ddf
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_36db56bffbfef5bc427a2dd1
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_02c5ced8e335e8b76373ee6d
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_71ef2839a3a2b6d7351260d9
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_3a4cdc463787577cb49ec381
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_58aab05fe112c770dd1a02e8
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_6e98201e08a2845ac61865e7
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_54e2fb4a9a218bb501766c3c
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_e15976970ff67226d1912515
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_0e7415b350efa3b6c99fdd7d
eea_tvv_range_bcde49674783397645a53d96	eea_hist_513686b255e37f19995be8a4
eea_tvv_range_bcde49674783397645a53d96	eea_hist_d7b9213ccdf92f290d970420
eea_tvv_range_bcde49674783397645a53d96	eea_hist_a2ef2fdd64170e21de3340fd
eea_tvv_range_bcde49674783397645a53d96	eea_hist_573a12d8d4a06c8f9bc54e04
eea_tvv_range_bcde49674783397645a53d96	eea_hist_ba58719ecff590039714cc02
eea_tvv_range_bcde49674783397645a53d96	eea_hist_5d4a70511e15ed0038061fa0
eea_tvv_range_c467f1a50571bfa1d11d1a9d	eea_hist_aecb4ed9b88d9fe3a5887453
eea_tvv_range_c467f1a50571bfa1d11d1a9d	eea_hist_cf730db1aee3910b453d9e83
eea_tvv_range_c467f1a50571bfa1d11d1a9d	eea_hist_b7f1a4555ff18e7cff7f6aca
eea_tvv_range_c467f1a50571bfa1d11d1a9d	eea_hist_38611fb848bc286cc2d9400f
eea_tvv_range_c467f1a50571bfa1d11d1a9d	eea_hist_40730231c80205e83579801d
eea_tvv_range_335be9fc901d1f0a152c232d	eea_hist_6f7811f6bce462c126ac6973
eea_tvv_range_335be9fc901d1f0a152c232d	eea_hist_a54e16b8e901fd6ee841b4ff
eea_tvv_range_0355ac59f0d7576bfb0e1443	eea_hist_e240587b379e07d3b109c2f1
eea_tvv_range_0355ac59f0d7576bfb0e1443	eea_hist_7784cb934eced10e919eed54
eea_tvv_range_0355ac59f0d7576bfb0e1443	eea_hist_7680ccfc59da8aa432a06343
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_9f213272f20f1e698daf2144
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_871ef52339f2586895def41d
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_4ca94ea8deead4821f028346
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_8c4cffb57efdbdfa21151bd2
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_db280370b75b9080afae501b
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_d8f192a7154f8e32c85763b2
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_01e7cd53710a41ac21ff7f1f
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_eddaf1f9685f114ed869f7d7
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_b333f1345059eab49feef397
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_b9b796b270e0e9c7ddbf5a61
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_d90cf0e48e089c2c46adbd81
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_f69de28bb891bc4fb39ef3a3
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_8dd7193de8b7b182427dc1f4
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_e17a226a9aaccad97be3c6ad
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_d44948681d966d82812b30ef
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_2a12a95cd52172f18a6f0703
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_e0866273d7f0c32284189406
eea_tvv_range_373aa7f4b2ab593107b925e7	eea_hist_2f00f494aba79ca40b68b43f
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_2fdc0304d2aa951ebc7d9ecb
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_31c437e54e6747de6abddff2
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_95e2054069c7b79afabba66a
eea_tvv_range_75aa7c985fcedba80ba8b190	eea_hist_59d4cab98badb6d50d384f0f
eea_tvv_range_75aa7c985fcedba80ba8b190	eea_hist_fdd3a34e9b310ace76dd2b4b
\.
