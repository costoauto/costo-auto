-- Generato da scripts/audit-eea-tvv-continuity.mjs.
-- Include continuita EEA TVV anche in presenza di uno o due anni
-- senza immatricolazioni osservate.

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
eea_tvv_range_4a356d0672afeab6b601ec3b	7	Alfa Romeo	Giulia	2016	2023	petrol	none	201	0.7918	8	7	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d72a532ea8ee29496aa83718	7	Alfa Romeo	Giulia	2016	2019	diesel	none	179	0.8384	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bf57d7efd49d19b7107ca6fc	7	Alfa Romeo	Giulia	2016	2019	diesel	none	150	0.8	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_acdb1a0347c1eaeda1ddc425	7	Alfa Romeo	Giulia	2018	2022	petrol	none	280	0.9636	5	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5aef52621f6d70e8c6d32b26	7	Alfa Romeo	Giulia	2018	2020	diesel	none	210	0.9209	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_147f4cb9d58f9fa4d32058dc	7	Alfa Romeo	Giulia	2021	2025	diesel	none	209	0.9054	4	5.5	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6866ae97967be7b4013fea4d	7	Alfa Romeo	Giulia	2021	2025	diesel	none	160	0.7584	5	4.8	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_806963181d6b53c28c4797a2	7	Alfa Romeo	Giulia	2023	2025	petrol	none	280	1	2	8	8.0987	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cf8e8d4a6822ee051d80bd05	4	Alfa Romeo	Stelvio	2018	2022	petrol	none	201	0.8445	5	7.5	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_812a0aa8a61bb88ba09de70d	4	Alfa Romeo	Stelvio	2021	2025	diesel	none	160	0.9259	4	5.5	5.8121	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4521424ec12692cac3e53274	10	Audi	A1	2011	2018	petrol	none	123	1	9	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e1bd75e1334e69f7616efe23	10	Audi	A1	2011	2016	petrol	none	85	0.7273	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3d9ad9a610d51e30275c72d8	10	Audi	A1	2012	2014	diesel	none	143	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d780a7c9d19f5ebd5959331e	10	Audi	A1	2015	2018	diesel	none	116	1	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0704452dee0d6371462bf53c	10	Audi	A1	2015	2018	petrol	none	150	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_593070da17786bbb2f9e94fe	10	Audi	A1	2015	2017	petrol	none	95	1	2	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2dcdcbc1d4d958966401cf14	99	Audi	A3	2012	2016	petrol	none	179	0.8571	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dab0b00d48c35bbbdce4d026	99	Audi	A3	2013	2016	diesel	none	184	0.8571	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_26fb6fbb8abe0650ab66f280	99	Audi	A3	2013	2015	petrol	none	124	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a5957c28dd5c997f0eefff47	99	Audi	A3	2014	2016	petrol	none	110	0.75	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_79afe1060cab0fe1be5346d6	99	Audi	A3	2016	2018	petrol	none	116	1	2	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_524dfd14efd4791a3aa97886	97	Audi	A4	2015	2018	diesel	none	143	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2f6d9ae6acd9074439fb1266	136	Audi	A8	2013	2017	diesel	none	260	1	7	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4bec2525b3139d019224a2d7	136	Audi	A8	2013	2017	diesel	none	385	0.8182	5	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3ed426a7090e828c6ef53e22	136	Audi	A8	2014	2016	petrol	none	435	1	2	8.3	8.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6715a779f8914f04190a64ad	136	Audi	A8	2020	2022	petrol/electric	plug_in_hybrid	340	1	2	8.3	8.3	19.6	21.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9e5cc019ea7245362d088abf	93	Audi	Q2	2016	2019	diesel	none	150	0.7823	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9dab9b941d42e865cba42d8b	93	Audi	Q2	2016	2018	petrol	none	150	0.8667	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8dfb90ff8a2fd8496384160d	93	Audi	Q2	2016	2018	diesel	none	190	0.7143	3	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7bcbbd55ccebeaf824175ec9	93	Audi	Q2	2021	2023	diesel	none	150	0.869	3	4.7	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38af953d221c6c6d75280ff8	12	Audi	Q3	2011	2017	diesel	none	177	0.7273	6	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8486764858953fa52757189b	12	Audi	Q3	2011	2015	petrol	none	170	0.8182	4	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1acb2e5fbfcec77506aa5512	12	Audi	Q3	2011	2014	petrol	none	211	1	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ca1a1863f22c0bc3f0dd4f48	12	Audi	Q3	2012	2015	diesel	none	140	0.8298	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dc5b0bf58ff79ca1e9037ceb	12	Audi	Q3	2015	2017	petrol	none	220	1	2	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aec3b1b4e81edf683721c438	12	Audi	Q3	2016	2018	petrol	none	125	1	2	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6aadce963f0569bdd220a2f8	12	Audi	Q3	2023	2025	petrol	none	190	1	2	8.0916	8.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4627fd59d6a2ee2cfec23148	89	Audi	Q5	2011	2013	petrol	none	271	1	3	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1f348e82249b0a0298c7f4f7	89	Audi	Q5	2011	2013	diesel	none	239	0.8333	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d6bd2d2ac576f660a5e5c6c2	89	Audi	Q5	2012	2015	diesel	none	177	0.875	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_79edfa7f6f3cc89eb913a062	89	Audi	Q5	2012	2015	petrol	none	224	1	4	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a2692b327b10d2493a3f1675	89	Audi	Q5	2012	2017	diesel	none	248	1	6	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5faf694960482d849f77ea0e	89	Audi	Q5	2014	2017	diesel	none	258	1	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3df3b740546553365cd72a0a	89	Audi	Q5	2014	2016	diesel	none	163	1	2	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fc552c191b264e14854086e5	89	Audi	Q5	2017	2020	diesel	none	163	0.7	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e6e77dc4a122d46c0f7454eb	89	Audi	Q5	2018	2021	diesel	none	190	1	2	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_98289e2ffcbddc665684ebf8	89	Audi	Q5	2018	2020	diesel	none	286	1	2	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0dac928fbcc9ecdd176ad6e6	138	Audi	Q7	2011	2015	diesel	none	340	0.75	4	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c562531f229c758c6720706	138	Audi	Q7	2011	2014	diesel	none	204	0.8	3	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4060a3c89dbe295006549246	138	Audi	Q7	2015	2019	diesel	none	272	1	4	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59907d366beec4e49c470d67	138	Audi	Q7	2015	2019	diesel	none	218	1	4	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53d9dd2d4fdd319082a4da01	142	Audi	Q8	2019	2021	petrol	hybrid	340	1	2	8.9	8.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a74829bbd7a7cbf577baff56	132	Audi	TT	2011	2013	diesel	none	170	0.7778	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1942a67078b52efeb806d0c6	38	BMW	1 Series	2015	2017	diesel	none	150	0.9667	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5009515ad45236a2c1bbb64e	38	BMW	1 Series	2015	2017	diesel	none	190	0.806	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_66192527c42bd4599899ac31	38	BMW	1 Series	2015	2017	petrol	none	109	0.875	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9865069aa3f93305f9172a6f	38	BMW	1 Series	2015	2017	diesel	none	224	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_45544eca280b23a841961ec5	38	BMW	1 Series	2016	2019	petrol	none	184	1	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2143b3c68fb5a8fb487439be	38	BMW	1 Series	2019	2024	petrol	none	137	0.8617	6	5.6	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_84006c9af987f5afe0366865	38	BMW	1 Series	2020	2024	diesel	none	116	0.9148	3	4.6	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1cff6aac19ef7fca1f97a12c	38	BMW	1 Series	2021	2024	petrol	none	109	0.8115	3	5.7	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a60fe234f8ba83dff3642a7f	38	BMW	1 Series	2021	2024	diesel	none	190	0.993	4	4.7	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_018bb4ec3109f60bd2765f3d	98	BMW	2 Series	2018	2021	petrol	none	109	1	3	5.9	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a8bfdf6b3a155b7767b10c33	98	BMW	2 Series	2018	2019	petrol	none	138	0.9537	2	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dd9460d3ad666313220d8866	98	BMW	2 Series	2021	2024	petrol	hybrid	156	0.9185	4	5.8	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_30b365b2b57c5d1567e85b9a	98	BMW	2 Series	2022	2025	petrol	none	136	0.8192	3	6.2	6.2545	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d740b8c411bb20e8ac68cc2f	14	BMW	3 Series	2011	2012	diesel	none	203	0.8	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_897368718ace6a66e1032976	14	BMW	3 Series	2016	2018	petrol	none	184	0.9867	3	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c788cd3d31dabb150450c8b0	168	BMW	4 Series	2014	2016	diesel	none	258	0.9231	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_934252b8b8a8caf3e390e178	168	BMW	4 Series	2014	2016	diesel	none	143	0.7273	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_79033a358572a7fead505af6	168	BMW	4 Series	2018	2021	diesel	none	190	0.9974	2	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3c667773fed96b759a093fb3	168	BMW	4 Series	2021	2023	diesel	hybrid	190	0.999	3	4.8	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_01f94eb7439ee19449bc003e	168	BMW	4 Series	2021	2023	petrol	none	245	0.8487	3	6.9	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a1cf6995605a0be404b2878	168	BMW	4 Series	2021	2023	petrol	none	184	0.8243	2	6.4	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02439da09670aa4d10f0874a	64	BMW	5 Series	2011	2014	diesel	none	202	0.75	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_395881cb999e619729dff3c8	64	BMW	5 Series	2017	2020	diesel	none	249	0.8448	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_789186fbd773fe1ea60167d9	64	BMW	5 Series	2017	2020	diesel	none	265	0.7624	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ebcb6f5bc47f507925b5c1e5	64	BMW	5 Series	2017	2019	diesel	none	320	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_76535222a5f96162c838b9f2	153	BMW	7 Series	2012	2015	diesel	none	258	0.8	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e7f10ffcc7d2328ff28fb3e4	153	BMW	7 Series	2012	2015	diesel	none	381	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e67a9e8b649c50a5723e9439	153	BMW	7 Series	2014	2018	petrol	none	449	1	4	9.8	9.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_125119553437d22c97c8e89a	153	BMW	7 Series	2015	2018	diesel	none	320	0.84	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c741f06b7cfb57e4543330a	153	BMW	7 Series	2019	2022	petrol/electric	plug_in_hybrid	286	0.9189	4	9.8	9.8	15.5	17.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b86499ad611e4b8e9521cc3d	153	BMW	7 Series	2019	2021	petrol	none	530	0.75	3	9.8	9.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_21262b04368f28d56d168cf7	177	BMW	iX1	2023	2025	electric	electric	204	0.9696	3	\N	\N	15.9865	16	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ab054cb0a07a90d8d33363cc	177	BMW	iX1	2023	2025	electric	electric	306	0.8614	3	\N	\N	17.2	17.4	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4aa5315cd85ace540cf1f111	57	BMW	X1	2011	2015	petrol	none	150	0.8	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ed9809662695f2600f8b409f	57	BMW	X1	2019	2022	diesel	none	190	0.8852	3	5	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6d4916b2b8c27420eec09114	57	BMW	X1	2019	2021	petrol	none	138	0.9246	4	5.4	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a84ed3bde54658a50486eb0b	57	BMW	X1	2020	2022	petrol/electric	plug_in_hybrid	125	1	3	5.6	5.6	13.8	13.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_154b643a7dc178ef5514c727	9	BMW	X2	2018	2022	petrol	none	138	0.8604	6	5.4	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7ce91a8952b394311372cd5e	9	BMW	X2	2018	2022	diesel	none	190	0.9141	4	5	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_18b5ab503eddffa24a18a980	9	BMW	X2	2020	2024	petrol/electric	plug_in_hybrid	125	1	5	5.4	6.4	13.7	15	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_616afda7e285fe5b37066e71	33	BMW	X3	2011	2017	diesel	none	258	0.7	7	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f41cae2e5653b79d0c2e7671	33	BMW	X3	2011	2017	diesel	none	313	0.8333	6	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1b5e8a04e9bb84d06a2ead76	33	BMW	X3	2011	2014	petrol	none	306	1	2	8.9	8.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_47d7da9f8f9fe5bc5f9b07fe	33	BMW	X3	2011	2013	petrol	none	258	1	3	8.9	8.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a21adb021cef15ce07aedcd6	33	BMW	X3	2012	2016	petrol	none	184	0.8	4	8.9	8.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6f97045fb4c3dd734d1c2ef2	33	BMW	X3	2012	2015	petrol	none	245	1	4	8.9	8.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_895010b34223389a35f72a2b	33	BMW	X3	2012	2015	diesel	none	143	0.75	4	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b347961a383b4d30a3231534	33	BMW	X3	2014	2016	diesel	none	190	0.9167	3	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f3486a5a9cef7eaa89299476	33	BMW	X3	2021	2023	petrol	hybrid	184	0.9134	3	7.6	7.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d87b5c2a3ebae47fdd29236	127	BMW	X4	2014	2017	diesel	none	190	0.8421	4	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b373e30b8c477938e37b24f4	127	BMW	X4	2014	2017	diesel	none	258	0.8	4	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a416b1ecb98035b96bc889d6	127	BMW	X4	2014	2017	diesel	none	313	0.7143	4	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bfead7340fc46f5e8f0a991a	127	BMW	X4	2014	2016	petrol	none	245	0.8571	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5646fb3e579ff0c79e17b890	127	BMW	X4	2014	2016	petrol	none	184	1	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b3f320788f4e0d7531e07f36	127	BMW	X4	2014	2016	petrol	none	306	1	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3af8c9bb0b0231863243d344	127	BMW	X4	2018	2020	diesel	none	265	0.9577	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d274f5a7748c989319fcd59a	127	BMW	X4	2018	2020	diesel	none	326	0.9908	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c9f2e11988ce5f464535301	127	BMW	X4	2018	2020	diesel	none	231	0.9819	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a6047bcc349ff139c078337	127	BMW	X4	2021	2023	petrol	hybrid	360	0.7826	3	8.8	9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_561647292e691e8a1f8b2a0c	170	BMW	X5	2013	2017	diesel	none	258	0.7419	5	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_52f91fc4faea00962b0cfbb0	170	BMW	X5	2014	2017	diesel	none	313	0.7273	4	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8bd2f00bbfde0bcfec429f22	170	BMW	X5	2014	2017	petrol	none	449	1	2	10.7	10.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5636fd294408ff3af43c46e6	170	BMW	X5	2014	2016	petrol	none	306	1	2	10.7	10.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d75efeb88efe385d76676447	170	BMW	X5	2015	2018	diesel	none	231	0.8333	4	7.2	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7ed6b0388038d385f9718d7c	170	BMW	X5	2015	2018	petrol	none	245	0.9565	4	10.7	10.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c7eee60ba36de586cc8f445	170	BMW	X5	2015	2017	petrol	none	575	1	3	10.7	10.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_432405b8918715ebe567081c	170	BMW	X5	2018	2021	diesel	none	265	0.8376	4	6.7	7.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ad20323c3bc85079edc14f92	170	BMW	X5	2019	2023	diesel	none	231	0.8936	4	7.2	7.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c4b7f8724ac2b536ddab233	180	BMW	X6	2011	2014	diesel	none	245	0.7143	4	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9836cbadabf4e5af09e2241f	180	BMW	X6	2011	2014	diesel	none	306	1	2	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_04a6c466cad2895267746124	180	BMW	X6	2014	2017	diesel	none	258	0.8333	4	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_39ab5f985928ac07ff8bffa1	180	BMW	X6	2015	2018	petrol	none	575	1	4	10.8	10.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_74e27e5bb7be5b5fd2e97302	180	BMW	X6	2019	2021	diesel	none	400	0.8898	3	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b8b1723766ab17348be9aa65	180	BMW	X6	2020	2023	petrol	none	625	0.9091	4	13.1	13.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f3c494d2f6123938123f40ef	180	BMW	X6	2020	2022	petrol	none	530	1	2	10.5	10.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dca110454749bc86ea2f83a1	194	Citroen	Berlingo	2011	2017	diesel	none	92	0.7069	7	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_77e930e6a41efaed2131fcf7	194	Citroen	Berlingo	2011	2015	diesel	none	113	0.7273	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4bf91787ffee6f64762c4ab4	194	Citroen	Berlingo	2012	2014	petrol	none	120	1	3	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_06da55639be851e604b6f961	194	Citroen	Berlingo	2016	2018	petrol	none	110	0.8571	3	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c3a441fcc577f55fbd653e5f	194	Citroen	Berlingo	2018	2023	diesel	none	102	0.812	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7e08ef637e719527aa1565cb	194	Citroen	Berlingo	2018	2020	electric	electric	67	1	2	\N	\N	17.7	17.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	194	Citroen	Berlingo	2019	2024	petrol	none	131	0.7073	6	6.4	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	194	Citroen	Berlingo	2019	2023	diesel	none	131	0.8617	5	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d6f2d5cf688da9224f35f09b	194	Citroen	Berlingo	2019	2023	petrol	none	110	0.8418	5	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	92	Citroen	C1	2012	2021	petrol	none	70	0.7368	13	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9390fa5e8439d5bc5cc800df	92	Citroen	C1	2014	2017	petrol	none	82	1	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	16	Citroen	C3	2011	2013	diesel	none	91	0.7083	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2228778ec82a825a604c47e2	16	Citroen	C3	2012	2015	diesel	none	68	0.8333	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f8743bab5c4230e4315b9fc9	16	Citroen	C3	2012	2014	diesel	none	113	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4f0f246275622af32d3cd43d	16	Citroen	C3	2016	2025	petrol	none	83	0.8	11	5.5	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d77ab39fb5a8d107dca65084	16	Citroen	C3	2016	2018	diesel	none	75	0.8	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e23e6f6d8642d30010323c86	16	Citroen	C3	2016	2019	diesel	none	100	0.75	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8a4b635e1384ed2195255bc7	16	Citroen	C3	2019	2024	petrol	none	110	0.9973	5	5.4	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a5581b4b3636859f661eff1f	16	Citroen	C3	2021	2025	diesel	none	102	0.9424	5	4.2	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e7440eee09c5adcd5ed36475	54	Citroen	C3 Aircross	2017	2024	petrol	none	110	0.7189	7	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8b76857d3c5319a5deaada24	54	Citroen	C3 Aircross	2018	2022	diesel	none	120	0.8701	4	3.7	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee00b9eb6cb9856d86a75813	54	Citroen	C3 Aircross	2018	2020	diesel	none	101	1	5	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_75127c19c6086b5d85294f1f	54	Citroen	C3 Aircross	2018	2019	petrol	none	83	1	3	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_91141bfea46d9c22ffca9b58	54	Citroen	C3 Aircross	2020	2022	diesel	none	110	0.9989	2	3.6	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f4b76b27a7131a67f3835e31	54	Citroen	C3 Aircross	2023	2025	diesel	none	110	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c61df263ace92e65c34a076	82	Citroen	C4	2011	2015	diesel	none	113	0.7273	7	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_872c767747baf6dcadb55c79	82	Citroen	C4	2020	2025	petrol	none	131	0.9764	6	5.3	5.862	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5d5ecebdfd3aeed2336807d	82	Citroen	C4	2021	2023	diesel	none	110	0.9939	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b4e7d841ff0ad94ddad303bb	95	Citroen	C4 Picasso	2011	2012	diesel	none	110	0.8085	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_41dde69ec2bd01304ddd2961	95	Citroen	C4 Picasso	2013	2019	diesel	none	118	0.7879	10	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e11be7054bbd9a368253410d	95	Citroen	C4 Picasso	2013	2015	diesel	none	92	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4ac286c395c80c7763a4385a	95	Citroen	C4 Picasso	2016	2018	petrol	none	131	0.8333	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	145	Citroen	C5	2011	2015	diesel	none	113	1	6	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_30a469fc65eeb3bfd78c3f2d	145	Citroen	C5	2012	2015	diesel	none	163	0.7083	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee426da61d110bc22306a237	29	Citroen	C5 Aircross	2018	2021	diesel	none	177	0.8674	4	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_14ac9a77c62f222d7412638e	29	Citroen	C5 Aircross	2019	2025	petrol	none	131	0.7596	6	6.1	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c173bf8c99b4dfe84ae8119	29	Citroen	C5 Aircross	2019	2022	diesel	none	131	0.876	4	5	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3c3b03bb053f03b1c7a5a999	29	Citroen	C5 Aircross	2020	2024	petrol/electric	plug_in_hybrid	181	0.9942	4	6.8	6.8	15.6	16.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_eee411f2fdd53660e7ebb4a9	29	Citroen	C5 Aircross	2023	2025	diesel	none	131	0.969	3	5.5	5.5016	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6e850c34072f0406b6db1f2c	264	Cupra	Ateca	2023	2025	petrol	none	190	1	2	8.0615	8.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_729127d8acc2fc31430835c6	67	Dacia	Duster	2011	2014	diesel	none	90	0.8438	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_311ebf69301475fec5bf02cb	67	Dacia	Duster	2011	2017	diesel	none	109	0.7333	13	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2ad4e084745e59e43418e25f	67	Dacia	Duster	2011	2015	lpg	none	104	0.9474	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7e904501c7ab6d41de415134	67	Dacia	Duster	2015	2017	petrol	none	114	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_634b3a59c9a720be8522d51a	67	Dacia	Duster	2018	2022	diesel	none	115	0.771	7	4.3	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9dfdcf422a9f21e204766f0f	67	Dacia	Duster	2020	2022	lpg	none	101	0.9859	3	5.4	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b9c17c28259d0879dabd5e61	21	Dacia	Jogger	2022	2025	petrol	none	110	0.842	4	5.7	5.7436	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_17b77d51d8995dff8a745491	149	Dacia	Lodgy	2012	2019	diesel	none	108	0.7407	10	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e7eb737d1db5f5c680626220	149	Dacia	Lodgy	2012	2015	diesel	none	90	0.8125	4	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_14ad4209fa37cc694f1e0a25	149	Dacia	Lodgy	2012	2015	petrol	none	83	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bd71d741b8fb25a837b5743d	149	Dacia	Lodgy	2015	2017	petrol	none	102	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68017aac38f43d2205e7f57b	149	Dacia	Lodgy	2016	2018	diesel	none	90	1	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5c5cc063e978e5f62941cd7b	149	Dacia	Lodgy	2018	2022	diesel	none	116	0.763	5	4.3	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_83e0a494587e00e91385757b	149	Dacia	Lodgy	2019	2022	diesel	none	95	1	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_259e0bbadc7e15bcb6d151f9	119	Dacia	Logan	2011	2015	diesel	none	89	0.7692	7	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4287a69d88a83076f80d98cd	119	Dacia	Logan	2011	2013	lpg	none	83	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_90ef3827d54234d416bdc206	119	Dacia	Logan	2011	2013	diesel	none	75	0.8333	3	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38aa482787a7ab62e182b767	119	Dacia	Logan	2011	2012	petrol	none	85	1	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3709a34d72c84d7162d6d703	119	Dacia	Logan	2013	2015	lpg	none	74	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_339c3efda01206410a85f130	119	Dacia	Logan	2014	2015	petrol	none	74	0.8571	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2f73c2185952ec47c5d36fc8	119	Dacia	Logan	2018	2021	petrol	none	73	0.7576	4	5.1	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7cb86e141acf1a62fa23c379	68	Dacia	Sandero	2011	2014	diesel	none	89	0.9091	6	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5a04b3886670251eea3e0bab	68	Dacia	Sandero	2011	2013	lpg	none	84	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fe32ff0cfffd58c229e9192b	68	Dacia	Sandero	2014	2017	petrol	none	74	0.8421	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02f248cdbf099188f64174f8	68	Dacia	Sandero	2014	2015	lpg	none	74	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e4463b261b383b52265b678b	68	Dacia	Sandero	2018	2021	diesel	none	95	0.9982	3	3.7	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5a05920ed0c551b84bdda164	68	Dacia	Sandero	2021	2025	petrol	none	67	0.9742	5	5	5.3358	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_13420f3d765fdba846107739	68	Dacia	Sandero	2023	2025	petrol	none	110	0.938	3	5.5	5.5902	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2a483a53dee72ae6e0c78a6a	110	Dacia	Spring	2021	2025	electric	electric	45	1	3	\N	\N	13.9	14.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9d1f4d51007bf6c720c7de20	133	DS	DS 3	2023	2025	petrol	none	131	0.9226	3	6	6.14	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_03e6a77d46be70f6f01d4af5	159	DS	DS 4	2021	2025	petrol	none	131	1	5	6	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c55f1f42f17e14eb991560c	159	DS	DS 4	2022	2024	petrol/electric	plug_in_hybrid	179	1	3	6.5	6.5	14.6	15.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_28759a1c09476087f0240cbe	159	DS	DS 4	2023	2025	diesel	none	131	1	3	5.2072	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_72d296949ab8a79a6141465c	128	DS	DS 7	2022	2025	diesel	none	131	1	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	85	Fiat	500	2011	2017	petrol	none	85	0.75	10	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7632b82caa9bbc577d6cd356	85	Fiat	500	2011	2017	petrol	none	103	0.7222	8	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a6b996e81b655bc9dd82f991	85	Fiat	500	2012	2016	diesel	none	76	1	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_baf6299db406dda0ee32a29c	85	Fiat	500	2012	2014	diesel	none	95	0.7143	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8912494e0329489429e4d20d	85	Fiat	500	2013	2016	lpg	none	69	0.8571	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9327f2ce137e0989434c76e6	85	Fiat	500	2015	2021	diesel	none	95	0.7	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_431b32bb7fb00ee337a07101	85	Fiat	500	2019	2023	lpg	none	69	1	5	5.6	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_846adab277602c511db0b83b	85	Fiat	500	2020	2024	petrol	hybrid	71	0.8225	5	4.6	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1b481ffdb73b269c1b9a4a76	35	Fiat	500L	2013	2017	petrol	none	95	0.8333	5	6.5	6.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c7989d9916381604cc80654	35	Fiat	500L	2013	2016	diesel	none	84	0.7586	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_144b6e5dc2777236668e2a25	35	Fiat	500L	2013	2015	diesel	none	105	1	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a4ecb031518dcf965c2219ff	35	Fiat	500L	2014	2019	lpg	none	120	0.9783	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a31a55cd0acd3a9424d8cd83	35	Fiat	500L	2019	2022	petrol	none	95	0.9156	4	6.3	6.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d8606a060e74dedb91c89081	88	Fiat	500X	2015	2017	petrol	none	139	0.8696	4	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1754a7f9c39966712dc9debd	88	Fiat	500X	2015	2017	diesel	none	140	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e9168bf2c3636ab10c379bc9	88	Fiat	500X	2015	2017	petrol	none	170	1	3	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_95260ceafd00d307b6c05688	88	Fiat	500X	2019	2025	diesel	none	95	0.8355	6	4.6	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_60f77400b02d0bd0675418c0	88	Fiat	500X	2019	2025	petrol	none	120	0.8341	7	5.8	6.4625	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ae406e6179efa3eeafc23b75	88	Fiat	500X	2019	2022	petrol	none	150	0.8816	5	5.9	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c21c19980c3786098861b117	88	Fiat	500X	2021	2023	diesel	none	131	0.9807	3	4.8	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cc196b7a6cb71a5dd20bc368	174	Fiat	Bravo	2011	2013	petrol	none	140	0.75	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4ac4af8e1d2b1b810f33403f	174	Fiat	Bravo	2012	2015	diesel	none	120	0.7692	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c7b91d01a842775bf412cf10	113	Fiat	Doblo	2011	2014	diesel	none	135	0.9808	2	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4cdb60d05bca91e70bf8c9a5	113	Fiat	Doblo	2011	2014	diesel	none	84	1	2	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_87ea28c812dbb7dd0efdc7f6	113	Fiat	Doblo	2014	2017	petrol	none	95	0.8966	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_45c8af4c5c6599aa0afdddae	113	Fiat	Doblo	2015	2017	diesel	none	120	0.92	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fd3c4a1acd546e5b4b36c9ec	113	Fiat	Doblo	2015	2017	diesel	none	95	0.8909	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c534a6561670be6917e63eaf	199	Fiat	Freemont	2012	2016	diesel	none	140	0.8571	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e98d4e557390049ac531704a	18	Fiat	Panda	2012	2017	petrol	none	86	0.7857	11	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1565669f7d549a5c1fbccad6	18	Fiat	Panda	2012	2014	petrol	none	60	0.8889	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c350de9f19d753c6738c05d9	18	Fiat	Panda	2012	2014	petrol	none	53	1	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_64a101e4936ef978ffa5b0bc	18	Fiat	Panda	2012	2014	diesel	none	69	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_91f61976f3b89a01b05ba3fa	18	Fiat	Panda	2014	2016	lpg	none	69	0.8182	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ef50464a6c61b291557074c8	18	Fiat	Panda	2016	2019	diesel	none	95	0.8571	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e48eef896e4fdd3e58e82e0a	18	Fiat	Panda	2019	2024	lpg	none	69	0.9554	6	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2276f3a35cbb484bb473db81	18	Fiat	Panda	2019	2022	petrol	none	86	0.9223	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_620cfced874bf2dd6c510036	58	Fiat	Punto	2011	2015	petrol	none	68	0.8304	8	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9955b405f0f2a1364eac185c	58	Fiat	Punto	2011	2014	diesel	none	93	0.75	6	3.4	3.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_48a9753b2244a6f0dc4837c9	58	Fiat	Punto	2012	2014	diesel	none	75	0.8276	2	3.4	3.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_395d69fcddea66e6a034f611	58	Fiat	Punto	2012	2014	petrol	none	60	1	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_320f577a01e998f54eb23e91	58	Fiat	Punto	2017	2019	petrol	none	69	0.8846	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1b9aa2205bd468090eabbc0c	58	Fiat	Punto	2019	2021	diesel	none	95	0.9938	3	3.4	3.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6742936d96ceae09e7783ad0	150	Fiat	Qubo	2011	2014	diesel	none	95	0.875	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a110b590ebdfe68515a11a0	150	Fiat	Qubo	2012	2014	petrol	none	74	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_40e740c2b966d340739eaece	150	Fiat	Qubo	2013	2017	diesel	none	77	0.7143	7	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c98476cf485762ae66698660	56	Fiat	Tipo	2016	2021	petrol	none	96	0.942	6	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_90f8838565525cb2304fc4e9	56	Fiat	Tipo	2016	2020	petrol	none	120	0.9556	4	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5a4c9082f8a9a5bc7cba5d7e	56	Fiat	Tipo	2016	2019	lpg	none	120	0.75	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_079b22ff3eaf5b67bcb9d9eb	56	Fiat	Tipo	2021	2023	diesel	none	95	0.8126	3	4.1	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b3a610666b4036f8eab6746e	56	Fiat	Tipo	2022	2024	petrol	hybrid	131	0.7771	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	185	Ford	B-Max	2012	2018	petrol	none	103	0.7308	13	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ccf6b7c10b33a8c52ce21b65	185	Ford	B-Max	2012	2014	petrol	none	90	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4b7421ffda1d13740d999ef5	185	Ford	B-Max	2012	2014	diesel	none	95	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cc660facacbec17fb1047fee	185	Ford	B-Max	2015	2018	petrol	none	90	0.8	4	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b8e4e9a76a131007a9163aa7	176	Ford	C-Max	2011	2019	diesel	none	118	0.732	11	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68dc824b0a3c598a4c21d996	176	Ford	C-Max	2011	2016	petrol	none	103	1	7	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_630171113d68c04cf9a160b3	176	Ford	C-Max	2011	2015	diesel	none	163	1	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59b3e9bceaeb55aef9d86fc6	176	Ford	C-Max	2012	2014	lpg	none	120	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aba7406be43df57941ef44eb	176	Ford	C-Max	2012	2014	diesel	none	95	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	96	Ford	Fiesta	2011	2017	diesel	none	73	0.7727	10	3.5	3.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bcd08b1667780fbdd35aa82d	96	Ford	Fiesta	2011	2015	petrol	none	101	0.75	9	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_654d6c8205214589e951be40	96	Ford	Fiesta	2011	2014	petrol	none	81	0.7813	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3e5ce6836ad254cec5d4cc04	96	Ford	Fiesta	2015	2017	petrol	none	81	0.75	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a8a32eb5317af04d2eaeb443	96	Ford	Fiesta	2017	2021	petrol	none	73	0.7441	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_febf1e297eb6b56cc3794ac6	96	Ford	Fiesta	2022	2024	petrol	none	200	0.8377	3	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dab00250fdf1c19313482d09	61	Ford	Focus	2011	2018	diesel	none	118	0.7326	12	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_35e5c28082c2dfb672aaf3fc	61	Ford	Focus	2011	2015	petrol	none	150	1	5	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_46d4d1eda91a56a9cb272522	61	Ford	Focus	2011	2014	petrol	none	103	0.7778	6	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8d27ef4541ef85071bdbc0f0	61	Ford	Focus	2011	2014	diesel	none	163	0.875	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2663ad670690171bb0e94655	61	Ford	Focus	2020	2024	petrol	hybrid	155	0.9733	4	5.4	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_97207a233ddd9fc360f07dc1	61	Ford	Focus	2022	2024	petrol	hybrid	125	0.8473	3	5.3	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2097ec89e80ec2b593be8abc	61	Ford	Focus	2022	2025	diesel	none	118	0.8156	6	4.7	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5521dcd4130c876f346742f5	61	Ford	Focus	2023	2025	petrol	none	280	0.8966	3	8	8.0302	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3d63dcd1985686d4ff5e1dde	130	Ford	Ka	2013	2018	petrol	none	70	0.7273	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2e810533cf760faa40ea99ac	52	Ford	Kuga	2011	2015	diesel	none	139	0.9091	5	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1039cabd8a0dab1dc98b9330	52	Ford	Kuga	2011	2015	diesel	none	163	0.8	5	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0c9efe9e5aff611d5098c378	52	Ford	Kuga	2014	2016	diesel	none	118	0.8333	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_121ad32fa1b02b5e0a276ada	52	Ford	Kuga	2020	2022	petrol	none	151	1	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d5225cadde5eb8370f6caeff	52	Ford	Kuga	2022	2024	petrol	hybrid	152	0.8645	4	5.1	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_929529d1d0b43d43bb3804fc	164	Ford	Mondeo	2011	2015	petrol	none	160	0.7143	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fc4f446efa3f7d29bd45ac75	164	Ford	Mondeo	2012	2016	diesel	none	117	0.7059	6	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_350fc92884b00b617bae8537	164	Ford	Mondeo	2017	2018	petrol	none	163	1	2	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68798a8dd9bfd982aa60b914	200	Ford	Mustang	2015	2019	petrol	none	317	0.7838	5	9	9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0a5dd2d8997cc76c1ff24e89	200	Ford	Mustang	2015	2018	petrol	none	421	0.7143	4	9	9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	200	Ford	Mustang	2018	2021	petrol	none	291	0.8281	4	9	9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68f72bcc9d5fa9b485ec115f	200	Ford	Mustang	2020	2025	petrol	none	448	0.7826	8	11.3	12.1879	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_898957f96a4fbd692fc5648c	200	Ford	Mustang	2020	2022	petrol	none	460	0.963	3	11.8	12	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f0fd986cbfbaffdb50ea654a	65	Ford	Puma	2020	2022	diesel	none	120	0.989	3	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dca4567f62d8c8fc2998d795	65	Ford	Puma	2022	2024	petrol	hybrid	155	1	2	5.7	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2bf5cee24de6b9fa33e4170f	186	Ford	S-Max	2011	2019	petrol	none	161	1	9	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_81a843dc1f7505ca4b697a6c	186	Ford	S-Max	2011	2015	diesel	none	163	0.7941	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c65277e54f30fb2e56a537d5	186	Ford	S-Max	2011	2014	diesel	none	116	0.8571	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ac68792e64142134db80bd60	186	Ford	S-Max	2011	2014	petrol	none	203	0.9	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_564d1e5d38d09568cf07b301	186	Ford	S-Max	2011	2013	diesel	none	200	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5a403191a4824e7addac80a8	186	Ford	S-Max	2013	2015	diesel	none	140	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_200f4f2edaafb80829453893	186	Ford	S-Max	2018	2022	diesel	none	190	0.7037	4	5.3	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_456665ddf436a476288289f0	186	Ford	S-Max	2019	2022	diesel	none	150	0.8191	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_29573fe846d3d2fbe415c52c	211	Honda	CR-V	2013	2015	diesel	none	150	0.8333	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e968fb822f51c0a21005be06	211	Honda	CR-V	2015	2018	diesel	none	160	1	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0185bf219f4f4fc691535905	211	Honda	CR-V	2016	2019	diesel	none	120	1	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a3d241ef1aaab2a16b72c533	211	Honda	CR-V	2016	2018	petrol	none	155	0.75	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4dfe191ab66231ca338b22bc	211	Honda	CR-V	2018	2020	petrol	none	173	0.9885	3	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fc38fe94d62fd995bed8ea9b	211	Honda	CR-V	2018	2020	petrol	none	193	1	3	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_610e46a0a4675ccb4ee5d107	305	Honda	e	2020	2023	electric	electric	154	1	2	\N	\N	17.8	17.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ff808709e68db9c5857b2315	207	Honda	HR-V	2015	2018	diesel	none	120	1	4	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_383ad1b8b0eb10bd03ec2b1d	230	Honda	Jazz	2013	2015	petrol	none	90	0.75	3	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_911428c3c6f008102abf01cf	230	Honda	Jazz	2015	2020	petrol	none	102	0.775	6	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cc1c41ac32d57d23fa829716	230	Honda	Jazz	2020	2022	petrol	hybrid	98	1	3	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	238	Hyundai	Bayon	2021	2025	petrol	none	82	0.8143	6	5.6	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f3d3dffba8c19efec8721e8e	238	Hyundai	Bayon	2021	2023	petrol	hybrid	101	1	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c3f84c69e6369b89efc8d9c7	76	Hyundai	i10	2011	2022	petrol	none	68	0.7	14	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e3104090831b01cb95f4d11d	76	Hyundai	i10	2014	2019	petrol	none	87	0.8333	6	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2a1e66c2d77272b1a7660a67	76	Hyundai	i10	2014	2019	lpg	none	69	0.9998	6	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_00578c53fe9cb2f7894a1bd4	76	Hyundai	i10	2023	2025	petrol	none	65	0.9995	4	5.1	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8d295141028f49b406888dff	13	Hyundai	i20	2012	2016	petrol	none	85	0.75	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b95e4c3ab69feb4f06b50e04	13	Hyundai	i20	2020	2025	petrol	none	83	0.8509	8	4.9	5.404	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9b6a5a4b92da7afb99d11977	13	Hyundai	i20	2022	2024	petrol	hybrid	101	0.9951	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2d973a75cf607b93143da3d9	307	Hyundai	i30	2012	2020	petrol	none	100	0.7105	10	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_23b5a415c88ec063cf1e86ec	307	Hyundai	i30	2012	2015	diesel	none	128	0.8235	4	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d1ef00a438efdb4787272a1	307	Hyundai	i30	2012	2014	diesel	none	110	0.9481	3	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_65a776f712d377490b978d8f	307	Hyundai	i30	2012	2014	diesel	none	90	0.9167	3	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f34da062384191634b99f3dc	307	Hyundai	i30	2012	2014	petrol	none	120	0.8	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e1ed0a1cf48f71c3df0dc847	307	Hyundai	i30	2020	2023	petrol	hybrid	120	0.8723	3	4.9	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_20c3b16a4f7839152fcf0909	205	Hyundai	Ioniq	2019	2022	petrol	hybrid	105	0.9032	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1fc5d44ddfb9714b9bb6b4b6	205	Hyundai	Ioniq	2019	2022	petrol/electric	plug_in_hybrid	105	0.9068	4	3.6	3.6	10.3	11.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ca997e9f6e05950b1c225434	314	Hyundai	Ioniq 5	2021	2022	electric	electric	73	1	3	\N	\N	16.8	17.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e1f2b3085f1c516a1243df92	311	Hyundai	Ioniq 6	2023	2025	electric	electric	325	1	3	\N	\N	16.9	16.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c0aede045d9a734267c70ba5	311	Hyundai	Ioniq 6	2023	2025	electric	electric	228	0.8837	3	\N	\N	16	16	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee32e72d9d42f3ee10adb48d	229	Hyundai	ix20	2011	2015	petrol	none	90	0.8	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_85178a5d9cf4c974b1aedb25	229	Hyundai	ix20	2011	2014	petrol	none	125	0.8	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c15884f371d35784afe732ba	229	Hyundai	ix20	2011	2014	diesel	none	77	0.9333	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_71f48502b588565e963bdb55	229	Hyundai	ix20	2012	2014	diesel	none	90	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7dea63529216382fb92e704d	229	Hyundai	ix20	2012	2014	diesel	none	116	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_be210c61be7864f45166c845	229	Hyundai	ix20	2016	2020	petrol	none	125	0.8571	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_33815a74b8b9d22fc5deab9f	229	Hyundai	ix20	2016	2019	petrol	none	90	0.9987	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9ddf8eda695c93def32b4813	8	Hyundai	Kona	2017	2019	petrol	none	120	1	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8725ca343c7de9e096d2b4d6	261	Hyundai	Santa Fe	2014	2016	diesel	none	150	1	2	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_39b37c7f45728a0e61f90ee5	261	Hyundai	Santa Fe	2019	2021	diesel	none	200	1	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5fabe29bd4ef8b87e780771d	261	Hyundai	Santa Fe	2020	2022	petrol	hybrid	179	1	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7e6fbc09e01c0ac2ba6f3bfe	316	Jaguar	E-Pace	2018	2020	diesel	none	241	1	2	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dfb6faec7dfc310805fc0b79	252	Jaguar	F-Pace	2016	2021	diesel	none	179	0.803	6	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2703d5f539feda4c6e611d72	252	Jaguar	F-Pace	2016	2021	diesel	none	300	0.8049	6	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6dc517bf762d8fa389fa3ec6	252	Jaguar	F-Pace	2017	2021	diesel	none	163	1	4	5.9	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7c03ea30795e24d2b2695699	252	Jaguar	F-Pace	2017	2021	diesel	none	241	0.8611	5	6.5	6.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_08012612ed7088243e005ff2	252	Jaguar	F-Pace	2017	2020	petrol	none	250	0.9636	3	7.8	7.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_262fee037e55ee7b09de5731	252	Jaguar	F-Pace	2022	2024	petrol	none	551	0.8846	3	11.4	12.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f8ad1da4b99d8e4b3b5a30bf	275	Jaguar	I-Pace	2018	2020	electric	electric	234	1	3	\N	\N	24.2	24.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7fb7cf04080d451fe9c90828	275	Jaguar	I-Pace	2023	2025	electric	electric	400	1	3	\N	\N	23.1	23.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6be3da42424b50593ca5a8c3	254	Jaguar	XE	2015	2021	diesel	none	179	0.8074	7	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_adeb136a459d81e33856670e	254	Jaguar	XE	2015	2020	diesel	none	163	0.8	6	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6f457986ac2202ba585dfd12	254	Jaguar	XE	2016	2020	petrol	none	200	1	4	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b8c5b3b7364fb7d96e8d849c	292	Jaguar	XF	2015	2020	diesel	none	163	1	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c62bacff2a7a3481f4e295ad	292	Jaguar	XF	2015	2018	diesel	none	300	0.9412	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ec1da0e884869b52328a1859	292	Jaguar	XF	2016	2020	diesel	none	179	0.7861	5	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_afeffea9669194bba6737d70	292	Jaguar	XF	2017	2021	diesel	none	241	0.878	4	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2e81e7ce8bb923f0f9791cba	22	Jeep	Compass	2020	2023	petrol/electric	plug_in_hybrid	131	0.7795	4	5.9	6	16.1	16.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d7268df3fd5b27442e5ee0c4	22	Jeep	Compass	2020	2022	petrol/electric	plug_in_hybrid	179	1	2	8.3	8.3	16.1	16.3	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f729de4f3aec95a68ec93d7a	22	Jeep	Compass	2023	2025	diesel	none	131	0.9264	3	5.3749	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7bb3d3d5e5b6c7d7e0110f69	44	Jeep	Renegade	2014	2017	diesel	none	140	0.7778	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c20e93b3974cc666f08ab9bd	44	Jeep	Renegade	2015	2017	petrol	none	140	1	2	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f7512dfa6d425ce2784f9769	44	Jeep	Renegade	2019	2022	petrol	none	150	0.7263	5	5.9	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5a2a23b7e1ee62757fb26704	44	Jeep	Renegade	2020	2024	petrol	none	120	0.7446	4	5.9	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4f1effb0fd32c57553d7fe28	44	Jeep	Renegade	2020	2022	petrol/electric	plug_in_hybrid	179	1	2	7.3	7.3	15.7	16	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f31c9493bda652a575830ba4	44	Jeep	Renegade	2021	2024	petrol	hybrid	131	1	3	5.6	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ae95d8a999cd5fb7f09f4986	44	Jeep	Renegade	2021	2024	petrol/electric	plug_in_hybrid	131	0.7409	4	5.6	5.8	15.6	16.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_40ac5e8177a0a71e42bfc541	44	Jeep	Renegade	2023	2025	diesel	none	131	0.8093	3	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	318	Kia	Ceed	2012	2017	petrol	none	100	0.7143	7	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dd72d657ff7b61ecc833b541	318	Kia	Ceed	2013	2016	lpg	none	99	1	4	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_da46ffca628d9a548c25d8f2	318	Kia	Ceed	2015	2018	diesel	none	110	0.7333	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cbc4f888b676f28f53f0d41a	318	Kia	Ceed	2018	2021	diesel	none	116	0.8377	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cdce12a12268c97f28303552	318	Kia	Ceed	2019	2021	lpg	none	100	0.9976	4	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_165c8dc37059882bdc5bd9a4	318	Kia	Ceed	2020	2024	petrol	none	204	1	5	6.8	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_daefa926387cd565c9f84c5c	318	Kia	Ceed	2020	2021	petrol	none	100	0.9718	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e6ba66e4eaca4724bc09893e	293	Kia	EV6	2021	2024	electric	electric	76	0.9329	3	\N	\N	16.5	17.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_659164701e0925e03e90484f	293	Kia	EV6	2021	2024	electric	electric	110	0.9914	3	\N	\N	18	18	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2c28cd29a5abae9b06d9e166	293	Kia	EV6	2021	2023	electric	electric	325	0.86	2	\N	\N	18	18	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a7610cdbc83cc0dce98454a6	293	Kia	EV6	2021	2023	electric	electric	228	0.8667	2	\N	\N	16.5	16.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_874358e15df2bfb81439d115	293	Kia	EV6	2022	2024	electric	electric	194	1	2	\N	\N	20.6	20.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a0ed297bd2f7b91d9b0863b2	43	Kia	Niro	2019	2021	petrol	hybrid	105	0.9322	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0c8677b685cedabe128946b5	43	Kia	Niro	2019	2021	petrol/electric	plug_in_hybrid	105	1	2	4.3	4.3	12.2	12.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b8a6c445015a8c030a42285a	43	Kia	Niro	2022	2024	electric	electric	68	1	2	\N	\N	16.2	16.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dd56cfdd39071b8a1d42d563	101	Kia	Picanto	2011	2013	petrol	none	69	0.8571	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aa02672758516804616f99fe	101	Kia	Picanto	2023	2025	petrol	none	66	0.9934	5	5.1	5.4218	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a0072556379ea3c5219f0cd3	101	Kia	Picanto	2024	2025	lpg	none	65	0.931	4	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3f32eda92652669e360df934	215	Kia	Rio	2012	2016	petrol	none	85	0.8	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9e29a4adddfbbc0107923eb8	215	Kia	Rio	2012	2014	diesel	none	90	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d16021089daa3ee7144b1595	215	Kia	Rio	2013	2015	lpg	none	86	1	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_82e2a42100e5598717b93a6a	215	Kia	Rio	2016	2019	diesel	none	76	1	5	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cd33446772e1af031c02c6fd	215	Kia	Rio	2020	2023	petrol	hybrid	101	1	2	4.9	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_92c59c92d7b0a6fa9721deb5	249	Kia	Sorento	2011	2013	diesel	none	197	0.8	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9f3b38e988b8ac6e184145fe	249	Kia	Sorento	2013	2015	diesel	none	150	0.8333	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_03da31cdee93b763bad925a1	249	Kia	Sorento	2015	2019	diesel	none	200	0.7692	5	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cd80c3d8144dc1b7c2711a44	249	Kia	Sorento	2018	2021	diesel	none	185	1	4	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b75b56ee951e0b7f0bef67ca	90	Kia	Sportage	2011	2014	diesel	none	116	0.8182	4	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2567805fa9d6d1a907c7adf7	90	Kia	Sportage	2011	2013	diesel	none	136	0.9	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_323f55ee85aa0efcb18f0d9e	90	Kia	Sportage	2011	2013	petrol	none	135	1	3	6.5	6.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_21514e093a29f2025ca8a4d5	90	Kia	Sportage	2016	2022	diesel	none	116	0.9259	6	4.4	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d4b044334a720ec9a9206d22	90	Kia	Sportage	2016	2022	petrol	none	132	0.7268	6	6.5	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_face50e632885766e2fc877c	90	Kia	Sportage	2016	2018	diesel	none	185	0.8528	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_34396baea8d755c52e7595b6	90	Kia	Sportage	2016	2020	diesel	none	138	0.919	7	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7e3c739cbd505121f3d39694	90	Kia	Sportage	2019	2022	lpg	none	132	1	3	6.8	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c1e904dbe7caaefb2c3b2b2c	90	Kia	Sportage	2021	2024	petrol	hybrid	179	0.9998	3	5.7	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2db82929d7de1571a31b1246	90	Kia	Sportage	2022	2024	diesel	hybrid	136	0.9799	2	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7f465d523a3ac0379231edfb	90	Kia	Sportage	2022	2025	lpg	none	150	1	3	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6461bd058a65f36ae6ed528b	212	Kia	Stonic	2017	2019	diesel	none	110	1	3	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5494c5197acde5744aa43700	212	Kia	Stonic	2018	2021	lpg	none	99	0.875	4	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5bb5b424bf86aeb91d156e85	212	Kia	Stonic	2019	2021	petrol	none	99	0.9882	3	5.5	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_18ae29972b003bd89fa11d83	212	Kia	Stonic	2019	2021	diesel	none	116	1	3	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ed9c07725130f34a96d850b9	212	Kia	Stonic	2020	2024	petrol	hybrid	101	0.8758	3	5.3	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_21b426a0bebb2cf74b2b803b	212	Kia	Stonic	2023	2025	petrol	none	82	1	5	5.7	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_83db8db21fbf899818362ee0	266	Kia	Venga	2011	2016	diesel	none	90	0.75	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_828c820efb603fcb63595641	266	Kia	Venga	2011	2015	diesel	none	77	0.75	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_634e893bb103f135475354f7	266	Kia	Venga	2011	2013	diesel	none	116	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d7733993f7f0f9c37a9533a	266	Kia	Venga	2013	2015	diesel	none	128	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ff83279fb31a0ca83143007f	266	Kia	Venga	2015	2019	petrol	none	90	0.9911	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f4120ad42efc8a56b570a1f9	266	Kia	Venga	2017	2019	lpg	none	90	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a837abf2c62dcc78e1397446	272	Kia	XCeed	2019	2021	petrol	none	140	1	3	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e223a12d60c4aa5b14025beb	272	Kia	XCeed	2019	2021	diesel	none	116	1	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e8bebe1dd89b26bcf2b936ca	272	Kia	XCeed	2019	2021	diesel	none	136	1	3	4.3	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7c5d4faeb6b4f03cac209505	272	Kia	XCeed	2021	2024	petrol	hybrid	160	1	4	6.2	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f800c457cd2bbf1371d477df	272	Kia	XCeed	2022	2024	diesel	hybrid	136	0.8012	3	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b45ff59f2cc575a44fa895ed	62	Lancia	Delta	2011	2013	lpg	none	120	0.9892	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b90b8e4d5cbbae0b060704cb	62	Lancia	Delta	2011	2013	petrol	none	140	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b3d0600b391367428cb145ec	62	Lancia	Delta	2011	2013	petrol	none	200	0.8333	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_25c9143c59824582d7f5a05c	17	Lancia	Musa	2011	2013	diesel	none	95	0.92	2	3.4	3.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_361c2f4383be5d4cf773ba0b	1	Lancia	Ypsilon	2011	2015	petrol	none	85	1	7	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b395d899258f8adc96c056b7	1	Lancia	Ypsilon	2012	2016	petrol	none	69	0.8199	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6812be04d4a4e5d1462977b7	1	Lancia	Ypsilon	2013	2017	lpg	none	69	0.7143	4	6.1	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e8207ccf2af3d3e7486b0dce	1	Lancia	Ypsilon	2017	2019	diesel	none	95	0.9899	2	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0a49735dca5feeb4da4e6c7e	1	Lancia	Ypsilon	2019	2025	lpg	none	69	0.9991	7	6	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_60b49c99952ed85f9380cebd	210	Land Rover	Discovery Sport	2019	2021	diesel	hybrid	150	0.9877	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cdd35acc7d35f1dd1b4f78ae	246	Land Rover	Range Rover	2012	2014	diesel	none	249	0.8	3	7.9	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f6c5e2ac5739dfdeb86c3152	246	Land Rover	Range Rover	2014	2017	diesel	none	340	0.8235	2	7.9	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5ebe031a972e1f9bb2060a3b	246	Land Rover	Range Rover	2014	2017	petrol	none	510	1	4	12.7	12.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b460f042d8e19c1d5d349d61	246	Land Rover	Range Rover	2022	2024	diesel	hybrid	249	0.8115	3	7.8	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7491f45e23d5da905e41ca7d	246	Land Rover	Range Rover	2022	2024	diesel	hybrid	300	0.9167	3	7.8	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_af8c20bf063ff44ee91816ff	278	Land Rover	Range Rover Evoque	2011	2015	petrol	none	241	0.9091	4	9.1	9.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c76ac680b6f9f73f7ace5bf1	278	Land Rover	Range Rover Evoque	2011	2013	diesel	none	150	0.72	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e69b9289445449c4cc00830f	278	Land Rover	Range Rover Evoque	2011	2013	diesel	none	190	0.913	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6fe7492008c05b1f436dcfbc	256	Land Rover	Range Rover Sport	2011	2012	diesel	none	246	1	3	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f40a16088de29839b619ede0	256	Land Rover	Range Rover Sport	2013	2015	diesel	none	292	1	3	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ab36d6175149363b9caf3ffe	256	Land Rover	Range Rover Sport	2014	2017	petrol	none	510	1	3	12.3	12.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a193836c6f58080c7ecb9ae5	256	Land Rover	Range Rover Sport	2014	2017	diesel	none	258	0.75	4	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_da04b49648dfca9ff484ba6d	273	Land Rover	Range Rover Velar	2019	2021	diesel	none	179	0.894	3	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_458df72a5994476d210d94fc	274	Maserati	Ghibli	2018	2022	petrol	none	349	0.977	4	10.5	11	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5ba74950c89a95646ddcbe8f	294	Maserati	Levante	2018	2022	petrol	none	349	0.7384	4	11.1	11.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_318a687ff433708d653cfaad	224	Mazda	2	2015	2019	petrol	none	90	0.909	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0ca5b101ad5ad24664a429e8	224	Mazda	2	2015	2019	diesel	none	105	0.7851	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0e55a37de808651be0b68ade	224	Mazda	2	2016	2019	petrol	none	75	0.917	3	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8751a6cebbc311ccf73e2f00	224	Mazda	2	2016	2019	petrol	none	116	0.7647	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_79822b716d002d357db72c1b	224	Mazda	2	2020	2024	petrol	hybrid	90	0.932	5	4.1	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a719fe65f74c25b09e83df2e	296	Mazda	3	2011	2019	petrol	none	102	0.7	10	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6622b88de1030d9fa70e0ef8	296	Mazda	3	2011	2013	diesel	none	116	0.75	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b35ce5574967170d67b4a29d	296	Mazda	3	2012	2018	diesel	none	150	0.75	7	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e902c5839b84d5bdae8c15e3	296	Mazda	3	2016	2018	diesel	none	105	0.9977	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_15f06de45ea26f08db566307	296	Mazda	3	2016	2018	petrol	none	165	1	2	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_adf4da102172c0021b89a9ed	296	Mazda	3	2020	2024	petrol	hybrid	150	0.8965	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_903e5d58493aab8ed0ce1646	296	Mazda	3	2021	2024	petrol	hybrid	122	0.9272	4	5	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a04896489d6c50307c6942e4	279	Mazda	6	2011	2014	diesel	none	177	0.8636	5	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_20bd5818d09f12ae83417fa3	279	Mazda	6	2013	2020	diesel	none	150	0.7	7	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_54d98288c3690b65c7e7d2f6	279	Mazda	6	2016	2022	petrol	none	165	0.9167	5	6.5	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c15cfd1988b3db87797b265e	279	Mazda	6	2017	2022	petrol	none	194	1	6	6.5	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68702bd6ff7574a0a03490b0	279	Mazda	6	2018	2020	diesel	none	184	0.953	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e5760d86c8e23f5bd2747508	219	Mazda	CX-3	2015	2019	petrol	none	120	0.8889	6	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_65dc8c96b8b60133e928ddef	219	Mazda	CX-3	2015	2019	petrol	none	150	0.7149	5	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_51395de615e600407b259b6f	219	Mazda	CX-3	2015	2019	diesel	none	105	0.7288	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_54914ff16510837a79e6cdf0	312	Mazda	CX-30	2019	2024	petrol	hybrid	122	0.9395	5	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fe85b022b40beafcf275ba44	312	Mazda	CX-30	2019	2021	petrol	hybrid	179	0.9056	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3f3809bf656b97330a578535	312	Mazda	CX-30	2019	2021	diesel	none	116	1	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5c076dcbe5d42b6a58adc8a	312	Mazda	CX-30	2020	2024	petrol	hybrid	150	0.9402	4	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9a6c937e0ef03dc414e16adf	222	Mazda	CX-5	2013	2019	diesel	none	175	0.7143	7	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_19b001f72ed3e8e43c2997c0	222	Mazda	CX-5	2013	2016	diesel	none	150	0.8571	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0bde2d27bd065fb942fa18f4	222	Mazda	CX-5	2014	2016	petrol	none	163	0.75	6	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	222	Mazda	CX-5	2018	2023	petrol	none	165	0.8042	5	6.7	7.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1d49bb2ae3a07b02e99a1393	222	Mazda	CX-5	2018	2020	diesel	none	184	1	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c4b022ccf42f3391c4dd668b	222	Mazda	CX-5	2022	2025	diesel	none	150	0.8775	4	5.9705	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b861679d270ec0bf7c3e3803	222	Mazda	CX-5	2022	2025	diesel	none	184	0.93	4	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	245	Mazda	MX-30	2020	2025	electric	electric	145	1	5	\N	\N	17.3	19	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_785450072dcb1a57a9d5a2cb	295	Mazda	MX-5	2016	2020	petrol	none	131	0.75	7	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d7fb4c4b7f6db405726c61dc	295	Mazda	MX-5	2018	2022	petrol	none	184	0.7031	5	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0e8de08fa3c88a29d32ff553	295	Mazda	MX-5	2021	2023	petrol	none	132	0.8241	3	6.1	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_82e5c5cc38dd3c17cfb3b4a6	30	Mercedes-Benz	A-Class	2014	2017	petrol	none	211	0.7647	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9ad3e9be6a2780fd6349c950	30	Mercedes-Benz	A-Class	2015	2018	petrol	none	102	1	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_eeaa56aef7b8f10f882b4618	30	Mercedes-Benz	A-Class	2015	2017	petrol	none	156	1	2	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1de2e7cd607850d74931b03d	30	Mercedes-Benz	A-Class	2015	2017	petrol	none	184	1	2	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_98686e3ee7d9d65304f6d894	30	Mercedes-Benz	A-Class	2019	2022	petrol	none	109	0.9055	4	5.8	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_defe12b31239d302d50898b6	30	Mercedes-Benz	A-Class	2021	2024	diesel	none	150	0.7159	4	4.7	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d9e3c4c0d44c4575d32ed5d1	30	Mercedes-Benz	A-Class	2022	2024	diesel	none	116	0.9401	3	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6340b81761ba6a066b1b3671	30	Mercedes-Benz	A-Class	2023	2024	petrol/electric	plug_in_hybrid	162	0.9989	3	6	6	17.1	18.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0b7eb1ea94c112a1897104e2	81	Mercedes-Benz	B-Class	2013	2017	petrol	none	184	0.7333	5	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2f22c378bb2120105d36fe32	81	Mercedes-Benz	B-Class	2015	2017	petrol	none	122	0.8049	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_288def3161339ef38d1d2bbf	81	Mercedes-Benz	B-Class	2015	2017	petrol	none	102	1	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_60c137fbbbb2c8549045aee7	81	Mercedes-Benz	B-Class	2015	2017	petrol	none	156	0.9444	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ec88d4d0760a02a7ac68d79c	81	Mercedes-Benz	B-Class	2015	2017	petrol	none	211	1	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_be49f5ac1c29892cbfe034db	81	Mercedes-Benz	B-Class	2019	2023	petrol	none	136	0.9583	5	5.6	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fc9502150f5dabdc86d99a96	81	Mercedes-Benz	B-Class	2020	2022	petrol	none	109	0.9915	3	5.7	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0638760d0ea651f190745321	81	Mercedes-Benz	B-Class	2022	2024	diesel	none	116	0.9014	3	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2755f42e0c30f6b434eb4fd6	81	Mercedes-Benz	B-Class	2022	2024	diesel	none	150	0.9245	3	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_665e402e72979657bbc39347	81	Mercedes-Benz	B-Class	2023	2024	petrol/electric	plug_in_hybrid	162	0.9826	3	6.1	6.1	17.4	18.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7116268db5091f1f0e99593c	104	Mercedes-Benz	C-Class	2013	2015	diesel	none	118	1	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5c9a766b2b8ca882c0f82928	104	Mercedes-Benz	C-Class	2015	2019	diesel	none	136	0.9651	3	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b0c29f158123c5d30d4dce2a	104	Mercedes-Benz	C-Class	2018	2020	diesel	none	194	0.8414	3	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bdc8d7f4307d77fe4f08b852	104	Mercedes-Benz	C-Class	2019	2021	diesel	none	245	0.7632	3	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c3bfc982dd64164641c8fad9	104	Mercedes-Benz	C-Class	2021	2024	diesel	hybrid	200	0.8975	4	4.7	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_80bb241f989c8d3a20144720	104	Mercedes-Benz	C-Class	2021	2024	petrol	hybrid	204	0.8571	4	6.2	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2472c384a2263c816a3d4342	104	Mercedes-Benz	C-Class	2022	2024	diesel	hybrid	163	0.9709	3	4.4	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b6fac41c7f937dfbfc5d9657	84	Mercedes-Benz	CLA	2015	2019	diesel	none	177	0.9505	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_23abcb15d6b75201b43045c1	84	Mercedes-Benz	CLA	2015	2017	petrol	none	156	1	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59536e12aff9944244075d40	84	Mercedes-Benz	CLA	2015	2017	petrol	none	122	0.9474	2	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0dff13e78582f3304bbf65bf	84	Mercedes-Benz	CLA	2019	2024	diesel	none	150	0.8658	6	4.8	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_578105df0cee8f7120c25ee4	84	Mercedes-Benz	CLA	2019	2022	petrol	none	224	0.8636	4	6.8	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0bbb9fc649343bce88517728	84	Mercedes-Benz	CLA	2019	2021	petrol	none	163	0.8931	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5c0b8d45195268c09d4219f4	84	Mercedes-Benz	CLA	2019	2021	petrol	none	136	0.9848	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3c81a2da25ba93f3e46fd342	84	Mercedes-Benz	CLA	2022	2024	diesel	none	116	0.9495	3	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c6a980d82aa86b8b6970aa55	84	Mercedes-Benz	CLA	2022	2024	petrol/electric	plug_in_hybrid	162	0.9783	4	6.2	6.3	15.3	18	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3bd421a78fc199dd46cdd482	84	Mercedes-Benz	CLA	2022	2024	diesel	none	190	0.84	3	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a131b8f2a499374e9807e219	20	Mercedes-Benz	E-Class	2012	2014	petrol	none	306	0.8333	2	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4d34d426e9e87b3da8755ba5	80	Mercedes-Benz	GLA	2014	2019	diesel	none	170	0.8182	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0d99addd97e477822155d0e0	80	Mercedes-Benz	GLA	2014	2017	petrol	none	156	0.7778	4	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_19b38d4a17cf573de636f16d	80	Mercedes-Benz	GLA	2014	2017	petrol	none	211	0.8	3	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b2be6a6cea77709fc40931f1	80	Mercedes-Benz	GLA	2015	2018	diesel	none	109	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a0d1335c4ffc12d153c9b368	80	Mercedes-Benz	GLA	2015	2018	diesel	none	177	0.8846	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_69b4e0d55c9b39e5517734fe	80	Mercedes-Benz	GLA	2015	2017	petrol	none	122	1	2	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8edd1bffc70e741506f48ac1	80	Mercedes-Benz	GLA	2020	2024	diesel	none	150	0.7832	5	5.2	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e632a20b39862d808148bf98	80	Mercedes-Benz	GLA	2020	2024	diesel	none	190	0.8272	5	5.3	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d7fbec38d604adf04362c59d	80	Mercedes-Benz	GLA	2020	2023	petrol	none	163	0.8424	4	6.6	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6aff0f25e63729cee8b81298	80	Mercedes-Benz	GLA	2020	2023	petrol	none	224	0.8824	4	7.5	7.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e972cb0a82fcff7858206e5a	80	Mercedes-Benz	GLA	2022	2024	diesel	none	116	0.9989	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59fa1128f1dd4a81571c093c	80	Mercedes-Benz	GLA	2023	2024	petrol/electric	plug_in_hybrid	162	1	3	6.8	6.8	18.1	19.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ab00de67b58dd8994e2ea3c6	156	Mercedes-Benz	GLB	2022	2025	diesel	none	150	0.7497	4	5.5	5.728	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bbbb98d262309a16a97edae2	156	Mercedes-Benz	GLB	2022	2024	diesel	none	116	0.9357	3	5.5	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2449ecc2dd72b3888501abb1	78	Mercedes-Benz	GLC	2019	2022	diesel	none	163	0.8209	4	5.3	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_24871eb6a7b8cb96efc12ddf	201	Mercedes-Benz	GLE	2015	2020	diesel	none	258	0.7531	5	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f084817676c009f32129f1ee	201	Mercedes-Benz	GLE	2015	2019	diesel	none	204	0.7105	4	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_079b719495799c9aed9b8f2e	201	Mercedes-Benz	GLE	2019	2021	diesel	none	245	0.7136	3	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68e7d3109a70d0c0469c420d	201	Mercedes-Benz	GLE	2020	2023	diesel/electric	plug_in_hybrid	195	0.8715	5	6.4	6.4	26.5	28.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0f5e1ab1a4c31216d3f9d284	201	Mercedes-Benz	GLE	2020	2023	diesel	none	330	0.7692	4	7.7	8.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e32f7c6fa6bfc6ea82cfaecf	146	Mercedes-Benz	GLS	2017	2020	diesel	none	258	0.8	4	7.9	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	144	Mercedes-Benz	S-Class	2012	2017	diesel	none	204	0.7273	5	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_76a31e57a66f5e31d66b8444	241	MG	HS	2022	2025	petrol	none	162	1	4	7.5257	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_65d4fb68328554df9cbabced	300	MG	ZS	2021	2025	petrol	none	109	0.7965	10	6.6	6.8904	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_48ec7b43dea9218d9797b2fd	218	Mitsubishi	ASX	2013	2019	diesel	none	115	0.7143	9	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c767dae8b4371fc566e472a	218	Mitsubishi	ASX	2017	2020	petrol	none	117	0.8444	4	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_049881cfec4012949c24d25b	218	Mitsubishi	ASX	2019	2021	petrol	none	150	0.9654	3	6.7	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7515e51a4e5cdddb62c155b6	267	Mitsubishi	Eclipse Cross	2017	2021	petrol	none	163	0.7283	5	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f65f440260150773e99b24c0	267	Mitsubishi	Eclipse Cross	2022	2024	petrol/electric	plug_in_hybrid	98	1	2	1.7	1.7	19.3	19.3	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ea4e0026710d5781e154215c	239	Mitsubishi	Outlander	2011	2013	diesel	none	177	0.8333	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	239	Mitsubishi	Outlander	2012	2017	diesel	none	150	0.8	6	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38ddc58ccf0338a5edd74766	239	Mitsubishi	Outlander	2012	2014	diesel	none	156	0.8	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2758648eced75d745b473ee1	239	Mitsubishi	Outlander	2014	2018	petrol	none	121	0.8333	4	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68ada9bcfacb9e78efff90bb	239	Mitsubishi	Outlander	2016	2021	petrol	none	150	0.9485	6	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_376af900981c3fb9aaf7fbf6	242	Mitsubishi	Pajero	2015	2019	diesel	none	190	0.7829	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38641061dc0c7f62537f78e2	301	Mitsubishi	Space Star	2013	2021	petrol	none	80	0.7143	9	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_757f3717a0e3dba8a826c688	66	Nissan	Juke	2011	2022	petrol	none	116	0.7	21	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8577889ba1273ab65a93b31b	66	Nissan	Juke	2011	2017	petrol	none	190	0.8571	6	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_76cff748f7dff6d455416753	66	Nissan	Juke	2011	2014	diesel	none	110	0.9231	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_51e414e2cc1974a20ec984da	66	Nissan	Juke	2015	2017	petrol	none	215	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2be17ffd48779d6dab9216b	66	Nissan	Juke	2018	2020	lpg	none	113	0.9798	2	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_69a0a0a474598e8d544ba714	192	Nissan	Leaf	2012	2016	electric	electric	109	1	4	\N	\N	20.6	20.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4a74b549f076f5def7cacc94	28	Nissan	Micra	2016	2020	diesel	none	90	0.9423	5	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4303482c02f8ddae1f2a02f8	28	Nissan	Micra	2017	2021	petrol	none	91	0.7839	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3275c8b61c3a4a6afbe3ad1d	28	Nissan	Micra	2017	2020	petrol	none	71	0.7699	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_687bbdd942d9af15b7883122	28	Nissan	Micra	2020	2023	lpg	none	91	0.9971	5	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0e0ffeccf38a903828ddf6fd	148	Nissan	Note	2011	2012	diesel	none	88	1	2	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4d15a933466fa4217c7d15a8	148	Nissan	Note	2013	2016	petrol	none	80	0.8	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_24a0dde1e3391514cd342f0e	148	Nissan	Note	2014	2017	petrol	none	98	0.7143	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5bdf3e95326eea1b457a372	53	Nissan	Qashqai	2011	2019	petrol	none	116	0.75	11	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b5a71a27b31333f41b73aa52	53	Nissan	Qashqai	2011	2013	petrol	none	141	1	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7f0284d77e5ac3d342719de2	53	Nissan	Qashqai	2015	2019	diesel	none	110	0.8421	5	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9b5215d80a5447d955b315f2	53	Nissan	Qashqai	2015	2017	petrol	none	163	0.8	3	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_591e8a2675dd23b4eb1457ac	53	Nissan	Qashqai	2019	2022	petrol	none	140	0.8998	4	5.8	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e0d9ea241db8d09795dbd47a	53	Nissan	Qashqai	2019	2021	petrol	none	159	0.9621	3	5.5	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c21aa284e1b774465ac6b711	183	Nissan	X-Trail	2011	2015	diesel	none	150	0.9231	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02efcaff35d79d0a771c9cca	183	Nissan	X-Trail	2015	2017	petrol	none	163	0.9	3	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fa14ff22e21fecf9bad416a4	183	Nissan	X-Trail	2018	2022	petrol	none	159	0.7421	6	6.4	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f26ccb6847bc3f669eadb778	183	Nissan	X-Trail	2022	2024	petrol	hybrid	158	0.8911	3	6.4	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_393460d8e624c0cc477da99e	151	Opel	Adam	2013	2018	petrol	none	88	0.8679	10	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53ece3ddadd23269945c228f	169	Opel	Agila	2011	2015	petrol	none	94	0.8667	5	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_eab82410a2a63290cb341141	169	Opel	Agila	2011	2015	petrol	none	68	1	6	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_73ca051a6b522c74e1e2018a	48	Opel	Astra	2011	2014	petrol	none	118	0.8	5	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e5b03d53ea2f05ffb08d553a	48	Opel	Astra	2012	2014	diesel	none	163	0.8571	3	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	48	Opel	Astra	2015	2018	petrol	none	104	0.8358	6	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_04d3f30c184f1c25dacd3e81	48	Opel	Astra	2019	2020	petrol	none	148	1	2	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_72a80cfec2086de4e26c1939	48	Opel	Astra	2022	2025	petrol	none	131	0.9206	4	5.5	5.7726	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c405087a1261d2f9a82f04df	48	Opel	Astra	2022	2025	petrol	none	110	1	4	5.4	5.5165	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_59edb20e7b7edece0f8d953b	48	Opel	Astra	2023	2025	diesel	none	131	0.9004	3	4.9	4.9265	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	15	Opel	Corsa	2011	2014	petrol	none	87	0.7204	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4e91cec682df81fe3f609256	15	Opel	Corsa	2011	2013	petrol	none	192	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_517702a44e30535821863b92	15	Opel	Corsa	2012	2015	diesel	none	75	0.8	4	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bde917f86e1173d2733412c9	15	Opel	Corsa	2012	2015	petrol	none	65	0.8095	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_51ebc32b37564e1ef5998129	15	Opel	Corsa	2015	2018	petrol	none	86	0.9474	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ecbe0456396a1a1b990d0718	15	Opel	Corsa	2019	2024	diesel	none	102	0.725	6	4	4.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_392da0f5b8ea968f49d99240	15	Opel	Corsa	2019	2023	petrol	none	75	0.8827	5	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dafb7da8c4e68e92ca670b85	15	Opel	Corsa	2019	2023	petrol	none	101	0.735	5	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1ff5767ada6444304a21cadd	15	Opel	Corsa	2020	2025	electric	electric	136	0.9788	4	\N	\N	15.5	16.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9451cb9803523eeca93db8fe	3	Opel	Crossland	2020	2025	petrol	none	110	0.9116	6	5.8	5.875	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5f24bce785cc310e768d342f	3	Opel	Crossland	2022	2025	petrol	none	131	0.8097	3	6.1	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d11b9fedba43e3712b9d1f97	45	Opel	Grandland	2023	2025	petrol	none	131	0.9982	3	6.3529	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e3d4a5c584efffb6eb7279e0	188	Opel	Meriva	2011	2013	diesel	none	95	0.8667	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53363c0d63c4555013f8f2d9	39	Opel	Mokka	2014	2017	lpg	none	140	0.8182	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d3f191fc245a81389421ba7	39	Opel	Mokka	2023	2025	petrol	none	101	0.85	3	5.5	5.691	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a5882aeede4572aa9998129a	39	Opel	Mokka	2023	2025	diesel	none	110	0.9825	3	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f7f8f303f4802a5bba6a33ee	137	Opel	Zafira	2011	2013	petrol	none	116	0.8333	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_002f3204d6bdfef3ea8af791	137	Opel	Zafira	2012	2015	diesel	none	110	0.8	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_400adf8bc375c0e2ada15358	137	Opel	Zafira	2012	2014	petrol	none	140	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9809fadb0082180570734a7c	157	Peugeot	108	2014	2021	petrol	none	70	0.7857	9	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c5873ff4df7b9788fc223fa	157	Peugeot	108	2014	2018	petrol	none	82	0.8571	5	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5cc85ab27f41af7f97c68014	102	Peugeot	2008	2013	2016	diesel	none	92	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_66159e7e9172147a017a508e	102	Peugeot	2008	2013	2015	diesel	none	68	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a45cb063848a421166df3549	102	Peugeot	2008	2013	2015	diesel	none	114	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d1b10670751446fcda46e90c	102	Peugeot	2008	2013	2015	petrol	none	120	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	102	Peugeot	2008	2015	2021	diesel	none	101	0.8	8	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	102	Peugeot	2008	2015	2019	diesel	none	120	0.8016	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3157234a9db68f2376ed76e1	102	Peugeot	2008	2015	2018	diesel	none	75	0.8333	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_52116adf0c63104421d10a95	102	Peugeot	2008	2018	2019	petrol	none	83	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_892f2b5ba5bf997354234038	102	Peugeot	2008	2020	2025	petrol	none	101	0.9427	6	5.4	5.685	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_80eb1c932629f6810d275c04	102	Peugeot	2008	2020	2025	petrol	none	131	0.7731	6	5.6	6.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_46afebf5cba9b066dddf5866	24	Peugeot	206	2011	2013	diesel	none	68	0.8889	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bcc4f724f6fbf60557182d9d	24	Peugeot	206	2011	2013	lpg	none	60	1	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2e30dabedd396ea78c410b31	105	Peugeot	208	2012	2016	diesel	none	68	0.8125	5	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fa2d6f9dcf8c7c0689d6618b	105	Peugeot	208	2012	2015	diesel	none	92	1	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6469b0fef2525122a652e83f	105	Peugeot	208	2012	2015	diesel	none	114	1	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c0ea74023a9bc9a0b9db37c9	105	Peugeot	208	2013	2015	petrol	none	200	1	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3b350087301e33cd15058cee	105	Peugeot	208	2015	2019	diesel	none	100	0.75	6	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_727d8831ede36de111ae0e11	105	Peugeot	208	2015	2018	diesel	none	75	0.7391	4	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e656e276f25b572581f5f2c4	105	Peugeot	208	2017	2019	petrol	none	83	0.8	4	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_45736405de27864554886d71	105	Peugeot	208	2019	2025	petrol	none	75	0.7133	7	5.3	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b809aa509aa602b1a1af1598	105	Peugeot	208	2019	2024	petrol	none	101	0.869	6	5.1	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0a58d26041de87f49697c03d	105	Peugeot	208	2020	2023	petrol	none	131	0.9281	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1768ec337e557388b3f30453	105	Peugeot	208	2023	2025	electric	electric	136	0.9988	3	\N	\N	15.5	15.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_88fb2c885612239a85baaddc	87	Peugeot	3008	2011	2015	diesel	none	113	0.88	7	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_36b306947137950cb953fa3f	87	Peugeot	3008	2016	2020	petrol	none	131	0.7778	4	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2f654bf35da7bc1e1df9331	87	Peugeot	3008	2016	2020	diesel	none	179	0.8752	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_583e701ff6545338ad142a1c	87	Peugeot	3008	2016	2018	petrol	none	165	1	3	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4caa77035e9d742ccbde8154	87	Peugeot	3008	2018	2021	diesel	none	131	0.8519	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_884d7089c0469eaedbef6224	87	Peugeot	3008	2019	2022	petrol/electric	plug_in_hybrid	200	1	4	6.9	6.9	15.3	15.4	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3f39e79c11eb8a6783d115b6	87	Peugeot	3008	2020	2022	petrol/electric	plug_in_hybrid	181	1	3	6.9	6.9	15.4	15.4	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1d0a46c4ad2efe30a2f98440	87	Peugeot	3008	2021	2025	petrol	none	131	0.8069	5	6.1	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ebebdafa6364063a232b7234	87	Peugeot	3008	2023	2025	diesel	none	131	0.9	3	5.3	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_85971cbb19569e2a15d7aff9	51	Peugeot	308	2012	2018	diesel	none	116	0.7143	13	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d16a624c4547b508c1f1ae15	51	Peugeot	308	2015	2021	petrol	none	131	0.7	7	5.4	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aa5980c13c1224c53b2ebed1	51	Peugeot	308	2015	2020	diesel	none	100	0.7012	7	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f9049366a2e93d2e2ac2211d	51	Peugeot	308	2015	2020	petrol	none	110	1	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f6baf8ec1394b88c68ada143	51	Peugeot	308	2015	2020	diesel	none	179	1	5	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f4f187856968bf13920e829a	51	Peugeot	308	2015	2018	diesel	none	150	0.8182	4	3.8	3.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_27744e392e621d39d53e86bd	51	Peugeot	308	2015	2017	petrol	none	272	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_366b5705e91e0fc8bc85789c	51	Peugeot	308	2015	2017	petrol	none	205	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2746cd5babd095b81b49eb69	51	Peugeot	308	2022	2025	petrol	none	131	0.9034	4	5.5661	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_97f43da8aebb886eb5dccaf6	51	Peugeot	308	2023	2025	diesel	none	131	0.8599	3	4.9888	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4bee0f86234b7dbd8536b465	40	Peugeot	5008	2011	2014	diesel	none	113	0.7674	6	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7e67f6ad7b8cc55aec011c04	40	Peugeot	5008	2017	2025	petrol	none	131	0.7493	9	6.2947	6.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e2a30dccae59deaccf7aa557	40	Peugeot	5008	2018	2020	diesel	none	178	0.7555	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a8938348c26a4524c355a50	40	Peugeot	5008	2021	2023	diesel	none	177	0.9837	3	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8fba7c9ad561f62b93ad87a1	131	Peugeot	508	2011	2014	diesel	none	140	0.8182	4	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_73f43b7e61bda3bba2c0d8de	131	Peugeot	508	2016	2018	diesel	none	120	0.8667	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8f4bfb17468be20c5b783261	131	Peugeot	508	2019	2024	petrol/electric	plug_in_hybrid	181	0.8165	5	6.2	6.2	14.7	16	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4d612f2c4fea32734be7b35e	131	Peugeot	508	2019	2022	diesel	none	131	0.9499	4	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_902bfaab249dd1389472ab63	131	Peugeot	508	2019	2021	diesel	none	163	0.9399	3	4.6	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c63b5d39babf9ea7a621f494	131	Peugeot	508	2021	2024	petrol/electric	plug_in_hybrid	200	1	4	6.2	6.2	15.9	16.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b3bcbb46df834102b45b2a3a	131	Peugeot	508	2022	2024	petrol	none	131	1	2	5.9	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d8ee559e5f6186378f5d78ac	131	Peugeot	508	2023	2025	diesel	none	131	0.9103	3	5.1	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_68243d18a3fd622cab76d223	107	Peugeot	Partner	2011	2016	diesel	none	91	0.7	9	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_77ebab6acba9d295dabcdcab	107	Peugeot	Partner	2011	2014	petrol	none	98	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_48433074bc1a43216a967bdb	107	Peugeot	Partner	2011	2015	diesel	none	112	0.7826	8	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d676a526b16fe71f6115c31f	107	Peugeot	Partner	2015	2018	diesel	none	120	0.7273	4	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c73ad668289ffd52de8389d	107	Peugeot	Partner	2015	2017	petrol	none	120	0.8	2	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1357b8dae2ccd7772853ac01	173	Peugeot	Rifter	2018	2023	diesel	none	131	0.8523	6	5.3	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ccb301f662cbba33717c7e2c	173	Peugeot	Rifter	2018	2023	diesel	none	102	0.834	6	5.2	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_827b688a98dbde9096001117	173	Peugeot	Rifter	2019	2023	petrol	none	110	0.7375	5	6.5	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1af795b2f1f1e21244c59e2d	173	Peugeot	Rifter	2020	2023	petrol	none	131	0.8452	4	6.9	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a1577eb8fa8c8faac8ab227a	290	Porsche	Cayenne	2018	2022	petrol	none	340	0.9653	5	9.4	9.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_26db1d61d288bb9bd7bbf614	253	Porsche	Macan	2016	2018	petrol	none	252	0.9091	2	8.2	8.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dd4c5c4f7bee4808bd919bb1	253	Porsche	Macan	2018	2021	petrol	none	245	0.9653	3	8.2	8.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1a584ca50aecc7da95473899	77	Renault	Captur	2013	2017	petrol	none	119	1	7	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_639c33ed2ae904e646076745	77	Renault	Captur	2020	2022	lpg	none	101	1	3	5.4	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d20657a78815a2e94a5f5ee1	6	Renault	Clio	2011	2021	diesel	none	88	0.7364	15	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_99ed4627729f7fde82c3f5bc	6	Renault	Clio	2011	2014	petrol	none	74	0.7115	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_afca1500d011b0a54f1fd0b0	6	Renault	Clio	2011	2012	petrol	none	102	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4c5396cbd34b0fa3228e43ef	6	Renault	Clio	2012	2017	lpg	none	73	0.8333	8	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ee2aa8ff2288250d841851d7	6	Renault	Clio	2013	2017	petrol	none	119	1	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_80d0ce3c49fbaaa4c0904154	6	Renault	Clio	2015	2021	petrol	none	74	0.7971	9	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a6fdfd513b565ee139284cd5	6	Renault	Clio	2015	2017	petrol	none	220	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e9fc7a7722606d3e0340d2e6	6	Renault	Clio	2016	2018	diesel	none	110	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_02d57f2ad1ecb9326eb7965a	6	Renault	Clio	2020	2022	petrol	none	66	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_71bc772a15351be3e1fd6c0a	6	Renault	Clio	2023	2025	petrol	none	67	1	2	5.3	5.3061	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c329c5d6c30331ba18fcd1d0	158	Renault	Kadjar	2018	2022	diesel	none	116	0.8357	5	4.2	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_94cccbbcef16921e7057a573	158	Renault	Kadjar	2018	2022	petrol	none	140	0.776	5	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bf4f845e4e81e29a8f6368c4	123	Renault	Kangoo	2011	2015	diesel	none	109	0.7895	6	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e677ed68824a197ed572f415	123	Renault	Kangoo	2011	2013	petrol	none	106	0.875	3	6.3	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_001c0ff38d76a66183c8fbeb	123	Renault	Kangoo	2011	2013	diesel	none	75	0.7273	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_64c40eebe417efbfdc364a3d	123	Renault	Kangoo	2011	2012	diesel	none	89	0.9375	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b90440f21502b239ddd33cf3	123	Renault	Kangoo	2016	2018	diesel	none	75	0.8	2	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c5efb7bc8b5e05534b183573	123	Renault	Kangoo	2017	2020	diesel	none	92	0.9565	5	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_97550dcdba8d6dd809e704a6	123	Renault	Kangoo	2021	2023	petrol	none	131	0.9528	2	6.3	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_866c2e97cae883cd31724a9b	26	Renault	Megane	2011	2015	diesel	none	92	0.8125	6	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_047c81ee7a7828f26c10c052	26	Renault	Megane	2011	2013	petrol	none	131	0.8537	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	26	Renault	Megane	2012	2013	diesel	none	162	1	2	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_90c1ea35ec005234a8199323	26	Renault	Megane	2018	2022	diesel	none	116	0.809	5	3.9	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_54ef9c3f207862a269b1906d	26	Renault	Megane	2019	2024	petrol	none	300	0.7742	6	7.9	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5232af4372823904e07fa21c	26	Renault	Megane	2019	2022	petrol	none	140	0.7739	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_323105898c7dea4a2855af87	179	Renault	Modus	2011	2013	diesel	none	88	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b91f1ad326d18e33799c688d	179	Renault	Modus	2011	2013	petrol	none	103	0.7778	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b3d8df21557dac705ebf8047	23	Renault	Scenic	2017	2020	petrol	none	116	0.8074	4	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_833e4dbefa42a94f164d50ba	23	Renault	Scenic	2017	2019	diesel	none	110	0.875	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	23	Renault	Scenic	2018	2022	petrol	none	140	0.951	5	5.9	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_14fe0cd144c151d5b9d8fcb8	27	Renault	Twingo	2011	2013	petrol	none	133	0.875	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5d2fca6e7a6ebb0f226ac3b7	27	Renault	Twingo	2011	2013	petrol	none	102	0.7692	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ef097eb9fedb6e26b8233d2e	27	Renault	Twingo	2012	2014	petrol	none	75	0.8333	3	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3ca128b74722127bd3f4bca0	27	Renault	Twingo	2014	2022	petrol	none	69	0.9413	14	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d8409f3e3e794d2717c71355	27	Renault	Twingo	2018	2020	petrol	none	91	0.9972	4	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_76b742d5f4e5ba5c2c68b001	27	Renault	Twingo	2018	2020	lpg	none	90	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e85edc8d3d15c62f872a9b1f	120	Renault	Zoe	2013	2015	electric	electric	58	0.8462	3	\N	\N	14.6	14.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e0ed180f4aaa34686852446c	120	Renault	Zoe	2017	2019	electric	electric	90	0.7273	6	\N	\N	13.3	14.6	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2a605bfaab9e06b5de513906	263	Seat	Alhambra	2011	2015	diesel	none	140	0.7188	5	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1543e9caa83e1abc7f88e00d	227	Seat	Arona	2018	2021	diesel	none	95	0.8642	3	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b67d4d668490c611598f8737	227	Seat	Arona	2019	2022	ng	none	90	1	4	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6b3287cc4ba06d8828a33f98	227	Seat	Arona	2020	2022	petrol	none	110	1	2	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3e94dff0cbe6bb726e3e5115	227	Seat	Arona	2020	2022	petrol	none	150	0.932	2	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3967e199e585f3bbefe6995c	227	Seat	Arona	2023	2025	petrol	none	150	0.9722	2	5.7	5.7182	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_61127ba0fcab24af0cc7a11a	276	Seat	Ateca	2016	2020	diesel	none	116	0.8	5	4.4	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fb53c37b718a8274c2ba69be	276	Seat	Ateca	2022	2024	diesel	none	116	1	2	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	71	Seat	Ibiza	2011	2016	diesel	none	105	0.8333	6	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_028eeb52f9c9726ad083564f	71	Seat	Ibiza	2011	2016	diesel	none	75	0.7333	6	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4796d984e254994812b810c1	71	Seat	Ibiza	2011	2015	petrol	none	105	0.8462	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7de15367d79b479652752133	71	Seat	Ibiza	2011	2014	diesel	none	143	0.7143	4	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fbd7ff5408c27ca764048f00	71	Seat	Ibiza	2012	2015	diesel	none	90	0.8	4	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7bdf840c5104410990a08d72	71	Seat	Ibiza	2012	2014	lpg	none	82	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_060eab61f56173ecbed3c2da	71	Seat	Ibiza	2014	2017	petrol	none	88	0.9375	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d992ad1d436b6f12f4e498f8	71	Seat	Ibiza	2017	2021	diesel	none	95	0.8702	5	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8defa028f5af2dc157aa2a7c	71	Seat	Ibiza	2017	2019	diesel	none	80	1	2	3.7	3.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_598fce2c48c29b5a2d159ca3	71	Seat	Ibiza	2018	2022	ng	none	90	0.7367	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_383fdd4e7abbf957d0fcf258	71	Seat	Ibiza	2023	2025	petrol	none	80	1	3	5.3	5.3821	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0fc16062f80b6ff177361fc8	71	Seat	Ibiza	2023	2025	petrol	none	150	0.9859	2	5.7097	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	36	Seat	Leon	2013	2017	diesel	none	108	0.7619	6	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	36	Seat	Leon	2014	2016	petrol	none	124	0.9	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8fd3dee68f48f0d6384058f3	36	Seat	Leon	2022	2024	petrol	none	131	1	2	5.6	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d72ebd91e36ccd0781af7ebb	36	Seat	Leon	2023	2025	petrol	none	110	1	3	5.5	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53a9ee9c00b3fb373b3702bc	233	Seat	Mii	2012	2017	petrol	none	60	0.7778	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8aff95585589d1d68b2ce8b8	233	Seat	Mii	2018	2020	ng	none	68	1	2	6.2	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_72bd7e5155beccab0f212b4e	233	Seat	Mii	2019	2021	electric	electric	83	1	3	\N	\N	12.9	12.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c83dc0b262fa120356f8c89f	228	Seat	Toledo	2013	2015	diesel	none	105	0.875	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bc2ba9a36592b03d91295983	304	Skoda	Citigo	2012	2018	petrol	none	60	0.75	7	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f50f9613ca6578072db6ef72	304	Skoda	Citigo	2012	2019	petrol	none	75	0.8	7	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_35100acf6d36ccc23497747b	41	Skoda	Fabia	2011	2015	petrol	none	69	0.7083	5	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aed730038cd3fb5a1c1eca30	41	Skoda	Fabia	2012	2017	petrol	none	88	0.75	7	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7b2594cb5e1e3f64592993cc	41	Skoda	Fabia	2015	2019	petrol	none	75	0.8	4	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_82c992497b5738ddee843d68	41	Skoda	Fabia	2015	2019	diesel	none	75	0.7435	5	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_453c1cc36296d9e163b8a322	41	Skoda	Fabia	2023	2025	petrol	none	150	0.8349	3	5.4726	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a16851e39c41f2e6b2ea3ca6	50	Skoda	Kamiq	2019	2022	petrol	none	150	0.9949	3	4.9	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_47b72923bfedc619a38c8de8	50	Skoda	Kamiq	2023	2025	petrol	none	150	0.9688	2	5.6731	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a54b68e95a4b202f57963d8	309	Skoda	Karoq	2023	2025	petrol	none	150	0.9991	2	6.1511	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8f5469abedb50041ed276520	269	Skoda	Kodiaq	2017	2020	diesel	none	190	1	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dc7f223ca86d7788eb12d296	269	Skoda	Kodiaq	2020	2022	petrol	none	150	1	2	5.8	5.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_97929dcd6e3ea2eed4151eec	79	Skoda	Octavia	2013	2016	petrol	none	220	1	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2947e0f1fab83a74599d81dd	79	Skoda	Octavia	2013	2015	petrol	none	105	0.7333	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_edfcc19fcb890a52733ab2ab	288	Skoda	Rapid	2012	2014	petrol	none	75	1	3	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	243	Skoda	Roomster	2011	2015	diesel	none	75	0.8	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	243	Skoda	Roomster	2011	2015	petrol	none	69	0.875	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dd35bdf19323d624e1ce7120	243	Skoda	Roomster	2012	2015	petrol	none	86	0.8125	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e53ba38e935652193c9f7bad	243	Skoda	Roomster	2012	2015	diesel	none	90	0.8824	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4947f1204ebe93041338840b	243	Skoda	Roomster	2012	2015	petrol	none	105	1	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_96bb43f8fb4041d6eb05ff32	243	Skoda	Roomster	2012	2014	diesel	none	105	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_95b6b6fddcfb90be212d2c1d	231	Skoda	Scala	2019	2021	petrol	none	116	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a0e1071c6250e5bb05cc0b43	231	Skoda	Scala	2023	2025	petrol	none	150	0.9539	2	5.6093	5.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53c7b9ab4b46df2d45c01f05	223	Skoda	Superb	2011	2015	diesel	none	105	0.8	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d2302e557d4aab51c68c6120	223	Skoda	Superb	2011	2013	petrol	none	200	1	2	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_93e22acbdc675ab4552c407e	223	Skoda	Superb	2012	2015	diesel	none	140	0.8333	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	223	Skoda	Superb	2015	2020	diesel	none	121	0.7727	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f8a6c9c08350711b341ad5d8	223	Skoda	Superb	2018	2020	diesel	none	190	0.9318	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_12906e00373735e0352ae13e	289	Skoda	Yeti	2011	2016	diesel	none	107	0.7143	10	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c80b1dfb0b459132c7286cb	289	Skoda	Yeti	2011	2016	diesel	none	140	0.7857	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c66d78d1fe58caefb1f19c2	289	Skoda	Yeti	2011	2015	petrol	none	105	0.9545	4	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fda0d304b6d84d3cfcf468fa	289	Skoda	Yeti	2011	2015	petrol	none	122	0.75	5	3.6	3.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fd9b8cb341a0c79212c721d8	289	Skoda	Yeti	2011	2015	diesel	none	170	0.8	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7238413e708e835d16ec41bc	103	Smart	Forfour	2015	2019	petrol	none	71	0.849	5	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_93e18f63f018676cc13da084	103	Smart	Forfour	2015	2017	petrol	none	90	0.8182	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_89b5930b53d45c4cf7299c1f	257	Subaru	BRZ	2012	2016	petrol	none	200	0.8	5	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ce2648c1dabc8f523c23b890	257	Subaru	BRZ	2017	2021	petrol	none	200	1	5	8.5	8.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f4fdb5aea32cd792a8302882	209	Subaru	Forester	2013	2019	diesel	none	147	0.8235	7	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	209	Subaru	Forester	2013	2018	petrol	none	241	1	5	8.1	8.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0fdf13c916f9979dd1dc9814	209	Subaru	Forester	2014	2018	petrol	none	150	0.75	5	8.1	8.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_455cf47a434a3fff934f735b	209	Subaru	Forester	2019	2024	petrol	hybrid	150	0.9204	6	8.1	8.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ecc4e2c65520f29a486f8842	232	Subaru	Impreza	2011	2013	petrol	none	114	0.9231	3	6.3	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_672744b5c82ddb5c7b74e04b	232	Subaru	Impreza	2012	2014	lpg	none	114	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cab9903f4dd9c95aab970590	232	Subaru	Impreza	2013	2015	diesel	none	147	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_630d172b55f859b4be6ed947	232	Subaru	Impreza	2017	2022	petrol	none	114	0.8519	6	6.3	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_477435c9d2b7a1c0b33783f9	232	Subaru	Impreza	2020	2022	petrol	hybrid	150	1	3	6.3	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a45cc4f99d643e9ab427b049	226	Subaru	Outback	2017	2019	diesel	none	150	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0b83d92ac545a8fd03794c97	226	Subaru	Outback	2018	2021	petrol	none	175	0.874	4	7.3	7.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0b82607902ef002a02b72517	299	Subaru	XV	2014	2019	diesel	none	147	1	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8a78c319fa02cdf9cdcfb58a	299	Subaru	XV	2014	2017	petrol	none	150	0.7826	4	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a8ceabd3f7cf1ec109aa1013	299	Subaru	XV	2017	2019	petrol	none	156	1	3	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	299	Subaru	XV	2018	2022	petrol	none	114	0.999	5	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dc8c09b62ebfab182c6da673	299	Subaru	XV	2019	2021	petrol	hybrid	150	1	3	6.5	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e90ed861c9138376e7bab69a	299	Subaru	XV	2022	2024	petrol	hybrid	150	1	3	7.9	7.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2253aa2817a9d6b6f607e0d9	284	Suzuki	Baleno	2016	2018	petrol	none	111	1	3	5.5	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_65017a52e381c89d8946a56f	281	Suzuki	Celerio	2015	2020	petrol	none	68	0.8673	6	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fa874a71cb7406d428bd254d	271	Suzuki	Ignis	2016	2019	petrol	none	90	0.8058	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_99f3ce5b583a271a87b4c4fd	271	Suzuki	Ignis	2022	2024	petrol	hybrid	83	0.9998	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7a255b5be155a44519487280	240	Suzuki	Jimny	2011	2018	petrol	none	85	0.75	10	6.8	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b382426313f42bab465cf7aa	240	Suzuki	Jimny	2018	2021	petrol	none	102	0.8893	4	6.8	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5845c37f8e7bc3324e10efcd	251	Suzuki	Swift	2011	2017	petrol	none	93	0.8108	9	4.1	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5f34da56dd26713c0eabf21e	251	Suzuki	Swift	2014	2016	diesel	none	75	1	3	5.2	5.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9758585cfebe2318a443f120	251	Suzuki	Swift	2022	2024	petrol	hybrid	129	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e7c590bacbcea53b39680504	313	Suzuki	SX4	2011	2014	petrol	none	111	0.875	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_354c659404c6ffaae27883c9	313	Suzuki	SX4	2011	2014	diesel	none	135	0.8571	4	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ecb88a9f8e31b7d49082347f	313	Suzuki	SX4	2013	2016	petrol	none	120	0.8148	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_417d9bb3b7d39791a99d5d46	313	Suzuki	SX4	2016	2020	petrol	none	140	0.833	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d4c9144b751b4b2e94573c23	313	Suzuki	SX4	2016	2020	petrol	none	111	0.8794	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1c04fddf2c153e7e6a509d54	313	Suzuki	SX4	2017	2019	diesel	none	120	0.8182	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	280	Suzuki	Vitara	2015	2019	diesel	none	120	1	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_276de688e07be977ad95ecfc	280	Suzuki	Vitara	2015	2018	petrol	none	120	1	4	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6c98e4a9acb252dbfb823fe5	280	Suzuki	Vitara	2016	2020	petrol	none	140	0.8194	5	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ab46686ab32b6a6913825315	280	Suzuki	Vitara	2018	2020	petrol	none	111	1	3	4.9	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5baf406053bab361c4f88e25	280	Suzuki	Vitara	2022	2024	petrol	hybrid	129	0.9701	3	5.3	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7658befce6581ea88d7aafa1	63	Tesla	Model 3	2019	2020	electric	electric	210	0.8549	4	\N	\N	13.2	13.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_805f5b1c828eeb99a5eb5522	63	Tesla	Model 3	2022	2023	electric	electric	210	0.7265	4	\N	\N	13.2	13.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c314eb91005a3f446b8d8965	286	Tesla	Model S	2019	2020	electric	electric	243	0.8889	4	\N	\N	17.5	17.5	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c2bcaee26b58a35889240c54	225	Tesla	Model X	2019	2021	electric	electric	243	1	5	\N	\N	19.1	19.1	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_29d1a4f35d58e622b4dd9364	83	Tesla	Model Y	2022	2023	electric	electric	210	0.9883	4	\N	\N	15.7	15.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	147	Toyota	Auris	2012	2013	diesel	none	125	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a20165adbb4c327e2853a2e5	124	Toyota	Avensis	2011	2015	diesel	none	125	0.8	6	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5145e9e7ddcb670a5dab3b84	124	Toyota	Avensis	2011	2013	petrol	none	147	1	2	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3a910a9e79648c4cc3fe92bb	124	Toyota	Avensis	2012	2014	diesel	none	177	1	2	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ddec42aa3efd253bc3d17a82	86	Toyota	Aygo	2013	2014	petrol	none	69	0.9375	2	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_4fb3fe9ae166789fa7e694a1	86	Toyota	Aygo	2015	2021	petrol	none	71	0.7368	8	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ff9bad5bd693d87d95c2110f	117	Toyota	Prius	2012	2015	petrol	none	99	1	3	4.2	4.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0eafb247a2062fb89366bc7d	117	Toyota	Prius	2019	2022	petrol	hybrid	98	1	3	4.2	4.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_64d3ae123660f5eac84d5afe	69	Toyota	RAV4	2013	2018	petrol	none	153	1	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_72c81b2220e765b7713b3224	69	Toyota	RAV4	2015	2019	diesel	none	143	0.8	5	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_47e7c51cade5bfe5c22027d4	134	Toyota	Verso	2011	2014	diesel	none	125	0.75	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a3e39acb5fe6ff5e81571938	134	Toyota	Verso	2012	2018	petrol	none	132	0.7143	6	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d588df970e3a98b2424fa683	134	Toyota	Verso	2015	2019	diesel	none	111	0.7917	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1d97da5fb1efb7dbbd9aa4b2	134	Toyota	Verso	2015	2017	petrol	none	147	0.7143	3	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_87a7fccc941740c4c85daa32	55	Toyota	Yaris	2017	2020	petrol	none	111	0.8295	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_da341fdd8155dd711b988db6	55	Toyota	Yaris	2017	2019	petrol	none	71	0.7619	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	55	Toyota	Yaris	2020	2024	petrol	hybrid	92	0.8183	5	3.8	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_64b2cb138749ece19e352d9f	55	Toyota	Yaris	2021	2024	petrol	none	72	0.7981	4	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_32066abfa064c9d28b2ac382	25	Toyota	Yaris Cross	2021	2023	petrol	hybrid	92	0.9999	2	4.5	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f23d2f3b2e623854eb129baa	171	Volkswagen	Arteon	2017	2021	diesel	none	190	0.7083	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2bcb68cbf6cd2a550dfaefe4	171	Volkswagen	Arteon	2017	2020	diesel	none	239	0.8	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	202	Volkswagen	Caddy	2011	2016	petrol	none	85	0.8	6	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_aede9d226dab4d5dd34e82b2	202	Volkswagen	Caddy	2011	2015	diesel	none	140	0.75	4	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6a24111cc6a16cda4e93912c	202	Volkswagen	Caddy	2011	2015	diesel	none	110	0.8519	4	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_13a5d1634bf4f59ec89e5de1	202	Volkswagen	Caddy	2011	2015	lpg	none	102	1	5	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_200a91e682e194f9a4219380	202	Volkswagen	Caddy	2011	2015	petrol	none	105	1	4	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d0129463eb68d0543ad55a8c	202	Volkswagen	Caddy	2011	2014	diesel	none	75	1	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1a8cb77f762f9ea465c85162	202	Volkswagen	Caddy	2016	2020	diesel	none	150	0.8182	5	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e1fa08c18fc2663ea3990d28	202	Volkswagen	Caddy	2017	2023	diesel	none	102	0.7	5	4.7	4.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0ba252f18c6d733c8c8254db	202	Volkswagen	Caddy	2017	2019	diesel	none	122	0.9868	3	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_042141d3362cd21f79687718	202	Volkswagen	Caddy	2018	2021	ng	none	110	0.9824	3	7.1	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_583e68cd88dd0f4cc37550b7	202	Volkswagen	Caddy	2023	2025	petrol	none	115	0.9583	5	6.4	6.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_83ced3db4202e310ba851f54	100	Volkswagen	Golf	2014	2016	petrol	none	124	0.9231	4	5.1	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_23e92951a207a9084c6d4b44	100	Volkswagen	Golf	2020	2024	petrol	none	131	0.9136	5	5.1	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6fe729cbe384acc087a055c1	100	Volkswagen	Golf	2020	2022	petrol/electric	plug_in_hybrid	150	0.9776	3	4.8	5.1	10.1	11.3	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8115b1e02381582ef55109eb	74	Volkswagen	Passat	2011	2017	petrol	none	123	0.75	7	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	74	Volkswagen	Passat	2015	2020	diesel	none	239	1	5	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0b34ff3fa3ad9b42a90d65f3	74	Volkswagen	Passat	2015	2018	diesel	none	120	0.8	4	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_87d111c6f0b89df412b016fa	74	Volkswagen	Passat	2018	2020	diesel	none	190	0.9738	2	4	4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c670e919943408dee12ab561	74	Volkswagen	Passat	2020	2022	petrol	none	150	0.8706	2	5.3	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_875c7ffb98c648352078455d	74	Volkswagen	Passat	2020	2021	diesel	none	121	1	2	4	4.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2d396b1671f9e0fa1b594ae4	59	Volkswagen	Polo	2011	2017	petrol	none	88	0.75	10	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2b2027b85d7a0261c2054042	59	Volkswagen	Polo	2011	2014	lpg	none	82	0.875	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_46cc622777603670680e29d0	59	Volkswagen	Polo	2015	2017	petrol	none	192	1	3	4.5	4.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_9216e6290ffd7726ec6f13ff	59	Volkswagen	Polo	2016	2021	diesel	none	94	0.7353	7	3.9	3.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_498fe673f75b56cf5aa7049d	59	Volkswagen	Polo	2018	2022	ng	none	90	0.7724	5	5	5.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1bd5d15638a6c8848d2c5b6f	59	Volkswagen	Polo	2022	2025	petrol	none	207	0.7419	4	6.7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7067e894ccceb518d2ea7187	59	Volkswagen	Polo	2023	2025	petrol	none	80	0.9992	2	5.3576	5.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ffa080fec4e0fd9412a072d4	115	Volkswagen	Sharan	2012	2015	diesel	none	140	0.8333	3	5.3	5.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7350b9e204a7f8c1f3585254	31	Volkswagen	T-Roc	2020	2025	petrol	none	110	0.8313	4	5.6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7fc38bbd2f425db16c4748e1	5	Volkswagen	Tiguan	2011	2015	petrol	none	211	0.7692	5	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_720775527af699ff5772c18c	5	Volkswagen	Tiguan	2012	2015	diesel	none	140	0.9677	2	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bcde49674783397645a53d96	5	Volkswagen	Tiguan	2014	2017	petrol	none	124	0.8571	6	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	5	Volkswagen	Tiguan	2016	2020	diesel	none	190	0.9971	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cc965d93449d74e70010f947	5	Volkswagen	Tiguan	2016	2018	petrol	none	179	0.9978	2	5.7	5.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_827aadc0a8050237399724aa	5	Volkswagen	Tiguan	2017	2020	diesel	none	150	0.8475	2	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_55a798a56259c4bac62310d9	5	Volkswagen	Tiguan	2018	2020	diesel	none	116	0.8823	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5445c6e1ba426e713d3da3b0	167	Volkswagen	Touareg	2011	2014	diesel	none	340	0.75	4	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6ad45a3a501aa95abeac7b74	167	Volkswagen	Touareg	2013	2018	diesel	none	204	0.75	6	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_50413d5a19de73b9d18692c7	167	Volkswagen	Touareg	2015	2018	diesel	none	262	1	2	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_143dc4bed19509fd2766f8c3	167	Volkswagen	Touareg	2023	2025	diesel	none	231	1	2	8.2765	8.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_555c13b77ea4a7eedd253df0	167	Volkswagen	Touareg	2023	2025	diesel	none	286	1	2	8.3	8.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0a3978c95411afe794a0a3d7	70	Volkswagen	Touran	2011	2018	petrol	none	107	0.75	8	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7acc4728631972c563b922cf	70	Volkswagen	Touran	2016	2020	diesel	none	150	0.7778	4	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_72a5cb1963c0a360addef0fb	70	Volkswagen	Touran	2016	2019	diesel	none	116	0.8258	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7481dc165423b3ebfe85921d	70	Volkswagen	Touran	2016	2018	diesel	none	190	0.8333	3	4.8	4.8	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_543b4c4c3ec3f9a6e4d51caa	70	Volkswagen	Touran	2023	2025	petrol	none	150	0.9837	2	6.4403	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53de10fa0ff350a1bd25e47b	72	Volkswagen	Up!	2012	2018	petrol	none	60	0.7826	5	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c552ca397bd1211665af3711	72	Volkswagen	Up!	2012	2017	petrol	none	75	0.8065	6	4.3	4.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2aaedb68184f556651b85292	72	Volkswagen	Up!	2014	2022	electric	electric	82	0.8	8	\N	\N	11.7	12.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2e8a5c31f4c4d250c47a29cc	72	Volkswagen	Up!	2019	2022	ng	none	68	0.7281	4	4.7	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0cb22995f4d6fd0674a7379a	72	Volkswagen	Up!	2019	2022	petrol	none	63	0.8848	6	4.3	4.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e13f8ec9f562f31f0ea4a0fa	285	Volvo	C40	2023	2025	electric	electric	252	1	3	\N	\N	16.375	16.4	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_335be9fc901d1f0a152c232d	285	Volvo	C40	2023	2024	electric	electric	409	0.7778	2	\N	\N	17.5	17.7	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_81f3b105b5c8dea0d620ec54	285	Volvo	C40	2023	2025	electric	electric	231	1	2	\N	\N	18.1	18.2	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f4953da80e33d14976995c14	315	Volvo	EX30	2023	2025	electric	electric	428	0.902	3	\N	\N	17.5	17.501	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_42bffd751310f5b523ab4f9c	220	Volvo	S60	2011	2016	diesel	none	114	0.7	6	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5ec74fd01d826cb9fda7659c	220	Volvo	S60	2011	2015	diesel	none	215	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8fadc394c9a0814cc55d3d7c	220	Volvo	S60	2011	2015	petrol	none	151	1	4	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_87c21bc4605eb129a92fd9e4	220	Volvo	S60	2011	2014	diesel	none	163	0.7308	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_35270407c6906fd5d72971a6	220	Volvo	S60	2011	2014	petrol	none	305	1	2	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_76420b11e12c72af3700312f	220	Volvo	S60	2011	2013	petrol	none	179	1	2	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e55b50149cab0c91ee6b919c	220	Volvo	S60	2012	2016	diesel	none	136	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_06f1f047f22395d777cd4ebe	220	Volvo	S60	2014	2016	diesel	none	181	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bbd8a435c9f4ee2f23e9dd8c	220	Volvo	S60	2015	2018	diesel	none	120	1	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ae60fcddc5adac1638fb215a	220	Volvo	S60	2015	2018	diesel	none	150	1	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_157223fb938208ca0fa1681b	220	Volvo	S60	2015	2017	diesel	none	190	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ecbdd3a49f65f313f6250a79	220	Volvo	S60	2016	2018	petrol	none	152	1	3	6	6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_ef51a01c33cd634cfcc9a30c	220	Volvo	S60	2019	2021	petrol	none	190	0.988	3	6.6	6.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_b358afab7ec782a60b1c4b56	220	Volvo	S60	2020	2023	petrol	hybrid	163	1	4	5.9	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c76e82caa7851026fe51077f	236	Volvo	S90	2016	2021	diesel	none	190	0.7931	6	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d5cf034c01c48aa4b12fe58d	236	Volvo	S90	2016	2020	diesel	none	235	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_917d9eef14f04f7c84760a34	236	Volvo	S90	2016	2018	diesel	none	150	0.9841	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6d0a3247481f6862b6e28970	236	Volvo	S90	2022	2024	petrol	hybrid	197	1	2	6.5	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e4c0dd8895125c5a54c24373	237	Volvo	V40	2012	2017	petrol	none	151	1	6	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_480e6785828019fbe74b5a2b	237	Volvo	V40	2012	2014	diesel	none	150	0.871	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3d41e0d33039a7a4bb8b9018	237	Volvo	V40	2013	2017	petrol	none	121	1	6	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_871ae6965dbae862ee24a407	237	Volvo	V40	2013	2016	diesel	none	114	0.7879	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7f11ad7744331613741b7d3f	237	Volvo	V40	2014	2017	diesel	none	190	0.8889	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_52e99c24887338a9240cb96b	237	Volvo	V40	2014	2017	petrol	none	245	1	3	5.4	5.4	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cb8f190772d50fa0675d29d8	262	Volvo	V60	2011	2017	petrol	none	151	1	7	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_74a636d550454d3c8cd55af9	262	Volvo	V60	2011	2015	diesel	none	215	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c244ef2cdfbeecec4ce211eb	262	Volvo	V60	2011	2014	petrol	none	179	1	3	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_3f5ffea7a7a3667ed9fdb5dd	262	Volvo	V60	2011	2014	petrol	none	305	1	2	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d608f551e2ff2368194c73fd	262	Volvo	V60	2012	2016	diesel	none	114	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_0c243e9f0ef57c4e05178369	262	Volvo	V60	2012	2016	diesel	none	136	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_8c13287079c2bbe5aeffdfca	262	Volvo	V60	2013	2015	diesel	none	163	0.8056	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_2b10aecbc5e9973a928d518a	262	Volvo	V60	2015	2018	diesel	none	120	0.8	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_38cc1f01e360c261f52d638a	262	Volvo	V60	2015	2017	diesel	none	150	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fa3a369c99f5ce1bf4bf1931	262	Volvo	V60	2015	2017	diesel	none	190	1	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_fd30e8ededb9bb612bb83af4	262	Volvo	V60	2015	2017	petrol	none	190	1	2	6.9	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_7f2e3b4ed59589bb128a1c41	262	Volvo	V60	2018	2021	diesel	none	150	0.9468	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_20b0472ddecdb4c6cf668dc9	262	Volvo	V60	2018	2020	diesel	none	190	0.9792	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	262	Volvo	V60	2020	2024	petrol	hybrid	163	0.9277	5	6.1	6.2	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_d696a67b706779f686737a8e	262	Volvo	V60	2020	2022	diesel	hybrid	197	0.9875	3	4.6	4.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_de21186819d0c3ed6721b6b4	262	Volvo	V60	2022	2024	petrol	hybrid	197	1	3	6.3	6.3	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_cdc1ade42f8a28462921ebb4	283	Volvo	V70	2011	2015	diesel	none	215	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	283	Volvo	V70	2012	2016	diesel	none	136	1	5	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_93864f48bcedb3e1dcf7b395	283	Volvo	V70	2012	2015	diesel	none	114	0.8	4	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_06bbe2759dd5940388b11f11	283	Volvo	V70	2013	2015	diesel	none	163	0.8182	3	4.6	4.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_56b188f0c6a744fe34510253	235	Volvo	XC40	2018	2021	diesel	none	150	0.91	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f392de5f48c15770c4169b3f	235	Volvo	XC40	2018	2020	diesel	none	190	0.9976	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f1c182be3b7370b276488ce1	235	Volvo	XC40	2019	2022	petrol	none	163	0.8685	4	6.5	6.9	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_299e0197c21d6a4145553a10	235	Volvo	XC40	2020	2023	petrol/electric	plug_in_hybrid	179	0.9211	4	6.5	6.9	15.2	15.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_30240626d7153a09d8dd526a	235	Volvo	XC40	2020	2022	petrol	none	129	0.9984	3	6.5	6.5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_db012011cecc0738c0be86a1	235	Volvo	XC40	2020	2022	petrol/electric	plug_in_hybrid	129	0.9969	3	6.5	6.5	15.2	15.9	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_f216b41a65b6f27b10c2caf1	235	Volvo	XC40	2022	2024	petrol	hybrid	163	1	3	6.6	6.7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_24934a378a7caf7ef95b1e4c	235	Volvo	XC40	2022	2024	petrol	hybrid	197	0.7531	3	6.7	7.1	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_effe7ed5580b2377350e11c7	235	Volvo	XC40	2023	2025	electric	electric	252	1	3	\N	\N	16.7	16.8	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_a42b4580514463993537f995	247	Volvo	XC60	2011	2017	diesel	none	217	1	8	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1f302fd88084452785dd4bce	247	Volvo	XC60	2011	2014	petrol	none	305	1	3	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_6be9a0d6dc086c42e60d1b48	247	Volvo	XC60	2012	2015	diesel	none	136	1	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_91d89978bded7af935171054	247	Volvo	XC60	2012	2015	diesel	none	163	0.8	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_36e0aca970be5304085bf1cb	247	Volvo	XC60	2013	2016	diesel	none	181	1	4	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_dc5d0550dd0867fb490091a9	247	Volvo	XC60	2015	2017	diesel	none	150	1	3	5	5	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5b57841b9ca0dccdbfff958a	247	Volvo	XC60	2017	2019	petrol	none	251	0.7143	3	7	7	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_665613abf36a497cb72cfb11	244	Volvo	XC90	2011	2015	diesel	none	200	1	5	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_5045055080e5170317894640	244	Volvo	XC90	2011	2014	diesel	none	163	0.8333	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_67d186621ad27d99b9f7c0e0	244	Volvo	XC90	2015	2018	diesel	none	190	1	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_bfa735595d760dbb764bcc2e	244	Volvo	XC90	2015	2018	petrol	none	253	1	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_53abd1c539af2eb4d63186ed	244	Volvo	XC90	2015	2017	petrol	none	320	1	2	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e9e11ac65f26f9ad98e7365f	244	Volvo	XC90	2015	2017	diesel	none	224	1	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_98f3a27aa3218997e845542c	244	Volvo	XC90	2017	2020	diesel	none	235	0.9314	4	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_e89a67dc1f0a1fff4a2c6930	244	Volvo	XC90	2020	2022	diesel	hybrid	235	0.9214	3	5.6	5.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
eea_tvv_range_1499e02f91a13b39557e5e67	244	Volvo	XC90	2020	2022	petrol	hybrid	250	0.8846	3	7.6	7.6	\N	\N	high	EEA CO2 monitoring, continuita Tipo/Variante/Versione	https://www.eea.europa.eu/en/datahub/datahubitem-view/fa8b1229-3db6-495d-b18e-9c9b3267c02b
\.

COPY mvp.eea_historical_display_range_members_v1 (
  range_id,
  historical_version_id,
  vehicle_profile_id
) FROM stdin;
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_d7f473188ad5c465ca4f69c4	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_3f0cf2a6c23f03d7ca6523db	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_cc631c0a910580015cd55711	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_145ee2301ae151c8e2d44fe5	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_12fb6b6958cbfaa4ebf010b4	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_a2b1990764dd9b92244cb817	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_c8509f464665699b2b5f58ba	\N
eea_tvv_range_4a356d0672afeab6b601ec3b	eea_hist_277224ec1dffcf72c5585a75	\N
eea_tvv_range_d72a532ea8ee29496aa83718	eea_hist_beb83f2b3a4da60f57fc7d8a	\N
eea_tvv_range_d72a532ea8ee29496aa83718	eea_hist_22cc2deaf70a795e4163c3f3	\N
eea_tvv_range_d72a532ea8ee29496aa83718	eea_hist_035c0c599e7aeb2fcf9a4afc	\N
eea_tvv_range_d72a532ea8ee29496aa83718	eea_hist_5898b4a055514c0e94b21513	\N
eea_tvv_range_bf57d7efd49d19b7107ca6fc	eea_hist_aba25a08fd4d220fe3da409b	\N
eea_tvv_range_bf57d7efd49d19b7107ca6fc	eea_hist_36008785a3d16bc22d13e952	\N
eea_tvv_range_bf57d7efd49d19b7107ca6fc	eea_hist_6a49a312a6d02d323eb4ff3a	\N
eea_tvv_range_bf57d7efd49d19b7107ca6fc	eea_hist_65925c3b74e90066d2db1855	\N
eea_tvv_range_acdb1a0347c1eaeda1ddc425	eea_hist_1eaf434d05e37f3ac79f4fc1	\N
eea_tvv_range_acdb1a0347c1eaeda1ddc425	eea_hist_64e7732bf5f88e2ceb53ed1a	\N
eea_tvv_range_acdb1a0347c1eaeda1ddc425	eea_hist_fd949d3c99b73d9f5d4dad9a	\N
eea_tvv_range_acdb1a0347c1eaeda1ddc425	eea_hist_5e7429539ba3ce8f084d2ddd	\N
eea_tvv_range_acdb1a0347c1eaeda1ddc425	eea_hist_e8327a32df002b63df3955ef	\N
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_0e286274585228a6de51edfa	\N
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_67783415046721b30aa20d24	\N
eea_tvv_range_5aef52621f6d70e8c6d32b26	eea_hist_fcac44552ae8cd4ca88de384	\N
eea_tvv_range_147f4cb9d58f9fa4d32058dc	eea_hist_dc2009fc0e54bab7a3382a3c	\N
eea_tvv_range_147f4cb9d58f9fa4d32058dc	eea_hist_c382d2e073093a02aedc7506	\N
eea_tvv_range_147f4cb9d58f9fa4d32058dc	eea_hist_a23da355389e6e99785f9ed8	\N
eea_tvv_range_147f4cb9d58f9fa4d32058dc	current_cluster:eab2d40c00cc10695db00b4653488789	22
eea_tvv_range_6866ae97967be7b4013fea4d	eea_hist_b222c4434618036cdbc31f01	\N
eea_tvv_range_6866ae97967be7b4013fea4d	eea_hist_bb7a45085895cb1640cc0437	\N
eea_tvv_range_6866ae97967be7b4013fea4d	eea_hist_e32b536925b39f0906cedbdc	\N
eea_tvv_range_6866ae97967be7b4013fea4d	eea_hist_9ee3d271aece852aeb55e814	\N
eea_tvv_range_6866ae97967be7b4013fea4d	current_cluster:7efff73b521c2f0e7e0c716d1363b901	23
eea_tvv_range_806963181d6b53c28c4797a2	eea_hist_d33ef65608372a3d7f8a5887	\N
eea_tvv_range_806963181d6b53c28c4797a2	current_cluster:505e118cb7c8d2c290d37dccb6ff6dca	20
eea_tvv_range_cf8e8d4a6822ee051d80bd05	eea_hist_d5ab8178c8017eec55a38130	\N
eea_tvv_range_cf8e8d4a6822ee051d80bd05	eea_hist_c17b72dbec929a35d7419a06	\N
eea_tvv_range_cf8e8d4a6822ee051d80bd05	eea_hist_9b07e33a520de2e853e2af66	\N
eea_tvv_range_cf8e8d4a6822ee051d80bd05	eea_hist_eb96fcd7ee4c2b3b7a7e1636	\N
eea_tvv_range_cf8e8d4a6822ee051d80bd05	eea_hist_af989747d5fec04d12126964	\N
eea_tvv_range_812a0aa8a61bb88ba09de70d	eea_hist_eff55cda633824f93fe29e36	\N
eea_tvv_range_812a0aa8a61bb88ba09de70d	eea_hist_8bff623c47c94ba05de3764c	\N
eea_tvv_range_812a0aa8a61bb88ba09de70d	eea_hist_daa715f1f688bcf73f693f88	\N
eea_tvv_range_812a0aa8a61bb88ba09de70d	current_cluster:149bfe5c9c949a9ca311e59d3f94681e	6
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_e645c43218941bf6791b6c77	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_bbf341e8d5ccce328b525c94	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_fcd8d1a591c150f32400b7f2	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_f75e6c552a74eea147ce6c72	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_8c38fb1d570091ab17892e8a	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_145a4bc9c9fe87aa0c9699e5	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_167fb5d40b27ff0aec6755de	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_e2b563f7e02374c2d918b4c9	\N
eea_tvv_range_4521424ec12692cac3e53274	eea_hist_f56eb2af2145f7767e65de13	\N
eea_tvv_range_e1bd75e1334e69f7616efe23	eea_hist_12128517c4d65f6f913e989e	\N
eea_tvv_range_e1bd75e1334e69f7616efe23	eea_hist_985eaaa6c14d0d34a012746c	\N
eea_tvv_range_e1bd75e1334e69f7616efe23	eea_hist_83d0e8b62d8283267da7d9cb	\N
eea_tvv_range_e1bd75e1334e69f7616efe23	eea_hist_b33da03d2f83006d8e25b06e	\N
eea_tvv_range_e1bd75e1334e69f7616efe23	eea_hist_48945fe2c2710fb2eb29451e	\N
eea_tvv_range_3d9ad9a610d51e30275c72d8	eea_hist_0434f8fe614811e0cd2649cb	\N
eea_tvv_range_3d9ad9a610d51e30275c72d8	eea_hist_6d440ea1af1bfbc783252336	\N
eea_tvv_range_d780a7c9d19f5ebd5959331e	eea_hist_2a9656ec90dd14f8407af26f	\N
eea_tvv_range_d780a7c9d19f5ebd5959331e	eea_hist_05812a6e37ae82d519906151	\N
eea_tvv_range_d780a7c9d19f5ebd5959331e	eea_hist_be34686298c9abdb4b21dab7	\N
eea_tvv_range_d780a7c9d19f5ebd5959331e	eea_hist_d916cf08b88263f66b7195e2	\N
eea_tvv_range_0704452dee0d6371462bf53c	eea_hist_b46a59127a039298b3c5ccf8	\N
eea_tvv_range_0704452dee0d6371462bf53c	eea_hist_35fd309d2900c7a7c8eb5b4f	\N
eea_tvv_range_0704452dee0d6371462bf53c	eea_hist_139d1d57ae97545c19d04ebd	\N
eea_tvv_range_0704452dee0d6371462bf53c	eea_hist_da862cda3a61e4660cd7566c	\N
eea_tvv_range_593070da17786bbb2f9e94fe	eea_hist_507d3cea49917182054d51fb	\N
eea_tvv_range_593070da17786bbb2f9e94fe	eea_hist_bc7c3b8ced311ceb665e3602	\N
eea_tvv_range_2dcdcbc1d4d958966401cf14	eea_hist_12c6f778ba32b92e65176ff3	\N
eea_tvv_range_2dcdcbc1d4d958966401cf14	eea_hist_00436d948d5865eafaf9bf98	\N
eea_tvv_range_2dcdcbc1d4d958966401cf14	eea_hist_b8dc8dd44eb9ff050981c756	\N
eea_tvv_range_2dcdcbc1d4d958966401cf14	eea_hist_f0ebe1963a1862166ab18531	\N
eea_tvv_range_2dcdcbc1d4d958966401cf14	eea_hist_503e247e459e75e005e2e882	\N
eea_tvv_range_dab0b00d48c35bbbdce4d026	eea_hist_7885c56b991400fc9386a755	\N
eea_tvv_range_dab0b00d48c35bbbdce4d026	eea_hist_0557fd09740a838a42031b87	\N
eea_tvv_range_dab0b00d48c35bbbdce4d026	eea_hist_bd2103af694d5b56eb8fa242	\N
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_a83a4018fd8be4ad3dcb582b	\N
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_66b6effb1d7ced8126e3774b	\N
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_9005687cfc9c545a42d58e0a	\N
eea_tvv_range_26fb6fbb8abe0650ab66f280	eea_hist_36ac611a82388a602b21e4e4	\N
eea_tvv_range_a5957c28dd5c997f0eefff47	eea_hist_689018d7572c958a68b47f09	\N
eea_tvv_range_a5957c28dd5c997f0eefff47	eea_hist_f1df3ee493deefd78478b029	\N
eea_tvv_range_a5957c28dd5c997f0eefff47	eea_hist_16fc10a94171168546f509cb	\N
eea_tvv_range_79afe1060cab0fe1be5346d6	eea_hist_478506f7c62de82913a83f93	\N
eea_tvv_range_79afe1060cab0fe1be5346d6	eea_hist_244576368eb9769f7800f7cc	\N
eea_tvv_range_524dfd14efd4791a3aa97886	eea_hist_2f2e77eede7149b0cf92c9c2	\N
eea_tvv_range_524dfd14efd4791a3aa97886	eea_hist_27c912406cc993200c7dcf7f	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_4f51cf417cb2d20d3a33fd39	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_ca18ec417ae77fd318d365ea	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_e63f8b5f0a490e3d3b76cc8b	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_f8c9e0cf75ecb3762820b2d4	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_6a80643c0cfe5c6a117896b9	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_6e859ee5c8db5874f7fa6018	\N
eea_tvv_range_2f6d9ae6acd9074439fb1266	eea_hist_324d3dc4467101eaa30c9246	\N
eea_tvv_range_4bec2525b3139d019224a2d7	eea_hist_8da0cfc0b9df0faebc6f004c	\N
eea_tvv_range_4bec2525b3139d019224a2d7	eea_hist_e1eda4f60796a10a02385bd4	\N
eea_tvv_range_4bec2525b3139d019224a2d7	eea_hist_f961cee42f0f2d955d1878e7	\N
eea_tvv_range_4bec2525b3139d019224a2d7	eea_hist_95d53c7450574006486fed4f	\N
eea_tvv_range_4bec2525b3139d019224a2d7	eea_hist_54600ec7b1bd0219132413e1	\N
eea_tvv_range_3ed426a7090e828c6ef53e22	eea_hist_c8a07a6299d8e916cbc057ea	\N
eea_tvv_range_3ed426a7090e828c6ef53e22	eea_hist_bfe3592fc62609dd29ca4be7	\N
eea_tvv_range_6715a779f8914f04190a64ad	eea_hist_bd02b048cc41ad06fac6a8c9	\N
eea_tvv_range_6715a779f8914f04190a64ad	eea_hist_2825f42e153331639cba901e	\N
eea_tvv_range_9e5cc019ea7245362d088abf	eea_hist_2d9ce9469676f8a53f83c258	\N
eea_tvv_range_9e5cc019ea7245362d088abf	eea_hist_47deab98c97f104196a54935	\N
eea_tvv_range_9e5cc019ea7245362d088abf	eea_hist_373ae49237c6afce48d08d16	\N
eea_tvv_range_9e5cc019ea7245362d088abf	eea_hist_71d0adc0e8d1c21cb29a034b	\N
eea_tvv_range_9dab9b941d42e865cba42d8b	eea_hist_df375194c72382966f70fb2c	\N
eea_tvv_range_9dab9b941d42e865cba42d8b	eea_hist_ad57a4e6397a96efc73b4246	\N
eea_tvv_range_9dab9b941d42e865cba42d8b	eea_hist_b0d558b5970755b58353d6d2	\N
eea_tvv_range_8dfb90ff8a2fd8496384160d	eea_hist_2c9f0ea7683f74582c03e872	\N
eea_tvv_range_8dfb90ff8a2fd8496384160d	eea_hist_6e85d9de563bb55d38821041	\N
eea_tvv_range_8dfb90ff8a2fd8496384160d	eea_hist_66f612124aa05aa0b44540e2	\N
eea_tvv_range_7bcbbd55ccebeaf824175ec9	eea_hist_43d17ce51ad074a565da0b82	\N
eea_tvv_range_7bcbbd55ccebeaf824175ec9	eea_hist_83fb6a5cc952ae02d21e2c51	\N
eea_tvv_range_7bcbbd55ccebeaf824175ec9	eea_hist_e00fbadafd11c1528c5f8a9b	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_4d1e3ea141508622e2afea85	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_913c2283763a974ee0efe6ef	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_7f5c3e670cbe9d2b5b6b29b1	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_a5b4f63d6d225ea466f5bbbf	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_40f580cd10b12da0530a28be	\N
eea_tvv_range_38af953d221c6c6d75280ff8	eea_hist_9887aad1285eb07538bbb5c3	\N
eea_tvv_range_8486764858953fa52757189b	eea_hist_cf147fa6208860296b5f6a00	\N
eea_tvv_range_8486764858953fa52757189b	eea_hist_382363897d1852ab238f6a09	\N
eea_tvv_range_8486764858953fa52757189b	eea_hist_112931b6f224118dbe71730c	\N
eea_tvv_range_8486764858953fa52757189b	eea_hist_b75caab12ffe5aa97e2f42c4	\N
eea_tvv_range_1acb2e5fbfcec77506aa5512	eea_hist_75bc5ebb90346be11127c29c	\N
eea_tvv_range_1acb2e5fbfcec77506aa5512	eea_hist_906a50cbd7802eb562268f90	\N
eea_tvv_range_1acb2e5fbfcec77506aa5512	eea_hist_a33154b4feb0b86ea7d81300	\N
eea_tvv_range_ca1a1863f22c0bc3f0dd4f48	eea_hist_6d3b59fb505abae7bdede147	\N
eea_tvv_range_ca1a1863f22c0bc3f0dd4f48	eea_hist_1b9f81a6012de663f0433ffa	\N
eea_tvv_range_ca1a1863f22c0bc3f0dd4f48	eea_hist_513fb61f0431b75dccb795ff	\N
eea_tvv_range_ca1a1863f22c0bc3f0dd4f48	eea_hist_fe5c7612c7207b89be34d78c	\N
eea_tvv_range_dc5b0bf58ff79ca1e9037ceb	eea_hist_29413d0b5ed6c8a2ff547cb4	\N
eea_tvv_range_dc5b0bf58ff79ca1e9037ceb	eea_hist_e2a921827184699efcf55825	\N
eea_tvv_range_aec3b1b4e81edf683721c438	eea_hist_66143a19e9a967c57078071b	\N
eea_tvv_range_aec3b1b4e81edf683721c438	eea_hist_d2ee9c10f220e99e40082f4a	\N
eea_tvv_range_6aadce963f0569bdd220a2f8	eea_hist_bdb5fa92b6058628fd0475c6	\N
eea_tvv_range_6aadce963f0569bdd220a2f8	current_cluster:e94d34be5b9f85d62d3d480ed5b71067	47
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_2b4ff320556ad29715ac257f	\N
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_9ff4c6a3a77a319bfb3237fb	\N
eea_tvv_range_4627fd59d6a2ee2cfec23148	eea_hist_1be181d03ad03cd42bb0bd35	\N
eea_tvv_range_1f348e82249b0a0298c7f4f7	eea_hist_ca7ac2ca07856b694ca6b583	\N
eea_tvv_range_1f348e82249b0a0298c7f4f7	eea_hist_66d516dba896cd362c3439c5	\N
eea_tvv_range_1f348e82249b0a0298c7f4f7	eea_hist_69acd77cd7a740ef5869d7fb	\N
eea_tvv_range_d6bd2d2ac576f660a5e5c6c2	eea_hist_cddb0544c5600255290364b5	\N
eea_tvv_range_d6bd2d2ac576f660a5e5c6c2	eea_hist_623e2c824b7a663093319461	\N
eea_tvv_range_d6bd2d2ac576f660a5e5c6c2	eea_hist_9864bc6114cde041860a55b9	\N
eea_tvv_range_79edfa7f6f3cc89eb913a062	eea_hist_81f97987ca9eb2567f8f7cda	\N
eea_tvv_range_79edfa7f6f3cc89eb913a062	eea_hist_0c6495ab28e61d5e736a8153	\N
eea_tvv_range_79edfa7f6f3cc89eb913a062	eea_hist_acd735e1a913270594866b9c	\N
eea_tvv_range_79edfa7f6f3cc89eb913a062	eea_hist_b8c691b149dafabacc0080e3	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_d78697391676e33a305bf07b	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_90c8800dc18066da5a88c485	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_7579a9cf037887585dff02a9	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_219f6414fcc61f4c1ed6057a	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_43952798a55a868f2de0efd6	\N
eea_tvv_range_a2692b327b10d2493a3f1675	eea_hist_20235a68e64fa868fc65f09e	\N
eea_tvv_range_5faf694960482d849f77ea0e	eea_hist_7a9fc980c84bd6d2e57d79c4	\N
eea_tvv_range_5faf694960482d849f77ea0e	eea_hist_d5252e209f67f80d06ff4be2	\N
eea_tvv_range_5faf694960482d849f77ea0e	eea_hist_edd75d12300053eeb3c8285c	\N
eea_tvv_range_5faf694960482d849f77ea0e	eea_hist_999634c720bedef0075602ff	\N
eea_tvv_range_3df3b740546553365cd72a0a	eea_hist_c0b84a3d510cfe6770394c18	\N
eea_tvv_range_3df3b740546553365cd72a0a	eea_hist_4753b9f081779f93e079a516	\N
eea_tvv_range_fc552c191b264e14854086e5	eea_hist_f7a11660368d8c3e8f10fe1b	\N
eea_tvv_range_fc552c191b264e14854086e5	eea_hist_965db3e7fb7b0fe57918e6a8	\N
eea_tvv_range_fc552c191b264e14854086e5	eea_hist_f6261b0895a125147a649038	\N
eea_tvv_range_e6e77dc4a122d46c0f7454eb	eea_hist_35a2b7a67681aa3fc47fe486	\N
eea_tvv_range_e6e77dc4a122d46c0f7454eb	eea_hist_6cc4be97037383af24774c74	\N
eea_tvv_range_98289e2ffcbddc665684ebf8	eea_hist_ad95d10afb3b40a9ed5050a5	\N
eea_tvv_range_98289e2ffcbddc665684ebf8	eea_hist_37e45942b8c1a7c0a35dab32	\N
eea_tvv_range_0dac928fbcc9ecdd176ad6e6	eea_hist_6493a64d24778d134e4908f8	\N
eea_tvv_range_0dac928fbcc9ecdd176ad6e6	eea_hist_13eff55c4e63baa4e61f8be2	\N
eea_tvv_range_0dac928fbcc9ecdd176ad6e6	eea_hist_65e8d669b2ff4ae2754b844d	\N
eea_tvv_range_0dac928fbcc9ecdd176ad6e6	eea_hist_9d4572ceab409f0844548f2b	\N
eea_tvv_range_4c562531f229c758c6720706	eea_hist_b8b18816445441f3b372bdc9	\N
eea_tvv_range_4c562531f229c758c6720706	eea_hist_ebf993f04308cdad3fc73367	\N
eea_tvv_range_4c562531f229c758c6720706	eea_hist_fa930473940f2c99db45d6ce	\N
eea_tvv_range_4060a3c89dbe295006549246	eea_hist_81c215b864c49fbb2162d6d6	\N
eea_tvv_range_4060a3c89dbe295006549246	eea_hist_a619988ddc886834958a0d80	\N
eea_tvv_range_4060a3c89dbe295006549246	eea_hist_6eef81fe0c03c8df5b55b767	\N
eea_tvv_range_4060a3c89dbe295006549246	eea_hist_1658d43dbd4713386fb9b719	\N
eea_tvv_range_59907d366beec4e49c470d67	eea_hist_0b303b74fc5ee2ee45f0e652	\N
eea_tvv_range_59907d366beec4e49c470d67	eea_hist_bc62bf88325478b72dcdc210	\N
eea_tvv_range_59907d366beec4e49c470d67	eea_hist_44b8bc10886a53b14d490b52	\N
eea_tvv_range_59907d366beec4e49c470d67	eea_hist_ea6c5c58fba2bcfaeb0506b7	\N
eea_tvv_range_53d9dd2d4fdd319082a4da01	eea_hist_e32097a55edadbae71fb4700	\N
eea_tvv_range_53d9dd2d4fdd319082a4da01	eea_hist_ccdc0539d16c175fa2945689	\N
eea_tvv_range_a74829bbd7a7cbf577baff56	eea_hist_797a2c3db45af7b1e232ab8e	\N
eea_tvv_range_a74829bbd7a7cbf577baff56	eea_hist_c9634f54fa69f39bf2b4cd1d	\N
eea_tvv_range_a74829bbd7a7cbf577baff56	eea_hist_231ce54f6df04da545162ec8	\N
eea_tvv_range_1942a67078b52efeb806d0c6	eea_hist_1a51cb54cdb5bfd6aa7b7ce6	\N
eea_tvv_range_1942a67078b52efeb806d0c6	eea_hist_f2713c33c1136d66dab0b3c9	\N
eea_tvv_range_1942a67078b52efeb806d0c6	eea_hist_429dce53d22bdebfff56105c	\N
eea_tvv_range_5009515ad45236a2c1bbb64e	eea_hist_3fa5d7379a8051d31a5f448e	\N
eea_tvv_range_5009515ad45236a2c1bbb64e	eea_hist_077b5eaba3dcfdfe11933f36	\N
eea_tvv_range_5009515ad45236a2c1bbb64e	eea_hist_da4f3202934f082c895c3bd6	\N
eea_tvv_range_66192527c42bd4599899ac31	eea_hist_df2ad04a979b7b35bb7440fb	\N
eea_tvv_range_66192527c42bd4599899ac31	eea_hist_7d43a10b8cf5ce34cdcbe5b0	\N
eea_tvv_range_66192527c42bd4599899ac31	eea_hist_ae797bdb2c1e585f0e7cb634	\N
eea_tvv_range_9865069aa3f93305f9172a6f	eea_hist_a335d8ca8557cb0dd9f8e1aa	\N
eea_tvv_range_9865069aa3f93305f9172a6f	eea_hist_2d46ddb62e99b1f1f380a5a0	\N
eea_tvv_range_9865069aa3f93305f9172a6f	eea_hist_fe149cc410e5f75833303a14	\N
eea_tvv_range_45544eca280b23a841961ec5	eea_hist_e2189f620b6b542fa110bc96	\N
eea_tvv_range_45544eca280b23a841961ec5	eea_hist_3993e0bed267e15fc833c84d	\N
eea_tvv_range_45544eca280b23a841961ec5	eea_hist_10cd89705fbd568bf0400950	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_4a4adaf04f0a66a087906ffd	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_0eb4c91138fb1c961e987043	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_a17341e3cf3ea038e49d04c1	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_477a7db1aa0dd285ebf25d8e	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_b360812dc78720a7f633b975	\N
eea_tvv_range_2143b3c68fb5a8fb487439be	eea_hist_beaabf1ef694e585848bd878	\N
eea_tvv_range_84006c9af987f5afe0366865	eea_hist_f1d6f96e87ba1968eafddbdf	\N
eea_tvv_range_84006c9af987f5afe0366865	eea_hist_f932db3e056b72f170c6234b	\N
eea_tvv_range_84006c9af987f5afe0366865	eea_hist_cf5247b22225af8cb387b1b9	\N
eea_tvv_range_1cff6aac19ef7fca1f97a12c	eea_hist_f28a020333f8abad5467218f	\N
eea_tvv_range_1cff6aac19ef7fca1f97a12c	eea_hist_8ee9f4bf99460e2465d81375	\N
eea_tvv_range_1cff6aac19ef7fca1f97a12c	eea_hist_71b2eb1194bed159572816ae	\N
eea_tvv_range_a60fe234f8ba83dff3642a7f	eea_hist_be784b35204c2b9ee7dfed1b	\N
eea_tvv_range_a60fe234f8ba83dff3642a7f	eea_hist_c192bdd4329d8228da0acdea	\N
eea_tvv_range_a60fe234f8ba83dff3642a7f	eea_hist_e831fc5f93ca1d398ac0087e	\N
eea_tvv_range_a60fe234f8ba83dff3642a7f	eea_hist_dbc63fb2f5a2cadd63092bdb	\N
eea_tvv_range_018bb4ec3109f60bd2765f3d	eea_hist_310fbf6cdca7220beb8793a8	\N
eea_tvv_range_018bb4ec3109f60bd2765f3d	eea_hist_9c9dbb50244ce95304c42999	\N
eea_tvv_range_018bb4ec3109f60bd2765f3d	eea_hist_9f9e1a141f2687fd8a225aa8	\N
eea_tvv_range_a8bfdf6b3a155b7767b10c33	eea_hist_a328f29579ad29368909646d	\N
eea_tvv_range_a8bfdf6b3a155b7767b10c33	eea_hist_92984ac8f2da5721f6065c7f	\N
eea_tvv_range_dd9460d3ad666313220d8866	eea_hist_6eeadfe822ae7c89412249a7	\N
eea_tvv_range_dd9460d3ad666313220d8866	eea_hist_4560699010da73041106e212	\N
eea_tvv_range_dd9460d3ad666313220d8866	eea_hist_07d94f52c3f8b277c97f4b9e	\N
eea_tvv_range_dd9460d3ad666313220d8866	eea_hist_148dd8b3dadf1edddb47e0a1	\N
eea_tvv_range_30b365b2b57c5d1567e85b9a	eea_hist_2ff345e77399d18350180bca	\N
eea_tvv_range_30b365b2b57c5d1567e85b9a	eea_hist_267d43cc0ff9a829d9679f11	\N
eea_tvv_range_30b365b2b57c5d1567e85b9a	current_cluster:c5d1f5a0653ba4fa5c6d9dc75dd8609d	436
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_4cc1f053504e71ed32f25e3a	\N
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_e98c3f093beeb52009bbf709	\N
eea_tvv_range_d740b8c411bb20e8ac68cc2f	eea_hist_e91e966cf89c7fb83c42aec7	\N
eea_tvv_range_897368718ace6a66e1032976	eea_hist_c286066f9382b0ae9186f3f4	\N
eea_tvv_range_897368718ace6a66e1032976	eea_hist_97c147014811b8d7b178e64b	\N
eea_tvv_range_897368718ace6a66e1032976	eea_hist_cf8c50bac4e4fdb7c1cf1243	\N
eea_tvv_range_c788cd3d31dabb150450c8b0	eea_hist_3ac6a09b75666b3a1fc498e2	\N
eea_tvv_range_c788cd3d31dabb150450c8b0	eea_hist_98ef02647161ed84bbec8c41	\N
eea_tvv_range_c788cd3d31dabb150450c8b0	eea_hist_8adfdc98146b9db0d78f1317	\N
eea_tvv_range_934252b8b8a8caf3e390e178	eea_hist_5f870b2ff514a01f49b1cc4f	\N
eea_tvv_range_934252b8b8a8caf3e390e178	eea_hist_6d83fd4db2fdc1ca18d15206	\N
eea_tvv_range_934252b8b8a8caf3e390e178	eea_hist_2fb36e70013f77d29dc30041	\N
eea_tvv_range_79033a358572a7fead505af6	eea_hist_235358550ef0c17bf8acb857	\N
eea_tvv_range_79033a358572a7fead505af6	eea_hist_a97870e12631806df1882e0f	\N
eea_tvv_range_3c667773fed96b759a093fb3	eea_hist_7df276020da8992aed6ea5ee	\N
eea_tvv_range_3c667773fed96b759a093fb3	eea_hist_757c2d4947aafd3e1162a436	\N
eea_tvv_range_3c667773fed96b759a093fb3	eea_hist_98986ed8193e57e4e7363058	\N
eea_tvv_range_01f94eb7439ee19449bc003e	eea_hist_e14b2835f016dd561f505bc1	\N
eea_tvv_range_01f94eb7439ee19449bc003e	eea_hist_c211b39723cb45ae90ea59cc	\N
eea_tvv_range_01f94eb7439ee19449bc003e	eea_hist_67b6b9f9c92b576839cef1b2	\N
eea_tvv_range_6a1cf6995605a0be404b2878	eea_hist_7e69d74185e5d57935f3c1ec	\N
eea_tvv_range_6a1cf6995605a0be404b2878	eea_hist_961be518094880933d5e509d	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_34ac4ee0d2a907c6d5029321	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_974b5a40f5144b0aee04a923	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_51993f0c04ddc88803c13c50	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_f9de3a9054a57ac88431d8c2	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_3e7b4b6feafb21b93c317436	\N
eea_tvv_range_02439da09670aa4d10f0874a	eea_hist_311603413727461c9c28e7e9	\N
eea_tvv_range_395881cb999e619729dff3c8	eea_hist_158acd804014ce7726db93fa	\N
eea_tvv_range_395881cb999e619729dff3c8	eea_hist_4f2cb9f643467e4cc10ef0f8	\N
eea_tvv_range_395881cb999e619729dff3c8	eea_hist_c4957c0b5cee3ee1e8e73543	\N
eea_tvv_range_789186fbd773fe1ea60167d9	eea_hist_105bc79b6684985b5c8c5b10	\N
eea_tvv_range_789186fbd773fe1ea60167d9	eea_hist_20949a6d25c82b604d3eb7b6	\N
eea_tvv_range_789186fbd773fe1ea60167d9	eea_hist_87e82f2f1ee64efc1a94354a	\N
eea_tvv_range_789186fbd773fe1ea60167d9	eea_hist_7b1eab440bbc21738065fa23	\N
eea_tvv_range_ebcb6f5bc47f507925b5c1e5	eea_hist_c4cba4dbb1bb51dcb1622e2c	\N
eea_tvv_range_ebcb6f5bc47f507925b5c1e5	eea_hist_f036becf58bfd4836160925d	\N
eea_tvv_range_76535222a5f96162c838b9f2	eea_hist_6fe28251a8071187a0f0ec58	\N
eea_tvv_range_76535222a5f96162c838b9f2	eea_hist_773df26fe327c12ac73039bb	\N
eea_tvv_range_76535222a5f96162c838b9f2	eea_hist_f80e8571ad60d3051167dfc0	\N
eea_tvv_range_76535222a5f96162c838b9f2	eea_hist_05492a28ce7629f166797c9b	\N
eea_tvv_range_e7f10ffcc7d2328ff28fb3e4	eea_hist_a7d6c003997bf950e4d73dc7	\N
eea_tvv_range_e7f10ffcc7d2328ff28fb3e4	eea_hist_382b045db0ab5bbae51facb2	\N
eea_tvv_range_e7f10ffcc7d2328ff28fb3e4	eea_hist_158f5714a95937f070a3c910	\N
eea_tvv_range_e67a9e8b649c50a5723e9439	eea_hist_e45650a45e576499bd69aa07	\N
eea_tvv_range_e67a9e8b649c50a5723e9439	eea_hist_4f750795b0fbc7da50897e4d	\N
eea_tvv_range_e67a9e8b649c50a5723e9439	eea_hist_96230a033c0d04a9654738e1	\N
eea_tvv_range_e67a9e8b649c50a5723e9439	eea_hist_832e90abf013c3dba52c3f0d	\N
eea_tvv_range_125119553437d22c97c8e89a	eea_hist_71c5d2e05e4407ba4a4decaf	\N
eea_tvv_range_125119553437d22c97c8e89a	eea_hist_cf9d003810d3830f5fe55e91	\N
eea_tvv_range_4c741f06b7cfb57e4543330a	eea_hist_b8fa898b7d177f2af5c322db	\N
eea_tvv_range_4c741f06b7cfb57e4543330a	eea_hist_a252934895ca91f6c4de36b0	\N
eea_tvv_range_4c741f06b7cfb57e4543330a	eea_hist_729cebd3966301bcf8770eb1	\N
eea_tvv_range_4c741f06b7cfb57e4543330a	eea_hist_523047bbd3cab0be370fc44c	\N
eea_tvv_range_b86499ad611e4b8e9521cc3d	eea_hist_776560ac1361c7dd74d9090b	\N
eea_tvv_range_b86499ad611e4b8e9521cc3d	eea_hist_cf578483631ab88a316a6269	\N
eea_tvv_range_b86499ad611e4b8e9521cc3d	eea_hist_66e811c3cba79db5f4fbb4cd	\N
eea_tvv_range_21262b04368f28d56d168cf7	eea_hist_88d30cc13f23011c51af3f07	\N
eea_tvv_range_21262b04368f28d56d168cf7	eea_hist_674f4f6c8b6e20215680d788	\N
eea_tvv_range_21262b04368f28d56d168cf7	current_cluster:a5605e07e4d5990723df65b732383b68	591
eea_tvv_range_ab054cb0a07a90d8d33363cc	eea_hist_a030e75caef64f938661615a	\N
eea_tvv_range_ab054cb0a07a90d8d33363cc	eea_hist_eb3570f793b5a8513f29da24	\N
eea_tvv_range_ab054cb0a07a90d8d33363cc	current_cluster:d5575403e77ebc02285180f6c2fc3124	592
eea_tvv_range_4aa5315cd85ace540cf1f111	eea_hist_35ab04674267a9228b8788ba	\N
eea_tvv_range_4aa5315cd85ace540cf1f111	eea_hist_9d8882dea7ce168eeb5f02fc	\N
eea_tvv_range_4aa5315cd85ace540cf1f111	eea_hist_a6b5c31959b6a5d960d77ace	\N
eea_tvv_range_4aa5315cd85ace540cf1f111	eea_hist_4accbbc3c617337b6caad59c	\N
eea_tvv_range_4aa5315cd85ace540cf1f111	eea_hist_29223f49cecc236c928e3240	\N
eea_tvv_range_ed9809662695f2600f8b409f	eea_hist_4b4ac539e52846774ced804b	\N
eea_tvv_range_ed9809662695f2600f8b409f	eea_hist_de118bc709fa2c488cd51a65	\N
eea_tvv_range_ed9809662695f2600f8b409f	eea_hist_450b612c6d93e1e8eb3b520b	\N
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_be4a39dec4e8d93d8671bc95	\N
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_7bb43bc205827f43c8416dff	\N
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_d94f3bf0c8a3b8a4e012ed2c	\N
eea_tvv_range_6d4916b2b8c27420eec09114	eea_hist_0a7e3dc5984d05c9baba1724	\N
eea_tvv_range_a84ed3bde54658a50486eb0b	eea_hist_12cefeefd0642556878e77b6	\N
eea_tvv_range_a84ed3bde54658a50486eb0b	eea_hist_dfa0f2cc789d2c184ab512b5	\N
eea_tvv_range_a84ed3bde54658a50486eb0b	eea_hist_7a07d24aa0afdc57685b8416	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_46011f472e48202bf587eafc	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_219c2ae08c64cdbb7d16874d	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_d50e3a75e855394347a65fea	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_86d84943384e03c506cbd832	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_0a917f5808d925b859debb05	\N
eea_tvv_range_154b643a7dc178ef5514c727	eea_hist_e1880a7956c9781f80222cba	\N
eea_tvv_range_7ce91a8952b394311372cd5e	eea_hist_416573b646839bfe064b302e	\N
eea_tvv_range_7ce91a8952b394311372cd5e	eea_hist_1cda82f341f4bf6851e0e7c1	\N
eea_tvv_range_7ce91a8952b394311372cd5e	eea_hist_f40d68208cc163f00b03425b	\N
eea_tvv_range_7ce91a8952b394311372cd5e	eea_hist_1cc8292e04c22fe628551f81	\N
eea_tvv_range_18b5ab503eddffa24a18a980	eea_hist_ccfddcb1cfade2d302b0a9e8	\N
eea_tvv_range_18b5ab503eddffa24a18a980	eea_hist_953f20973c350bd855f73786	\N
eea_tvv_range_18b5ab503eddffa24a18a980	eea_hist_c5244fc66111d99a17b3a747	\N
eea_tvv_range_18b5ab503eddffa24a18a980	eea_hist_e31c226d16af6e5a00a3f7fd	\N
eea_tvv_range_18b5ab503eddffa24a18a980	eea_hist_2de8193d5fbc7999342965cd	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_9fac39f8a8ac3e2a8719001c	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_898b7d1b916d785ce103b775	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_c08443ce4b5dd1a7c73eba6a	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_b87cf9533a4a8016c266e8ba	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_7cb5711f3e326c68a0cfe180	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_b0a14c141b95b0b7e785c368	\N
eea_tvv_range_616afda7e285fe5b37066e71	eea_hist_388283d1af3feb9a6faa8fb9	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_09c5cd40bafaef8b95c46964	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_ec085b1ca07065eada403976	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_6a5727356a39fb4164f123a2	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_4fe9f35678310d31046aa2f1	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_368963a0d0916d6c51d3b401	\N
eea_tvv_range_f41cae2e5653b79d0c2e7671	eea_hist_9078efae32ae5117851e5499	\N
eea_tvv_range_1b5e8a04e9bb84d06a2ead76	eea_hist_b10a7e289d47507915e4661f	\N
eea_tvv_range_1b5e8a04e9bb84d06a2ead76	eea_hist_3e98b24e58d60febbb932cae	\N
eea_tvv_range_47d7da9f8f9fe5bc5f9b07fe	eea_hist_f286aa9d7007fc9801e463e6	\N
eea_tvv_range_47d7da9f8f9fe5bc5f9b07fe	eea_hist_dbf3dec27dcb971ddae0f654	\N
eea_tvv_range_47d7da9f8f9fe5bc5f9b07fe	eea_hist_949ccc2dd56f1edacad5fd87	\N
eea_tvv_range_a21adb021cef15ce07aedcd6	eea_hist_9d0c1e0934b53deaddf44c22	\N
eea_tvv_range_a21adb021cef15ce07aedcd6	eea_hist_76d21a56e35acaca13bd63cf	\N
eea_tvv_range_a21adb021cef15ce07aedcd6	eea_hist_69a88ad5b0d7447300879aff	\N
eea_tvv_range_a21adb021cef15ce07aedcd6	eea_hist_f75aa7857969885a74378557	\N
eea_tvv_range_6f97045fb4c3dd734d1c2ef2	eea_hist_f1f0591f746fc2ce39c070ee	\N
eea_tvv_range_6f97045fb4c3dd734d1c2ef2	eea_hist_106edac1d4afaa0c569b4818	\N
eea_tvv_range_6f97045fb4c3dd734d1c2ef2	eea_hist_342b1d43db3c6334d508912f	\N
eea_tvv_range_6f97045fb4c3dd734d1c2ef2	eea_hist_a7ebdfe2a405d4de6ecc7253	\N
eea_tvv_range_895010b34223389a35f72a2b	eea_hist_3ef9417938f9626c961f4273	\N
eea_tvv_range_895010b34223389a35f72a2b	eea_hist_4c0636df30ae31fb1e36c8ec	\N
eea_tvv_range_895010b34223389a35f72a2b	eea_hist_24ab433a03eaa802ad83c650	\N
eea_tvv_range_895010b34223389a35f72a2b	eea_hist_1058bca6e566824a5c86e195	\N
eea_tvv_range_b347961a383b4d30a3231534	eea_hist_555dee26f1c0187a00b29550	\N
eea_tvv_range_b347961a383b4d30a3231534	eea_hist_f57e2f7255bca57b0b8ac967	\N
eea_tvv_range_b347961a383b4d30a3231534	eea_hist_e2785174ac384fa09093c46e	\N
eea_tvv_range_f3486a5a9cef7eaa89299476	eea_hist_496597ee692ec2041dcb2bb6	\N
eea_tvv_range_f3486a5a9cef7eaa89299476	eea_hist_f7dd70a13ebdcca66f63bafe	\N
eea_tvv_range_f3486a5a9cef7eaa89299476	eea_hist_074680f1f8601ab6b5d8c134	\N
eea_tvv_range_5d87b5c2a3ebae47fdd29236	eea_hist_84c9329e6ba10527aa73ca08	\N
eea_tvv_range_5d87b5c2a3ebae47fdd29236	eea_hist_6b04830d5458cceddce14156	\N
eea_tvv_range_5d87b5c2a3ebae47fdd29236	eea_hist_dc363ea96899cebccece80db	\N
eea_tvv_range_5d87b5c2a3ebae47fdd29236	eea_hist_08f1a5fa766f6f5f38e89485	\N
eea_tvv_range_b373e30b8c477938e37b24f4	eea_hist_9328caa766ee551c1c7be309	\N
eea_tvv_range_b373e30b8c477938e37b24f4	eea_hist_5810d7358a20bdec1055dde6	\N
eea_tvv_range_b373e30b8c477938e37b24f4	eea_hist_31cd0ed6ff647ecb36cf88f6	\N
eea_tvv_range_b373e30b8c477938e37b24f4	eea_hist_2678a698d67bb49873f111c2	\N
eea_tvv_range_a416b1ecb98035b96bc889d6	eea_hist_06459d98bd8e579d3b967b0e	\N
eea_tvv_range_a416b1ecb98035b96bc889d6	eea_hist_bb71d9e0104784fcd63b8e3b	\N
eea_tvv_range_a416b1ecb98035b96bc889d6	eea_hist_ddde91d96538c4ed0725c618	\N
eea_tvv_range_a416b1ecb98035b96bc889d6	eea_hist_9ae946612f746d621073bcab	\N
eea_tvv_range_bfead7340fc46f5e8f0a991a	eea_hist_59dc91dd1836e68e12e83068	\N
eea_tvv_range_bfead7340fc46f5e8f0a991a	eea_hist_e1ad1fb4f1233ad846465d81	\N
eea_tvv_range_bfead7340fc46f5e8f0a991a	eea_hist_bca29fd6c34944b97a3ad34a	\N
eea_tvv_range_5646fb3e579ff0c79e17b890	eea_hist_e5de1de995ed011d893a82b6	\N
eea_tvv_range_5646fb3e579ff0c79e17b890	eea_hist_44500be9df8ebd80180bcedd	\N
eea_tvv_range_5646fb3e579ff0c79e17b890	eea_hist_677003c06a39179d7f270c58	\N
eea_tvv_range_b3f320788f4e0d7531e07f36	eea_hist_8b3f90d34a83ceb663d1f2c7	\N
eea_tvv_range_b3f320788f4e0d7531e07f36	eea_hist_4c3d78c95a9deb8fefb2ca3e	\N
eea_tvv_range_b3f320788f4e0d7531e07f36	eea_hist_86743999c16e151ee5baf5a8	\N
eea_tvv_range_3af8c9bb0b0231863243d344	eea_hist_75928b30fa8848a7bbb3132b	\N
eea_tvv_range_3af8c9bb0b0231863243d344	eea_hist_fdb3dc5caa8a400a9b84f7fb	\N
eea_tvv_range_3af8c9bb0b0231863243d344	eea_hist_79d41bc5b01b09a1f58ced1c	\N
eea_tvv_range_d274f5a7748c989319fcd59a	eea_hist_238ef43f0c40d4cd86212869	\N
eea_tvv_range_d274f5a7748c989319fcd59a	eea_hist_4c19fe12984e6c412e034466	\N
eea_tvv_range_d274f5a7748c989319fcd59a	eea_hist_e4825702158751c0927f7afb	\N
eea_tvv_range_1c9f2e11988ce5f464535301	eea_hist_e02fffc2a92827d5eeda45df	\N
eea_tvv_range_1c9f2e11988ce5f464535301	eea_hist_c0088081767f0367c0c168ff	\N
eea_tvv_range_1c9f2e11988ce5f464535301	eea_hist_ae96eda89aeeca1f13c479cb	\N
eea_tvv_range_6a6047bcc349ff139c078337	eea_hist_47b6d5b390fd4412d35e9d7b	\N
eea_tvv_range_6a6047bcc349ff139c078337	eea_hist_45414b06aca4a4aadc5b5885	\N
eea_tvv_range_6a6047bcc349ff139c078337	eea_hist_ddc69664495473ac5351004b	\N
eea_tvv_range_561647292e691e8a1f8b2a0c	eea_hist_3e709c6fdbb9a112f072670e	\N
eea_tvv_range_561647292e691e8a1f8b2a0c	eea_hist_19def8371f645db0926778e0	\N
eea_tvv_range_561647292e691e8a1f8b2a0c	eea_hist_afa566cbcb9e9122f351a07b	\N
eea_tvv_range_561647292e691e8a1f8b2a0c	eea_hist_150aceb69dc9229f31cd9432	\N
eea_tvv_range_561647292e691e8a1f8b2a0c	eea_hist_240dfe2d670c23fae37bb516	\N
eea_tvv_range_52f91fc4faea00962b0cfbb0	eea_hist_568ed64c9a917f4752bb68da	\N
eea_tvv_range_52f91fc4faea00962b0cfbb0	eea_hist_563410d71c99d07ac91d7fe4	\N
eea_tvv_range_52f91fc4faea00962b0cfbb0	eea_hist_8a69f27047939bda44f1987e	\N
eea_tvv_range_52f91fc4faea00962b0cfbb0	eea_hist_759317f3d4b15114cffe93a9	\N
eea_tvv_range_8bd2f00bbfde0bcfec429f22	eea_hist_9cf084f55430a3bc85807b7c	\N
eea_tvv_range_8bd2f00bbfde0bcfec429f22	eea_hist_028d4003719541bb3d27f95d	\N
eea_tvv_range_5636fd294408ff3af43c46e6	eea_hist_c97e79af0f5328698879ec28	\N
eea_tvv_range_5636fd294408ff3af43c46e6	eea_hist_4b2a3a32042a5877b23bab03	\N
eea_tvv_range_d75efeb88efe385d76676447	eea_hist_26449babbacdbccc838c7a33	\N
eea_tvv_range_d75efeb88efe385d76676447	eea_hist_e5520799027fe1885020e650	\N
eea_tvv_range_d75efeb88efe385d76676447	eea_hist_0228836cd7f72e0dd01890e6	\N
eea_tvv_range_d75efeb88efe385d76676447	eea_hist_5e614086510bf5712f44a25f	\N
eea_tvv_range_7ed6b0388038d385f9718d7c	eea_hist_6ede7ba1f088430cb98d0a68	\N
eea_tvv_range_7ed6b0388038d385f9718d7c	eea_hist_9596bfeaef0aca60d23eec6e	\N
eea_tvv_range_7ed6b0388038d385f9718d7c	eea_hist_300368ab0000d1929f1eea4f	\N
eea_tvv_range_7ed6b0388038d385f9718d7c	eea_hist_54495eef844694fbdbbb1270	\N
eea_tvv_range_6c7eee60ba36de586cc8f445	eea_hist_34c923700b97a01c8cc855ca	\N
eea_tvv_range_6c7eee60ba36de586cc8f445	eea_hist_68a933ed8d6b8f61c4633f1b	\N
eea_tvv_range_6c7eee60ba36de586cc8f445	eea_hist_8e2432e5b00453857eafc0d2	\N
eea_tvv_range_432405b8918715ebe567081c	eea_hist_0d837ea139271586f9f0669c	\N
eea_tvv_range_432405b8918715ebe567081c	eea_hist_9bd7793944e24bb55d9fd369	\N
eea_tvv_range_432405b8918715ebe567081c	eea_hist_f28791719c7267174f094574	\N
eea_tvv_range_432405b8918715ebe567081c	eea_hist_ebdf036089b30442cf0f50c1	\N
eea_tvv_range_ad20323c3bc85079edc14f92	eea_hist_7a316e4cd0fc38198acf8354	\N
eea_tvv_range_ad20323c3bc85079edc14f92	eea_hist_56d99e2bdb52d79a8da5589f	\N
eea_tvv_range_ad20323c3bc85079edc14f92	eea_hist_51380fca9927f9186288a3ac	\N
eea_tvv_range_ad20323c3bc85079edc14f92	eea_hist_ecc30eba84f43ea616df0295	\N
eea_tvv_range_1c4b7f8724ac2b536ddab233	eea_hist_f91dd973e1f5b4deda86b0b2	\N
eea_tvv_range_1c4b7f8724ac2b536ddab233	eea_hist_9ac1247cc1d150293825c670	\N
eea_tvv_range_1c4b7f8724ac2b536ddab233	eea_hist_866999147d0f732786be0b4a	\N
eea_tvv_range_1c4b7f8724ac2b536ddab233	eea_hist_c0519517e318e8a3359a1e8e	\N
eea_tvv_range_9836cbadabf4e5af09e2241f	eea_hist_06bb2b21f71797226ac5b693	\N
eea_tvv_range_9836cbadabf4e5af09e2241f	eea_hist_379bbe9b262883d239076e4e	\N
eea_tvv_range_04a6c466cad2895267746124	eea_hist_456e3edbca3f58ddabc020ff	\N
eea_tvv_range_04a6c466cad2895267746124	eea_hist_dc093eeb35e5abcf258ae733	\N
eea_tvv_range_04a6c466cad2895267746124	eea_hist_e76fd83c03742b6f89b91742	\N
eea_tvv_range_04a6c466cad2895267746124	eea_hist_856dcbe2f5f991b550ba7822	\N
eea_tvv_range_39ab5f985928ac07ff8bffa1	eea_hist_3af082e6041fe14ce3513a93	\N
eea_tvv_range_39ab5f985928ac07ff8bffa1	eea_hist_9edfd9454c73a9f334fcd98e	\N
eea_tvv_range_39ab5f985928ac07ff8bffa1	eea_hist_bcf8a08a9dd74ee4af1d31f6	\N
eea_tvv_range_39ab5f985928ac07ff8bffa1	eea_hist_b16a77a1fe2aeaaa6be835d2	\N
eea_tvv_range_74e27e5bb7be5b5fd2e97302	eea_hist_59480fbb8268b8d8643d66b0	\N
eea_tvv_range_74e27e5bb7be5b5fd2e97302	eea_hist_a837a570d2e2971ef643478d	\N
eea_tvv_range_74e27e5bb7be5b5fd2e97302	eea_hist_eb1f0575cfbd7781a8edad53	\N
eea_tvv_range_b8b1723766ab17348be9aa65	eea_hist_22222934593a08721b26171d	\N
eea_tvv_range_b8b1723766ab17348be9aa65	eea_hist_b75f375c29b277f0ff8e314b	\N
eea_tvv_range_b8b1723766ab17348be9aa65	eea_hist_0c197674584e03ae6be29a61	\N
eea_tvv_range_b8b1723766ab17348be9aa65	eea_hist_f3c318cdab2b0f345607c3dd	\N
eea_tvv_range_f3c494d2f6123938123f40ef	eea_hist_9b024d2aad12ba91bb9917b7	\N
eea_tvv_range_f3c494d2f6123938123f40ef	eea_hist_90c70f7880047004ea61b64e	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_2b82a60de0aada08a1d5147f	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_b751e213bb1bb19df828b829	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_10228b94856100a20598993f	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_614c418b0826961b37b8f59a	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_0fd6a56a6b2149f59b3beeee	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_a0fa7b06322eed05dba3cebd	\N
eea_tvv_range_dca110454749bc86ea2f83a1	eea_hist_818a07295b3ac2ef2c1d437d	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_6d0fd816a44fbb6e380702ed	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_558db80529fc0a65bd44fe1e	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_5f43c439333d8f981aa16416	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_9dffc7fe7a2e469e216d96da	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_c210db3ab65492f202a2306d	\N
eea_tvv_range_77e930e6a41efaed2131fcf7	eea_hist_c30d2ae46b6d80013d5b9e1c	\N
eea_tvv_range_4bf91787ffee6f64762c4ab4	eea_hist_79dedfcb0b3059d83a638ca7	\N
eea_tvv_range_4bf91787ffee6f64762c4ab4	eea_hist_7b3b3b0a8b02cc94a137a1f3	\N
eea_tvv_range_4bf91787ffee6f64762c4ab4	eea_hist_e3a75dcdcb88044ef9be6c43	\N
eea_tvv_range_06da55639be851e604b6f961	eea_hist_41142907e32d84c4b2312fab	\N
eea_tvv_range_06da55639be851e604b6f961	eea_hist_3ed636489ff6a3865680c1a6	\N
eea_tvv_range_06da55639be851e604b6f961	eea_hist_79ff4d3cf28b7b0b6b970d63	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_a9cd89b7418ec5673b7a6530	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_80b75f2afe4183c46efa0f09	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_17f2987f2cd8bc08ae24200c	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_6f659beadac075a842e3b554	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_6654f5db91d6e18df75fba3a	\N
eea_tvv_range_c3a441fcc577f55fbd653e5f	eea_hist_776f159c3da9620e940835ae	\N
eea_tvv_range_7e08ef637e719527aa1565cb	eea_hist_2e6a02455b1231ed38adba29	\N
eea_tvv_range_7e08ef637e719527aa1565cb	eea_hist_aa78b9b664803231978cbf8c	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_a21d49e6973849eea8be5c9b	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_0f6112b7746cbdcad7ea58c3	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_5bb991fd8ad017a3a3581d08	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_ed64e10a3411264eb3042685	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_c3dd7b56e1ebfefdf08b7860	\N
eea_tvv_range_7adf0eb582e9dfcd8d7f0278	eea_hist_d7143c6c7a7c78cfb5338c1a	\N
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	eea_hist_cafea743e8f01339799f589c	\N
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	eea_hist_245a6b639a68995076c177f3	\N
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	eea_hist_58b040001be1aa7a9bbaee9e	\N
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	eea_hist_aca3bd781b2d2d348c40353c	\N
eea_tvv_range_5d13b8b47a0cf7f68ac008b7	eea_hist_c298880f57886c9347c67e82	\N
eea_tvv_range_d6f2d5cf688da9224f35f09b	eea_hist_25ee30e04e303328d026ea59	\N
eea_tvv_range_d6f2d5cf688da9224f35f09b	eea_hist_43aecbeade2da4f1ec86ce49	\N
eea_tvv_range_d6f2d5cf688da9224f35f09b	eea_hist_15a426edbe0786b520ed3a13	\N
eea_tvv_range_d6f2d5cf688da9224f35f09b	eea_hist_9ddf8981cf41b82e07e0e62b	\N
eea_tvv_range_d6f2d5cf688da9224f35f09b	eea_hist_1933608fa1526c583810fb06	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_369bd901ee6c26c24eee9f95	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_42cc9a1f0dfd0583b2849e09	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_b1ce10921a32a082e4ec5aa2	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_ab4cd52e7ebc58ae90e326e7	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_8c655ad5d89baca5213eb6aa	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_0bd37ae04d0da24cb5cd5c08	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_03cd59df0fb24f21da47d2ea	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_1ac65eae12771d9201ab021f	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_85a9cd230bc417023677df92	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_a531705eafda3630af37a80a	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_b01d0e2458f0128424a70153	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_f3c60da5f44c1575506b5968	\N
eea_tvv_range_8c3efc9a7c13e2fcfb043ae0	eea_hist_18824296e458e4bd6e48675f	\N
eea_tvv_range_9390fa5e8439d5bc5cc800df	eea_hist_3ece1a2e200a892e2b5f8436	\N
eea_tvv_range_9390fa5e8439d5bc5cc800df	eea_hist_9031e122b83d47bf7500de99	\N
eea_tvv_range_9390fa5e8439d5bc5cc800df	eea_hist_5be46b3625e83b10239c473f	\N
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_92f00b32ae13aa98e5f6d386	\N
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_f9955e53e99af8beb1481f14	\N
eea_tvv_range_c5ba9d2bd5b51d3a14d101b5	eea_hist_ac612754973441a4b97cc0b7	\N
eea_tvv_range_2228778ec82a825a604c47e2	eea_hist_44c6c7ca179328a2db208e29	\N
eea_tvv_range_2228778ec82a825a604c47e2	eea_hist_6362b5d46906525e7467ace9	\N
eea_tvv_range_2228778ec82a825a604c47e2	eea_hist_7c100595f16d2f10ef22fbce	\N
eea_tvv_range_2228778ec82a825a604c47e2	eea_hist_82986924d27e657285ee1cdc	\N
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_d39a3c89183d26e9d34435ec	\N
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_77575bfd717eccab8c6c3b75	\N
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_c5afd3eda3688bb6435c4c83	\N
eea_tvv_range_f8743bab5c4230e4315b9fc9	eea_hist_622992e2ce8dfa0850a53a52	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_d38acb8ac9c6a2e7f0f98e84	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_6fb80c45e4ff7bb76fd74667	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_5d96ca04d7bc8ed5e329b6b9	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_e9a2ae71a7ff40dbd123b83f	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_6a9d0d7f5e9d6382c0f6ef94	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_30f562c243ec5353e09a1a04	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_316964e54d1835a0a856f8c2	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_7c3271fcca3bbf927f2efc70	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_9ec6b16dd3a56e44ae3508c4	\N
eea_tvv_range_4f0f246275622af32d3cd43d	eea_hist_a56bc5c1afc5a4907495caa6	\N
eea_tvv_range_4f0f246275622af32d3cd43d	current_cluster:f914ca57a020a53bfbb78d097fe20ce7	71
eea_tvv_range_d77ab39fb5a8d107dca65084	eea_hist_148a2837d40d93c695d4eef2	\N
eea_tvv_range_d77ab39fb5a8d107dca65084	eea_hist_d2956a44efdcfde4fe93c1f6	\N
eea_tvv_range_d77ab39fb5a8d107dca65084	eea_hist_af0ac08edcc032e818c10240	\N
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_99f133769ee2418a6b9b677c	\N
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_2e2b187af754d2d971d94110	\N
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_272e2e615f80fc1730968fae	\N
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_1b1f6f152346c8034eebec8f	\N
eea_tvv_range_e23e6f6d8642d30010323c86	eea_hist_be25fa0af61fe02ef64bec5b	\N
eea_tvv_range_8a4b635e1384ed2195255bc7	eea_hist_f70c1b3caaddcef8f9ebb00e	\N
eea_tvv_range_8a4b635e1384ed2195255bc7	eea_hist_2e2dd6bf67ef374541de75d9	\N
eea_tvv_range_8a4b635e1384ed2195255bc7	eea_hist_4ff0b78b64b4051955f4ce05	\N
eea_tvv_range_8a4b635e1384ed2195255bc7	eea_hist_8508761951db25835ac9fc36	\N
eea_tvv_range_8a4b635e1384ed2195255bc7	eea_hist_bededc533e80a85f55de77f5	\N
eea_tvv_range_a5581b4b3636859f661eff1f	eea_hist_926bdcb48b392fe234a94e91	\N
eea_tvv_range_a5581b4b3636859f661eff1f	eea_hist_d0347458ad0791d16a206926	\N
eea_tvv_range_a5581b4b3636859f661eff1f	eea_hist_96493e40abf9bfca59f470f7	\N
eea_tvv_range_a5581b4b3636859f661eff1f	eea_hist_6d0dce4b3016000d32ff5a05	\N
eea_tvv_range_a5581b4b3636859f661eff1f	current_cluster:4b12dfa104332d765dfc778151c06495	73
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_483d855f386e15c5d62a77aa	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_d9d19f5046b56c0d7d88539c	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_4496f24b518126e146150219	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_cb0e50f60bf3bf41a142004e	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_c854f84e9fe86a01abf186b7	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_ab4111080a75c2bb094b00ff	\N
eea_tvv_range_e7440eee09c5adcd5ed36475	eea_hist_14e557562bf29425a051ac90	\N
eea_tvv_range_8b76857d3c5319a5deaada24	eea_hist_5587ed020b2c1bf3949004e3	\N
eea_tvv_range_8b76857d3c5319a5deaada24	eea_hist_6356afe2d2a47e7f500464bf	\N
eea_tvv_range_8b76857d3c5319a5deaada24	eea_hist_f335c5e6b1f691b231241f3c	\N
eea_tvv_range_8b76857d3c5319a5deaada24	eea_hist_4de0cbec62276f3e48a8a2f0	\N
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_875223fec2cc46f7215190ce	\N
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_dee736c604d657e559bcc237	\N
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_c909ba4a63a6b9fe00defb2f	\N
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_b00fdb9bc72bc4f4ec7ed3ac	\N
eea_tvv_range_ee00b9eb6cb9856d86a75813	eea_hist_4ac139ff0dcd4de22fbf82a9	\N
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_2c4d0a72cf5e74ef5d9ac86d	\N
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_b83c7e5e74b7d9b0576ec763	\N
eea_tvv_range_75127c19c6086b5d85294f1f	eea_hist_420a4d299de9f75b67c6dc3c	\N
eea_tvv_range_91141bfea46d9c22ffca9b58	eea_hist_7b128953bae3e35b513b0dff	\N
eea_tvv_range_91141bfea46d9c22ffca9b58	eea_hist_331d6b75771bb09828e4479c	\N
eea_tvv_range_f4b76b27a7131a67f3835e31	eea_hist_d9602a7228a3e57bd2718cf9	\N
eea_tvv_range_f4b76b27a7131a67f3835e31	eea_hist_c61a1f7b837e1379ff6df065	\N
eea_tvv_range_f4b76b27a7131a67f3835e31	current_cluster:48f9ceb22e88c50b7b266105b8d125d7	234
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_6183f3e6dd067a7255b0be7d	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_9a175887a44efe3b9e183c58	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_613abb88b2b064996edc790e	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_e0388fa7e5e65b732ae190d2	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_440af561aef86c0dcd7b86b6	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_ab8953e4858fa6c1e4b41155	\N
eea_tvv_range_6c61df263ace92e65c34a076	eea_hist_8246057a23e933ce7001c2ec	\N
eea_tvv_range_872c767747baf6dcadb55c79	eea_hist_f51b9e953c5ba1c1b896e4b7	\N
eea_tvv_range_872c767747baf6dcadb55c79	eea_hist_2778c475da13896c10698d32	\N
eea_tvv_range_872c767747baf6dcadb55c79	eea_hist_e85dbfa1a273b3051b9aaf1f	\N
eea_tvv_range_872c767747baf6dcadb55c79	eea_hist_8ae2b466eba34d98a5931759	\N
eea_tvv_range_872c767747baf6dcadb55c79	eea_hist_d9c70142b94e568e84932b02	\N
eea_tvv_range_872c767747baf6dcadb55c79	current_cluster:ba697ce91b84e2f52c36218a0eb7ea22	369
eea_tvv_range_c5d5ecebdfd3aeed2336807d	eea_hist_43ffa82734f8cd167fcdcb96	\N
eea_tvv_range_c5d5ecebdfd3aeed2336807d	eea_hist_1ed59624eb71b6120409e23b	\N
eea_tvv_range_c5d5ecebdfd3aeed2336807d	eea_hist_cffe4b367c7d5425dc28c430	\N
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_e5c6e82498757b3da1314d97	\N
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_ba9e5b64befa319ad69b78db	\N
eea_tvv_range_b4e7d841ff0ad94ddad303bb	eea_hist_22ad587f278b76e5871a1332	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_1c0a3b95477338bf54a20306	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_00884fbb4e0578e9ce3caad3	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_d4a6798e6d73994fde2f5faa	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_93b279ed317a286efd06acf2	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_c26125fb09225c4e60bee2c6	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_2780ff980c30c989978dba01	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_967171c56bfaea9b52d5069e	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_490444b9e8f091682b5894a2	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_1233742464932afc52cbbef6	\N
eea_tvv_range_41dde69ec2bd01304ddd2961	eea_hist_17912ef9a72d00cdc685d463	\N
eea_tvv_range_e11be7054bbd9a368253410d	eea_hist_d6db7d14dfb601ddf5a3c665	\N
eea_tvv_range_e11be7054bbd9a368253410d	eea_hist_5563c28ec290cad3b3fa5b3c	\N
eea_tvv_range_e11be7054bbd9a368253410d	eea_hist_825e3cce684d50aed3412440	\N
eea_tvv_range_4ac286c395c80c7763a4385a	eea_hist_9bfa25b0e68fcd6e3f6ed810	\N
eea_tvv_range_4ac286c395c80c7763a4385a	eea_hist_581d3ee24ca3ec013f38a620	\N
eea_tvv_range_4ac286c395c80c7763a4385a	eea_hist_9bc91a2499c1e33ba5eb48a5	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_c85cd22c967a8e57a9114ab3	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_29398cb55e883450c1a5826b	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_174a94f3498f2645367cbf5f	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_98a81016ea25d43a99c9197d	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_38599bfc173f28f0d9e2a85d	\N
eea_tvv_range_0f5fa81f271ddc1fb4b5b0b9	eea_hist_c0ec31bf413e3af384d0b029	\N
eea_tvv_range_30a469fc65eeb3bfd78c3f2d	eea_hist_178cab9bd5e64424e75bfde9	\N
eea_tvv_range_30a469fc65eeb3bfd78c3f2d	eea_hist_6494b1d0a11cdd3b9666d22a	\N
eea_tvv_range_30a469fc65eeb3bfd78c3f2d	eea_hist_bee3d29ddbb8426bc5549fae	\N
eea_tvv_range_30a469fc65eeb3bfd78c3f2d	eea_hist_04d6525e944914b1aeaac3a9	\N
eea_tvv_range_ee426da61d110bc22306a237	eea_hist_ad73389839677fd3dde4c956	\N
eea_tvv_range_ee426da61d110bc22306a237	eea_hist_a0c8c6f07d899329b2d45311	\N
eea_tvv_range_ee426da61d110bc22306a237	eea_hist_81e71dd6683c466c5dfa8a74	\N
eea_tvv_range_ee426da61d110bc22306a237	eea_hist_9a7cf84bfbb64092d416631a	\N
eea_tvv_range_14ac9a77c62f222d7412638e	eea_hist_744fb22586bb6a10e1de4167	\N
eea_tvv_range_14ac9a77c62f222d7412638e	eea_hist_37a574efebed8b221b8a63ce	\N
eea_tvv_range_14ac9a77c62f222d7412638e	eea_hist_9dcf76e631a373bc91af6a33	\N
eea_tvv_range_14ac9a77c62f222d7412638e	eea_hist_1dce37b78d09ae7f19ea9423	\N
eea_tvv_range_14ac9a77c62f222d7412638e	eea_hist_a772b635dbd88c7917dc77ae	\N
eea_tvv_range_14ac9a77c62f222d7412638e	current_cluster:f75859c534e2ae01b4fb577f1024755a	112
eea_tvv_range_6c173bf8c99b4dfe84ae8119	eea_hist_b19b43e21cf0bf5c806eace4	\N
eea_tvv_range_6c173bf8c99b4dfe84ae8119	eea_hist_542802d3b0ff4f61c606ae42	\N
eea_tvv_range_6c173bf8c99b4dfe84ae8119	eea_hist_aca8fc169403bd255f0c2265	\N
eea_tvv_range_6c173bf8c99b4dfe84ae8119	eea_hist_314c7beeb39d720c8ea9b6a1	\N
eea_tvv_range_3c3b03bb053f03b1c7a5a999	eea_hist_a078a522266693870ad49f4f	\N
eea_tvv_range_3c3b03bb053f03b1c7a5a999	eea_hist_8e94214debe90b0f40a17c44	\N
eea_tvv_range_3c3b03bb053f03b1c7a5a999	eea_hist_64f9afcd1d52793376c6da8d	\N
eea_tvv_range_3c3b03bb053f03b1c7a5a999	eea_hist_1794dec77c9ff1352bed9a66	\N
eea_tvv_range_eee411f2fdd53660e7ebb4a9	eea_hist_21bb9a6206fcbbfc92b27dc0	\N
eea_tvv_range_eee411f2fdd53660e7ebb4a9	eea_hist_36db76795c8209434abeeae8	\N
eea_tvv_range_eee411f2fdd53660e7ebb4a9	current_cluster:6264b1452aace03223bc16ea56f7541b	113
eea_tvv_range_6e850c34072f0406b6db1f2c	eea_hist_14c4cdaf243d5d50625ec823	\N
eea_tvv_range_6e850c34072f0406b6db1f2c	current_cluster:38cf1b51ffb364f0f2345f97c5aa9d52	767
eea_tvv_range_729127d8acc2fc31430835c6	eea_hist_c906d28135285a422c6f5b89	\N
eea_tvv_range_729127d8acc2fc31430835c6	eea_hist_e578c2eab42fff0b33be4299	\N
eea_tvv_range_729127d8acc2fc31430835c6	eea_hist_ac3210a56819a60642e2bed0	\N
eea_tvv_range_729127d8acc2fc31430835c6	eea_hist_1d76e60f4e25b4b00cd57e46	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_6b6227efcf00f4f3593f3428	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_36ca52fe963e15fc5603181d	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_08f17be18872f6931a6bc52c	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_4d6e292b270f243d3de1a313	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_f52836c26eb6bdde7b978d8e	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_914636878874deeac6bd3c13	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_d58304bd803c57e7c449f3c3	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_08e5bb188e3c3ce25d8d6018	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_a42778d47dee55ed0db7ef3b	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_00e59194b58e98e489f1c9cb	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_a2b23b58e2bbb0993802a6ed	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_2900fa60ba0a4fcc94f27548	\N
eea_tvv_range_311ebf69301475fec5bf02cb	eea_hist_96c413fe20a8128562caae18	\N
eea_tvv_range_2ad4e084745e59e43418e25f	eea_hist_3367d91037671fc7044f93ea	\N
eea_tvv_range_2ad4e084745e59e43418e25f	eea_hist_f244d5f155d9c95404ce5bd3	\N
eea_tvv_range_2ad4e084745e59e43418e25f	eea_hist_093d7fc0df4ddece16202556	\N
eea_tvv_range_2ad4e084745e59e43418e25f	eea_hist_d50b08635dfc9d8f1f35165e	\N
eea_tvv_range_2ad4e084745e59e43418e25f	eea_hist_92720d641ae769a70a7d95df	\N
eea_tvv_range_7e904501c7ab6d41de415134	eea_hist_7a6181c3992fff9ebf370ae4	\N
eea_tvv_range_7e904501c7ab6d41de415134	eea_hist_b5e00d01d2c29fed989958ba	\N
eea_tvv_range_7e904501c7ab6d41de415134	eea_hist_82daab28f80c3a187611f561	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_f1f06d28ab52ac2cfb280a49	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_7199389830168c6baa9f26d4	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_7d441acdc84f36a3734a0a3a	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_1a08ba898ede7fa0d5fd3e5e	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_894e1b24856c9c3f0a7e92ce	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_4d09102ec280cb408e435ddb	\N
eea_tvv_range_634b3a59c9a720be8522d51a	eea_hist_044e3c95d40241f1412a0bab	\N
eea_tvv_range_9dfdcf422a9f21e204766f0f	eea_hist_fa4e1f02fcbfe8eb232c9eb2	\N
eea_tvv_range_9dfdcf422a9f21e204766f0f	eea_hist_bd673d43779675087025b16c	\N
eea_tvv_range_9dfdcf422a9f21e204766f0f	eea_hist_283bc16a5bfd2e345de2fa18	\N
eea_tvv_range_b9c17c28259d0879dabd5e61	eea_hist_df8ac793e15d03e10958215a	\N
eea_tvv_range_b9c17c28259d0879dabd5e61	eea_hist_8fce9374aa5ef85268421c78	\N
eea_tvv_range_b9c17c28259d0879dabd5e61	eea_hist_7da157e2a5af6f21f61c132d	\N
eea_tvv_range_b9c17c28259d0879dabd5e61	current_cluster:ebbdf8e1ec3e580ec95c3e6f4ffaea14	85
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_538bf6a80a498a725e805a2f	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_1dac0955b36d2bfc07b89e95	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_31a55eb79d3a325b4f9ad709	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_89aa640c8b8923bfcf4c3c59	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_b5e47b4165e1a449f1d26983	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_cda91b0a8b62acd08e82064e	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_b63f658b121f0ea7628d39d8	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_9f89f7e18a1556323d99c03f	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_851bc790b866825fbd646728	\N
eea_tvv_range_17b77d51d8995dff8a745491	eea_hist_ced2a737a3478683ef61ac4e	\N
eea_tvv_range_e7eb737d1db5f5c680626220	eea_hist_d3f83786ef84086f195bbfbf	\N
eea_tvv_range_e7eb737d1db5f5c680626220	eea_hist_e1da6324cc087cf5786499ff	\N
eea_tvv_range_e7eb737d1db5f5c680626220	eea_hist_7f220c8d5603893a54ba5139	\N
eea_tvv_range_e7eb737d1db5f5c680626220	eea_hist_9b905cb611bc0bf1dcad9679	\N
eea_tvv_range_14ad4209fa37cc694f1e0a25	eea_hist_fc65f09bb01aa4d511f21884	\N
eea_tvv_range_14ad4209fa37cc694f1e0a25	eea_hist_7aa3c6b7afbc3d04a248d8a7	\N
eea_tvv_range_14ad4209fa37cc694f1e0a25	eea_hist_4365ff09b2e2a8b8c7009f77	\N
eea_tvv_range_bd71d741b8fb25a837b5743d	eea_hist_e7e2f7184ba513113121f711	\N
eea_tvv_range_bd71d741b8fb25a837b5743d	eea_hist_9f03019c65c245ead8f6e1a6	\N
eea_tvv_range_bd71d741b8fb25a837b5743d	eea_hist_0b94e4ced4b1209c7a16d9aa	\N
eea_tvv_range_68017aac38f43d2205e7f57b	eea_hist_7e9509632ffe5381163fd6db	\N
eea_tvv_range_68017aac38f43d2205e7f57b	eea_hist_60bfc603c898510f2593e1e0	\N
eea_tvv_range_68017aac38f43d2205e7f57b	eea_hist_b3d2af58aef181431f4a15f8	\N
eea_tvv_range_5c5cc063e978e5f62941cd7b	eea_hist_bdace88e452c09b835ef5553	\N
eea_tvv_range_5c5cc063e978e5f62941cd7b	eea_hist_99149dcbcdafe2c7170125dd	\N
eea_tvv_range_5c5cc063e978e5f62941cd7b	eea_hist_cc0302a8b5001bc83141fa61	\N
eea_tvv_range_5c5cc063e978e5f62941cd7b	eea_hist_13f4a4fa50161cbb698d1145	\N
eea_tvv_range_5c5cc063e978e5f62941cd7b	eea_hist_7bf918a4456b287b28594596	\N
eea_tvv_range_83e0a494587e00e91385757b	eea_hist_e30041ea3f394e5bb429ab99	\N
eea_tvv_range_83e0a494587e00e91385757b	eea_hist_99cd68a7eae79da1eaa98383	\N
eea_tvv_range_83e0a494587e00e91385757b	eea_hist_4d651f189dd405f7153693d6	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_78a94840d886a1c4d8e87ec3	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_6d178be58d3f76af5fc8d9b2	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_aec33f1b470f54f281cebf59	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_380955b0709adc0bcf51e239	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_462484e665fe6428bca31f13	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_fd1ee3c1eb8360ca9da5cd4e	\N
eea_tvv_range_259e0bbadc7e15bcb6d151f9	eea_hist_70b20d78377dc25ee1c35503	\N
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_530e0621c7851af45a85f4f0	\N
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_522dead5f2d6dc7e6d980a65	\N
eea_tvv_range_4287a69d88a83076f80d98cd	eea_hist_829bdf49d3431e8519ca0214	\N
eea_tvv_range_90ef3827d54234d416bdc206	eea_hist_4359c05ed2c98f4c783d823e	\N
eea_tvv_range_90ef3827d54234d416bdc206	eea_hist_cf2be263a3baa5368b82e9f4	\N
eea_tvv_range_90ef3827d54234d416bdc206	eea_hist_122ed3d71c55979e4b571738	\N
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_042a4d8765f57c8787dab2e2	\N
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_dfd2050ba3c88de425d79ede	\N
eea_tvv_range_38aa482787a7ab62e182b767	eea_hist_37687c80c826a6f1215e1a28	\N
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_16a9f06aa69f29bc9bb0c3dd	\N
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_e27c46529289494db915fe84	\N
eea_tvv_range_3709a34d72c84d7162d6d703	eea_hist_669bbe8b614c6cebf5860955	\N
eea_tvv_range_339c3efda01206410a85f130	eea_hist_52dbbf2a6f5c9f2d813c29c3	\N
eea_tvv_range_339c3efda01206410a85f130	eea_hist_c3585e2ae33c4bec1efa6f0e	\N
eea_tvv_range_339c3efda01206410a85f130	eea_hist_a235e27ce12f848020af60c3	\N
eea_tvv_range_2f73c2185952ec47c5d36fc8	eea_hist_6c0f79896c2bc3fc4d7e7430	\N
eea_tvv_range_2f73c2185952ec47c5d36fc8	eea_hist_25d752bf05bd31fa9a28609d	\N
eea_tvv_range_2f73c2185952ec47c5d36fc8	eea_hist_6d45bd9504f0052e74095151	\N
eea_tvv_range_2f73c2185952ec47c5d36fc8	eea_hist_34f5c984afb1eadda84cb961	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_4087a02b11f59e3d13e6a1cf	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_78aca96875216df35f743151	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_b8d78ca5dc8295aa31115211	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_efb63e13cafe1f3d7379fc1a	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_98de38843862364ebdd82906	\N
eea_tvv_range_7cb86e141acf1a62fa23c379	eea_hist_538b426d7566a1630c82714e	\N
eea_tvv_range_5a04b3886670251eea3e0bab	eea_hist_ab3c004046db9d68151051f5	\N
eea_tvv_range_5a04b3886670251eea3e0bab	eea_hist_03f39fab5004598442c98c57	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_25b4340a61066c2fa259ed09	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_75f5a6932e64ff5bf9884838	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_eaec5a7c51fc0352777d9dd1	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_478af6d8bef8d5d6f24b5064	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_12220e61b6a346ae9e9297ea	\N
eea_tvv_range_fe32ff0cfffd58c229e9192b	eea_hist_0a0c408549e5bcb4943b980d	\N
eea_tvv_range_02f248cdbf099188f64174f8	eea_hist_1f9e8fdc4f2c53e70ffa88d7	\N
eea_tvv_range_02f248cdbf099188f64174f8	eea_hist_70d6a9f52c42579b19fc36cc	\N
eea_tvv_range_e4463b261b383b52265b678b	eea_hist_f45d63b9d4708f793c81ff50	\N
eea_tvv_range_e4463b261b383b52265b678b	eea_hist_88dc7b1fd9f1031d75e0a496	\N
eea_tvv_range_e4463b261b383b52265b678b	eea_hist_6f54692883f69b01380d198e	\N
eea_tvv_range_5a05920ed0c551b84bdda164	eea_hist_eb41faaa6f084733f1b6c696	\N
eea_tvv_range_5a05920ed0c551b84bdda164	eea_hist_5709570be4cf6c1dff21157d	\N
eea_tvv_range_5a05920ed0c551b84bdda164	eea_hist_110d42b9ff6dea09bae1f22d	\N
eea_tvv_range_5a05920ed0c551b84bdda164	eea_hist_1c53b5d324025419d406e5c4	\N
eea_tvv_range_5a05920ed0c551b84bdda164	current_cluster:2b37000b51aa7b83f6ea431002958037	301
eea_tvv_range_13420f3d765fdba846107739	eea_hist_9f81e5513aa1b475b8b53393	\N
eea_tvv_range_13420f3d765fdba846107739	eea_hist_439e80e5888d40579acb737c	\N
eea_tvv_range_13420f3d765fdba846107739	current_cluster:6725c5429f61ea9beb414e2ed013d99d	302
eea_tvv_range_2a483a53dee72ae6e0c78a6a	eea_hist_7524395b0dc48365f65cd5f5	\N
eea_tvv_range_2a483a53dee72ae6e0c78a6a	eea_hist_a463cf455e96dc7e0073f675	\N
eea_tvv_range_2a483a53dee72ae6e0c78a6a	current_cluster:b04392f61d1c0039f46d8773af86c8ec	479
eea_tvv_range_9d1f4d51007bf6c720c7de20	eea_hist_d3bd6cbf2c2b02312bb61cfb	\N
eea_tvv_range_9d1f4d51007bf6c720c7de20	eea_hist_14cce1bf89b80643e0b00c9f	\N
eea_tvv_range_9d1f4d51007bf6c720c7de20	current_cluster:e4265c707119fcbc734496cbb934cae4	523
eea_tvv_range_03e6a77d46be70f6f01d4af5	eea_hist_cdb2885d2717a4f0a7c99523	\N
eea_tvv_range_03e6a77d46be70f6f01d4af5	eea_hist_cf7030ae26f1a33579b8b5c1	\N
eea_tvv_range_03e6a77d46be70f6f01d4af5	eea_hist_89203c81be52f44534114b30	\N
eea_tvv_range_03e6a77d46be70f6f01d4af5	eea_hist_09285671a46df417175dc605	\N
eea_tvv_range_03e6a77d46be70f6f01d4af5	current_cluster:ca02aa7fe74b3152bed5e782e23491b6	553
eea_tvv_range_4c55f1f42f17e14eb991560c	eea_hist_80917772f97647bb33145117	\N
eea_tvv_range_4c55f1f42f17e14eb991560c	eea_hist_6583adb87830bd72a22f5b27	\N
eea_tvv_range_4c55f1f42f17e14eb991560c	eea_hist_8d14e0db4c4d82067af4c370	\N
eea_tvv_range_28759a1c09476087f0240cbe	eea_hist_a4973001d4c724f3c68b48b9	\N
eea_tvv_range_28759a1c09476087f0240cbe	eea_hist_10d41fcc5539c3175ad0ddd0	\N
eea_tvv_range_28759a1c09476087f0240cbe	current_cluster:a3d198bc13975eae3fe789cd5ffd97b5	554
eea_tvv_range_72d296949ab8a79a6141465c	eea_hist_88433fb68d56dab519b14400	\N
eea_tvv_range_72d296949ab8a79a6141465c	eea_hist_07079bae77bc0f43e03cae8b	\N
eea_tvv_range_72d296949ab8a79a6141465c	eea_hist_825a934da0297a7d3136b406	\N
eea_tvv_range_72d296949ab8a79a6141465c	current_cluster:b2aba2577987fcc802bf8d1f9dd5a729	511
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_24ebea2c53a3d7f56bb0090d	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_72b703e77474b8b66152b77e	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_cb2c5206ea1cb85a2d656873	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_770db33df5518bd18b4f59b1	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_512f1758b5383670de4bd218	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_544eafd0d059f73a49e25773	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_ce1a200d57f223b5456c8748	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_edbe26a33dcf5021bec16a53	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_ed4590a3224997ec0882e56e	\N
eea_tvv_range_c5dc738dd1baa1fb9d5c4e3f	eea_hist_8b3f73f7a94c1756c0597d96	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_19e333389bc4652ed9f2ced0	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_3f591875d0484797de62a37a	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_995a84aa384f9db7b6184ab0	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_548b184ca27ea2ccceab85b3	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_e1c6206c6e87383cf0e454ff	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_72bb602c6af6ea8909a24020	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_2a91749e8e5002e3b8072818	\N
eea_tvv_range_7632b82caa9bbc577d6cd356	eea_hist_59b9904769a4da879cfaf7d6	\N
eea_tvv_range_a6b996e81b655bc9dd82f991	eea_hist_6833e57e3c4adb1f792e192a	\N
eea_tvv_range_a6b996e81b655bc9dd82f991	eea_hist_fa1f489ab4870b40d29e58ce	\N
eea_tvv_range_a6b996e81b655bc9dd82f991	eea_hist_e0818e5ba31e9405bb81b36a	\N
eea_tvv_range_a6b996e81b655bc9dd82f991	eea_hist_819558e1890d069c731ab8f1	\N
eea_tvv_range_baf6299db406dda0ee32a29c	eea_hist_9eadfc691111cfbf23975ca2	\N
eea_tvv_range_baf6299db406dda0ee32a29c	eea_hist_ded58ab9e4495bafc40e14e2	\N
eea_tvv_range_baf6299db406dda0ee32a29c	eea_hist_893e23d1d2f65ab290754b4e	\N
eea_tvv_range_8912494e0329489429e4d20d	eea_hist_048da6c41e4a19f57a23d260	\N
eea_tvv_range_8912494e0329489429e4d20d	eea_hist_53ec8857437825ced41b9289	\N
eea_tvv_range_8912494e0329489429e4d20d	eea_hist_1da5985627c8ee5201449aea	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_bd2c70a0d6f6cbf3f0ea36c0	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_3f207a9e94b2172c1d58397e	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_86a41dfc4a44ea7bd1d98b23	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_49c32d9a6fb60bb2e98a35ca	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_58fca3dc9c5e584c3ab71f5c	\N
eea_tvv_range_9327f2ce137e0989434c76e6	eea_hist_abb585f444f15aaf67784b25	\N
eea_tvv_range_431b32bb7fb00ee337a07101	eea_hist_54a78b08c2ef51af8310bb59	\N
eea_tvv_range_431b32bb7fb00ee337a07101	eea_hist_0fb55a26d4ccf40910e2173e	\N
eea_tvv_range_431b32bb7fb00ee337a07101	eea_hist_dd6e5dd40554fa8e05fa55b2	\N
eea_tvv_range_431b32bb7fb00ee337a07101	eea_hist_21ab8bbdb7cc3c6224bb2a65	\N
eea_tvv_range_431b32bb7fb00ee337a07101	eea_hist_0382f0213042d424a2d6c944	\N
eea_tvv_range_846adab277602c511db0b83b	eea_hist_06ee7072c8809f1153c47d24	\N
eea_tvv_range_846adab277602c511db0b83b	eea_hist_8f2ce0701988e7a9ebbcaddd	\N
eea_tvv_range_846adab277602c511db0b83b	eea_hist_d4dd8462ca52178649a53935	\N
eea_tvv_range_846adab277602c511db0b83b	eea_hist_0daaeb01daa425fd3dd32337	\N
eea_tvv_range_846adab277602c511db0b83b	eea_hist_8f687ab62cadbe76b4a9d326	\N
eea_tvv_range_1b481ffdb73b269c1b9a4a76	eea_hist_9e784acc43063a907cd6eb41	\N
eea_tvv_range_1b481ffdb73b269c1b9a4a76	eea_hist_d506c3f60af0043afee80d92	\N
eea_tvv_range_1b481ffdb73b269c1b9a4a76	eea_hist_e3c0469ff7420b996502e33b	\N
eea_tvv_range_1b481ffdb73b269c1b9a4a76	eea_hist_894276843c62e1cfd79aa006	\N
eea_tvv_range_1b481ffdb73b269c1b9a4a76	eea_hist_6ccfce79e7cc4c0c845ddad7	\N
eea_tvv_range_1c7989d9916381604cc80654	eea_hist_b8a3b8cc1c55756bc4f67104	\N
eea_tvv_range_1c7989d9916381604cc80654	eea_hist_8c7bed23e4ded7de8177ad1b	\N
eea_tvv_range_1c7989d9916381604cc80654	eea_hist_2f1a5f00fb88080960bbcddd	\N
eea_tvv_range_1c7989d9916381604cc80654	eea_hist_4acc1bf5d2d849235653e6d9	\N
eea_tvv_range_144b6e5dc2777236668e2a25	eea_hist_57514414c402d5f149cd407a	\N
eea_tvv_range_144b6e5dc2777236668e2a25	eea_hist_b157d7d91a0d5e45cb2c67c7	\N
eea_tvv_range_144b6e5dc2777236668e2a25	eea_hist_3eb032cf8400cf2331bbe055	\N
eea_tvv_range_a4ecb031518dcf965c2219ff	eea_hist_ad189f5ed5e5cec232e231d7	\N
eea_tvv_range_a4ecb031518dcf965c2219ff	eea_hist_84300d6c724f013bbf923f59	\N
eea_tvv_range_a4ecb031518dcf965c2219ff	eea_hist_92269ab9719a71aa2539569f	\N
eea_tvv_range_a4ecb031518dcf965c2219ff	eea_hist_b417503253ab03cca5a2dc4b	\N
eea_tvv_range_a4ecb031518dcf965c2219ff	eea_hist_fe451365bd90222c2fad7481	\N
eea_tvv_range_a31a55cd0acd3a9424d8cd83	eea_hist_990198615697e86f1a549eb7	\N
eea_tvv_range_a31a55cd0acd3a9424d8cd83	eea_hist_933573f93cb0555a00393a5d	\N
eea_tvv_range_a31a55cd0acd3a9424d8cd83	eea_hist_9ee08d61c08a1c1d5a87b345	\N
eea_tvv_range_a31a55cd0acd3a9424d8cd83	eea_hist_56a7093502b64f4f23c02e27	\N
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_d06654e52c53973471706e9b	\N
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_393e4fb988e975e6cd1955d2	\N
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_389653b1e37a0491b8f90876	\N
eea_tvv_range_d8606a060e74dedb91c89081	eea_hist_c63e019733d107abb7b5a78b	\N
eea_tvv_range_1754a7f9c39966712dc9debd	eea_hist_a79f3ef34ea3783de2198fea	\N
eea_tvv_range_1754a7f9c39966712dc9debd	eea_hist_8ac70b398d8f166b0d79d28e	\N
eea_tvv_range_1754a7f9c39966712dc9debd	eea_hist_8432c1f1e40d51206b8f14f8	\N
eea_tvv_range_e9168bf2c3636ab10c379bc9	eea_hist_b17bfc22d86ad3be70e5141e	\N
eea_tvv_range_e9168bf2c3636ab10c379bc9	eea_hist_6530b0cf8dabd68fe2b5f193	\N
eea_tvv_range_e9168bf2c3636ab10c379bc9	eea_hist_880ee8635cb917f1d592bb21	\N
eea_tvv_range_95260ceafd00d307b6c05688	eea_hist_ba6806173fae3a3bc8fc1b04	\N
eea_tvv_range_95260ceafd00d307b6c05688	eea_hist_29b496157b68c78e63e82374	\N
eea_tvv_range_95260ceafd00d307b6c05688	eea_hist_866ebee86f23047ca735f003	\N
eea_tvv_range_95260ceafd00d307b6c05688	eea_hist_5717df1fddbba74144faee47	\N
eea_tvv_range_95260ceafd00d307b6c05688	eea_hist_64892924e9513925211d3a9b	\N
eea_tvv_range_95260ceafd00d307b6c05688	current_cluster:37db9d62b277fc1a953c4406bd2718b2	397
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_41a06b6dbc01004b41531aaa	\N
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_d5a87119bf556215b8f6ede5	\N
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_fc7a549a41d29aae204d0fd3	\N
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_5555d30f9e9701f93970220d	\N
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_89ad64215b3e5acd35a01b5b	\N
eea_tvv_range_60f77400b02d0bd0675418c0	eea_hist_b7579e899b172f11049dff4e	\N
eea_tvv_range_60f77400b02d0bd0675418c0	current_cluster:25e872c5678fd1365664f9af70d2d640	398
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f839564d0071a7b75859f6da	\N
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f08b44bfeb33e1696c892194	\N
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_f24bce5ecf285b9aa2757330	\N
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_568b48ae00c162beeb599766	\N
eea_tvv_range_ae406e6179efa3eeafc23b75	eea_hist_42c7d9c36dbe8465b686f385	\N
eea_tvv_range_c21c19980c3786098861b117	eea_hist_e13c67c78bcf8b5429dbd3ec	\N
eea_tvv_range_c21c19980c3786098861b117	eea_hist_3f67bccfbad2bbb12f4f2ad3	\N
eea_tvv_range_c21c19980c3786098861b117	eea_hist_09eb99b2591675ba7fd8d910	\N
eea_tvv_range_cc196b7a6cb71a5dd20bc368	eea_hist_f318500637825c78c2423e6f	\N
eea_tvv_range_cc196b7a6cb71a5dd20bc368	eea_hist_3735c15e881975969954e91f	\N
eea_tvv_range_cc196b7a6cb71a5dd20bc368	eea_hist_4aaf96d1c1f7793db33eb3a8	\N
eea_tvv_range_4ac4af8e1d2b1b810f33403f	eea_hist_0749a44c429a7724fa5f4325	\N
eea_tvv_range_4ac4af8e1d2b1b810f33403f	eea_hist_587a69f1be77035fa4c40d91	\N
eea_tvv_range_4ac4af8e1d2b1b810f33403f	eea_hist_441ca8cdce716cd225c15ba5	\N
eea_tvv_range_4ac4af8e1d2b1b810f33403f	eea_hist_23b8f7b31c17fb3c374ec113	\N
eea_tvv_range_c7b91d01a842775bf412cf10	eea_hist_d1fdbf2770f5bab981f1600b	\N
eea_tvv_range_c7b91d01a842775bf412cf10	eea_hist_38ebe84d1a04986762bf4455	\N
eea_tvv_range_4cdb60d05bca91e70bf8c9a5	eea_hist_4fb3acaa617bd627e01587d2	\N
eea_tvv_range_4cdb60d05bca91e70bf8c9a5	eea_hist_d6f3297a65f7fbb7ab8eaa3b	\N
eea_tvv_range_87ea28c812dbb7dd0efdc7f6	eea_hist_0b1723e0bc9b892cc697c361	\N
eea_tvv_range_87ea28c812dbb7dd0efdc7f6	eea_hist_74e64e137cfed04441f44bc6	\N
eea_tvv_range_87ea28c812dbb7dd0efdc7f6	eea_hist_d56a4ae262f92d79d9de6332	\N
eea_tvv_range_45c8af4c5c6599aa0afdddae	eea_hist_9e6a16e49b11f0badb854bcf	\N
eea_tvv_range_45c8af4c5c6599aa0afdddae	eea_hist_723acfde36cb9fccd5778c56	\N
eea_tvv_range_45c8af4c5c6599aa0afdddae	eea_hist_d3fee9ae84151826e6de0a42	\N
eea_tvv_range_fd3c4a1acd546e5b4b36c9ec	eea_hist_4ae784920c94ebabb7ecbc47	\N
eea_tvv_range_fd3c4a1acd546e5b4b36c9ec	eea_hist_d2ca112c7badb870fb879879	\N
eea_tvv_range_fd3c4a1acd546e5b4b36c9ec	eea_hist_4b759bc8817d3a5a1f23a2c3	\N
eea_tvv_range_c534a6561670be6917e63eaf	eea_hist_1eaaa857054d9c1a8e358006	\N
eea_tvv_range_c534a6561670be6917e63eaf	eea_hist_83166b68b76296165b940544	\N
eea_tvv_range_c534a6561670be6917e63eaf	eea_hist_69f3712ce030c241f2265ac5	\N
eea_tvv_range_c534a6561670be6917e63eaf	eea_hist_7560fd95d6c4cb59e31af6fe	\N
eea_tvv_range_c534a6561670be6917e63eaf	eea_hist_99c1789cf51fdbdf24b5f040	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_a1747498457ea8b54e7db94d	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_d979eb77c04f0e7a33e84975	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_91000d1eedb8ef44b8ff212e	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_28428b1a0c0fea4bc27326e4	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_5b3752a37d8bb4eb071cd955	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_e3edb52c98c2da1ddeecf423	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_95245c767278e71e1e5115e7	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_516092183bcd2d3b82c8bcc2	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_1bfce224ff1bfdb8b1a4abc2	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_5ee11db9244bfe75bd5fdc05	\N
eea_tvv_range_e98d4e557390049ac531704a	eea_hist_29fee27d108ec6dcb1da7581	\N
eea_tvv_range_1565669f7d549a5c1fbccad6	eea_hist_5354cec3cddf77c6bd284048	\N
eea_tvv_range_1565669f7d549a5c1fbccad6	eea_hist_b10ff38a3ed71d2af1e1d9da	\N
eea_tvv_range_c350de9f19d753c6738c05d9	eea_hist_bef6e9ef8f1699f5d183aeea	\N
eea_tvv_range_c350de9f19d753c6738c05d9	eea_hist_f4ae86ba902474c3c8fd650b	\N
eea_tvv_range_c350de9f19d753c6738c05d9	eea_hist_5524190c7d5d508c391080f7	\N
eea_tvv_range_64a101e4936ef978ffa5b0bc	eea_hist_0536bfea0cfca30354af5e94	\N
eea_tvv_range_64a101e4936ef978ffa5b0bc	eea_hist_64da3e12fee900affe56eeda	\N
eea_tvv_range_91f61976f3b89a01b05ba3fa	eea_hist_d68c490491024727f594345f	\N
eea_tvv_range_91f61976f3b89a01b05ba3fa	eea_hist_2d55f53ece04d2382b49cad7	\N
eea_tvv_range_91f61976f3b89a01b05ba3fa	eea_hist_17980bf62891dd26a15c6cb0	\N
eea_tvv_range_ef50464a6c61b291557074c8	eea_hist_3ad7c1704baab5e0d4e964eb	\N
eea_tvv_range_ef50464a6c61b291557074c8	eea_hist_7a3c734edcfeafd60525f0ba	\N
eea_tvv_range_ef50464a6c61b291557074c8	eea_hist_c5b20a9bf2d883e12a1d792b	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_fc8166d94561824a57fbaa0f	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_978e78ed8e56765b667381e8	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_740ea98057faf897d76fd1c1	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_74cce1c973500f5b308072bc	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_164667122abc2acd287026f0	\N
eea_tvv_range_e48eef896e4fdd3e58e82e0a	eea_hist_ec7e3a5b9fe9eb155175326a	\N
eea_tvv_range_2276f3a35cbb484bb473db81	eea_hist_0b184e7f1f4aa9891bd59b4f	\N
eea_tvv_range_2276f3a35cbb484bb473db81	eea_hist_984984e8767bbcf8285e6d39	\N
eea_tvv_range_2276f3a35cbb484bb473db81	eea_hist_1b6464e989de206c28a9803e	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_6b7a86427f6917c3b0a026ae	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_03dc19c642e73a56f9ee4c6c	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_cb21a1450acfba3cfbe4346b	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_fd91aa3033dd7273feee7b92	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_d29bb9f8008629f85a7187c7	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_fcfd088adc767a3fc6037849	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_cdfbdfca76726e8cd6b5a9a8	\N
eea_tvv_range_620cfced874bf2dd6c510036	eea_hist_a6f2de41c5a8e3ce1e10674f	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_fe48eda31e23342a18e549de	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_2cba37bc49b70fa506dd91cb	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_c7d070ca39c04c1de570b3f7	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_025996fb8bf08146294e0c86	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_bb99bb5d0d435c4a7c385015	\N
eea_tvv_range_9955b405f0f2a1364eac185c	eea_hist_1b8caeb8b1426a2bb832f5af	\N
eea_tvv_range_48a9753b2244a6f0dc4837c9	eea_hist_567c89b6d4f672b2a1de9c74	\N
eea_tvv_range_48a9753b2244a6f0dc4837c9	eea_hist_31e7d4da340c0fdd395c9b5a	\N
eea_tvv_range_395d69fcddea66e6a034f611	eea_hist_7253f2617b1d856c255dcbff	\N
eea_tvv_range_395d69fcddea66e6a034f611	eea_hist_d370d3491f1968517150a672	\N
eea_tvv_range_320f577a01e998f54eb23e91	eea_hist_6ebb888df86581bb092ea962	\N
eea_tvv_range_320f577a01e998f54eb23e91	eea_hist_ddc0678d0d3406c0d73fe3fb	\N
eea_tvv_range_1b9aa2205bd468090eabbc0c	eea_hist_2d3fd3edc2b782ad4c43ba21	\N
eea_tvv_range_1b9aa2205bd468090eabbc0c	eea_hist_ea37087aa4a3a4d160c03c83	\N
eea_tvv_range_1b9aa2205bd468090eabbc0c	eea_hist_d30d456786c4fce76e0cfbf8	\N
eea_tvv_range_6742936d96ceae09e7783ad0	eea_hist_15582bac2a55c4d4a4d7a8d8	\N
eea_tvv_range_6742936d96ceae09e7783ad0	eea_hist_604532e0b9f591a7c72949ee	\N
eea_tvv_range_6742936d96ceae09e7783ad0	eea_hist_4aee0dfca90614ee0aca4982	\N
eea_tvv_range_6742936d96ceae09e7783ad0	eea_hist_906b8fdbb0ae2c2f4cd8b758	\N
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_fb5bcdb368887498a6e6ec2d	\N
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_5d02fa64a6dc18f0acf4e1c6	\N
eea_tvv_range_6a110b590ebdfe68515a11a0	eea_hist_d804cb5483f2186dd5943c0c	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_b0a9749452b7d2c5b2c65cb9	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_c4992c24c06a83fdc5add70e	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_275fb9f080ea266201b18ec7	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_56e89ab8829b6fc01cf21819	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_e8a7906931f97ad43249452f	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_4da2f37fa42b20e5c84b963d	\N
eea_tvv_range_40e740c2b966d340739eaece	eea_hist_67f7ab5da81b6e48eb1182f7	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_d2ee55951d56c1541a63cffa	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_c137fe70c494cf796c3dc532	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_aef7ef9e34cf767c73d6229f	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_4db9598b7246569d1d9da50b	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_203298b54fdc336d3f6baab9	\N
eea_tvv_range_c98476cf485762ae66698660	eea_hist_3f52eadf0c5ddd250fb36482	\N
eea_tvv_range_90f8838565525cb2304fc4e9	eea_hist_e447c1b28d5549912bd31866	\N
eea_tvv_range_90f8838565525cb2304fc4e9	eea_hist_9de09aedff489129d83655d0	\N
eea_tvv_range_90f8838565525cb2304fc4e9	eea_hist_55b79c9b13644672fe7309f6	\N
eea_tvv_range_90f8838565525cb2304fc4e9	eea_hist_5e13a75ad371429c290de00b	\N
eea_tvv_range_5a4c9082f8a9a5bc7cba5d7e	eea_hist_b3bd172575c2f6068a92b99e	\N
eea_tvv_range_5a4c9082f8a9a5bc7cba5d7e	eea_hist_439c8212816e9146ad7222b4	\N
eea_tvv_range_5a4c9082f8a9a5bc7cba5d7e	eea_hist_c8ef41873bd09e48117e0f36	\N
eea_tvv_range_079b22ff3eaf5b67bcb9d9eb	eea_hist_1f76c553be35c28217386b90	\N
eea_tvv_range_079b22ff3eaf5b67bcb9d9eb	eea_hist_69bb82db30c155c50776daac	\N
eea_tvv_range_079b22ff3eaf5b67bcb9d9eb	eea_hist_6012b9d153113b0d8d87b493	\N
eea_tvv_range_b3a610666b4036f8eab6746e	eea_hist_7c5cddc52d64232d742e0feb	\N
eea_tvv_range_b3a610666b4036f8eab6746e	eea_hist_7b29b65d994aee3667a50d97	\N
eea_tvv_range_b3a610666b4036f8eab6746e	eea_hist_c05f90f7d7fc7e330261ba4e	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_a17f2c47e0e414c29f2d872e	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_821911d9495a44a3be9288f1	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_2a307b04fc6122cfe303416f	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_ef0c9b78c102e774374b4ab1	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_bf45761b45d28b2133947364	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_09e0e39e9a3a7a8e62e1000a	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_c08380997ca2687afaef58f7	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_93df6f3b0eead6ab5417c0e5	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_a5b0346b08079504eb6c3679	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_35732b852e0162cebad020e4	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_d800dfc1b059d81e363431bb	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_0655a42477f0618d24968c68	\N
eea_tvv_range_079e0b7b1d83a2fe4a27baf1	eea_hist_467f903961921d179adda708	\N
eea_tvv_range_ccf6b7c10b33a8c52ce21b65	eea_hist_7af56a623249be6a07d3dba2	\N
eea_tvv_range_ccf6b7c10b33a8c52ce21b65	eea_hist_d7e446cd06d9a5ae2fe072e1	\N
eea_tvv_range_ccf6b7c10b33a8c52ce21b65	eea_hist_b8c4b392513744d075a83e0e	\N
eea_tvv_range_4b7421ffda1d13740d999ef5	eea_hist_49137d7285029b586236f561	\N
eea_tvv_range_4b7421ffda1d13740d999ef5	eea_hist_10a2c8ea4f912c7e28174bc0	\N
eea_tvv_range_4b7421ffda1d13740d999ef5	eea_hist_db6aa33a8a5a028cca7801fb	\N
eea_tvv_range_cc660facacbec17fb1047fee	eea_hist_88f2eb0d5b5eb344c9031c5f	\N
eea_tvv_range_cc660facacbec17fb1047fee	eea_hist_66bc8f439fb2336f0443ccf1	\N
eea_tvv_range_cc660facacbec17fb1047fee	eea_hist_c8fd2584cfd2cbd70ffbb77e	\N
eea_tvv_range_cc660facacbec17fb1047fee	eea_hist_e753d6387b53243e76eb1ff1	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_1d9e88207ef2e62996368a43	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_036f4aedfbb4afda67b382bd	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_4bc21afd962bada0b7d83d70	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_1236ae2a935a4cbc3c84a203	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_c1e8efa68ccd9ae92bfdc9b6	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_485b3dc55b10fc0bfde06525	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_bc051aa81a037d970fd26a2b	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_e600ed1290f609f0906dd97c	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_d4097bf4bc5a764823ecc2e6	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_4c47c0bd2d35c7e7b87253d6	\N
eea_tvv_range_b8e4e9a76a131007a9163aa7	eea_hist_9235df873ac76e8dfc8d7533	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_fe900a0bbebccbece8b122b4	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_13280f13c94e376700715479	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_74cdbe73e155b5357c5e18b3	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_1d469ec73466d1fa2e57c0e6	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_78a7b3281f557d6da72eccf7	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_5ee8a78b882753fb4769b1f9	\N
eea_tvv_range_68dc824b0a3c598a4c21d996	eea_hist_0ac87de9851c290a037217ff	\N
eea_tvv_range_630171113d68c04cf9a160b3	eea_hist_e8ad3b32fa89a629fb9c2946	\N
eea_tvv_range_630171113d68c04cf9a160b3	eea_hist_ef6925c78b295932dbe8590d	\N
eea_tvv_range_630171113d68c04cf9a160b3	eea_hist_94ca2a5846c9f796ce169dbf	\N
eea_tvv_range_630171113d68c04cf9a160b3	eea_hist_7adb8406964eb99cc3f2d585	\N
eea_tvv_range_630171113d68c04cf9a160b3	eea_hist_8d1955467cb90ccd715e00dc	\N
eea_tvv_range_59b3e9bceaeb55aef9d86fc6	eea_hist_f594528ab84984458bc4570a	\N
eea_tvv_range_59b3e9bceaeb55aef9d86fc6	eea_hist_19d72a9cc8ca377d2b5ffbf2	\N
eea_tvv_range_59b3e9bceaeb55aef9d86fc6	eea_hist_e68bdec3e2e4d3b79a5c3c6a	\N
eea_tvv_range_aba7406be43df57941ef44eb	eea_hist_e37d0fbdbf542735197afca5	\N
eea_tvv_range_aba7406be43df57941ef44eb	eea_hist_949331204eec1d80ed0dfae4	\N
eea_tvv_range_aba7406be43df57941ef44eb	eea_hist_75359a3b4ec14062d7ca67f3	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_9dc568616ae50287715bf937	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_31b86adefa0004f2327416b0	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_dd2b859aff338c6701204954	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_ec0f0d854822d2916538bfb8	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_98b95d4127fbe72bcfb6b8b5	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_f3371a6e235488a9835db338	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_75f4f596f93016963b8367e2	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_d12f9928ffb4d37beabe2e01	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_3848d65115b072e404206c5c	\N
eea_tvv_range_2dc01f6db70ffb9a78c9cd6f	eea_hist_6ad117ead871679d451af848	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_7df9f8f876032ea62ef57713	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_744454debed67b9dc513e5c0	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_c5d35b37a46b86b594e1bc51	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_f786ec97a1ef8276647e8342	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_1315ecdc1e086a2e3e14d13a	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_902c4aca7b3583770e2b8278	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_e5c9ffe306d62d8a3541bd89	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_7d8778b470befeb48fc0726a	\N
eea_tvv_range_bcd08b1667780fbdd35aa82d	eea_hist_31a2e14087497dc86ef0b5d6	\N
eea_tvv_range_654d6c8205214589e951be40	eea_hist_f69454d71a6dba20d9169275	\N
eea_tvv_range_654d6c8205214589e951be40	eea_hist_6c78db5f64412c86cd501c9b	\N
eea_tvv_range_654d6c8205214589e951be40	eea_hist_365fb3cf2e86166a51884b40	\N
eea_tvv_range_654d6c8205214589e951be40	eea_hist_7b13ad247c686badc44dda17	\N
eea_tvv_range_654d6c8205214589e951be40	eea_hist_d90388dc8ea6b25c1772805d	\N
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_97fdbb4cd3512ba6c809af66	\N
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_a5e2b5574cb268cf4a113238	\N
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_449c350695b0e4d7eea30115	\N
eea_tvv_range_3e5ce6836ad254cec5d4cc04	eea_hist_1d037ff0bf20bc411e0cef13	\N
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_5f49a765c7380e0ae161b928	\N
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_6014f081e5dad9632149f4b5	\N
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_678caed63f1569bd4aa8db8f	\N
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_3749d0a723c9e8f6ffcaa21f	\N
eea_tvv_range_a8a32eb5317af04d2eaeb443	eea_hist_7042d39d384aebf3c7c3e9ef	\N
eea_tvv_range_febf1e297eb6b56cc3794ac6	eea_hist_88ec9a1f1ce3551254d445d0	\N
eea_tvv_range_febf1e297eb6b56cc3794ac6	eea_hist_e9551c76d108b29f36076f23	\N
eea_tvv_range_febf1e297eb6b56cc3794ac6	eea_hist_d3c7a157c46e2d1cb76e4417	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f5fa759c1409cdcb0fd213f4	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_ac6d13d7232494c317d8686f	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f667d905f12e1f05f2c82ef5	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_1c6418d752aa07c82c9416e3	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_4ff5a286c9fbf97ec046f527	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_80f855a601476366251831a0	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_c577a46daf6f7d695f53bab0	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_6de7ff4ab8f33d8e0ca04875	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_5bd4fa7513fde1275576da46	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_23c46f3c1b3e8cb1d72f2691	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_3613a3ea8ef204c31b2a1355	\N
eea_tvv_range_dab00250fdf1c19313482d09	eea_hist_f60906e87da76603b1d1b7ce	\N
eea_tvv_range_35e5c28082c2dfb672aaf3fc	eea_hist_6dba57e5aa0ee6c4852eea09	\N
eea_tvv_range_35e5c28082c2dfb672aaf3fc	eea_hist_cbd57569a7e8e0506dacd458	\N
eea_tvv_range_35e5c28082c2dfb672aaf3fc	eea_hist_2db18605f8921bec17a03903	\N
eea_tvv_range_35e5c28082c2dfb672aaf3fc	eea_hist_73b1444649f04e0d7f1e9434	\N
eea_tvv_range_35e5c28082c2dfb672aaf3fc	eea_hist_e4aa424ff46381570a47f5c9	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_3ddaaf8f8b30a7824e2afe47	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_7551a28541425e3ffd7bf507	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_bc4890f11ea5319c76d91b3a	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_c3fa3f49c78955d8e1d8158d	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_3db522257d8d03a13910045a	\N
eea_tvv_range_46d4d1eda91a56a9cb272522	eea_hist_c33391e31656a34d55f93f00	\N
eea_tvv_range_8d27ef4541ef85071bdbc0f0	eea_hist_cebdb9a99e0d314f99c2f8dd	\N
eea_tvv_range_8d27ef4541ef85071bdbc0f0	eea_hist_49d7b50a1932006c6fcd71e6	\N
eea_tvv_range_8d27ef4541ef85071bdbc0f0	eea_hist_42ef31f411cc8859ce2eb6df	\N
eea_tvv_range_8d27ef4541ef85071bdbc0f0	eea_hist_a2566687217254cef1bd90d8	\N
eea_tvv_range_2663ad670690171bb0e94655	eea_hist_7a9c98aeebf0e25bd2491669	\N
eea_tvv_range_2663ad670690171bb0e94655	eea_hist_f43a2a3570491a966884b413	\N
eea_tvv_range_2663ad670690171bb0e94655	eea_hist_568a87978d8ff0ef1a901506	\N
eea_tvv_range_2663ad670690171bb0e94655	eea_hist_90366f764d157b0818f04fb3	\N
eea_tvv_range_97207a233ddd9fc360f07dc1	eea_hist_3c14e832377fac35b5fd4d11	\N
eea_tvv_range_97207a233ddd9fc360f07dc1	eea_hist_7fa6b56ae02981c72e93b5c7	\N
eea_tvv_range_97207a233ddd9fc360f07dc1	eea_hist_fceec66a17cf9eff30203824	\N
eea_tvv_range_2097ec89e80ec2b593be8abc	eea_hist_60cf8d81a371e72edf5f0848	\N
eea_tvv_range_2097ec89e80ec2b593be8abc	eea_hist_3b788193b1393ea00447a7c0	\N
eea_tvv_range_2097ec89e80ec2b593be8abc	eea_hist_b3b28e9341abd570fc35ffa5	\N
eea_tvv_range_2097ec89e80ec2b593be8abc	eea_hist_827819528e7be3acb17df35c	\N
eea_tvv_range_2097ec89e80ec2b593be8abc	current_cluster:b7b3ac57e13f91e50e5bccf0b1bbbea8	267
eea_tvv_range_2097ec89e80ec2b593be8abc	current_cluster:5078b0d8d42098f0b505e0f2726a5283	267
eea_tvv_range_5521dcd4130c876f346742f5	eea_hist_71b6508ef8893cd2c785e82d	\N
eea_tvv_range_5521dcd4130c876f346742f5	eea_hist_316212634df9f8e22e1a29f0	\N
eea_tvv_range_5521dcd4130c876f346742f5	current_cluster:0d8decd682a7fbf11a36f73d637a4ae6	268
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_df477db51f6d177973a0fcb5	\N
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_ca0017a4753bd154ed0378c2	\N
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_52cdd25d336fd6c2216018d6	\N
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_ae6b37d55bb2c1ed41371536	\N
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_02ef777658804496677ffb91	\N
eea_tvv_range_3d63dcd1985686d4ff5e1dde	eea_hist_3dcd9b235967710062dc9bfb	\N
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_08c8aff30c3042ab1d9d0f06	\N
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_4e7857d7418ba25c3f3f89c0	\N
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_d1fc0ec5c526a6e544f4455f	\N
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_783180bfbb52cce139f28148	\N
eea_tvv_range_2e810533cf760faa40ea99ac	eea_hist_d114a8a1bc0021aae8a25acb	\N
eea_tvv_range_1039cabd8a0dab1dc98b9330	eea_hist_0779c84a6eb382d87ec1aaac	\N
eea_tvv_range_1039cabd8a0dab1dc98b9330	eea_hist_40b6272eb2d60e3d0991e218	\N
eea_tvv_range_1039cabd8a0dab1dc98b9330	eea_hist_a22f05a99e2a4b0abae89ca6	\N
eea_tvv_range_1039cabd8a0dab1dc98b9330	eea_hist_04ef690138a68db1c8e8cf27	\N
eea_tvv_range_1039cabd8a0dab1dc98b9330	eea_hist_39231b639a2fb58b9eb9b808	\N
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_34f570d6507dae4848477661	\N
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_3ea6f549309983c9a9fe33ca	\N
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_2f82846f352960ca584e0274	\N
eea_tvv_range_0c9efe9e5aff611d5098c378	eea_hist_432db1d3b036fb654b370516	\N
eea_tvv_range_121ad32fa1b02b5e0a276ada	eea_hist_94cdc52e8bfb28165b3935db	\N
eea_tvv_range_121ad32fa1b02b5e0a276ada	eea_hist_cdc282a6c79a6df0f13dbbed	\N
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_e84e1d520cac9fd585556c03	\N
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_4bf54af900f38e39ba04eb71	\N
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_a2d43cc3b82d3940a87ed0e2	\N
eea_tvv_range_d5225cadde5eb8370f6caeff	eea_hist_9bae53470e5bcce0e55496cf	\N
eea_tvv_range_929529d1d0b43d43bb3804fc	eea_hist_5bfe5906135c583ff81fe954	\N
eea_tvv_range_929529d1d0b43d43bb3804fc	eea_hist_de690a8410cb42963e8541bf	\N
eea_tvv_range_929529d1d0b43d43bb3804fc	eea_hist_376c783156b778e58edeed79	\N
eea_tvv_range_929529d1d0b43d43bb3804fc	eea_hist_3a2f057be7e89a7c328b35c7	\N
eea_tvv_range_929529d1d0b43d43bb3804fc	eea_hist_193dda486842c9bde24843c6	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_95450df0372f115456477e12	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_3bfde5c21fcfdfc3ecdfd337	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_f589786b4fb4de2586663ad9	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_674404ce1904fbaab6323296	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_2c272d7e960d8752cfa86b1a	\N
eea_tvv_range_fc4f446efa3f7d29bd45ac75	eea_hist_c43ff8163606eefe8e586a48	\N
eea_tvv_range_350fc92884b00b617bae8537	eea_hist_6085d2da6dc554c83481a5ce	\N
eea_tvv_range_350fc92884b00b617bae8537	eea_hist_b27d37a52140c44edee85e35	\N
eea_tvv_range_68798a8dd9bfd982aa60b914	eea_hist_53f5c1db17e45f9a31055708	\N
eea_tvv_range_68798a8dd9bfd982aa60b914	eea_hist_6a05274a2df684de8caa15a8	\N
eea_tvv_range_68798a8dd9bfd982aa60b914	eea_hist_547dd0da5aaf83c39a362d07	\N
eea_tvv_range_68798a8dd9bfd982aa60b914	eea_hist_5662f5265d5ec120580b6bb0	\N
eea_tvv_range_68798a8dd9bfd982aa60b914	eea_hist_5433148d201bc7f6f95a5ebe	\N
eea_tvv_range_0a5dd2d8997cc76c1ff24e89	eea_hist_a3742eda5a4e16537e09b149	\N
eea_tvv_range_0a5dd2d8997cc76c1ff24e89	eea_hist_d5d5f060c4bc4cbd9750b7d1	\N
eea_tvv_range_0a5dd2d8997cc76c1ff24e89	eea_hist_993ca2e84f6589d1647f3cc6	\N
eea_tvv_range_0a5dd2d8997cc76c1ff24e89	eea_hist_4a702eacd88f7b4ccf855a51	\N
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_ad93e936f0ad6255a8d8aa78	\N
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_7d963da7b1578ba49a29acfe	\N
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_78efd10ae1ef6495826fa1a7	\N
eea_tvv_range_ebd43ffdd6de8a9f1fc317e8	eea_hist_a990450f100e51679cf5334b	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_5add0c5be7351b949a570ba0	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_0cf76268906d180f81bfaaf9	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_61d609e95b4cb3c1daef762e	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_7afefedb138af53bc3f42326	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_b5b92f9f2f927cfa1285803c	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	eea_hist_970f72cc591cb0b33d0fb885	\N
eea_tvv_range_68f72bcc9d5fa9b485ec115f	current_cluster:ae03d574979f59a051219d718c12acc5	625
eea_tvv_range_68f72bcc9d5fa9b485ec115f	current_cluster:62bdc426a54c999cd21632dbc6ef98ee	625
eea_tvv_range_898957f96a4fbd692fc5648c	eea_hist_462aa1e40446690a5c5d47b4	\N
eea_tvv_range_898957f96a4fbd692fc5648c	eea_hist_0c1d3a328fbb4ad1ba99c397	\N
eea_tvv_range_898957f96a4fbd692fc5648c	eea_hist_6db317363ea3ce31f44aa8d4	\N
eea_tvv_range_f0fd986cbfbaffdb50ea654a	eea_hist_19a3e735e23e03d5818ef2c3	\N
eea_tvv_range_f0fd986cbfbaffdb50ea654a	eea_hist_19303237762dadfb3b568ee3	\N
eea_tvv_range_f0fd986cbfbaffdb50ea654a	eea_hist_eccc639ae17034173f0285aa	\N
eea_tvv_range_dca4567f62d8c8fc2998d795	eea_hist_3c32dc66afa626c5413bfeae	\N
eea_tvv_range_dca4567f62d8c8fc2998d795	eea_hist_c44cf4ba8266a41683d00046	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_b238b4908589cebc3b4cec34	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_f9a7723d1903101708254116	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_996751f99a737ad53c56ca6b	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_b88553baa2e9f59110866993	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_efe6935fe37970696d03d075	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_f31130785163b3d7ddf99d3a	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_b0cf5fd2383a4dd0fed2e4b7	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_5ad00882f90d07cc1dc280d6	\N
eea_tvv_range_2bf5cee24de6b9fa33e4170f	eea_hist_6ec3d6c9cfbee0173e9b534e	\N
eea_tvv_range_81a843dc1f7505ca4b697a6c	eea_hist_8b7f50b56bd6f99116eed3be	\N
eea_tvv_range_81a843dc1f7505ca4b697a6c	eea_hist_3bfcf77117cc4e05c769f5de	\N
eea_tvv_range_81a843dc1f7505ca4b697a6c	eea_hist_382b3ae41aca23e6adb5b06d	\N
eea_tvv_range_81a843dc1f7505ca4b697a6c	eea_hist_df3b614c97e6dd9c13f6dae2	\N
eea_tvv_range_81a843dc1f7505ca4b697a6c	eea_hist_c0e3612fd2b27471c553ecfc	\N
eea_tvv_range_c65277e54f30fb2e56a537d5	eea_hist_72994e79ab26db5b6d4da20c	\N
eea_tvv_range_c65277e54f30fb2e56a537d5	eea_hist_30b2671b1158fc4d9886b7f3	\N
eea_tvv_range_c65277e54f30fb2e56a537d5	eea_hist_5fd4fc9791bd89e673ff1f65	\N
eea_tvv_range_c65277e54f30fb2e56a537d5	eea_hist_1898d0182f834cc70ba6f22e	\N
eea_tvv_range_ac68792e64142134db80bd60	eea_hist_4610eab1889e3f423f962ad5	\N
eea_tvv_range_ac68792e64142134db80bd60	eea_hist_5af38ce3d786ffc151c3c537	\N
eea_tvv_range_ac68792e64142134db80bd60	eea_hist_ee74b18aca4c088959d1df06	\N
eea_tvv_range_564d1e5d38d09568cf07b301	eea_hist_cb38e530352ddda6e1f0c7d7	\N
eea_tvv_range_564d1e5d38d09568cf07b301	eea_hist_ba8b4bb9933c39514b6fb66e	\N
eea_tvv_range_564d1e5d38d09568cf07b301	eea_hist_ba3c20e10b11cbaa542e613e	\N
eea_tvv_range_5a403191a4824e7addac80a8	eea_hist_8c5ebf60f42d6de541aeab7d	\N
eea_tvv_range_5a403191a4824e7addac80a8	eea_hist_952a986296bf295a9047bcea	\N
eea_tvv_range_5a403191a4824e7addac80a8	eea_hist_c3166ab9dab6e202101d1d54	\N
eea_tvv_range_200f4f2edaafb80829453893	eea_hist_986dd2cd9863c5b8e38dddd3	\N
eea_tvv_range_200f4f2edaafb80829453893	eea_hist_aa6db5d45b4e2300725aafd9	\N
eea_tvv_range_200f4f2edaafb80829453893	eea_hist_a5007a418a9ba65a8c9f4b11	\N
eea_tvv_range_200f4f2edaafb80829453893	eea_hist_4b1d7f678ae7601a0aec993d	\N
eea_tvv_range_456665ddf436a476288289f0	eea_hist_5ebf707d897204a2e0e2b848	\N
eea_tvv_range_456665ddf436a476288289f0	eea_hist_b6dc4755566b84146f500693	\N
eea_tvv_range_456665ddf436a476288289f0	eea_hist_e0cdbf929ef905704f5b7b0e	\N
eea_tvv_range_456665ddf436a476288289f0	eea_hist_dc27799e959958d8dcd08388	\N
eea_tvv_range_29573fe846d3d2fbe415c52c	eea_hist_61e8036b70fb2ce3ed63033d	\N
eea_tvv_range_29573fe846d3d2fbe415c52c	eea_hist_50232272190b04135bccee1b	\N
eea_tvv_range_29573fe846d3d2fbe415c52c	eea_hist_1bf1617a025724947f2dacee	\N
eea_tvv_range_e968fb822f51c0a21005be06	eea_hist_2453cd09859b48938619a1e8	\N
eea_tvv_range_e968fb822f51c0a21005be06	eea_hist_52a3ff27cd2ded6d6b007dd7	\N
eea_tvv_range_e968fb822f51c0a21005be06	eea_hist_0d3398ce262e50c1a431cead	\N
eea_tvv_range_e968fb822f51c0a21005be06	eea_hist_de094a620a749f00466922b9	\N
eea_tvv_range_0185bf219f4f4fc691535905	eea_hist_2e946c2478ecfe60e5385b0c	\N
eea_tvv_range_0185bf219f4f4fc691535905	eea_hist_fe972f8f7e9716bb244c7a47	\N
eea_tvv_range_0185bf219f4f4fc691535905	eea_hist_4f8d36f6cf5cd35a25edce38	\N
eea_tvv_range_0185bf219f4f4fc691535905	eea_hist_bcefeaf3dd0864b55fa4b4cf	\N
eea_tvv_range_a3d241ef1aaab2a16b72c533	eea_hist_5738c33482a02ae04b9939ba	\N
eea_tvv_range_a3d241ef1aaab2a16b72c533	eea_hist_3ca681497f5643629c0d0d6b	\N
eea_tvv_range_a3d241ef1aaab2a16b72c533	eea_hist_aa035da29faef3e55094db87	\N
eea_tvv_range_4dfe191ab66231ca338b22bc	eea_hist_1122e05d8430a8728692ad56	\N
eea_tvv_range_4dfe191ab66231ca338b22bc	eea_hist_e44d1d0cce406d2460f95af7	\N
eea_tvv_range_4dfe191ab66231ca338b22bc	eea_hist_0abd0fd9434801c733f4b842	\N
eea_tvv_range_fc38fe94d62fd995bed8ea9b	eea_hist_bb03fec4acf6d82b1a8718d7	\N
eea_tvv_range_fc38fe94d62fd995bed8ea9b	eea_hist_467817679d9f655088b26027	\N
eea_tvv_range_fc38fe94d62fd995bed8ea9b	eea_hist_ed1cec5739377bad42abe857	\N
eea_tvv_range_610e46a0a4675ccb4ee5d107	eea_hist_1b099bec371d6666b94246cb	\N
eea_tvv_range_610e46a0a4675ccb4ee5d107	eea_hist_253c14d5062015e1dbfe85d8	\N
eea_tvv_range_ff808709e68db9c5857b2315	eea_hist_2fe96a91d474c86c0bd92b1e	\N
eea_tvv_range_ff808709e68db9c5857b2315	eea_hist_def56edb7aff84dfd193dd9f	\N
eea_tvv_range_ff808709e68db9c5857b2315	eea_hist_9b60801df3a7ca6e57def072	\N
eea_tvv_range_ff808709e68db9c5857b2315	eea_hist_2c3da43455bc265fdf0238e4	\N
eea_tvv_range_383ad1b8b0eb10bd03ec2b1d	eea_hist_b10bd2c49cbb5f77834fbb86	\N
eea_tvv_range_383ad1b8b0eb10bd03ec2b1d	eea_hist_602bb8a27c6c903df306eadb	\N
eea_tvv_range_383ad1b8b0eb10bd03ec2b1d	eea_hist_999271f18a42a23edc7b4b6d	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_4de88757b69136cac5ed0303	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_04566b9fff974f83effced84	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_dc393b8fab00286455b58e6d	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_ba0a2d440cc95af3a6e612d1	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_560a740b9bdd8afb9e208533	\N
eea_tvv_range_911428c3c6f008102abf01cf	eea_hist_3458b9f4dbe53527d4c26947	\N
eea_tvv_range_cc1c41ac32d57d23fa829716	eea_hist_6aaa83e5c4a8563f08bfad7b	\N
eea_tvv_range_cc1c41ac32d57d23fa829716	eea_hist_0ca2704fd186ffe52ce3cc1b	\N
eea_tvv_range_cc1c41ac32d57d23fa829716	eea_hist_fd9e1f7d6dab1d5cad9a92e3	\N
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	eea_hist_658b232b9c251e060664f1bf	\N
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	eea_hist_1dd5e52aa3b64e9d057584a2	\N
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	eea_hist_bed2f09ab6c9e8a35698647c	\N
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	current_cluster:942754d8994803589971d52667524944	712
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	eea_hist_f4db1560de73c9c200038b21	\N
eea_tvv_range_dfbd10e7e1215d9ba9c497b3	current_cluster:9861535373c0b4cff482754dadceff9b	712
eea_tvv_range_f3d3dffba8c19efec8721e8e	eea_hist_1cb55d50ce37e81716a8f972	\N
eea_tvv_range_f3d3dffba8c19efec8721e8e	eea_hist_44bb984fbb869dd936e36730	\N
eea_tvv_range_f3d3dffba8c19efec8721e8e	eea_hist_c0c60b258e6e15aec7516315	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_51f3f292a9450ced4c1e96d0	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_b99e5cecf95372538c7c1fcc	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_331719ac5526e8193749a3c3	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d0889d2ebad5d364f3e58f45	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_2b1c55df8042ca9f443a8a23	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_3481548cb5d50e8fe7df46b2	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_99d434989c8d4dde0cdc28a5	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_bd084f7cec2c1d787fa25aa9	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_284a7b71d2460a0baf355cdb	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d1e8543cdef6b6703f0dc571	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_d535dba59679dd8df6d9dd5e	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_df0efe7d42d98532b76d3516	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_e370bb67b1439b683664d6bf	\N
eea_tvv_range_c3f84c69e6369b89efc8d9c7	eea_hist_f3a02ae5a816b7e292d8f06d	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_41e8d3fff233ef93640961f0	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_1fe20d1e3f8c405210f5d792	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_0a387f5588637a9a77874576	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_ed18fbb843b674383bde35fa	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_cbd80ba25e1026477eb7ee81	\N
eea_tvv_range_e3104090831b01cb95f4d11d	eea_hist_db70549fb6679fd5fb2096c6	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_80ceba4b02a6ac0abf389fab	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_826858ce6a30dff24e1698b6	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_77f340f601d2f3f0ad0bb7d4	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_62cd2aeb3edc19b0b6fe8e86	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_61bc4f978b0fff09062e51ae	\N
eea_tvv_range_2a1e66c2d77272b1a7660a67	eea_hist_a1c449473b7ed2fe3c0cc182	\N
eea_tvv_range_00578c53fe9cb2f7894a1bd4	eea_hist_bcdc5bf3eac9df3fff2915f2	\N
eea_tvv_range_00578c53fe9cb2f7894a1bd4	eea_hist_a4dd014a3bd1d2ec52eaf4b2	\N
eea_tvv_range_00578c53fe9cb2f7894a1bd4	eea_hist_ce9d81b5b7ab8b35efa543a9	\N
eea_tvv_range_00578c53fe9cb2f7894a1bd4	current_cluster:4449483e7a9e89d4ff2be0e2529fedfd	337
eea_tvv_range_8d295141028f49b406888dff	eea_hist_a8a8c9fd1ce4c926778ea3fc	\N
eea_tvv_range_8d295141028f49b406888dff	eea_hist_e757cfa4e09b9793800463a1	\N
eea_tvv_range_8d295141028f49b406888dff	eea_hist_c9775c5c157c552137ccb983	\N
eea_tvv_range_8d295141028f49b406888dff	eea_hist_5c47160d07c1ffb73eb7d36e	\N
eea_tvv_range_8d295141028f49b406888dff	eea_hist_18d95b2b2e21904ced265233	\N
eea_tvv_range_8d295141028f49b406888dff	eea_hist_cb4f8cf539e69519ce218ae9	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_9d31635812dac35297f314fb	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_b47caa044feaf22d9890368b	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_68874c9ce779dd2ac2ba0a67	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_c04e2ad5137fe902d1c5d24b	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_3ccdd260e95829a898f33a3d	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	current_cluster:de03158a8eab1d43d61c929f28de4d2d	51
eea_tvv_range_b95e4c3ab69feb4f06b50e04	eea_hist_8fe821a17c2ee5fdd53c2197	\N
eea_tvv_range_b95e4c3ab69feb4f06b50e04	current_cluster:3b5bdd6a4f023f1ebe204f4ad273caa9	51
eea_tvv_range_9b6a5a4b92da7afb99d11977	eea_hist_8ee6236b12f2063c69d6219b	\N
eea_tvv_range_9b6a5a4b92da7afb99d11977	eea_hist_8d4068659918af1e8c817614	\N
eea_tvv_range_9b6a5a4b92da7afb99d11977	eea_hist_bc8768e3c2abd1569f3d0901	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_c250c072b73fbf99d56b994b	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_26497c95f9f7935f46af0880	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_a97e0b73ce3fcf5b2b3ffad2	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_33fc841dbe557b218cc68e51	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_894405077e4177db8ec60ffb	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_f4aa4db8867857e26996d856	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_0eee8f47302ff0b7a5e1df10	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_53f7cf0b5df636ca093521c2	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_9be6561c2724700dcaa74ca4	\N
eea_tvv_range_2d973a75cf607b93143da3d9	eea_hist_bc198a30659776d3c6ae9614	\N
eea_tvv_range_23b5a415c88ec063cf1e86ec	eea_hist_66179cdb91eb27fd61272754	\N
eea_tvv_range_23b5a415c88ec063cf1e86ec	eea_hist_ca29c569f4ecb0388b1ebf7c	\N
eea_tvv_range_23b5a415c88ec063cf1e86ec	eea_hist_1a1cca22534f82874d7ff84b	\N
eea_tvv_range_23b5a415c88ec063cf1e86ec	eea_hist_8582adff89a542d18280242c	\N
eea_tvv_range_5d1ef00a438efdb4787272a1	eea_hist_971987171c4da1bf31b2a184	\N
eea_tvv_range_5d1ef00a438efdb4787272a1	eea_hist_1034096342501ddc841e8950	\N
eea_tvv_range_5d1ef00a438efdb4787272a1	eea_hist_000dfbabd154f04548ea6648	\N
eea_tvv_range_65a776f712d377490b978d8f	eea_hist_31f0cc6c7f39510da33e8fe5	\N
eea_tvv_range_65a776f712d377490b978d8f	eea_hist_df62ecf101c357accb741b3b	\N
eea_tvv_range_65a776f712d377490b978d8f	eea_hist_f58cd100757568b933bdc657	\N
eea_tvv_range_f34da062384191634b99f3dc	eea_hist_862d2a653704e7241e482cba	\N
eea_tvv_range_f34da062384191634b99f3dc	eea_hist_7f8a1cd3b4f552de51ad61c8	\N
eea_tvv_range_f34da062384191634b99f3dc	eea_hist_fc792d7b3312b76fddce1b02	\N
eea_tvv_range_e1ed0a1cf48f71c3df0dc847	eea_hist_944a21a956bfe4eaffadd644	\N
eea_tvv_range_e1ed0a1cf48f71c3df0dc847	eea_hist_6e23e34af425984c6bbaf13b	\N
eea_tvv_range_e1ed0a1cf48f71c3df0dc847	eea_hist_0bf26ec7f8141c23bf181d9d	\N
eea_tvv_range_20c3b16a4f7839152fcf0909	eea_hist_a4989b82d2ef3c8d58bfb81a	\N
eea_tvv_range_20c3b16a4f7839152fcf0909	eea_hist_71574b9661e09e6b1cb41420	\N
eea_tvv_range_20c3b16a4f7839152fcf0909	eea_hist_217e000064243b646892edb3	\N
eea_tvv_range_20c3b16a4f7839152fcf0909	eea_hist_216c326af5c53e299963aa9f	\N
eea_tvv_range_1fc5d44ddfb9714b9bb6b4b6	eea_hist_75105be64d30ddee18928089	\N
eea_tvv_range_1fc5d44ddfb9714b9bb6b4b6	eea_hist_79a552ab3108f61dca08c7c3	\N
eea_tvv_range_1fc5d44ddfb9714b9bb6b4b6	eea_hist_9fbc9004a759076a66a820c2	\N
eea_tvv_range_1fc5d44ddfb9714b9bb6b4b6	eea_hist_5f117871e9dfd09c7ab32790	\N
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_34a0dd3a0561cd85851cd4e0	\N
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_7f8f8fccb7854dd6941bcad7	\N
eea_tvv_range_ca997e9f6e05950b1c225434	eea_hist_96d059c1fcdc8b5f0e4ea1d7	\N
eea_tvv_range_e1f2b3085f1c516a1243df92	eea_hist_1b2eeefc11c71f922a8d2b0c	\N
eea_tvv_range_e1f2b3085f1c516a1243df92	eea_hist_4770720570533942d6e044bb	\N
eea_tvv_range_e1f2b3085f1c516a1243df92	current_cluster:55ab11e5bf7b91605a51df20a33c063a	864
eea_tvv_range_c0aede045d9a734267c70ba5	eea_hist_1a395831a09f6ccd61a4770b	\N
eea_tvv_range_c0aede045d9a734267c70ba5	eea_hist_3b8980fb14dae27cf71d3cb6	\N
eea_tvv_range_c0aede045d9a734267c70ba5	current_cluster:75b511a9e435d6958e115ded87ccf9fd	863
eea_tvv_range_ee32e72d9d42f3ee10adb48d	eea_hist_e109049f0d1f592734c03e7d	\N
eea_tvv_range_ee32e72d9d42f3ee10adb48d	eea_hist_034a0d230b9ca672867c65ee	\N
eea_tvv_range_ee32e72d9d42f3ee10adb48d	eea_hist_d78e9d727955b8dfe49f7400	\N
eea_tvv_range_ee32e72d9d42f3ee10adb48d	eea_hist_4e83e07c6ea505273c9635c6	\N
eea_tvv_range_ee32e72d9d42f3ee10adb48d	eea_hist_c09097dbd3028cd18633f70a	\N
eea_tvv_range_85178a5d9cf4c974b1aedb25	eea_hist_ad181ecf1bca1ab1b1594f3e	\N
eea_tvv_range_85178a5d9cf4c974b1aedb25	eea_hist_7967d814ef6861731d673628	\N
eea_tvv_range_85178a5d9cf4c974b1aedb25	eea_hist_e39480165fe59b73202bf6a5	\N
eea_tvv_range_85178a5d9cf4c974b1aedb25	eea_hist_ac399e8f6373e371216f33f6	\N
eea_tvv_range_c15884f371d35784afe732ba	eea_hist_832b2b22663a87b244e1e4d6	\N
eea_tvv_range_c15884f371d35784afe732ba	eea_hist_e0c7009afabc529caef62fed	\N
eea_tvv_range_c15884f371d35784afe732ba	eea_hist_0404a26aac45a56c0fedd160	\N
eea_tvv_range_c15884f371d35784afe732ba	eea_hist_cbdce1f951cc0e6d76377da2	\N
eea_tvv_range_71f48502b588565e963bdb55	eea_hist_e7a6e88e644a5ba55b2d3258	\N
eea_tvv_range_71f48502b588565e963bdb55	eea_hist_7e9013f59765df63d8f9089c	\N
eea_tvv_range_71f48502b588565e963bdb55	eea_hist_a5f8ccbad4af9620b538a9da	\N
eea_tvv_range_7dea63529216382fb92e704d	eea_hist_acff656b379b33b024f68d61	\N
eea_tvv_range_7dea63529216382fb92e704d	eea_hist_ade0809bdffa0a5373912263	\N
eea_tvv_range_7dea63529216382fb92e704d	eea_hist_85cd7fc6e8eceef988e8b271	\N
eea_tvv_range_be210c61be7864f45166c845	eea_hist_1ea382e4cb94a0e6e450b471	\N
eea_tvv_range_be210c61be7864f45166c845	eea_hist_f1921d6b1f05764f3844861a	\N
eea_tvv_range_be210c61be7864f45166c845	eea_hist_263bd46dfb385e8580ac44fb	\N
eea_tvv_range_be210c61be7864f45166c845	eea_hist_f75fbcc5e87d0494e4445e79	\N
eea_tvv_range_33815a74b8b9d22fc5deab9f	eea_hist_1eae8dfd02b3423506e6e123	\N
eea_tvv_range_33815a74b8b9d22fc5deab9f	eea_hist_26232f4bcea9eb1d30cd00a1	\N
eea_tvv_range_33815a74b8b9d22fc5deab9f	eea_hist_789a63926b19124a7bf6dee6	\N
eea_tvv_range_33815a74b8b9d22fc5deab9f	eea_hist_578eabed77c0ed7ef72899e4	\N
eea_tvv_range_9ddf8eda695c93def32b4813	eea_hist_19153f614621791d557b0875	\N
eea_tvv_range_9ddf8eda695c93def32b4813	eea_hist_04951a0af1d36468df9d0c3c	\N
eea_tvv_range_9ddf8eda695c93def32b4813	eea_hist_2afa5619449a0b9dac51a585	\N
eea_tvv_range_8725ca343c7de9e096d2b4d6	eea_hist_9dc84eaa43d83816fdced328	\N
eea_tvv_range_8725ca343c7de9e096d2b4d6	eea_hist_57447ff1af7e42b6edf3e052	\N
eea_tvv_range_39b37c7f45728a0e61f90ee5	eea_hist_a96b29ac50b86faa0cadddb8	\N
eea_tvv_range_39b37c7f45728a0e61f90ee5	eea_hist_dcca5209a8b28acc43b439ab	\N
eea_tvv_range_39b37c7f45728a0e61f90ee5	eea_hist_66e4a4d894d46dda2bc1b33e	\N
eea_tvv_range_5fabe29bd4ef8b87e780771d	eea_hist_8acf2fd81835c6c5e9796621	\N
eea_tvv_range_5fabe29bd4ef8b87e780771d	eea_hist_cb54ef5715b41622f709093b	\N
eea_tvv_range_5fabe29bd4ef8b87e780771d	eea_hist_527ec82b162eeeb7052ae162	\N
eea_tvv_range_7e6fbc09e01c0ac2ba6f3bfe	eea_hist_f2ff7eaa9dc117e2b4f2163b	\N
eea_tvv_range_7e6fbc09e01c0ac2ba6f3bfe	eea_hist_1ed671f98c7e96fbd8a43a0f	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_15691fec16fb82fe3d773ef4	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_bc8ab4017e93f115d3d81764	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_b3d11e05852f85a5d75cfbe9	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_927c46343d24b8d0d9a9dd3c	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_c1e6455eb044c199261dacf9	\N
eea_tvv_range_dfb6faec7dfc310805fc0b79	eea_hist_910a6fc2b3a76187d37bb28f	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_273b1d74dbe32ce617cb755e	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_c9ade4fc841cfff0fb392815	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_10bcfe76810a53a1a9e17802	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_09d2a98dc96cd0c002a0efcc	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_2c57cd8e62380bcd675777c4	\N
eea_tvv_range_2703d5f539feda4c6e611d72	eea_hist_43c285bada2b7b36ec25597e	\N
eea_tvv_range_6dc517bf762d8fa389fa3ec6	eea_hist_f6001e2f2b25c9d712084e0e	\N
eea_tvv_range_6dc517bf762d8fa389fa3ec6	eea_hist_324e3ee0a39700d7084249a8	\N
eea_tvv_range_6dc517bf762d8fa389fa3ec6	eea_hist_c15f32a43c27de06bfb4ec72	\N
eea_tvv_range_6dc517bf762d8fa389fa3ec6	eea_hist_01cac94140bb7f2fd6c4989e	\N
eea_tvv_range_7c03ea30795e24d2b2695699	eea_hist_9c8be6421bb69cccb8df1d8c	\N
eea_tvv_range_7c03ea30795e24d2b2695699	eea_hist_661de62138cb7e33752d86d5	\N
eea_tvv_range_7c03ea30795e24d2b2695699	eea_hist_b7bb7c7fe565c2f50e3e0aad	\N
eea_tvv_range_7c03ea30795e24d2b2695699	eea_hist_4dea3603558db15ce046cb60	\N
eea_tvv_range_7c03ea30795e24d2b2695699	eea_hist_8a405eb28fcfea5ff11c4302	\N
eea_tvv_range_08012612ed7088243e005ff2	eea_hist_71ab0fa4d0b337ee4c4a56dd	\N
eea_tvv_range_08012612ed7088243e005ff2	eea_hist_105d6c1b9389ef4d212f9c70	\N
eea_tvv_range_08012612ed7088243e005ff2	eea_hist_8b3930487577fb8a1a8be8b2	\N
eea_tvv_range_262fee037e55ee7b09de5731	eea_hist_6cac64a2a00a4d9d1519686b	\N
eea_tvv_range_262fee037e55ee7b09de5731	eea_hist_6f037beed51e21a6b0b7e93f	\N
eea_tvv_range_262fee037e55ee7b09de5731	eea_hist_e0eac6e9f12680c098e734a1	\N
eea_tvv_range_f8ad1da4b99d8e4b3b5a30bf	eea_hist_44796cb651d5e5ffd171df04	\N
eea_tvv_range_f8ad1da4b99d8e4b3b5a30bf	eea_hist_e3cf859619a548d1e09ce2f0	\N
eea_tvv_range_f8ad1da4b99d8e4b3b5a30bf	eea_hist_7ec129abd4dcda2aafae1baa	\N
eea_tvv_range_7fb7cf04080d451fe9c90828	eea_hist_406be57e50f8521c5497e986	\N
eea_tvv_range_7fb7cf04080d451fe9c90828	eea_hist_0a3298e35838f58bc015c277	\N
eea_tvv_range_7fb7cf04080d451fe9c90828	current_cluster:30076111b53ae0c1fba9d111223dedef	791
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_223e8fe763aefcb9fed80234	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_eb705fc5cd8d3621cb069e51	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_d11b31eee16426eb5614f377	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_4f00c3e9035928b1bcb567dc	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_5689b2487958841a153960ce	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_aa3665c9d3b19157cf9232c6	\N
eea_tvv_range_6be3da42424b50593ca5a8c3	eea_hist_88e0b2534d86fd373df635d8	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_963f011c7068a7c8de38abaf	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_f19f439b8d435873f5dd69f9	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_f8f4a918d6bb080234454ba8	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_2fbdeed2fa81d907f94db152	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_038163a1fde13cd7e42005c8	\N
eea_tvv_range_adeb136a459d81e33856670e	eea_hist_8992aa6d538785251c1cb1dc	\N
eea_tvv_range_6f457986ac2202ba585dfd12	eea_hist_c63177be35668e53e8c57a02	\N
eea_tvv_range_6f457986ac2202ba585dfd12	eea_hist_58644007b66802e293544232	\N
eea_tvv_range_6f457986ac2202ba585dfd12	eea_hist_957070901f8c1f86751a5500	\N
eea_tvv_range_6f457986ac2202ba585dfd12	eea_hist_79cf045f6d5a34e8135084cf	\N
eea_tvv_range_b8c5b3b7364fb7d96e8d849c	eea_hist_48fffde8b3900f6f0cccc081	\N
eea_tvv_range_b8c5b3b7364fb7d96e8d849c	eea_hist_507f81df05c25e7ae5ed88d8	\N
eea_tvv_range_b8c5b3b7364fb7d96e8d849c	eea_hist_823549ac5732c442528afa0a	\N
eea_tvv_range_b8c5b3b7364fb7d96e8d849c	eea_hist_aba09cd01c9f531595bc2e90	\N
eea_tvv_range_c62bacff2a7a3481f4e295ad	eea_hist_6189222287d187031c8144d5	\N
eea_tvv_range_c62bacff2a7a3481f4e295ad	eea_hist_a152fd7d369ddc3747c2633b	\N
eea_tvv_range_c62bacff2a7a3481f4e295ad	eea_hist_a5163fb4e17d706cbc9ecd94	\N
eea_tvv_range_c62bacff2a7a3481f4e295ad	eea_hist_dde4a4bf08e4351f14c7ed1d	\N
eea_tvv_range_ec1da0e884869b52328a1859	eea_hist_5c6c1bfbde5504311a45891f	\N
eea_tvv_range_ec1da0e884869b52328a1859	eea_hist_cf3d897fda77343c4f07ddd2	\N
eea_tvv_range_ec1da0e884869b52328a1859	eea_hist_794e193e43ddc6ba93a5280f	\N
eea_tvv_range_ec1da0e884869b52328a1859	eea_hist_cc2cc7bbfdafc3ba095ff2fc	\N
eea_tvv_range_ec1da0e884869b52328a1859	eea_hist_3af0f9cb709310ee26904d83	\N
eea_tvv_range_afeffea9669194bba6737d70	eea_hist_be2c99c15d2c4a4cdd4f1db5	\N
eea_tvv_range_afeffea9669194bba6737d70	eea_hist_e9283bd85f9799bc590a2827	\N
eea_tvv_range_afeffea9669194bba6737d70	eea_hist_8b7bcfb1900b3700fd32c371	\N
eea_tvv_range_afeffea9669194bba6737d70	eea_hist_c6b06c0b4e3b77ba1937ace0	\N
eea_tvv_range_2e81e7ce8bb923f0f9791cba	eea_hist_63fddbb92a1997e0db0f82ce	\N
eea_tvv_range_2e81e7ce8bb923f0f9791cba	eea_hist_4bad50f0ed130d68bc0193a1	\N
eea_tvv_range_2e81e7ce8bb923f0f9791cba	eea_hist_ccaaf9adf069220bae9fab8a	\N
eea_tvv_range_2e81e7ce8bb923f0f9791cba	eea_hist_1172c47c41654cc0edbd4751	\N
eea_tvv_range_d7268df3fd5b27442e5ee0c4	eea_hist_e0f5a129f35d4881ad0b6211	\N
eea_tvv_range_d7268df3fd5b27442e5ee0c4	eea_hist_1d91803109c99f42987ac707	\N
eea_tvv_range_f729de4f3aec95a68ec93d7a	eea_hist_abd68e9feef307e2bc2d8759	\N
eea_tvv_range_f729de4f3aec95a68ec93d7a	eea_hist_778fa42f0696077a948c8b27	\N
eea_tvv_range_f729de4f3aec95a68ec93d7a	current_cluster:0cc22823f5c587b4c762f6ea74d9f3f1	91
eea_tvv_range_7bb3d3d5e5b6c7d7e0110f69	eea_hist_2ad34fae51f70bb07503f9fb	\N
eea_tvv_range_7bb3d3d5e5b6c7d7e0110f69	eea_hist_babe1583d7505cb887bd9c9f	\N
eea_tvv_range_7bb3d3d5e5b6c7d7e0110f69	eea_hist_d54d80e74879dd533f472fb0	\N
eea_tvv_range_c20e93b3974cc666f08ab9bd	eea_hist_6f80901ee0b480fc2ef43740	\N
eea_tvv_range_c20e93b3974cc666f08ab9bd	eea_hist_90a47cf11d0cbcd486bd4e43	\N
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_b26cc6ef5dadb15a816f0cf2	\N
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_97243597a8f0bf14f6f81393	\N
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_8016913958886579714e767a	\N
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_7b345e88a92d9b73b9b21585	\N
eea_tvv_range_f7512dfa6d425ce2784f9769	eea_hist_872423e846d87edd86e5444e	\N
eea_tvv_range_5a2a23b7e1ee62757fb26704	eea_hist_adcac421ca4d3b96db090955	\N
eea_tvv_range_5a2a23b7e1ee62757fb26704	eea_hist_6af79055264e2d46bfc9d267	\N
eea_tvv_range_5a2a23b7e1ee62757fb26704	eea_hist_d2561aaa24029fd4ad7aa597	\N
eea_tvv_range_5a2a23b7e1ee62757fb26704	eea_hist_a9bf3552d2a59eb0c777eaa0	\N
eea_tvv_range_4f1effb0fd32c57553d7fe28	eea_hist_86f3733739ad0f9a72dd8608	\N
eea_tvv_range_4f1effb0fd32c57553d7fe28	eea_hist_b91b1ebb3505528b3f8f4cb4	\N
eea_tvv_range_f31c9493bda652a575830ba4	eea_hist_6c95d20bfee26c5eb8e81fbf	\N
eea_tvv_range_f31c9493bda652a575830ba4	eea_hist_19fef02352f35c87cc61c789	\N
eea_tvv_range_f31c9493bda652a575830ba4	eea_hist_fac44a27bc767abee1e7f804	\N
eea_tvv_range_ae95d8a999cd5fb7f09f4986	eea_hist_7e0f3bdd84b1abb68361965c	\N
eea_tvv_range_ae95d8a999cd5fb7f09f4986	eea_hist_e3112686ddfd432b77b11902	\N
eea_tvv_range_ae95d8a999cd5fb7f09f4986	eea_hist_aab9279a2801f3ad74997ed2	\N
eea_tvv_range_ae95d8a999cd5fb7f09f4986	eea_hist_19f4b9efc5a341c9a62c4816	\N
eea_tvv_range_40ac5e8177a0a71e42bfc541	eea_hist_eb64db39c5ba1ad948606678	\N
eea_tvv_range_40ac5e8177a0a71e42bfc541	eea_hist_79c31eeb5ec42487234e262a	\N
eea_tvv_range_40ac5e8177a0a71e42bfc541	current_cluster:60fd0fb9ac025a2ee35e5a6f86d7ce96	185
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_0da117f2344306277fbd2c1b	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_a8f81b6e2c2a1a26da361414	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_fdec54594726b57725bb25cc	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_10a877189d7331bf1a8849c0	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_d451fc23010a9cb6b4ae9b1b	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_6e8e102b62370a9318c14a03	\N
eea_tvv_range_7a3e8a3e52d4cd980b334ff2	eea_hist_6b0eb7139f69fdf1e0b284eb	\N
eea_tvv_range_dd72d657ff7b61ecc833b541	eea_hist_fb30a70fa54f839b070e0f75	\N
eea_tvv_range_dd72d657ff7b61ecc833b541	eea_hist_15c0695306e008b1fcbe7db5	\N
eea_tvv_range_dd72d657ff7b61ecc833b541	eea_hist_cde19f4b53426fee0caf422e	\N
eea_tvv_range_dd72d657ff7b61ecc833b541	eea_hist_fa194adbef798ed8b679cb12	\N
eea_tvv_range_da46ffca628d9a548c25d8f2	eea_hist_01fffe33be043e3f170b8969	\N
eea_tvv_range_da46ffca628d9a548c25d8f2	eea_hist_be9dde3a18028a8837d232c4	\N
eea_tvv_range_da46ffca628d9a548c25d8f2	eea_hist_e794e1ed648361c774b5369f	\N
eea_tvv_range_da46ffca628d9a548c25d8f2	eea_hist_50a5fc343b63c61e5249ce37	\N
eea_tvv_range_cbc4f888b676f28f53f0d41a	eea_hist_f503d68f35419d1a61f8bc14	\N
eea_tvv_range_cbc4f888b676f28f53f0d41a	eea_hist_12ed49a59a509483c6870488	\N
eea_tvv_range_cbc4f888b676f28f53f0d41a	eea_hist_4469d9d01e077fcf2666c048	\N
eea_tvv_range_cbc4f888b676f28f53f0d41a	eea_hist_2043a26d5c92545f725c13b0	\N
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_d7801068ee15c0cce82fdc9f	\N
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_249e631423b5d729464aa53c	\N
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_66d870e257a7dd724a20dd92	\N
eea_tvv_range_cdce12a12268c97f28303552	eea_hist_d9d1bec9171142253ac37f0d	\N
eea_tvv_range_165c8dc37059882bdc5bd9a4	eea_hist_227d867ae591cf55db42ed37	\N
eea_tvv_range_165c8dc37059882bdc5bd9a4	eea_hist_ec70b2b243466bb00f3c4045	\N
eea_tvv_range_165c8dc37059882bdc5bd9a4	eea_hist_83cece543e93c0741a77f11a	\N
eea_tvv_range_165c8dc37059882bdc5bd9a4	eea_hist_1bda14e05b486b96e7debac8	\N
eea_tvv_range_165c8dc37059882bdc5bd9a4	eea_hist_d0d54ec88a2b3169e40074fd	\N
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_ca563c55fba2c38627af5609	\N
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_6fb7ded38190650516e99662	\N
eea_tvv_range_daefa926387cd565c9f84c5c	eea_hist_5d018713a7e0cdc48422541e	\N
eea_tvv_range_e6ba66e4eaca4724bc09893e	eea_hist_1a8b0089f78bfeca36ab7563	\N
eea_tvv_range_e6ba66e4eaca4724bc09893e	eea_hist_fbcf1a7c29b442c2d46ea976	\N
eea_tvv_range_e6ba66e4eaca4724bc09893e	eea_hist_f0908830811c99fb780de686	\N
eea_tvv_range_659164701e0925e03e90484f	eea_hist_b1a37ead084842963103636f	\N
eea_tvv_range_659164701e0925e03e90484f	eea_hist_ba2b63652443818f038e1a70	\N
eea_tvv_range_659164701e0925e03e90484f	eea_hist_74d3a44c318c03bab3a1c680	\N
eea_tvv_range_2c28cd29a5abae9b06d9e166	eea_hist_24192dd468435a457803f20f	\N
eea_tvv_range_2c28cd29a5abae9b06d9e166	eea_hist_6d84e200699c28658b649667	\N
eea_tvv_range_a7610cdbc83cc0dce98454a6	eea_hist_eaafb5bafe7f80c0b00f09e2	\N
eea_tvv_range_a7610cdbc83cc0dce98454a6	eea_hist_223923e87271686458d6ec3d	\N
eea_tvv_range_874358e15df2bfb81439d115	eea_hist_cff3cd6eebb85e2471bda36b	\N
eea_tvv_range_874358e15df2bfb81439d115	eea_hist_7e250dae14cf782d47600816	\N
eea_tvv_range_a0ed297bd2f7b91d9b0863b2	eea_hist_cf025c9c084e483a901a288e	\N
eea_tvv_range_a0ed297bd2f7b91d9b0863b2	eea_hist_951ead24c0078dc69f636363	\N
eea_tvv_range_a0ed297bd2f7b91d9b0863b2	eea_hist_86232d757316cef242664a40	\N
eea_tvv_range_0c8677b685cedabe128946b5	eea_hist_cb671d703e01f8849a3155df	\N
eea_tvv_range_0c8677b685cedabe128946b5	eea_hist_3bdac1b9f42d6d1a8a84b3e3	\N
eea_tvv_range_b8a6c445015a8c030a42285a	eea_hist_49b3e6c39e0fa30c324512fb	\N
eea_tvv_range_b8a6c445015a8c030a42285a	eea_hist_45d05bbcd7a47fb8bec73e35	\N
eea_tvv_range_dd56cfdd39071b8a1d42d563	eea_hist_ac9136df0b21ef134367955d	\N
eea_tvv_range_dd56cfdd39071b8a1d42d563	eea_hist_e33ec83f32ce2cf03785ce9b	\N
eea_tvv_range_dd56cfdd39071b8a1d42d563	eea_hist_9484ddcb1fd0ad61e1e05fdf	\N
eea_tvv_range_aa02672758516804616f99fe	eea_hist_7b9f45fdc367c1db05bfb0a3	\N
eea_tvv_range_aa02672758516804616f99fe	eea_hist_805ec969fa2db340fc23b817	\N
eea_tvv_range_aa02672758516804616f99fe	eea_hist_df63eb2b53e8d78f08bf264f	\N
eea_tvv_range_aa02672758516804616f99fe	current_cluster:76ff04bb3f00e528190c213d42a4da5c	450
eea_tvv_range_aa02672758516804616f99fe	current_cluster:9f5d89b7eb8aea8a399adfe0fe1cc18f	450
eea_tvv_range_a0072556379ea3c5219f0cd3	eea_hist_cb2a7e6fd2543d7961068e7a	\N
eea_tvv_range_a0072556379ea3c5219f0cd3	eea_hist_bd4c35394b56165e77e294a4	\N
eea_tvv_range_a0072556379ea3c5219f0cd3	current_cluster:fad80df95067a78f4e101f94bc8c8024	452
eea_tvv_range_a0072556379ea3c5219f0cd3	current_cluster:8f7bc3a900ae136a184a82e6ab994430	452
eea_tvv_range_3f32eda92652669e360df934	eea_hist_aff4e89562c9227777c25167	\N
eea_tvv_range_3f32eda92652669e360df934	eea_hist_3a7ee4b6783b24c0decf53fc	\N
eea_tvv_range_3f32eda92652669e360df934	eea_hist_f25689707286cd7f5970c241	\N
eea_tvv_range_3f32eda92652669e360df934	eea_hist_5bb15d3fd1694ef0edb15e90	\N
eea_tvv_range_3f32eda92652669e360df934	eea_hist_dff969a57a7e3f2db5c52200	\N
eea_tvv_range_3f32eda92652669e360df934	eea_hist_8786a3d1f5732a664a55b77b	\N
eea_tvv_range_9e29a4adddfbbc0107923eb8	eea_hist_337807a5abae10f645a86f17	\N
eea_tvv_range_9e29a4adddfbbc0107923eb8	eea_hist_172f09ceb306570d0bcae5bc	\N
eea_tvv_range_9e29a4adddfbbc0107923eb8	eea_hist_6614dc42707cddce132ad2fb	\N
eea_tvv_range_d16021089daa3ee7144b1595	eea_hist_02035edff58e66618828b145	\N
eea_tvv_range_d16021089daa3ee7144b1595	eea_hist_f5f213b38f4a39ac17081098	\N
eea_tvv_range_d16021089daa3ee7144b1595	eea_hist_58c2011c2ab7466adc0b6bcd	\N
eea_tvv_range_82e2a42100e5598717b93a6a	eea_hist_66c96d05dd492c16fb90fa59	\N
eea_tvv_range_82e2a42100e5598717b93a6a	eea_hist_6904053cf24c31c56bdcbdfb	\N
eea_tvv_range_82e2a42100e5598717b93a6a	eea_hist_fe48e8a43817719a8418dc9c	\N
eea_tvv_range_82e2a42100e5598717b93a6a	eea_hist_9c1330d59668f92d411ddca2	\N
eea_tvv_range_82e2a42100e5598717b93a6a	eea_hist_efc49c096e7fd98d4cafa205	\N
eea_tvv_range_cd33446772e1af031c02c6fd	eea_hist_d854fa3bf3d51270df79ff96	\N
eea_tvv_range_cd33446772e1af031c02c6fd	eea_hist_ac4924fad706be553aee45cb	\N
eea_tvv_range_92c59c92d7b0a6fa9721deb5	eea_hist_dbdc686992deaebadef886ba	\N
eea_tvv_range_92c59c92d7b0a6fa9721deb5	eea_hist_49b267a41b047fd82ae106db	\N
eea_tvv_range_92c59c92d7b0a6fa9721deb5	eea_hist_5969df3ff997c96fbb086e29	\N
eea_tvv_range_9f3b38e988b8ac6e184145fe	eea_hist_448d227ec2108245017b3034	\N
eea_tvv_range_9f3b38e988b8ac6e184145fe	eea_hist_dff895c1d81550a2f088e696	\N
eea_tvv_range_9f3b38e988b8ac6e184145fe	eea_hist_277c3193a9bbceb331243ff6	\N
eea_tvv_range_03da31cdee93b763bad925a1	eea_hist_1506e46cd194b8a80a07355c	\N
eea_tvv_range_03da31cdee93b763bad925a1	eea_hist_aa8248f33dda8137a2669627	\N
eea_tvv_range_03da31cdee93b763bad925a1	eea_hist_193953b2028258d192a57efd	\N
eea_tvv_range_03da31cdee93b763bad925a1	eea_hist_158bf1b93416c075a2031c10	\N
eea_tvv_range_03da31cdee93b763bad925a1	eea_hist_9ac8d3ca6e19fb1ab5460c80	\N
eea_tvv_range_cd80c3d8144dc1b7c2711a44	eea_hist_53eacd462e468fb8ba4327da	\N
eea_tvv_range_cd80c3d8144dc1b7c2711a44	eea_hist_c121666427f6c489925a3853	\N
eea_tvv_range_cd80c3d8144dc1b7c2711a44	eea_hist_16e6c9eb9b80b618f36f7fc5	\N
eea_tvv_range_cd80c3d8144dc1b7c2711a44	eea_hist_f47ceaebb6c21bde68f7427a	\N
eea_tvv_range_b75b56ee951e0b7f0bef67ca	eea_hist_599cfe665c33205c1e859b7d	\N
eea_tvv_range_b75b56ee951e0b7f0bef67ca	eea_hist_d472b0eb3fba45aaf0d0d8ce	\N
eea_tvv_range_b75b56ee951e0b7f0bef67ca	eea_hist_f5bdbf30c30c5cb0f099ff84	\N
eea_tvv_range_b75b56ee951e0b7f0bef67ca	eea_hist_e2f25d7b180eea872d8bcaab	\N
eea_tvv_range_2567805fa9d6d1a907c7adf7	eea_hist_d05f422df8260e0d14958b92	\N
eea_tvv_range_2567805fa9d6d1a907c7adf7	eea_hist_1d2d23c09b86c578458b95d2	\N
eea_tvv_range_2567805fa9d6d1a907c7adf7	eea_hist_a5bc1a460c5cf81809cf8f0e	\N
eea_tvv_range_323f55ee85aa0efcb18f0d9e	eea_hist_b58725586fd2490bfdcbfa3f	\N
eea_tvv_range_323f55ee85aa0efcb18f0d9e	eea_hist_6dd1371953f11bdc301877fc	\N
eea_tvv_range_323f55ee85aa0efcb18f0d9e	eea_hist_bd56bb1a9f867e21ab3b254e	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_71576243aacb2ecaa5e12f37	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_b90e9a5c95325e48e40013e4	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_884d91d99c19b3a88eb82244	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_b3df50128f428fe8438b83ca	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_eebfb01ba1467511524a300a	\N
eea_tvv_range_21514e093a29f2025ca8a4d5	eea_hist_6d9ad425eda6c68ebf4a700a	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_18367c256b5215f2737b19cf	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_b2e7e59752251fac3d4553ef	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_3925812891fdb6ba5cc5c17d	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_fddb03a5cdc026ea902e9772	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_7176224eaa06c9ec47d67666	\N
eea_tvv_range_d4b044334a720ec9a9206d22	eea_hist_39463afa54be9b0aefa7e6f6	\N
eea_tvv_range_face50e632885766e2fc877c	eea_hist_37a98afb476d651a614e6d08	\N
eea_tvv_range_face50e632885766e2fc877c	eea_hist_0320802b5443b07606be7e76	\N
eea_tvv_range_face50e632885766e2fc877c	eea_hist_f966fd6d5bfe4479dbac07fb	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_7a4377de953d83cd24754373	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_19435547ddf43bdae5354e0d	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_c072b5703f6be57cafc2c73e	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_2df1815e05e15dab164fa328	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_6d533320d26962f4e1ecff94	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_4ca8a13474efe7b72bb762c0	\N
eea_tvv_range_34396baea8d755c52e7595b6	eea_hist_741d9df113e986f65b675bc8	\N
eea_tvv_range_7e3c739cbd505121f3d39694	eea_hist_3f7634715cb7818a5a9b5b6d	\N
eea_tvv_range_7e3c739cbd505121f3d39694	eea_hist_aab3b57e9371434ea95fddbb	\N
eea_tvv_range_7e3c739cbd505121f3d39694	eea_hist_179bb7e02b0a3f4c547cc7ba	\N
eea_tvv_range_c1e904dbe7caaefb2c3b2b2c	eea_hist_0c50dc3f37c1e6535178521c	\N
eea_tvv_range_c1e904dbe7caaefb2c3b2b2c	eea_hist_def84a1b713be6d5ffb485ec	\N
eea_tvv_range_c1e904dbe7caaefb2c3b2b2c	eea_hist_d3b4e5c113c71ace35f9e740	\N
eea_tvv_range_2db82929d7de1571a31b1246	eea_hist_c35b4e39198ed46d2e5e958b	\N
eea_tvv_range_2db82929d7de1571a31b1246	eea_hist_a77a446d9803eee7c222e8ea	\N
eea_tvv_range_7f465d523a3ac0379231edfb	eea_hist_24f36ef676569b169ca93b5a	\N
eea_tvv_range_7f465d523a3ac0379231edfb	eea_hist_5c8b2e92402e41a9b3a14eb2	\N
eea_tvv_range_7f465d523a3ac0379231edfb	current_cluster:a39604393673bb875a3620b89d0e911f	409
eea_tvv_range_6461bd058a65f36ae6ed528b	eea_hist_d315f208fd92a5c4ae3397ab	\N
eea_tvv_range_6461bd058a65f36ae6ed528b	eea_hist_89140b56abf2294b837b4428	\N
eea_tvv_range_6461bd058a65f36ae6ed528b	eea_hist_6aebbbeb2ec2a4d4f3c2bb48	\N
eea_tvv_range_5494c5197acde5744aa43700	eea_hist_f4ad9120357fd921c35b6022	\N
eea_tvv_range_5494c5197acde5744aa43700	eea_hist_319d9372caa4d8c43cfbfe65	\N
eea_tvv_range_5494c5197acde5744aa43700	eea_hist_1a0876fa84f7e5e135d05028	\N
eea_tvv_range_5494c5197acde5744aa43700	eea_hist_ab1139f18928d6c6703c3a9a	\N
eea_tvv_range_5bb5b424bf86aeb91d156e85	eea_hist_44ede316f500c8c6d06115f8	\N
eea_tvv_range_5bb5b424bf86aeb91d156e85	eea_hist_ac6705907290b7b31cb48b3e	\N
eea_tvv_range_5bb5b424bf86aeb91d156e85	eea_hist_308e17c6d03c749c7c25e6af	\N
eea_tvv_range_18ae29972b003bd89fa11d83	eea_hist_0c7d9ad4f4c586f9e800bed4	\N
eea_tvv_range_18ae29972b003bd89fa11d83	eea_hist_a3f98baa00de7b32e3551069	\N
eea_tvv_range_18ae29972b003bd89fa11d83	eea_hist_7fa4984751620e022284768f	\N
eea_tvv_range_ed9c07725130f34a96d850b9	eea_hist_1df5b877baef7f2d30000e73	\N
eea_tvv_range_ed9c07725130f34a96d850b9	eea_hist_1eac292ea6882f13debe919c	\N
eea_tvv_range_ed9c07725130f34a96d850b9	eea_hist_107825369ed4efc671310ced	\N
eea_tvv_range_21b426a0bebb2cf74b2b803b	eea_hist_0c3a526134393c189eef012e	\N
eea_tvv_range_21b426a0bebb2cf74b2b803b	eea_hist_1e497aa0b165d5d2f85e5987	\N
eea_tvv_range_21b426a0bebb2cf74b2b803b	current_cluster:daa22182618a782a9a5a26288a824e5e	658
eea_tvv_range_21b426a0bebb2cf74b2b803b	eea_hist_81c42bbe1c07330dc00adcd6	\N
eea_tvv_range_21b426a0bebb2cf74b2b803b	current_cluster:e47ae7f87a17f2eecfff1702abeba81e	658
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_23ea0f9d54f624f8e529ade9	\N
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_19577767534f5e334e89cc41	\N
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_354ce93f42deda42c89f9690	\N
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_451c0ee4a7c4d618c0d49074	\N
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_0c1149e2fbc4e6eec32e4a3b	\N
eea_tvv_range_83db8db21fbf899818362ee0	eea_hist_0fb0a23ddc49d99981e2d3c4	\N
eea_tvv_range_828c820efb603fcb63595641	eea_hist_9c976f9ec71a2f78486da1fa	\N
eea_tvv_range_828c820efb603fcb63595641	eea_hist_a9236cca9539755790e32d16	\N
eea_tvv_range_828c820efb603fcb63595641	eea_hist_5672c8992ce7ec075005895a	\N
eea_tvv_range_828c820efb603fcb63595641	eea_hist_2263905219f782ebc9b0022d	\N
eea_tvv_range_828c820efb603fcb63595641	eea_hist_927e89b219a7b3a481cffa55	\N
eea_tvv_range_634e893bb103f135475354f7	eea_hist_186deeefdf74d02a1d0d9843	\N
eea_tvv_range_634e893bb103f135475354f7	eea_hist_9135c03ce0c3ea8b23e824af	\N
eea_tvv_range_634e893bb103f135475354f7	eea_hist_99da0fbfa5d964be198f88ea	\N
eea_tvv_range_5d7733993f7f0f9c37a9533a	eea_hist_ae5940d6d693819085046acb	\N
eea_tvv_range_5d7733993f7f0f9c37a9533a	eea_hist_4b05ba3cc05813a95e19daab	\N
eea_tvv_range_5d7733993f7f0f9c37a9533a	eea_hist_76cceb14e6e057f09fc21cec	\N
eea_tvv_range_ff83279fb31a0ca83143007f	eea_hist_07244a7e534b7c95e8395ad9	\N
eea_tvv_range_ff83279fb31a0ca83143007f	eea_hist_14a2d4661cbc17a531d53c25	\N
eea_tvv_range_ff83279fb31a0ca83143007f	eea_hist_8afa9943a75d004b5c0e5300	\N
eea_tvv_range_ff83279fb31a0ca83143007f	eea_hist_aeb99c24b39f9fd7c0ad6f81	\N
eea_tvv_range_f4120ad42efc8a56b570a1f9	eea_hist_69082391cb49335e137e127c	\N
eea_tvv_range_f4120ad42efc8a56b570a1f9	eea_hist_28ccdd609cba41e5819042fe	\N
eea_tvv_range_f4120ad42efc8a56b570a1f9	eea_hist_39ca8524a56bad569191c55a	\N
eea_tvv_range_a837abf2c62dcc78e1397446	eea_hist_7da7d5f12ed29fdea758385a	\N
eea_tvv_range_a837abf2c62dcc78e1397446	eea_hist_fe4e31e8cea8ee2219a704c1	\N
eea_tvv_range_a837abf2c62dcc78e1397446	eea_hist_57e3b16a3201a64b6d4fdfae	\N
eea_tvv_range_e223a12d60c4aa5b14025beb	eea_hist_5aefad981997ddaf2afa8d79	\N
eea_tvv_range_e223a12d60c4aa5b14025beb	eea_hist_2a61cd242e7663641d0464c1	\N
eea_tvv_range_e223a12d60c4aa5b14025beb	eea_hist_355fd83fdead646b873944f4	\N
eea_tvv_range_e8bebe1dd89b26bcf2b936ca	eea_hist_f664ede7957955d6dbaafcaa	\N
eea_tvv_range_e8bebe1dd89b26bcf2b936ca	eea_hist_d26b6a8c6db0fb3cdd6519ce	\N
eea_tvv_range_e8bebe1dd89b26bcf2b936ca	eea_hist_e55a5dc32f77e6824eb8ec9d	\N
eea_tvv_range_7c5d4faeb6b4f03cac209505	eea_hist_63e6ef79f40e24277affc20f	\N
eea_tvv_range_7c5d4faeb6b4f03cac209505	eea_hist_cb8d3920f807dbf57398138c	\N
eea_tvv_range_7c5d4faeb6b4f03cac209505	eea_hist_1ceb438866de1e603d3086c7	\N
eea_tvv_range_7c5d4faeb6b4f03cac209505	eea_hist_7db1588b2033516932271fdc	\N
eea_tvv_range_f800c457cd2bbf1371d477df	eea_hist_845de2725ad0ca0d8746a09b	\N
eea_tvv_range_f800c457cd2bbf1371d477df	eea_hist_396bb2e3b803a9fbdcef11ed	\N
eea_tvv_range_f800c457cd2bbf1371d477df	eea_hist_c0b7c60a3277aa29058056da	\N
eea_tvv_range_b45ff59f2cc575a44fa895ed	eea_hist_cdbd021b4535e1e47ed553f8	\N
eea_tvv_range_b45ff59f2cc575a44fa895ed	eea_hist_403575f2f1007e8a622d8c2c	\N
eea_tvv_range_b45ff59f2cc575a44fa895ed	eea_hist_2ad24bba89074da93edf7495	\N
eea_tvv_range_b90b8e4d5cbbae0b060704cb	eea_hist_45122f7cfeadf3577a363ea1	\N
eea_tvv_range_b90b8e4d5cbbae0b060704cb	eea_hist_b19d24630cf41cdde58011ac	\N
eea_tvv_range_b90b8e4d5cbbae0b060704cb	eea_hist_dc7810b17614cc02fc06de01	\N
eea_tvv_range_b3d0600b391367428cb145ec	eea_hist_f45d95d2be2b7ea21b2bb530	\N
eea_tvv_range_b3d0600b391367428cb145ec	eea_hist_2c7be7be5dc0ef14da6af795	\N
eea_tvv_range_b3d0600b391367428cb145ec	eea_hist_b31bbc6003f8894e43ea31c9	\N
eea_tvv_range_25c9143c59824582d7f5a05c	eea_hist_7bc18704e816c9af449b1735	\N
eea_tvv_range_25c9143c59824582d7f5a05c	eea_hist_05cb1287a7115ac8aa544520	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_589d143536fb3083ab337efd	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_c350eec0750bc93cd340085f	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_d3c74f5b0ae0d52903b3a1ee	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_8cc70a65112d531bf6038057	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_ef6d1802437ad8ff65ca9a17	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_29c184bd3005cadd4f0c9779	\N
eea_tvv_range_361c2f4383be5d4cf773ba0b	eea_hist_1afef27174e1ebde6e613818	\N
eea_tvv_range_b395d899258f8adc96c056b7	eea_hist_d0b8b17848e1ffbc3cd43dfd	\N
eea_tvv_range_b395d899258f8adc96c056b7	eea_hist_30e9356ca37759eec8508f86	\N
eea_tvv_range_b395d899258f8adc96c056b7	eea_hist_1023eb2e2e0d5047e34bad52	\N
eea_tvv_range_6812be04d4a4e5d1462977b7	eea_hist_7dd33e91daa546d0295c30ab	\N
eea_tvv_range_6812be04d4a4e5d1462977b7	eea_hist_17d7f138b45f55027b38a054	\N
eea_tvv_range_6812be04d4a4e5d1462977b7	eea_hist_a2d4fb9fe52833290d410543	\N
eea_tvv_range_6812be04d4a4e5d1462977b7	eea_hist_1b10a8f7be6d779c33ff6007	\N
eea_tvv_range_e8207ccf2af3d3e7486b0dce	eea_hist_c0b8c58e537abc85d4de7e8b	\N
eea_tvv_range_e8207ccf2af3d3e7486b0dce	eea_hist_8905b58c4cb349f701b5d1aa	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_0c79b6856fceace7a94664d3	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_4330412bf8dfa7c7dd181868	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_cd0e97f11dee2f4f077d7e2a	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_210111823592aef76089f190	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_e1bdb15d7240adef7b7da2fa	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	eea_hist_cabd44b1122e3333386c1646	\N
eea_tvv_range_0a49735dca5feeb4da4e6c7e	current_cluster:d49edba21b84525291fe4f03f759bf93	1129
eea_tvv_range_60b49c99952ed85f9380cebd	eea_hist_54caa3b9d6acbcf889e08d4a	\N
eea_tvv_range_60b49c99952ed85f9380cebd	eea_hist_c918ca77d9e87f441904634a	\N
eea_tvv_range_60b49c99952ed85f9380cebd	eea_hist_7803bc1bc47d4e0348f2419a	\N
eea_tvv_range_cdd35acc7d35f1dd1b4f78ae	eea_hist_cb9adf9fe5c61ca7857ce8a3	\N
eea_tvv_range_cdd35acc7d35f1dd1b4f78ae	eea_hist_84ac6ba85b73b2c8a3be691c	\N
eea_tvv_range_cdd35acc7d35f1dd1b4f78ae	eea_hist_89215f4ab5d5a0896889b065	\N
eea_tvv_range_f6c5e2ac5739dfdeb86c3152	eea_hist_945f1a15ef69a183a4182966	\N
eea_tvv_range_f6c5e2ac5739dfdeb86c3152	eea_hist_60e4001dcddf107b05fdc998	\N
eea_tvv_range_5ebe031a972e1f9bb2060a3b	eea_hist_babecd5a7fa57bf4d334465e	\N
eea_tvv_range_5ebe031a972e1f9bb2060a3b	eea_hist_b6e2c277e9ef571c15e6a146	\N
eea_tvv_range_5ebe031a972e1f9bb2060a3b	eea_hist_84278d53803c1b799bd957f3	\N
eea_tvv_range_5ebe031a972e1f9bb2060a3b	eea_hist_2af38598187242c7455e1590	\N
eea_tvv_range_b460f042d8e19c1d5d349d61	eea_hist_60adb2e88ebb9e59cf243be1	\N
eea_tvv_range_b460f042d8e19c1d5d349d61	eea_hist_9099103e0b91f05ded7fc617	\N
eea_tvv_range_b460f042d8e19c1d5d349d61	eea_hist_c30fa513eeb8e98047df77d3	\N
eea_tvv_range_7491f45e23d5da905e41ca7d	eea_hist_e36a9db7e46d8c53534a52d2	\N
eea_tvv_range_7491f45e23d5da905e41ca7d	eea_hist_06c745b0f6d13220526887fd	\N
eea_tvv_range_7491f45e23d5da905e41ca7d	eea_hist_d86b28c1561c2512c9a75645	\N
eea_tvv_range_af8c20bf063ff44ee91816ff	eea_hist_9722f496f947f3a48b53d084	\N
eea_tvv_range_af8c20bf063ff44ee91816ff	eea_hist_244d33f94b4d9c32bc10a30b	\N
eea_tvv_range_af8c20bf063ff44ee91816ff	eea_hist_044803490fae6f754a61286d	\N
eea_tvv_range_af8c20bf063ff44ee91816ff	eea_hist_67e877bfa986caf8f9c656d4	\N
eea_tvv_range_c76ac680b6f9f73f7ace5bf1	eea_hist_b9e74aeb8a22a0cd1f7defd4	\N
eea_tvv_range_c76ac680b6f9f73f7ace5bf1	eea_hist_64a767401fe96628879dbe61	\N
eea_tvv_range_c76ac680b6f9f73f7ace5bf1	eea_hist_280285453e8d05644f7f6825	\N
eea_tvv_range_e69b9289445449c4cc00830f	eea_hist_c6819078dc1ef9fa8c407b14	\N
eea_tvv_range_e69b9289445449c4cc00830f	eea_hist_54a9754a474ab463c38e413a	\N
eea_tvv_range_e69b9289445449c4cc00830f	eea_hist_e5c10820e7150df030406b2b	\N
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_6a8e3c9e86c9fcb5d3878d6c	\N
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_30a76bd32cf44a1f4d4f2a6a	\N
eea_tvv_range_6fe7492008c05b1f436dcfbc	eea_hist_fc584a656ba888eeca3b0ea1	\N
eea_tvv_range_f40a16088de29839b619ede0	eea_hist_88bbb3e105fe976240dbf60c	\N
eea_tvv_range_f40a16088de29839b619ede0	eea_hist_69ea22bc60a229348c79cf51	\N
eea_tvv_range_f40a16088de29839b619ede0	eea_hist_72d8c7aca6ab7b88ae80f16e	\N
eea_tvv_range_ab36d6175149363b9caf3ffe	eea_hist_c3d7ff5097a61f885b7f6240	\N
eea_tvv_range_ab36d6175149363b9caf3ffe	eea_hist_e6eb13bdea9405acb27d6a10	\N
eea_tvv_range_ab36d6175149363b9caf3ffe	eea_hist_d473ac7bd74ac653578be120	\N
eea_tvv_range_a193836c6f58080c7ecb9ae5	eea_hist_b5f0e2f8cdfc800603dea8ea	\N
eea_tvv_range_a193836c6f58080c7ecb9ae5	eea_hist_b688232271780d25152b78ee	\N
eea_tvv_range_a193836c6f58080c7ecb9ae5	eea_hist_2044d84725f8e419ba178897	\N
eea_tvv_range_a193836c6f58080c7ecb9ae5	eea_hist_e89517c98ca050d1b44498eb	\N
eea_tvv_range_da04b49648dfca9ff484ba6d	eea_hist_6fcaadc9490d77be45466511	\N
eea_tvv_range_da04b49648dfca9ff484ba6d	eea_hist_76d67f4aaa0c9d1fe63b0f18	\N
eea_tvv_range_da04b49648dfca9ff484ba6d	eea_hist_f5fcdb1d95c347896c6396c0	\N
eea_tvv_range_458df72a5994476d210d94fc	eea_hist_b5a1d9705a66637014b99fc0	\N
eea_tvv_range_458df72a5994476d210d94fc	eea_hist_6922cfd21b639590599f6d20	\N
eea_tvv_range_458df72a5994476d210d94fc	eea_hist_82ad4abda114d0f17aebeefc	\N
eea_tvv_range_458df72a5994476d210d94fc	eea_hist_8a0c4dc8ad477d8cbd78c640	\N
eea_tvv_range_5ba74950c89a95646ddcbe8f	eea_hist_bb5641d4b01300d517651872	\N
eea_tvv_range_5ba74950c89a95646ddcbe8f	eea_hist_e54210945684fbd74c9fc87e	\N
eea_tvv_range_5ba74950c89a95646ddcbe8f	eea_hist_5849fa3d346b49306b422b25	\N
eea_tvv_range_5ba74950c89a95646ddcbe8f	eea_hist_0569b3da1d2666eaa7f0eaa8	\N
eea_tvv_range_318a687ff433708d653cfaad	eea_hist_871a471bbe54fe4a2ad05480	\N
eea_tvv_range_318a687ff433708d653cfaad	eea_hist_b6e7faebd203e7aebe89668d	\N
eea_tvv_range_318a687ff433708d653cfaad	eea_hist_d8eb53c06c75e08b81b19693	\N
eea_tvv_range_318a687ff433708d653cfaad	eea_hist_b2f9931fa911c5fdf1298349	\N
eea_tvv_range_0ca5b101ad5ad24664a429e8	eea_hist_0201f697360154c984839a57	\N
eea_tvv_range_0ca5b101ad5ad24664a429e8	eea_hist_711a72229837ce153fb147c0	\N
eea_tvv_range_0ca5b101ad5ad24664a429e8	eea_hist_520be17addc6972b19644edf	\N
eea_tvv_range_0ca5b101ad5ad24664a429e8	eea_hist_9131c5128ea8683c46687ba6	\N
eea_tvv_range_0ca5b101ad5ad24664a429e8	eea_hist_45f5cce213ce522075f6e775	\N
eea_tvv_range_0e55a37de808651be0b68ade	eea_hist_6437e44bf628401f11e25687	\N
eea_tvv_range_0e55a37de808651be0b68ade	eea_hist_1f85bc0290eda51d5f12f333	\N
eea_tvv_range_0e55a37de808651be0b68ade	eea_hist_ae7f1ad47f49f8936bbff20f	\N
eea_tvv_range_8751a6cebbc311ccf73e2f00	eea_hist_0fc86bdda56b9a4900376436	\N
eea_tvv_range_8751a6cebbc311ccf73e2f00	eea_hist_b7353119aa7ac95a565c7ead	\N
eea_tvv_range_8751a6cebbc311ccf73e2f00	eea_hist_c11131b851f19a6763ff63a0	\N
eea_tvv_range_8751a6cebbc311ccf73e2f00	eea_hist_f3f9e6c61f3d784604cbcef0	\N
eea_tvv_range_79822b716d002d357db72c1b	eea_hist_babf96a9dc5328f528f8119d	\N
eea_tvv_range_79822b716d002d357db72c1b	eea_hist_d3c66be81b01b166420f0164	\N
eea_tvv_range_79822b716d002d357db72c1b	eea_hist_9bcc8d74c5296b9fc052bc91	\N
eea_tvv_range_79822b716d002d357db72c1b	eea_hist_3b20220c4e699a5283618999	\N
eea_tvv_range_79822b716d002d357db72c1b	eea_hist_de3d7869a328dae90df06bb6	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_287fd4d5bb9a0d81ca9053e8	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_007e28a7cd4cd02686c4f88b	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_0aeb5bf0ffe3609cea8fd9ab	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_f01d1bced1525e01f7c62f4f	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_f8b0e39be4b0b2302f141bcb	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_72694e33b2e8b0fc5cb554d9	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_835893ddfadadf83ef687de5	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_0a0ed3796bdbf1028b9efd14	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_33d7c06c771b484dd9e10270	\N
eea_tvv_range_a719fe65f74c25b09e83df2e	eea_hist_93421e616e9903cb611141b3	\N
eea_tvv_range_6622b88de1030d9fa70e0ef8	eea_hist_137618c799f92c70b2bb6462	\N
eea_tvv_range_6622b88de1030d9fa70e0ef8	eea_hist_2e6b4163ddda7513812beae9	\N
eea_tvv_range_6622b88de1030d9fa70e0ef8	eea_hist_e561d1d361975668d07d5db7	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_fa392bacf932d144464b9380	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_1de42ae5dac0f76cff7544ab	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_9dc2d72998c30e5bf109646c	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_75a62327981ed8c58c20cf92	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_aa96755542dd4959baa83f5b	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_36b39f305463d1a39b33322e	\N
eea_tvv_range_b35ce5574967170d67b4a29d	eea_hist_13d5877f188d9bc4a1bdb3c0	\N
eea_tvv_range_e902c5839b84d5bdae8c15e3	eea_hist_2b124085a91ff0e1e7579bbe	\N
eea_tvv_range_e902c5839b84d5bdae8c15e3	eea_hist_154ddefd5c89021425981149	\N
eea_tvv_range_e902c5839b84d5bdae8c15e3	eea_hist_d729ce271b1c4c4b952c368c	\N
eea_tvv_range_15f06de45ea26f08db566307	eea_hist_424263aa328f25e0930334dd	\N
eea_tvv_range_15f06de45ea26f08db566307	eea_hist_a4340069293fd69a2aad8518	\N
eea_tvv_range_adf4da102172c0021b89a9ed	eea_hist_aa2c471d9066f44052e372e7	\N
eea_tvv_range_adf4da102172c0021b89a9ed	eea_hist_8a9868d3e06f278ebc3dba26	\N
eea_tvv_range_adf4da102172c0021b89a9ed	eea_hist_54ce0bf68d5edcd65c34059b	\N
eea_tvv_range_adf4da102172c0021b89a9ed	eea_hist_07311d44d416b193fae1d431	\N
eea_tvv_range_903e5d58493aab8ed0ce1646	eea_hist_b029683c0f9ff2133135d882	\N
eea_tvv_range_903e5d58493aab8ed0ce1646	eea_hist_1fd447ae69b2f4f4e29fc560	\N
eea_tvv_range_903e5d58493aab8ed0ce1646	eea_hist_c70637f4c7f5778e6797ea86	\N
eea_tvv_range_903e5d58493aab8ed0ce1646	eea_hist_9bfc34059ca90ce7278d073f	\N
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_dc247bcb54f182c2b488641d	\N
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_e47eee3d61e9abcd540cf9ad	\N
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_ca5210b0647280081fcdfe08	\N
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_f353cc822aebf657a79b9d32	\N
eea_tvv_range_a04896489d6c50307c6942e4	eea_hist_d96214563c558055eb62d99d	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_2a1c72352a2cd6651b088539	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_98c70aa6c9fafa4fbe353e9c	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_b3068defc6754399e9fd132c	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_a2e7b95810f2d971a0f0af07	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_b1d6743f8d9e48eb724bda9b	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_222295fd210ac2fe81b73d8d	\N
eea_tvv_range_20bd5818d09f12ae83417fa3	eea_hist_3c35efab46182e0baa069f62	\N
eea_tvv_range_54d98288c3690b65c7e7d2f6	eea_hist_03a37048d1f1850e5fb2973a	\N
eea_tvv_range_54d98288c3690b65c7e7d2f6	eea_hist_2ba8306da6421689a4fbe7fb	\N
eea_tvv_range_54d98288c3690b65c7e7d2f6	eea_hist_b7a986276cf2de948f6406a8	\N
eea_tvv_range_54d98288c3690b65c7e7d2f6	eea_hist_f37d4f1859a5a3cd880f5f49	\N
eea_tvv_range_54d98288c3690b65c7e7d2f6	eea_hist_fac40779c598f8a126228ff9	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_30cfec02de21e9c30fb3db99	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_80b0a1225434c86c63336334	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_dfa3f3e18cb05ea1445d24d3	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_17994d1ec2c34314f568b382	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_616a409af9f57808fed5be22	\N
eea_tvv_range_c15cfd1988b3db87797b265e	eea_hist_9dd18af51019bef46d20d99a	\N
eea_tvv_range_68702bd6ff7574a0a03490b0	eea_hist_1dca66c889845e82b5630553	\N
eea_tvv_range_68702bd6ff7574a0a03490b0	eea_hist_66192c2810ff2e6d4f8a40b4	\N
eea_tvv_range_68702bd6ff7574a0a03490b0	eea_hist_5b5988136fa9a918f856a322	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_f9363229df7dd3483a798ec8	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_f393c15476fb8bc8586e382a	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_beaf0a1dd99852ef6d0be176	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_eb36ff603908aea80e9b61f8	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_2be58e33ba69814e4a9a73bd	\N
eea_tvv_range_e5760d86c8e23f5bd2747508	eea_hist_598b12446626a93c141b1036	\N
eea_tvv_range_65dc8c96b8b60133e928ddef	eea_hist_923d6c916296fa4f0b0aa0e4	\N
eea_tvv_range_65dc8c96b8b60133e928ddef	eea_hist_1c364ff704f67a8dc6129a99	\N
eea_tvv_range_65dc8c96b8b60133e928ddef	eea_hist_a4d1d0a5af5d10458b62eeef	\N
eea_tvv_range_65dc8c96b8b60133e928ddef	eea_hist_812c3095c59e508f0f8f315c	\N
eea_tvv_range_65dc8c96b8b60133e928ddef	eea_hist_7b18076ff3c0deb8465d1cd8	\N
eea_tvv_range_51395de615e600407b259b6f	eea_hist_3e060dbddbb582fca7952b6f	\N
eea_tvv_range_51395de615e600407b259b6f	eea_hist_c9b47570941a11f4b82239e7	\N
eea_tvv_range_51395de615e600407b259b6f	eea_hist_197d02777301aba158955560	\N
eea_tvv_range_51395de615e600407b259b6f	eea_hist_6e77ca62dd1560788d75fd07	\N
eea_tvv_range_51395de615e600407b259b6f	eea_hist_24378f52e1a896cc9182662f	\N
eea_tvv_range_54914ff16510837a79e6cdf0	eea_hist_2bba845542c88b432400c68e	\N
eea_tvv_range_54914ff16510837a79e6cdf0	eea_hist_941378d5087d88077985f345	\N
eea_tvv_range_54914ff16510837a79e6cdf0	eea_hist_da2f8292ace853c4760fea4c	\N
eea_tvv_range_54914ff16510837a79e6cdf0	eea_hist_11c2b3bf885f86d64239f771	\N
eea_tvv_range_54914ff16510837a79e6cdf0	eea_hist_be19fcd1eadf135c57e984a9	\N
eea_tvv_range_fe85b022b40beafcf275ba44	eea_hist_68a2fe4cdc952df97ac55fbc	\N
eea_tvv_range_fe85b022b40beafcf275ba44	eea_hist_15e36a0b63e22e6ddd6af5fc	\N
eea_tvv_range_fe85b022b40beafcf275ba44	eea_hist_94e0e0631ae27be732ef4919	\N
eea_tvv_range_3f3809bf656b97330a578535	eea_hist_30375e7cdb23713308927abd	\N
eea_tvv_range_3f3809bf656b97330a578535	eea_hist_d5d861116da22b75a332048b	\N
eea_tvv_range_3f3809bf656b97330a578535	eea_hist_a32793d08964b82560f3be58	\N
eea_tvv_range_c5c076dcbe5d42b6a58adc8a	eea_hist_c626f0b2cd9174f7eb8180b6	\N
eea_tvv_range_c5c076dcbe5d42b6a58adc8a	eea_hist_46675af6c77fdc0d1a520d74	\N
eea_tvv_range_c5c076dcbe5d42b6a58adc8a	eea_hist_2772f7ea710ab94774d608cc	\N
eea_tvv_range_c5c076dcbe5d42b6a58adc8a	eea_hist_1bc51f4a2b01e5cd5db8fb09	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_d0a0e5bc65de54a2c95c27c1	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_0fb79af1a83107d4426594f3	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_1ae1bb588d44d807df8d9f55	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_f18b0b6ef599c481fa46abd1	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_582db22de165f0e50ba25b2c	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_7a71e34f071505c4dc1a31f5	\N
eea_tvv_range_9a6c937e0ef03dc414e16adf	eea_hist_39be001fa2a63744ebbe437c	\N
eea_tvv_range_19b001f72ed3e8e43c2997c0	eea_hist_815ae69a894a3b02645ae6fa	\N
eea_tvv_range_19b001f72ed3e8e43c2997c0	eea_hist_d7245bb9fea78ca04f2fcc53	\N
eea_tvv_range_19b001f72ed3e8e43c2997c0	eea_hist_b901d41a82e814c77e8b740d	\N
eea_tvv_range_19b001f72ed3e8e43c2997c0	eea_hist_6f0e5722912a0079302bacd6	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_8b5634639e7f470aa7796078	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_d113fb0a743f06551cb41ed4	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_9fa8d0d1babe636e8959feba	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_14008bd5bcf1aae7dff7a740	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_412956fe464fc58fc9900986	\N
eea_tvv_range_0bde2d27bd065fb942fa18f4	eea_hist_e882a83ae603e8e558a0c461	\N
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	eea_hist_a51441d801b10a5573a719a2	\N
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	eea_hist_0893f834ba05436f85351e99	\N
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	eea_hist_23c1766629019987645592eb	\N
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	eea_hist_2163e2a46ede9e7c6808c6fe	\N
eea_tvv_range_91ef9c3a9742d9e9cb2a2cc9	eea_hist_7b3dc96dfe64cf86f8acfb01	\N
eea_tvv_range_1d49bb2ae3a07b02e99a1393	eea_hist_06aaf1ec5f7a2f0b2f99ee1f	\N
eea_tvv_range_1d49bb2ae3a07b02e99a1393	eea_hist_3057c9339720bd7206cdd73a	\N
eea_tvv_range_1d49bb2ae3a07b02e99a1393	eea_hist_7dc34308df5a4770d87a7280	\N
eea_tvv_range_c4b022ccf42f3391c4dd668b	eea_hist_0891f6d73e23382d0c04f2a8	\N
eea_tvv_range_c4b022ccf42f3391c4dd668b	eea_hist_44551d445fe1cbd40ac49c5c	\N
eea_tvv_range_c4b022ccf42f3391c4dd668b	eea_hist_6d02c5f3344e763a5f312865	\N
eea_tvv_range_c4b022ccf42f3391c4dd668b	current_cluster:9b860e34c53ed62c2136598c29c3c863	679
eea_tvv_range_b861679d270ec0bf7c3e3803	eea_hist_f8d71d60836e2580393eb97b	\N
eea_tvv_range_b861679d270ec0bf7c3e3803	eea_hist_e4bb0de67229a9d53c39a1bb	\N
eea_tvv_range_b861679d270ec0bf7c3e3803	eea_hist_c90258648a97a1c3934b411e	\N
eea_tvv_range_b861679d270ec0bf7c3e3803	current_cluster:6260f374ce64f84e5a5eb6be39bc850a	680
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	eea_hist_32606e5fa70a3e40d138b267	\N
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	eea_hist_2ef4039fdf3ba32b6e1a5c41	\N
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	eea_hist_c2828dab317fe3b132b2db25	\N
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	eea_hist_5c5fc73c2371b1d6af387066	\N
eea_tvv_range_b6b6b1dc429a7c552aa0e64e	current_cluster:5a4a9ac2854903e4a63c21a903afa944	727
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_0d933193c20f3d712b55c9b3	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_e13b9a2ce5a91a613538204f	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_fe2510ae18a180ce85bc460b	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_1bd22433526d26ae7374bbc4	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_d8d76d0c4dc158afb404f25a	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_b51860dc593c9739a7ed63a9	\N
eea_tvv_range_785450072dcb1a57a9d5a2cb	eea_hist_b0744e2b997294bea79ef665	\N
eea_tvv_range_d7fb4c4b7f6db405726c61dc	eea_hist_e10f8feca04f9ee376320fc9	\N
eea_tvv_range_d7fb4c4b7f6db405726c61dc	eea_hist_898d5d40e9e9b0cd1b81605c	\N
eea_tvv_range_d7fb4c4b7f6db405726c61dc	eea_hist_fdacc6c27f53e0d85809f841	\N
eea_tvv_range_d7fb4c4b7f6db405726c61dc	eea_hist_796fc6ab3af594a833cdfd67	\N
eea_tvv_range_d7fb4c4b7f6db405726c61dc	eea_hist_a41fa8da3e6058c9e95e321d	\N
eea_tvv_range_0e8de08fa3c88a29d32ff553	eea_hist_69f4ed046bdc03033ba45cc7	\N
eea_tvv_range_0e8de08fa3c88a29d32ff553	eea_hist_de580dc562af74f61a6512d6	\N
eea_tvv_range_0e8de08fa3c88a29d32ff553	eea_hist_7e8e6d606b108b4d47e662e5	\N
eea_tvv_range_82e5c5cc38dd3c17cfb3b4a6	eea_hist_05bb616e8736f01b8765eea7	\N
eea_tvv_range_82e5c5cc38dd3c17cfb3b4a6	eea_hist_9e381b090ef5636e68920caa	\N
eea_tvv_range_82e5c5cc38dd3c17cfb3b4a6	eea_hist_08a955e11abff6a97596e92e	\N
eea_tvv_range_9ad3e9be6a2780fd6349c950	eea_hist_da8b367b757dbfc6acb17a4b	\N
eea_tvv_range_9ad3e9be6a2780fd6349c950	eea_hist_6b37089d3faf0494ab2e6153	\N
eea_tvv_range_9ad3e9be6a2780fd6349c950	eea_hist_943b0844df3d78dbbb41487f	\N
eea_tvv_range_eeaa56aef7b8f10f882b4618	eea_hist_b8b583437367aaee988ea671	\N
eea_tvv_range_eeaa56aef7b8f10f882b4618	eea_hist_ae4b19e28f9ad3776f35315b	\N
eea_tvv_range_1de2e7cd607850d74931b03d	eea_hist_4fef741c518e186e30887a11	\N
eea_tvv_range_1de2e7cd607850d74931b03d	eea_hist_8910068274b665562df2d37f	\N
eea_tvv_range_98686e3ee7d9d65304f6d894	eea_hist_2a3865601b0c3d35f68f1cbf	\N
eea_tvv_range_98686e3ee7d9d65304f6d894	eea_hist_e4042b7efba27ff6d60ae79f	\N
eea_tvv_range_98686e3ee7d9d65304f6d894	eea_hist_1c42c4470daf6281a66be173	\N
eea_tvv_range_98686e3ee7d9d65304f6d894	eea_hist_db1820ddffaabbbba8f106e7	\N
eea_tvv_range_defe12b31239d302d50898b6	eea_hist_815aa329dae110a29fc2bcde	\N
eea_tvv_range_defe12b31239d302d50898b6	eea_hist_19dbcb7ccead07298b040b91	\N
eea_tvv_range_defe12b31239d302d50898b6	eea_hist_f43c0c1fb9886933a3465821	\N
eea_tvv_range_defe12b31239d302d50898b6	eea_hist_0f3e802aed8e9161e7e78163	\N
eea_tvv_range_d9e3c4c0d44c4575d32ed5d1	eea_hist_bdff233b955d01eea9e4980a	\N
eea_tvv_range_d9e3c4c0d44c4575d32ed5d1	eea_hist_404b963c01a202f0e4d9c372	\N
eea_tvv_range_d9e3c4c0d44c4575d32ed5d1	eea_hist_74fa90ae7f315361a10d238c	\N
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_9919d5c510b661936d40dce4	\N
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_3350328c312099be2460a8ac	\N
eea_tvv_range_6340b81761ba6a066b1b3671	eea_hist_7de358a937b4bfc6e00d9f7b	\N
eea_tvv_range_0b7eb1ea94c112a1897104e2	eea_hist_3c90d5671998cbd564d596a2	\N
eea_tvv_range_0b7eb1ea94c112a1897104e2	eea_hist_d0a9c51a6564ea99593523ef	\N
eea_tvv_range_0b7eb1ea94c112a1897104e2	eea_hist_f54ab0dcab8a4961b0efeeec	\N
eea_tvv_range_0b7eb1ea94c112a1897104e2	eea_hist_f9889e8499bf1e66bb8c9edf	\N
eea_tvv_range_0b7eb1ea94c112a1897104e2	eea_hist_607880ca83186d4c56800f5d	\N
eea_tvv_range_2f22c378bb2120105d36fe32	eea_hist_5efc59155a42f00241f65e05	\N
eea_tvv_range_2f22c378bb2120105d36fe32	eea_hist_7a23d32e5d2955240af41ad7	\N
eea_tvv_range_288def3161339ef38d1d2bbf	eea_hist_9098c3115fc7c1556819007e	\N
eea_tvv_range_288def3161339ef38d1d2bbf	eea_hist_c0fa3f3a6d60bca6670e09fa	\N
eea_tvv_range_60c137fbbbb2c8549045aee7	eea_hist_653e4510433e37f63ec10d79	\N
eea_tvv_range_60c137fbbbb2c8549045aee7	eea_hist_668e0f74f810af9f794a57c2	\N
eea_tvv_range_ec88d4d0760a02a7ac68d79c	eea_hist_e2d14d3a506a95d24a219578	\N
eea_tvv_range_ec88d4d0760a02a7ac68d79c	eea_hist_94fe3e796cc6ba3812873bc6	\N
eea_tvv_range_be49f5ac1c29892cbfe034db	eea_hist_1aec59cbb1900d5e4f7fd5fa	\N
eea_tvv_range_be49f5ac1c29892cbfe034db	eea_hist_85e4a675a43fd3a5281ad6ef	\N
eea_tvv_range_be49f5ac1c29892cbfe034db	eea_hist_7df1ad66dde284848128c92c	\N
eea_tvv_range_be49f5ac1c29892cbfe034db	eea_hist_e49936543dec932f8ffa55ac	\N
eea_tvv_range_be49f5ac1c29892cbfe034db	eea_hist_29d5973e58ff96103247ab20	\N
eea_tvv_range_fc9502150f5dabdc86d99a96	eea_hist_ec63d6f815f400ea4620fae3	\N
eea_tvv_range_fc9502150f5dabdc86d99a96	eea_hist_a5422f5eb7896857d9be4fbc	\N
eea_tvv_range_fc9502150f5dabdc86d99a96	eea_hist_9dc185aeb225b1e4db1e9b2f	\N
eea_tvv_range_0638760d0ea651f190745321	eea_hist_6f1be6b5c2f738fb44107062	\N
eea_tvv_range_0638760d0ea651f190745321	eea_hist_8b85d3e409f0392e0a8a843b	\N
eea_tvv_range_0638760d0ea651f190745321	eea_hist_41e63ea46ffd76c1624c3a45	\N
eea_tvv_range_2755f42e0c30f6b434eb4fd6	eea_hist_be66da73b2cb3788c03a5889	\N
eea_tvv_range_2755f42e0c30f6b434eb4fd6	eea_hist_30a10ca8110adeff608324c0	\N
eea_tvv_range_2755f42e0c30f6b434eb4fd6	eea_hist_db53326b67410c6f8b838846	\N
eea_tvv_range_665e402e72979657bbc39347	eea_hist_ed055af22794be51b0f86860	\N
eea_tvv_range_665e402e72979657bbc39347	eea_hist_a04bc29e146bacd0e882e956	\N
eea_tvv_range_665e402e72979657bbc39347	eea_hist_8b8b94d0c0fe4f5f62e5fd32	\N
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_a726e706602e0cc915568030	\N
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_d4788cfdbd36c00cb7523b63	\N
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_55f7204a2616744b65bd9b02	\N
eea_tvv_range_7116268db5091f1f0e99593c	eea_hist_e3c0f0e69fe49453072bdeef	\N
eea_tvv_range_5c9a766b2b8ca882c0f82928	eea_hist_4a395cb5baa930d377f5509f	\N
eea_tvv_range_5c9a766b2b8ca882c0f82928	eea_hist_f791d9c1fd23c22e34593907	\N
eea_tvv_range_5c9a766b2b8ca882c0f82928	eea_hist_33a49ab524b2be36246ef830	\N
eea_tvv_range_b0c29f158123c5d30d4dce2a	eea_hist_cf3e5868741938ab0bd3f827	\N
eea_tvv_range_b0c29f158123c5d30d4dce2a	eea_hist_035da7d2af23b23dffa0ef7d	\N
eea_tvv_range_b0c29f158123c5d30d4dce2a	eea_hist_2189722e52eebdb1215d6ed4	\N
eea_tvv_range_bdc8d7f4307d77fe4f08b852	eea_hist_b4052d1a477b7a290830be01	\N
eea_tvv_range_bdc8d7f4307d77fe4f08b852	eea_hist_562bdf9f9fc66d6de5f15cb6	\N
eea_tvv_range_bdc8d7f4307d77fe4f08b852	eea_hist_e03bf3b0b58320e80bf8adbc	\N
eea_tvv_range_c3bfc982dd64164641c8fad9	eea_hist_1e60c78ba0486a88ebca0037	\N
eea_tvv_range_c3bfc982dd64164641c8fad9	eea_hist_9c7d9487f17d4dd4fffe92dd	\N
eea_tvv_range_c3bfc982dd64164641c8fad9	eea_hist_799c24a85d4e17aa3c0b5cb9	\N
eea_tvv_range_c3bfc982dd64164641c8fad9	eea_hist_626d5a830769df84f395bd34	\N
eea_tvv_range_80bb241f989c8d3a20144720	eea_hist_58310338a8ea0e6640eccc15	\N
eea_tvv_range_80bb241f989c8d3a20144720	eea_hist_3b0e0f5324eff0012b9a87ad	\N
eea_tvv_range_80bb241f989c8d3a20144720	eea_hist_46c23be1d890bceb3093317d	\N
eea_tvv_range_80bb241f989c8d3a20144720	eea_hist_cfd64fd4a68af495647ecdf8	\N
eea_tvv_range_2472c384a2263c816a3d4342	eea_hist_952d7ab06fc2524374d459ef	\N
eea_tvv_range_2472c384a2263c816a3d4342	eea_hist_de5423e4215b73b92dee439f	\N
eea_tvv_range_2472c384a2263c816a3d4342	eea_hist_0b44dae51d370218386bc7c9	\N
eea_tvv_range_b6fac41c7f937dfbfc5d9657	eea_hist_84ca912cc39ffcbb0670fbd9	\N
eea_tvv_range_b6fac41c7f937dfbfc5d9657	eea_hist_c088850d2af193b4103e908c	\N
eea_tvv_range_b6fac41c7f937dfbfc5d9657	eea_hist_d4ba4dbc301c47396f8a57e7	\N
eea_tvv_range_23abcb15d6b75201b43045c1	eea_hist_cc7a7bd5463681137fa76bef	\N
eea_tvv_range_23abcb15d6b75201b43045c1	eea_hist_77ae6e4b30778332c613f17b	\N
eea_tvv_range_59536e12aff9944244075d40	eea_hist_b4cabc594f4948d5526e576c	\N
eea_tvv_range_59536e12aff9944244075d40	eea_hist_5b6d523999e422b2b0bbc967	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_bca6401d2eaaba87469c14cc	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_4ac9a91b7635dfdfdd5abf2a	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_dc840912cca510256c3cb91e	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_6aa182b251ec94e5c516f1e8	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_4913d3e601df48cfbb2ee527	\N
eea_tvv_range_0dff13e78582f3304bbf65bf	eea_hist_ed1fe5b4845155566861df4f	\N
eea_tvv_range_578105df0cee8f7120c25ee4	eea_hist_5bfebfb46de9e61922d320b0	\N
eea_tvv_range_578105df0cee8f7120c25ee4	eea_hist_2020062feda154586e705d45	\N
eea_tvv_range_578105df0cee8f7120c25ee4	eea_hist_8d61508e7bdcf97c597036bb	\N
eea_tvv_range_578105df0cee8f7120c25ee4	eea_hist_42c0117a76266ccf3cae1cf5	\N
eea_tvv_range_0bbb9fc649343bce88517728	eea_hist_70b2ea8808e02354a7f4686c	\N
eea_tvv_range_0bbb9fc649343bce88517728	eea_hist_8917f8f251b8cb73ff26ca47	\N
eea_tvv_range_0bbb9fc649343bce88517728	eea_hist_5708540a5aafc3cb112fbbdc	\N
eea_tvv_range_5c0b8d45195268c09d4219f4	eea_hist_8e1638c9932770daacc8741c	\N
eea_tvv_range_5c0b8d45195268c09d4219f4	eea_hist_2ce64e6a7316733d6b5b8504	\N
eea_tvv_range_5c0b8d45195268c09d4219f4	eea_hist_aa955e74750174f26309de68	\N
eea_tvv_range_3c81a2da25ba93f3e46fd342	eea_hist_4f8ef9ada4fbde4c473a136a	\N
eea_tvv_range_3c81a2da25ba93f3e46fd342	eea_hist_de02a97b70c552d35701d162	\N
eea_tvv_range_3c81a2da25ba93f3e46fd342	eea_hist_5622d631423ad32760fe5b29	\N
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_ab3ce4be8d489f153f00da9d	\N
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_be9747306572e9de33ddc3c3	\N
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_22e55eb1c8bef75e925ccd9c	\N
eea_tvv_range_c6a980d82aa86b8b6970aa55	eea_hist_d86f1f9e708c54d3e7c182a4	\N
eea_tvv_range_3bd421a78fc199dd46cdd482	eea_hist_5751d6bf85888cedaa34c13d	\N
eea_tvv_range_3bd421a78fc199dd46cdd482	eea_hist_9db859024eb9e1edcff9e954	\N
eea_tvv_range_3bd421a78fc199dd46cdd482	eea_hist_35fac19e749527f934a4312e	\N
eea_tvv_range_a131b8f2a499374e9807e219	eea_hist_2277650d15abea997553c096	\N
eea_tvv_range_a131b8f2a499374e9807e219	eea_hist_e3d181cbb48fda6626184acc	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_fc11c0781acaf91871c00b18	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_2177a08459b11512944ee102	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_f40ec1822b6abe224a49d2ca	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_e1f43c26451e27c750c52ee5	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_e2318fd6ce0f0289183167d4	\N
eea_tvv_range_4d34d426e9e87b3da8755ba5	eea_hist_3c4ed286672956042b126096	\N
eea_tvv_range_0d99addd97e477822155d0e0	eea_hist_cfc51c83e88af22612cb46b8	\N
eea_tvv_range_0d99addd97e477822155d0e0	eea_hist_09bc5e07a3ae0d4b46a711e5	\N
eea_tvv_range_0d99addd97e477822155d0e0	eea_hist_4e050742dee9914232c08169	\N
eea_tvv_range_0d99addd97e477822155d0e0	eea_hist_1c4261aa7c7fc1052d02bafe	\N
eea_tvv_range_19b38d4a17cf573de636f16d	eea_hist_d5c373865f8a49d0d07640b7	\N
eea_tvv_range_19b38d4a17cf573de636f16d	eea_hist_403b333c58cdc728017b89c3	\N
eea_tvv_range_19b38d4a17cf573de636f16d	eea_hist_2a2c8aa6ba6f061cf1e7d8d3	\N
eea_tvv_range_b2be6a6cea77709fc40931f1	eea_hist_5838f97a8ab4809dd69e3a3f	\N
eea_tvv_range_b2be6a6cea77709fc40931f1	eea_hist_dd0167291c4e816def87a4af	\N
eea_tvv_range_a0d1335c4ffc12d153c9b368	eea_hist_e0f80e7826ed5c0deef05b32	\N
eea_tvv_range_a0d1335c4ffc12d153c9b368	eea_hist_ce0eab9071670d6155af29b4	\N
eea_tvv_range_a0d1335c4ffc12d153c9b368	eea_hist_ec4a99033921c5a1b34b85ab	\N
eea_tvv_range_a0d1335c4ffc12d153c9b368	eea_hist_52deaaa4330489310a0b376d	\N
eea_tvv_range_69b4e0d55c9b39e5517734fe	eea_hist_4ebba8809566f8dce2fbc721	\N
eea_tvv_range_69b4e0d55c9b39e5517734fe	eea_hist_bb2ece3236898048cf4ec6f8	\N
eea_tvv_range_8edd1bffc70e741506f48ac1	eea_hist_dc83c9e3ab9aff89641f9ee1	\N
eea_tvv_range_8edd1bffc70e741506f48ac1	eea_hist_2a691c7c97d23b7187766df2	\N
eea_tvv_range_8edd1bffc70e741506f48ac1	eea_hist_19f011f08f0766ec32aeaaad	\N
eea_tvv_range_8edd1bffc70e741506f48ac1	eea_hist_153131143c8acad176255513	\N
eea_tvv_range_8edd1bffc70e741506f48ac1	eea_hist_f9b3c829d6358984b6a2e5e5	\N
eea_tvv_range_e632a20b39862d808148bf98	eea_hist_06697a9ae6116f3241de9cb9	\N
eea_tvv_range_e632a20b39862d808148bf98	eea_hist_0eca3dd1f903860ce9040811	\N
eea_tvv_range_e632a20b39862d808148bf98	eea_hist_00ab0daf471acd2b593ffc11	\N
eea_tvv_range_e632a20b39862d808148bf98	eea_hist_30fea9eaef8fad1b64601570	\N
eea_tvv_range_e632a20b39862d808148bf98	eea_hist_ae15259f5dd5e44485f715de	\N
eea_tvv_range_d7fbec38d604adf04362c59d	eea_hist_a62c99e9ea4e6e7960eece18	\N
eea_tvv_range_d7fbec38d604adf04362c59d	eea_hist_db437ebe1bcdae6166a3ab0e	\N
eea_tvv_range_d7fbec38d604adf04362c59d	eea_hist_7a491a2d13aa2d7de42c6123	\N
eea_tvv_range_d7fbec38d604adf04362c59d	eea_hist_b86b66464e1d88b320d6b0f8	\N
eea_tvv_range_6aff0f25e63729cee8b81298	eea_hist_e7515ca123e1697054d53aa5	\N
eea_tvv_range_6aff0f25e63729cee8b81298	eea_hist_65a313212866427a8ea8f674	\N
eea_tvv_range_6aff0f25e63729cee8b81298	eea_hist_6d636885fe16b770509322ec	\N
eea_tvv_range_6aff0f25e63729cee8b81298	eea_hist_cf286a2994efbba99e3acf15	\N
eea_tvv_range_e972cb0a82fcff7858206e5a	eea_hist_4a8474099529b108b1ccfe51	\N
eea_tvv_range_e972cb0a82fcff7858206e5a	eea_hist_4709f45a7edfeb1699efb918	\N
eea_tvv_range_e972cb0a82fcff7858206e5a	eea_hist_0b1e7b7513ae9da301a9b536	\N
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_e0d5e9055e1e502fb1faf2b3	\N
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_e624375f48fba46fe4e95626	\N
eea_tvv_range_59fa1128f1dd4a81571c093c	eea_hist_3eca0039c8cbd5117a52c7d5	\N
eea_tvv_range_ab00de67b58dd8994e2ea3c6	eea_hist_bcfe3e63fa266d0d297857cc	\N
eea_tvv_range_ab00de67b58dd8994e2ea3c6	eea_hist_200e3b5b65ba91ce900be82f	\N
eea_tvv_range_ab00de67b58dd8994e2ea3c6	eea_hist_2d699529c2625cf82b4c0ded	\N
eea_tvv_range_ab00de67b58dd8994e2ea3c6	current_cluster:bfb4aa289f46a86296f65818eac243a0	549
eea_tvv_range_bbbb98d262309a16a97edae2	eea_hist_00683db065fbe7a4b4fb3a93	\N
eea_tvv_range_bbbb98d262309a16a97edae2	eea_hist_54c20483c91f5541d6838c8f	\N
eea_tvv_range_bbbb98d262309a16a97edae2	eea_hist_3da3efc894604aedd6b0f25e	\N
eea_tvv_range_2449ecc2dd72b3888501abb1	eea_hist_fbd5210e6429089407e4566f	\N
eea_tvv_range_2449ecc2dd72b3888501abb1	eea_hist_4d210b5f7d508f041ab95904	\N
eea_tvv_range_2449ecc2dd72b3888501abb1	eea_hist_3c55bd2e9b534735c234cacd	\N
eea_tvv_range_2449ecc2dd72b3888501abb1	eea_hist_21dc4e1edc9d504f855cd4d3	\N
eea_tvv_range_24871eb6a7b8cb96efc12ddf	eea_hist_64e07d415d32fb2931f66ed0	\N
eea_tvv_range_24871eb6a7b8cb96efc12ddf	eea_hist_3e6eb6ae191565c0a1b4280a	\N
eea_tvv_range_24871eb6a7b8cb96efc12ddf	eea_hist_41dcdd17d2e71d58cba1ac97	\N
eea_tvv_range_24871eb6a7b8cb96efc12ddf	eea_hist_486e1ddb2523d5fa79c43eea	\N
eea_tvv_range_24871eb6a7b8cb96efc12ddf	eea_hist_c21c54b528f05cdfa65e8eb4	\N
eea_tvv_range_f084817676c009f32129f1ee	eea_hist_cc3b2d0fa4c23076b56b4baf	\N
eea_tvv_range_f084817676c009f32129f1ee	eea_hist_ab7845f07fb7a3095b6c44cf	\N
eea_tvv_range_f084817676c009f32129f1ee	eea_hist_95b7dd52c3205b8ba632e941	\N
eea_tvv_range_f084817676c009f32129f1ee	eea_hist_199c963b425c33f1aad8cca8	\N
eea_tvv_range_079b719495799c9aed9b8f2e	eea_hist_e5c2bd74ccc9574a96cf793b	\N
eea_tvv_range_079b719495799c9aed9b8f2e	eea_hist_bc8de6124f2ab9a2cba40770	\N
eea_tvv_range_079b719495799c9aed9b8f2e	eea_hist_5a9759ee45cecfb6c5f1b0fa	\N
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_06bebd96391f57c24ffa466d	\N
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_c7ce3571e594a21953a777d6	\N
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_266f1c5c131bbc5140226625	\N
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_67719ac08142c9ca5adf3d36	\N
eea_tvv_range_68e7d3109a70d0c0469c420d	eea_hist_208758c648cf149a4835ad8d	\N
eea_tvv_range_0f5e1ab1a4c31216d3f9d284	eea_hist_4bba2204d9f6c522bec4754b	\N
eea_tvv_range_0f5e1ab1a4c31216d3f9d284	eea_hist_9c8d9e0a4c2a91256316da44	\N
eea_tvv_range_0f5e1ab1a4c31216d3f9d284	eea_hist_3b056eab0e70dff4c392d54e	\N
eea_tvv_range_0f5e1ab1a4c31216d3f9d284	eea_hist_4e3b77e86289437e84e74a96	\N
eea_tvv_range_e32f7c6fa6bfc6ea82cfaecf	eea_hist_8c49f0e3c2b1cd49d1732d58	\N
eea_tvv_range_e32f7c6fa6bfc6ea82cfaecf	eea_hist_eea33234d29d90b35ba59b40	\N
eea_tvv_range_e32f7c6fa6bfc6ea82cfaecf	eea_hist_11402bddca60cc2f3801a6f4	\N
eea_tvv_range_e32f7c6fa6bfc6ea82cfaecf	eea_hist_7c59d2cfc50abc47d6c906b4	\N
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	eea_hist_8ba200846ee8f2747e66c34c	\N
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	eea_hist_797d88dabbea5fcaeb25255a	\N
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	eea_hist_0e9f15a5cb83197bb2b44ce2	\N
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	eea_hist_6d6fd42eb01ab673fbdec9e7	\N
eea_tvv_range_8fc6d359e3ddf4f9ab85826c	eea_hist_34d5ac8a950137682f4b5b7d	\N
eea_tvv_range_76a31e57a66f5e31d66b8444	eea_hist_f6f51729087c864b147b8556	\N
eea_tvv_range_76a31e57a66f5e31d66b8444	eea_hist_ba85d4b6c1c6a262cb198c9a	\N
eea_tvv_range_76a31e57a66f5e31d66b8444	eea_hist_d2951cbf23582e9b69d90ae4	\N
eea_tvv_range_76a31e57a66f5e31d66b8444	current_cluster:198ba1d3b73e53ebc93d1d7cf928a829	721
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_f839970343ec06dde6e8d732	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_d67c5a1f9213d5f2974fa3ce	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_8f61715eb1407cd65a7cfe3d	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_f54bd9361801720a00bb325d	\N
eea_tvv_range_65d4fb68328554df9cbabced	current_cluster:7e9cf065fa6fcf189cd363d02010a212	835
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_d3f02083d069613a4490b1b4	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_9a0fa07f4b769fd036f19f72	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_94155f5d1658d99622688800	\N
eea_tvv_range_65d4fb68328554df9cbabced	eea_hist_79a534168086c58ba27506a3	\N
eea_tvv_range_65d4fb68328554df9cbabced	current_cluster:3ac9e2ad463c0aaebe5d53eca7a802c7	835
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_94fb4ef86661b0d43493809b	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_00dab6dabd1685ec04631441	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_63f49d531756e1bd5f6fcdd0	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_e950192e62d110c1fffb42b4	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_c67ff276b144beac8a251109	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_f8e5e5775748ca4f4564e244	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_374409292dcb2102222ba693	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_27cf1b2e6bab36edbd3f6b2d	\N
eea_tvv_range_48ec7b43dea9218d9797b2fd	eea_hist_e5f0f2d9fdcc9377704bd8e3	\N
eea_tvv_range_4c767dae8b4371fc566e472a	eea_hist_8266553b230c2d08dbeb7df1	\N
eea_tvv_range_4c767dae8b4371fc566e472a	eea_hist_ee26e79d6b9b865c705b8db8	\N
eea_tvv_range_4c767dae8b4371fc566e472a	eea_hist_0bcd401f31e6a99a03e65222	\N
eea_tvv_range_4c767dae8b4371fc566e472a	eea_hist_cf263fcdfee5d18619f1c249	\N
eea_tvv_range_049881cfec4012949c24d25b	eea_hist_620323974186446a761feab2	\N
eea_tvv_range_049881cfec4012949c24d25b	eea_hist_e7e31cbf50d3190de11b4f70	\N
eea_tvv_range_049881cfec4012949c24d25b	eea_hist_67a4d413606b298ec701d451	\N
eea_tvv_range_7515e51a4e5cdddb62c155b6	eea_hist_2b8bae580e07983deeb179d5	\N
eea_tvv_range_7515e51a4e5cdddb62c155b6	eea_hist_f8952c9ab4f0bc4ac1b11eb0	\N
eea_tvv_range_7515e51a4e5cdddb62c155b6	eea_hist_b9341db81c7fbc563f03ff63	\N
eea_tvv_range_7515e51a4e5cdddb62c155b6	eea_hist_46b53470d6d9c7773464c7ef	\N
eea_tvv_range_7515e51a4e5cdddb62c155b6	eea_hist_a46de67e4b3eceea33aec217	\N
eea_tvv_range_f65f440260150773e99b24c0	eea_hist_833b1a26e96de48e43268527	\N
eea_tvv_range_f65f440260150773e99b24c0	eea_hist_5e13f3248b3742f7f6868b9b	\N
eea_tvv_range_ea4e0026710d5781e154215c	eea_hist_2e85453f61064ccd3dfe8a03	\N
eea_tvv_range_ea4e0026710d5781e154215c	eea_hist_a64d184b44e17fde7d562b5e	\N
eea_tvv_range_ea4e0026710d5781e154215c	eea_hist_df72676faf65326c08edc80c	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_d8d4a9474f98d6fb4d967d76	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_a6ec4e52b0c5d8b29c9f8659	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_5269e0c8a2e5a242deb8ee9e	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_a669ec3b18dfc81b28e56482	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_f8ef2efbabb29de2436f73c6	\N
eea_tvv_range_344dcdbcc1b060e7a8ac7e22	eea_hist_274af3dbec5d8d0446a590b0	\N
eea_tvv_range_38ddc58ccf0338a5edd74766	eea_hist_419a658eba8845c7aeb2abbe	\N
eea_tvv_range_38ddc58ccf0338a5edd74766	eea_hist_c39b946266b55b4a2b06443b	\N
eea_tvv_range_38ddc58ccf0338a5edd74766	eea_hist_20dffe06ccf54564838d5e5a	\N
eea_tvv_range_2758648eced75d745b473ee1	eea_hist_026e184f1af1d11359a7a9ae	\N
eea_tvv_range_2758648eced75d745b473ee1	eea_hist_130c1c686415df90266bfaaa	\N
eea_tvv_range_2758648eced75d745b473ee1	eea_hist_371aff1b7d438cd8405f5abe	\N
eea_tvv_range_2758648eced75d745b473ee1	eea_hist_a432bf9647ab1d3ab943d867	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_e729a6abef8d21f8274bbf1e	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_6803ead566fc6bd9c011c8d4	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_b3a73ec06439d838eac39762	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_274c159fd4c2286a470914f9	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_4076925e9477d13a9e2ff0b3	\N
eea_tvv_range_68ada9bcfacb9e78efff90bb	eea_hist_2461cb1762d60a3f4a18e6c1	\N
eea_tvv_range_376af900981c3fb9aaf7fbf6	eea_hist_b3bc1ac1bf8057aea2f6ff9e	\N
eea_tvv_range_376af900981c3fb9aaf7fbf6	eea_hist_b646490c37f8a4d13c373e52	\N
eea_tvv_range_376af900981c3fb9aaf7fbf6	eea_hist_b869781e52b2f44e534d1215	\N
eea_tvv_range_376af900981c3fb9aaf7fbf6	eea_hist_0da21cba0f2b654f7be695fe	\N
eea_tvv_range_376af900981c3fb9aaf7fbf6	eea_hist_1a7d700a346bae686223fe31	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_ccbf31c90286bc63d6d8f8c2	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_394900ca12773a9cfacf4c43	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_71907501ee4f80c707248338	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_8e70bb89e378eeccd4a18287	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_0acc7f1d0e3b158ce59341d7	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_26198f547f4f5074201a08c8	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_c8563022972803e936e5dbb6	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_c2cf3aa3fa6f25a0ab19a1ee	\N
eea_tvv_range_38641061dc0c7f62537f78e2	eea_hist_544b57c9abae746d243b8a24	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7ce5a54779acbdd56d3e5c1b	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_6e0af0c90d2f3e77099395f4	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_d7042e14ff1a8841e54e3913	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_44e09e02c7462823ad55ca8e	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_0be3e3c5a5811bf6ddd1c087	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_bb5edc8a459a386832471dd0	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7a3fb54c90722187493a2276	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_cea0fbc7d8db071578190321	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_eca9b6e92def37cfa958500b	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_ae10161a286c3d581f22ea44	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_2aabdce848571f1be3c88295	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_5c7b4c62a7691f962e21a2ff	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_c3ab697e79247335858b2616	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_0581a89c327bd0cb0a6a039a	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_551474f6476ac38ec092e266	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_17141dca5c61db549324f6cc	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_32588dd47b34acd4c91ce8cc	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_7b91aae36fffb9fb7554a62c	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_e1c65ce14da1b4480349493c	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_08a640381d828a852b5f170b	\N
eea_tvv_range_757f3717a0e3dba8a826c688	eea_hist_e2d8c2a4ed6a985219af7be0	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_ddb1b559ebe79690d2448519	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_d3195ae7a79958527a36427e	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_025c87eb55d83f350a982914	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_f52719079c4764e7b8797d46	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_9a126e81ec71833389c24509	\N
eea_tvv_range_8577889ba1273ab65a93b31b	eea_hist_70093ef062b2197810cab815	\N
eea_tvv_range_76cff748f7dff6d455416753	eea_hist_21eed2040ba3e0351f359715	\N
eea_tvv_range_76cff748f7dff6d455416753	eea_hist_50bbf4bcdd70abb512b83056	\N
eea_tvv_range_76cff748f7dff6d455416753	eea_hist_913c18cca648efe642fc5768	\N
eea_tvv_range_76cff748f7dff6d455416753	eea_hist_bbaafc12b39614a55c54bd67	\N
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_77843368d2696f01b7c227fc	\N
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_3baf2800c57ea9441d711cb3	\N
eea_tvv_range_51e414e2cc1974a20ec984da	eea_hist_546a9d551edeba73d16eb864	\N
eea_tvv_range_e2be17ffd48779d6dab9216b	eea_hist_d6dbfadb94203456699ed81a	\N
eea_tvv_range_e2be17ffd48779d6dab9216b	eea_hist_32a4ba00f549567c4aa48b3a	\N
eea_tvv_range_69a0a0a474598e8d544ba714	eea_hist_e96dcdc15aa7030d6e22687b	\N
eea_tvv_range_69a0a0a474598e8d544ba714	eea_hist_bccd02c9e9ae55c48a5d85a5	\N
eea_tvv_range_69a0a0a474598e8d544ba714	eea_hist_953c30c978dd7faefb057708	\N
eea_tvv_range_69a0a0a474598e8d544ba714	eea_hist_20609ba04f7b53866e6fc2f5	\N
eea_tvv_range_4a74b549f076f5def7cacc94	eea_hist_700ab053ff47b3a2f557f7ae	\N
eea_tvv_range_4a74b549f076f5def7cacc94	eea_hist_cd4a70736bcfa9b12966e724	\N
eea_tvv_range_4a74b549f076f5def7cacc94	eea_hist_181a5210e653e590a25396d3	\N
eea_tvv_range_4a74b549f076f5def7cacc94	eea_hist_824a73bd8d13440d22caff52	\N
eea_tvv_range_4a74b549f076f5def7cacc94	eea_hist_7a08a2b3bda4fedd90249a9e	\N
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_fcbb79e52102ab12695c97ed	\N
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_70b41e54ca34f29e537a3d20	\N
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_95554c7754e9884c1b2cbf5a	\N
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_ab704644e5ad9cbfdf26cb4f	\N
eea_tvv_range_4303482c02f8ddae1f2a02f8	eea_hist_f8d6cf2b3f6ad21c4873c382	\N
eea_tvv_range_3275c8b61c3a4a6afbe3ad1d	eea_hist_69f89502b5e55b5fe21259c4	\N
eea_tvv_range_3275c8b61c3a4a6afbe3ad1d	eea_hist_1eeaf5fee7f95dabfecf295f	\N
eea_tvv_range_3275c8b61c3a4a6afbe3ad1d	eea_hist_b069442b066383c590d6918c	\N
eea_tvv_range_3275c8b61c3a4a6afbe3ad1d	eea_hist_a8c75302c2e21d13c3381fbc	\N
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_15d5644288650e64692a3a0d	\N
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_9dc4d98733c16c7ad75172f3	\N
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_358c7b5b9f12c070798c06dd	\N
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_960f079ce47a6c2eec4b54fb	\N
eea_tvv_range_687bbdd942d9af15b7883122	eea_hist_accd132b1691eca9b1c43d9e	\N
eea_tvv_range_0e0ffeccf38a903828ddf6fd	eea_hist_fba36ada862acbc32ae158a7	\N
eea_tvv_range_0e0ffeccf38a903828ddf6fd	eea_hist_f20d99da04bd13ddc21c2d87	\N
eea_tvv_range_4d15a933466fa4217c7d15a8	eea_hist_8a0a79397310fb6abf34598e	\N
eea_tvv_range_4d15a933466fa4217c7d15a8	eea_hist_76d5a21edb6a0c874648cf11	\N
eea_tvv_range_4d15a933466fa4217c7d15a8	eea_hist_d67e69926f0ba1e3d59ac74f	\N
eea_tvv_range_4d15a933466fa4217c7d15a8	eea_hist_4a7a00eb3fd34dfb1ad9994b	\N
eea_tvv_range_24a0dde1e3391514cd342f0e	eea_hist_056dcf1f7c8189b754fef9d1	\N
eea_tvv_range_24a0dde1e3391514cd342f0e	eea_hist_5df2d77341263ecce74cb862	\N
eea_tvv_range_24a0dde1e3391514cd342f0e	eea_hist_d3f40aa6a75cf0ce11bdd034	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_7ba5cf62545ea8243779fc40	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_37b0da010f9e51cf14a1d626	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_6ab0d1aa6629392df83ed80a	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_6165f699ec597f11b3015f5b	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_54d857c4302a2ab74ebd685c	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_331848f5a98dc9225601f48c	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_986fa37e3864a8305e5e24c2	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_aa74e4b99e697cd846d8e8bc	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_ba85971fd74d1c5841a05fd1	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_26e1761627554e54ad0a8c67	\N
eea_tvv_range_c5bdf3e95326eea1b457a372	eea_hist_61ba89147d07bcdb6c208c4d	\N
eea_tvv_range_b5a71a27b31333f41b73aa52	eea_hist_b2b1e1243bae91bece2b8453	\N
eea_tvv_range_b5a71a27b31333f41b73aa52	eea_hist_3b551821005e2b29c21b0a83	\N
eea_tvv_range_b5a71a27b31333f41b73aa52	eea_hist_ab0e159880fca41f030cd2e9	\N
eea_tvv_range_7f0284d77e5ac3d342719de2	eea_hist_f7a8a7e27c002478877ace3b	\N
eea_tvv_range_7f0284d77e5ac3d342719de2	eea_hist_7f6a579f6867001c6ec794f7	\N
eea_tvv_range_7f0284d77e5ac3d342719de2	eea_hist_e7275733950e0a24a502d837	\N
eea_tvv_range_7f0284d77e5ac3d342719de2	eea_hist_832931d207de0267b22bd7f7	\N
eea_tvv_range_7f0284d77e5ac3d342719de2	eea_hist_59097a3dbf23be0f69a35154	\N
eea_tvv_range_9b5215d80a5447d955b315f2	eea_hist_a8458f1ed56feee867ca1421	\N
eea_tvv_range_9b5215d80a5447d955b315f2	eea_hist_73e47431fadc0f7df3f80cbb	\N
eea_tvv_range_9b5215d80a5447d955b315f2	eea_hist_136177d7d9886ec24815de69	\N
eea_tvv_range_591e8a2675dd23b4eb1457ac	eea_hist_62608a19f078882389836538	\N
eea_tvv_range_591e8a2675dd23b4eb1457ac	eea_hist_f5f4df25d88d88f5b9ea2ad5	\N
eea_tvv_range_591e8a2675dd23b4eb1457ac	eea_hist_82a9fb139dc317d12bc9627e	\N
eea_tvv_range_591e8a2675dd23b4eb1457ac	eea_hist_585b0c43cfc0364753e09a85	\N
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_8d5c34f8471b6af3f7e5fc57	\N
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_64020436e34d4dd22c08c20a	\N
eea_tvv_range_e0d9ea241db8d09795dbd47a	eea_hist_ebcb65e979dcb6f1d7087204	\N
eea_tvv_range_c21aa284e1b774465ac6b711	eea_hist_6d1d95abc2935c861ef0c1b0	\N
eea_tvv_range_c21aa284e1b774465ac6b711	eea_hist_f89b5168e067282fe2714145	\N
eea_tvv_range_c21aa284e1b774465ac6b711	eea_hist_f96c5e59eb8bb6d1b7ccca9e	\N
eea_tvv_range_c21aa284e1b774465ac6b711	eea_hist_2229141e761ff38122e9ae2f	\N
eea_tvv_range_c21aa284e1b774465ac6b711	eea_hist_4528f889a723dd3225aebea5	\N
eea_tvv_range_02efcaff35d79d0a771c9cca	eea_hist_a53a1c8622c60aad4c271cd4	\N
eea_tvv_range_02efcaff35d79d0a771c9cca	eea_hist_0e014339690ba119a44dd223	\N
eea_tvv_range_02efcaff35d79d0a771c9cca	eea_hist_68dd74657ff7ae2da51124fa	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_66ee717b74cd31a83f392264	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_e537e1c7f8cb535cd66ec69d	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_a7900c93e9229f7a3a30d71e	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_a231f4bb3db86810461eb2d4	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_59dbf1192f04dddc13e41fe8	\N
eea_tvv_range_fa14ff22e21fecf9bad416a4	eea_hist_077fd0f52c8d419c21439cfc	\N
eea_tvv_range_f26ccb6847bc3f669eadb778	eea_hist_7fe415802efcec1d9e8d890a	\N
eea_tvv_range_f26ccb6847bc3f669eadb778	eea_hist_22a982f4b90caa439f445d52	\N
eea_tvv_range_f26ccb6847bc3f669eadb778	eea_hist_47884ddc0f051c2358fcde76	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_1b5a10416a631711853d2f6b	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ee0e3e8364b4587a2a8a627e	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_3cf69b206c5c6e95c3dbe9ab	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_4f3f1906d27e49275b78064e	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_009fca4955b29f84a0f34dd6	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ed48a7c3a97ed7063947521e	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_ab6a731102242b7cbdf1e5a7	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_48caf88610ef8be885753d39	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_771f8946efa72dd02ba1aeab	\N
eea_tvv_range_393460d8e624c0cc477da99e	eea_hist_16f60243454fbedccb9c242d	\N
eea_tvv_range_53ece3ddadd23269945c228f	eea_hist_bd1e2de5aad04521adf0fe02	\N
eea_tvv_range_53ece3ddadd23269945c228f	eea_hist_0106a75d52c1fc43a66dd81e	\N
eea_tvv_range_53ece3ddadd23269945c228f	eea_hist_32f7fe25ec70362729a3707f	\N
eea_tvv_range_53ece3ddadd23269945c228f	eea_hist_e38b3b261bec6ef3ee6b575b	\N
eea_tvv_range_53ece3ddadd23269945c228f	eea_hist_a2932870c9320025bebe2264	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_594f87a31c0746967b832840	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_21da2ae8db16ef6dbe1d1d23	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_1b03c988a9c9e38b47345b86	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_81fa80a9adf281de5fe7dc1a	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_5db3689e9631baf16a2613ba	\N
eea_tvv_range_eab82410a2a63290cb341141	eea_hist_44acadddc482b91b3e15a42e	\N
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_3b4dcc4a2715dabe80cf92af	\N
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_63fdfcf56af0bddb7955f786	\N
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_7094e26e7bf6d504668c555c	\N
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_0a8c571c28250db7662aa0a1	\N
eea_tvv_range_73ca051a6b522c74e1e2018a	eea_hist_1bf460b5b678b2c68c2e20d0	\N
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_ac84dfecf3ec584c305a0291	\N
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_c817f078be39c3eaa52ef9e6	\N
eea_tvv_range_e5b03d53ea2f05ffb08d553a	eea_hist_5f3359df1c95e759207ebe1d	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_32cab830415e40debb953d67	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_be76edec3905f44c906bac3e	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_16e94a8f121882c5e692e023	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_9fe269b20e0bd6c037b65e9b	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_7e98a3562107a16d13205a09	\N
eea_tvv_range_4b6cc02cf5e249bcfc27b4c2	eea_hist_8111c9cadb4b1a53d2e6636a	\N
eea_tvv_range_04d3f30c184f1c25dacd3e81	eea_hist_2ba88a17006e25576b5fde83	\N
eea_tvv_range_04d3f30c184f1c25dacd3e81	eea_hist_2b3decdf434826861733eed3	\N
eea_tvv_range_72a80cfec2086de4e26c1939	eea_hist_b89025a590e7dfee1a44eb4e	\N
eea_tvv_range_72a80cfec2086de4e26c1939	eea_hist_fa42020cc6d32765ae691a3f	\N
eea_tvv_range_72a80cfec2086de4e26c1939	eea_hist_6912cc6d390fc9248868e771	\N
eea_tvv_range_72a80cfec2086de4e26c1939	current_cluster:39b0e01cf55e2d32d672fa983279c533	196
eea_tvv_range_c405087a1261d2f9a82f04df	eea_hist_ec24b856ed0697859fc128d9	\N
eea_tvv_range_c405087a1261d2f9a82f04df	eea_hist_89ce8a354bf2e12ed987a35b	\N
eea_tvv_range_c405087a1261d2f9a82f04df	eea_hist_bac9d8df845790edacd76cb1	\N
eea_tvv_range_c405087a1261d2f9a82f04df	current_cluster:c2b7f7e3a05fc9486e5d40665ba05bc3	200
eea_tvv_range_59edb20e7b7edece0f8d953b	eea_hist_cb54f13092dd44982127862f	\N
eea_tvv_range_59edb20e7b7edece0f8d953b	eea_hist_d48a4145f1aa9b3936f3cc8e	\N
eea_tvv_range_59edb20e7b7edece0f8d953b	current_cluster:ce53e74c27c1f983936fd50f727397f9	197
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_d00c05b1104be25e5790e6fa	\N
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_5e2cb2799258897b0196a954	\N
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_4fbafa282b1af30b7f9e397b	\N
eea_tvv_range_89c21ec1d8a4e21b1fd2c385	eea_hist_dc76872d2dc2db7afa09cbcd	\N
eea_tvv_range_4e91cec682df81fe3f609256	eea_hist_f0db635964c46e7121b3fe1a	\N
eea_tvv_range_4e91cec682df81fe3f609256	eea_hist_b37ef6a44280c4bbcf2b2c15	\N
eea_tvv_range_4e91cec682df81fe3f609256	eea_hist_f65e8b6fc5cc4bb349cd6ba0	\N
eea_tvv_range_517702a44e30535821863b92	eea_hist_d96661563392d7aa482b07dd	\N
eea_tvv_range_517702a44e30535821863b92	eea_hist_7221010e88141f08945bc03e	\N
eea_tvv_range_517702a44e30535821863b92	eea_hist_c77c678a7fb6d87e761d3ff1	\N
eea_tvv_range_517702a44e30535821863b92	eea_hist_6b94f4704a88b713161086ab	\N
eea_tvv_range_bde917f86e1173d2733412c9	eea_hist_389b78cc9c7759ae84aeb5ff	\N
eea_tvv_range_bde917f86e1173d2733412c9	eea_hist_078d0ffe1073e2b39ef21a18	\N
eea_tvv_range_bde917f86e1173d2733412c9	eea_hist_068a4485d5f3fa54497f5232	\N
eea_tvv_range_51ebc32b37564e1ef5998129	eea_hist_0e6e6cecf018da8ce6099658	\N
eea_tvv_range_51ebc32b37564e1ef5998129	eea_hist_bd906a3bef51d29bc3429483	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_9e27da6fdee591ed8f167bd4	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_017a119aa6fbeac68ec816ab	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_496bf42fb7bb97b3c9723f6f	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_50a653a01c2dd5147e8ad94a	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_2e448022965a2c6a16023196	\N
eea_tvv_range_ecbe0456396a1a1b990d0718	eea_hist_dc8ce2ae1098d68121a36633	\N
eea_tvv_range_392da0f5b8ea968f49d99240	eea_hist_775ff02bbf03204506ed5c3d	\N
eea_tvv_range_392da0f5b8ea968f49d99240	eea_hist_e2996b07461d4bff8835f5c2	\N
eea_tvv_range_392da0f5b8ea968f49d99240	eea_hist_866b8e524710ee16454a8876	\N
eea_tvv_range_392da0f5b8ea968f49d99240	eea_hist_e0cd825ef2961bf69ffd71e0	\N
eea_tvv_range_392da0f5b8ea968f49d99240	eea_hist_7a6749c3eb0c8e4e26326c00	\N
eea_tvv_range_dafb7da8c4e68e92ca670b85	eea_hist_acce6c0d45b26e5529158c24	\N
eea_tvv_range_dafb7da8c4e68e92ca670b85	eea_hist_1b3bff3dab7775e65aef0346	\N
eea_tvv_range_dafb7da8c4e68e92ca670b85	eea_hist_229bbec7e0f813540974ffde	\N
eea_tvv_range_dafb7da8c4e68e92ca670b85	eea_hist_02543b7169ff5d98178a5531	\N
eea_tvv_range_dafb7da8c4e68e92ca670b85	eea_hist_eb05d84a2f32b1cc8bade147	\N
eea_tvv_range_1ff5767ada6444304a21cadd	eea_hist_caf2d7d8cfb9c49041c1c096	\N
eea_tvv_range_1ff5767ada6444304a21cadd	eea_hist_02677746b30e8efa1af80f8e	\N
eea_tvv_range_1ff5767ada6444304a21cadd	eea_hist_72eaa25f3172c65065df7d5d	\N
eea_tvv_range_1ff5767ada6444304a21cadd	current_cluster:7df2cc1d1b6f8208c60e21a49742460b	64
eea_tvv_range_9451cb9803523eeca93db8fe	eea_hist_253598be55ba92e8458b24c0	\N
eea_tvv_range_9451cb9803523eeca93db8fe	eea_hist_7526540d2a6aec59f5385541	\N
eea_tvv_range_9451cb9803523eeca93db8fe	eea_hist_4edef64aec32c0d7c71f2138	\N
eea_tvv_range_9451cb9803523eeca93db8fe	eea_hist_030f15a619ab306171bb2045	\N
eea_tvv_range_9451cb9803523eeca93db8fe	eea_hist_6eb9121e96aac815dd22b558	\N
eea_tvv_range_9451cb9803523eeca93db8fe	current_cluster:acfc299b005e5d2d9f444e30e823b05d	1
eea_tvv_range_5f24bce785cc310e768d342f	eea_hist_0a2d50123aafbbf2d1e28084	\N
eea_tvv_range_5f24bce785cc310e768d342f	eea_hist_f86ff2849d2ffaa3f206ee03	\N
eea_tvv_range_5f24bce785cc310e768d342f	current_cluster:7b56f39d86c84601e645f1da6344aea8	2
eea_tvv_range_d11b9fedba43e3712b9d1f97	eea_hist_1f065c6d02a10d6ae71853cc	\N
eea_tvv_range_d11b9fedba43e3712b9d1f97	eea_hist_56b7ecddb81cfa7665e59594	\N
eea_tvv_range_d11b9fedba43e3712b9d1f97	current_cluster:65bd545386c4076203cef5d6c0c58752	188
eea_tvv_range_e3d4a5c584efffb6eb7279e0	eea_hist_70df5f3fb6d0609c54efdac4	\N
eea_tvv_range_e3d4a5c584efffb6eb7279e0	eea_hist_63fa34d8f4d3b0bc9c7bdcf2	\N
eea_tvv_range_e3d4a5c584efffb6eb7279e0	eea_hist_f3d40da622bea604686d7161	\N
eea_tvv_range_53363c0d63c4555013f8f2d9	eea_hist_f6c5c013364986893910b708	\N
eea_tvv_range_53363c0d63c4555013f8f2d9	eea_hist_888a96eff1c09c8a9fbe334a	\N
eea_tvv_range_53363c0d63c4555013f8f2d9	eea_hist_0917b94defdd0b4cc8d1dc8c	\N
eea_tvv_range_53363c0d63c4555013f8f2d9	eea_hist_d6081e6754c9e4692b93782d	\N
eea_tvv_range_5d3f191fc245a81389421ba7	eea_hist_778faf20e464cdf29a46d6a4	\N
eea_tvv_range_5d3f191fc245a81389421ba7	eea_hist_f21e35a3e3e65a3b0e615149	\N
eea_tvv_range_5d3f191fc245a81389421ba7	current_cluster:c2d5c3af02b0cd23242e113d9b3e847d	158
eea_tvv_range_a5882aeede4572aa9998129a	eea_hist_e6b2e33147f31271862d2bb6	\N
eea_tvv_range_a5882aeede4572aa9998129a	eea_hist_d7598381a5481db7ae5bd791	\N
eea_tvv_range_a5882aeede4572aa9998129a	current_cluster:7040fdf786b21ade2be0c5075e4a8bf8	1102
eea_tvv_range_f7f8f303f4802a5bba6a33ee	eea_hist_735150551e94d1685f9f63fd	\N
eea_tvv_range_f7f8f303f4802a5bba6a33ee	eea_hist_e288af581393c6dcfebb72cb	\N
eea_tvv_range_f7f8f303f4802a5bba6a33ee	eea_hist_7b2af02b2ca94f5225794aa7	\N
eea_tvv_range_002f3204d6bdfef3ea8af791	eea_hist_2915f16ba0f4413df709fd79	\N
eea_tvv_range_002f3204d6bdfef3ea8af791	eea_hist_10a8a0035286b1ec3f97cd05	\N
eea_tvv_range_002f3204d6bdfef3ea8af791	eea_hist_09ea11d41c5b94d5d7c18d2e	\N
eea_tvv_range_002f3204d6bdfef3ea8af791	eea_hist_672dffd431655b295af3f758	\N
eea_tvv_range_400adf8bc375c0e2ada15358	eea_hist_3a32c958085a13d4498b84e2	\N
eea_tvv_range_400adf8bc375c0e2ada15358	eea_hist_b167469375feffd6858edd6c	\N
eea_tvv_range_400adf8bc375c0e2ada15358	eea_hist_2dea08f83a58d6345d0e5dee	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_46991e1dfb3fe3654eab03e4	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_706956190129ad094548715c	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_f351e31c3263ea702e306c52	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_3377403eeff0cb624e624ac3	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_e8de0ef095e2b6d9d016260e	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_513489b329e5a0c5f27e0e8c	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_b03cad9c85ffd2040cac3090	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_f1b3884f1769f800564b929c	\N
eea_tvv_range_9809fadb0082180570734a7c	eea_hist_cfc9d75bd8d640d172e4676e	\N
eea_tvv_range_6c5873ff4df7b9788fc223fa	eea_hist_30795c0ebbbf23d7cb6380fe	\N
eea_tvv_range_6c5873ff4df7b9788fc223fa	eea_hist_acc485a14b52ce6f28d5e41c	\N
eea_tvv_range_6c5873ff4df7b9788fc223fa	eea_hist_166aec4bf778562ec5338e4e	\N
eea_tvv_range_6c5873ff4df7b9788fc223fa	eea_hist_d2b355e277754ea7599c6d93	\N
eea_tvv_range_6c5873ff4df7b9788fc223fa	eea_hist_44aa5b60b80a7738b2fd75b0	\N
eea_tvv_range_5cc85ab27f41af7f97c68014	eea_hist_d6f50afcf689f4d2c4cee631	\N
eea_tvv_range_5cc85ab27f41af7f97c68014	eea_hist_d77fc65c783b43582c7c7b65	\N
eea_tvv_range_5cc85ab27f41af7f97c68014	eea_hist_c70b4b25f6f331e145a58230	\N
eea_tvv_range_5cc85ab27f41af7f97c68014	eea_hist_343a03ae445b67f49f229826	\N
eea_tvv_range_66159e7e9172147a017a508e	eea_hist_580e95b205c6dd7325b1a494	\N
eea_tvv_range_66159e7e9172147a017a508e	eea_hist_632aa6516d9d56b3af78bbe8	\N
eea_tvv_range_66159e7e9172147a017a508e	eea_hist_3c9d69e14e389b72d513139e	\N
eea_tvv_range_a45cb063848a421166df3549	eea_hist_9a6a6e9cf767f2612646a7c6	\N
eea_tvv_range_a45cb063848a421166df3549	eea_hist_3a5be4b7e78718e8e9452bc5	\N
eea_tvv_range_a45cb063848a421166df3549	eea_hist_eba872e18f31356c11ef89eb	\N
eea_tvv_range_d1b10670751446fcda46e90c	eea_hist_1e51e49980cf45e76ac8133f	\N
eea_tvv_range_d1b10670751446fcda46e90c	eea_hist_e265e16d2be7bccdae585feb	\N
eea_tvv_range_d1b10670751446fcda46e90c	eea_hist_a5f60ac337222df5e0ad9d28	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_88dd42a61e6660afb8436874	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_d0ea3ee3132dfc0b318bc8d5	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_7bfdc80d4c0559ed4e33b97a	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_b1f0b25cc38633e270dbab92	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_5937fa67e6f27cc9435a0e24	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_6aaed96dc407a648716f0b9b	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_d3985857683a331433420e81	\N
eea_tvv_range_00c0ee5b0931a09bf3f7fdf5	eea_hist_9ab196bb9298eb0ba59238dd	\N
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	eea_hist_31bf5a5be45b08b44b8d9828	\N
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	eea_hist_2d035ad35885411a1afd7373	\N
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	eea_hist_3a23be8fa5879a18d73fbe5e	\N
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	eea_hist_a8cf729a99364ca96c31d5d1	\N
eea_tvv_range_6e99a5d0d246fb9a0c7b6dbc	eea_hist_94eeb4e68ee3091b62940d1e	\N
eea_tvv_range_3157234a9db68f2376ed76e1	eea_hist_0a4804286d1cac1468a676fb	\N
eea_tvv_range_3157234a9db68f2376ed76e1	eea_hist_ccc54e5b5ea958f989fc1f3f	\N
eea_tvv_range_3157234a9db68f2376ed76e1	eea_hist_7c5a6d3ff3135539b192ef0d	\N
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_13ee6f40de16d9eed41ade10	\N
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_6387bc8a03d1255ede0b39e2	\N
eea_tvv_range_52116adf0c63104421d10a95	eea_hist_d5c02498473aaab647608740	\N
eea_tvv_range_892f2b5ba5bf997354234038	eea_hist_dfce8f276a29c726a326e60f	\N
eea_tvv_range_892f2b5ba5bf997354234038	eea_hist_cb810aa7f99c041b8e9c74c5	\N
eea_tvv_range_892f2b5ba5bf997354234038	eea_hist_ac6ba9b7bb390ca0b46a0f9f	\N
eea_tvv_range_892f2b5ba5bf997354234038	eea_hist_ad441ee54170b681c2de5d4a	\N
eea_tvv_range_892f2b5ba5bf997354234038	eea_hist_c10bd885db5f4dfc0d43c068	\N
eea_tvv_range_892f2b5ba5bf997354234038	current_cluster:95f90025b8643790912fae79c067f0bc	457
eea_tvv_range_80eb1c932629f6810d275c04	eea_hist_8316f8b3e1f466d471e1b9a4	\N
eea_tvv_range_80eb1c932629f6810d275c04	eea_hist_200cbfbdfffc4e35c0efa590	\N
eea_tvv_range_80eb1c932629f6810d275c04	eea_hist_c594df8e772bc7d26c2f0939	\N
eea_tvv_range_80eb1c932629f6810d275c04	eea_hist_9d1a87232c6d3c8b3a5762cc	\N
eea_tvv_range_80eb1c932629f6810d275c04	eea_hist_c24112062355e7e9e483931a	\N
eea_tvv_range_80eb1c932629f6810d275c04	current_cluster:e86b613048d36841e9672413cb323570	456
eea_tvv_range_46afebf5cba9b066dddf5866	eea_hist_23bca812e3754c381c02513e	\N
eea_tvv_range_46afebf5cba9b066dddf5866	eea_hist_e0c3e74c4e2f572d978000b2	\N
eea_tvv_range_46afebf5cba9b066dddf5866	eea_hist_da1497a28fb2611e074e8be2	\N
eea_tvv_range_bcc4f724f6fbf60557182d9d	eea_hist_86da8fcfccf46ec51c718bd7	\N
eea_tvv_range_bcc4f724f6fbf60557182d9d	eea_hist_173d2c641b8868e53e9861d7	\N
eea_tvv_range_bcc4f724f6fbf60557182d9d	eea_hist_4f06abef4680e4ef816e5ae7	\N
eea_tvv_range_2e30dabedd396ea78c410b31	eea_hist_e87c6cf1c44eaf67743e4945	\N
eea_tvv_range_2e30dabedd396ea78c410b31	eea_hist_88b49037700e11321314117f	\N
eea_tvv_range_2e30dabedd396ea78c410b31	eea_hist_8b5b0b1e160bf46d1a1fad09	\N
eea_tvv_range_2e30dabedd396ea78c410b31	eea_hist_f09e151385032f5d1f76e884	\N
eea_tvv_range_2e30dabedd396ea78c410b31	eea_hist_1c08708bc97f618fef16b827	\N
eea_tvv_range_fa2d6f9dcf8c7c0689d6618b	eea_hist_0476d08dc904e49f612b0120	\N
eea_tvv_range_fa2d6f9dcf8c7c0689d6618b	eea_hist_0cd790f9d83529134ee89d47	\N
eea_tvv_range_fa2d6f9dcf8c7c0689d6618b	eea_hist_68d617c9ef2f76c627b117b2	\N
eea_tvv_range_fa2d6f9dcf8c7c0689d6618b	eea_hist_d5c8350bccef56ab0d9a6fa8	\N
eea_tvv_range_6469b0fef2525122a652e83f	eea_hist_bdd099e16b63c75b98ef7f74	\N
eea_tvv_range_6469b0fef2525122a652e83f	eea_hist_2bc5604e7896c5502e3fa0ba	\N
eea_tvv_range_6469b0fef2525122a652e83f	eea_hist_1f4905338110c63edb003d61	\N
eea_tvv_range_6469b0fef2525122a652e83f	eea_hist_b5a322d5f77c7fb91d02b102	\N
eea_tvv_range_c0ea74023a9bc9a0b9db37c9	eea_hist_cfc18b3ba39f745e95205019	\N
eea_tvv_range_c0ea74023a9bc9a0b9db37c9	eea_hist_d77e9ef82382a813dc4bf431	\N
eea_tvv_range_c0ea74023a9bc9a0b9db37c9	eea_hist_0ba0290ccb4eed46392bee7e	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_5a55600dd411ae9db5534899	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_ea423560eeb1c482642b2329	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_e8339da28887ee5ed1616e33	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_a3d305301f357ba15c70ef69	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_8d585e3662dbdf083181292e	\N
eea_tvv_range_3b350087301e33cd15058cee	eea_hist_74c4faa71351980798a0b533	\N
eea_tvv_range_727d8831ede36de111ae0e11	eea_hist_31962c09b89965d06c1bbb65	\N
eea_tvv_range_727d8831ede36de111ae0e11	eea_hist_45c8ea17b2d81ef5789f4271	\N
eea_tvv_range_727d8831ede36de111ae0e11	eea_hist_d7f8d80754db163f57e51134	\N
eea_tvv_range_727d8831ede36de111ae0e11	eea_hist_e5de0ddcab4d60f8339ed649	\N
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_474cd278a6bebb35683fe334	\N
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_25fe69b749412f035fe2aef4	\N
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_4e81c8a039f397841552825b	\N
eea_tvv_range_e656e276f25b572581f5f2c4	eea_hist_e1457da6b78a562da2a78d27	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_d9a832a7d09a861048e1e6a0	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_a503bab873236dfcc33fe64d	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_ce10607b51073fc8f65c3486	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_10d75f1182f3c6c63548d22a	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_fb58a72188dc7a99ac22ecb4	\N
eea_tvv_range_45736405de27864554886d71	eea_hist_d78a1a61238bfb3b558d23d3	\N
eea_tvv_range_45736405de27864554886d71	current_cluster:522abb3d450b4a2a2a2ded21a710f84c	469
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_fa9fc977eed139de33922781	\N
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_302c69128b701fe266319535	\N
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_7ff93944e01b50efeabb2e30	\N
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_6b0b56249183be52c578ca5e	\N
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_caa256cdc077ae63c8e0723d	\N
eea_tvv_range_b809aa509aa602b1a1af1598	eea_hist_6c02d0a87d327313c78711f2	\N
eea_tvv_range_0a58d26041de87f49697c03d	eea_hist_ed283a41d95bbeb598e7d8bf	\N
eea_tvv_range_0a58d26041de87f49697c03d	eea_hist_f2ed7c9326ea5527de529cae	\N
eea_tvv_range_0a58d26041de87f49697c03d	eea_hist_708329b1f782d1643d3a7134	\N
eea_tvv_range_0a58d26041de87f49697c03d	eea_hist_2f3cca6f0bd64e3982e052f3	\N
eea_tvv_range_1768ec337e557388b3f30453	eea_hist_4305672e06faddafc0960e0b	\N
eea_tvv_range_1768ec337e557388b3f30453	eea_hist_c065eafbb8316bfa9d822cd8	\N
eea_tvv_range_1768ec337e557388b3f30453	current_cluster:3391b8c9029f4d615f7edc9bc437f7d0	467
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_2882289901633b7bb5bf9fcb	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_a73d645be35cc8bdcda5ae2b	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_7f326645d413de4754de500b	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_3e5ae2edbe413b49bc055dec	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_e8a4afc210873f461712a05e	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_820a8cc67a104e1b009baa51	\N
eea_tvv_range_88fb2c885612239a85baaddc	eea_hist_a8c9872a9b41782c090103ce	\N
eea_tvv_range_36b306947137950cb953fa3f	eea_hist_e854f62c3e140cc1e05656ac	\N
eea_tvv_range_36b306947137950cb953fa3f	eea_hist_8879059ff0910fb3ce2b365e	\N
eea_tvv_range_36b306947137950cb953fa3f	eea_hist_f9a71803abb47c14e3850c1a	\N
eea_tvv_range_36b306947137950cb953fa3f	eea_hist_cd908340ddb8837e330776f8	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_b15daab18667327ea1410dfd	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_a5e5cf77a10bb441243a4771	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_404672efc3cd5c95b1ecd5d4	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_0069e8630d0ee8d7979711c8	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_cce585ea61e98c2fa60bf0fd	\N
eea_tvv_range_e2f654bf35da7bc1e1df9331	eea_hist_fca831a822ffd7a1039974e5	\N
eea_tvv_range_583e701ff6545338ad142a1c	eea_hist_9ca3c80df893065b4119d791	\N
eea_tvv_range_583e701ff6545338ad142a1c	eea_hist_ad0e574916b3ecb93a1c0470	\N
eea_tvv_range_583e701ff6545338ad142a1c	eea_hist_148a00e2bc8a8e4abc0776b3	\N
eea_tvv_range_4caa77035e9d742ccbde8154	eea_hist_537ef2c57a5561990422b702	\N
eea_tvv_range_4caa77035e9d742ccbde8154	eea_hist_d81990e703e86f76576f3d52	\N
eea_tvv_range_4caa77035e9d742ccbde8154	eea_hist_d238f41135351e8072703c75	\N
eea_tvv_range_4caa77035e9d742ccbde8154	eea_hist_11079f714940d61a2010c0e8	\N
eea_tvv_range_884d7089c0469eaedbef6224	eea_hist_48994014a49fda4e5f692885	\N
eea_tvv_range_884d7089c0469eaedbef6224	eea_hist_9f537ce6c5818c8b1d04b580	\N
eea_tvv_range_884d7089c0469eaedbef6224	eea_hist_54cc8dbe56ce7a3fdc36c4d0	\N
eea_tvv_range_884d7089c0469eaedbef6224	eea_hist_684d908c9d5263ccf0013dc5	\N
eea_tvv_range_3f39e79c11eb8a6783d115b6	eea_hist_1fd26dcb25c029506dd39cd9	\N
eea_tvv_range_3f39e79c11eb8a6783d115b6	eea_hist_b878cbfd530eba411aaa17f3	\N
eea_tvv_range_3f39e79c11eb8a6783d115b6	eea_hist_3f15054f71babf2a83f983ec	\N
eea_tvv_range_1d0a46c4ad2efe30a2f98440	eea_hist_c354fd24339a71e6e90e483c	\N
eea_tvv_range_1d0a46c4ad2efe30a2f98440	eea_hist_9b40b2023a35a7f5800c88b5	\N
eea_tvv_range_1d0a46c4ad2efe30a2f98440	eea_hist_acee17aa22144bd5c4d381ad	\N
eea_tvv_range_1d0a46c4ad2efe30a2f98440	eea_hist_0d148297e5989cc3805f6c3f	\N
eea_tvv_range_1d0a46c4ad2efe30a2f98440	current_cluster:fc8bfbfe6327b6941375129fdfe4a384	390
eea_tvv_range_ebebdafa6364063a232b7234	eea_hist_745c378af040d4597fd8caad	\N
eea_tvv_range_ebebdafa6364063a232b7234	eea_hist_70ebd8aeff3e69e1a4295169	\N
eea_tvv_range_ebebdafa6364063a232b7234	current_cluster:020262e8ee615a85472fa765a02dc2b9	1124
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_91a41bf5e1f574d416b67d72	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_369f06259c20ab93461ff5cb	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_faad314316225e0990f07802	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_df63cbe71a25569f64b11996	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_74f93801a2fde2135fd1b1dc	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_e9f37ae0cbf0ab70b2eb3eaf	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_58d7858ac2a4aace73c09005	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_f43170bf57037b27d7bfd61d	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_790af063fb2759cd678c300e	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_bd9ee72cb9b700a7d5885a74	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_fdfb2706688fc257f5871fef	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_58f04a531f9944694f4a5524	\N
eea_tvv_range_85971cbb19569e2a15d7aff9	eea_hist_269d0b85fcfd6de0d9221fb5	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_f4a8d659f6cfcf26c08eba02	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_b983c5e5ec38d3d0298022ba	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_9f51f2e5e41dc6200f168cb0	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_7721f6f1e8175147efd1b142	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_98450c944a3f995b695d1025	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_e50d30bd94ab908722ef9673	\N
eea_tvv_range_d16a624c4547b508c1f1ae15	eea_hist_41eafe0f9d9ef9af6fc25daf	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_c207a3d8f1cf525db1cab8e5	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_7faf9afb970a4c7f07fc07ce	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_5cbf5e130766656e64c4d789	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_b8aae6c7b287834fe53a5706	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_4c0bb255f089d1f2ec337aa1	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_f67bc64f03ee54bf61d07782	\N
eea_tvv_range_aa5980c13c1224c53b2ebed1	eea_hist_242876e44e19e6f22babd298	\N
eea_tvv_range_f9049366a2e93d2e2ac2211d	eea_hist_cd3dc7c468f38900babcfc70	\N
eea_tvv_range_f9049366a2e93d2e2ac2211d	eea_hist_1ebda9f5df4e4ef2ff588ba5	\N
eea_tvv_range_f9049366a2e93d2e2ac2211d	eea_hist_480785c25e12f47584bf8c9c	\N
eea_tvv_range_f9049366a2e93d2e2ac2211d	eea_hist_abf49f98d7a0d8c0255277fe	\N
eea_tvv_range_f6baf8ec1394b88c68ada143	eea_hist_8a1cf31d4ccd78a0166ebcb2	\N
eea_tvv_range_f6baf8ec1394b88c68ada143	eea_hist_34e36a0efbdbe4ef86051a02	\N
eea_tvv_range_f6baf8ec1394b88c68ada143	eea_hist_7971a712b9da67155563c2ab	\N
eea_tvv_range_f6baf8ec1394b88c68ada143	eea_hist_c4daebb9301afcb344a7b7ea	\N
eea_tvv_range_f6baf8ec1394b88c68ada143	eea_hist_8b9f407fe546cfbf73e76a26	\N
eea_tvv_range_f4f187856968bf13920e829a	eea_hist_ae1118d0c91ec612b430661d	\N
eea_tvv_range_f4f187856968bf13920e829a	eea_hist_404ddd0ccfdc31f8bb840d45	\N
eea_tvv_range_f4f187856968bf13920e829a	eea_hist_34aa1dfabac1ef655798fd2c	\N
eea_tvv_range_f4f187856968bf13920e829a	eea_hist_ff2ecdaf9edefcce8d75f7a7	\N
eea_tvv_range_27744e392e621d39d53e86bd	eea_hist_f88714d8c30b006a26d5dbdf	\N
eea_tvv_range_27744e392e621d39d53e86bd	eea_hist_a06623a431ff9583ba1b30bf	\N
eea_tvv_range_27744e392e621d39d53e86bd	eea_hist_72af4a8bdac42480e2d0c841	\N
eea_tvv_range_366b5705e91e0fc8bc85789c	eea_hist_4afb09f9d9e9d7cb0e33cd8e	\N
eea_tvv_range_366b5705e91e0fc8bc85789c	eea_hist_8e196e4efd44c1eb24532db8	\N
eea_tvv_range_366b5705e91e0fc8bc85789c	eea_hist_dc222ccb622f524ceae418fd	\N
eea_tvv_range_2746cd5babd095b81b49eb69	eea_hist_3a1e3272c5417436006576ef	\N
eea_tvv_range_2746cd5babd095b81b49eb69	eea_hist_fe26fa7980d579f0e96c08c2	\N
eea_tvv_range_2746cd5babd095b81b49eb69	eea_hist_fb6dbfe8550698913ed41c51	\N
eea_tvv_range_2746cd5babd095b81b49eb69	current_cluster:9810ea6c38395877bcd5b43e51adbe93	212
eea_tvv_range_97f43da8aebb886eb5dccaf6	eea_hist_85358930a30a084341df96b4	\N
eea_tvv_range_97f43da8aebb886eb5dccaf6	eea_hist_0b07622b5157a96a524f6ff3	\N
eea_tvv_range_97f43da8aebb886eb5dccaf6	current_cluster:1b6bd821903840d2a28dd1631f3bc344	213
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_b2624e22d784ac01c761c20b	\N
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_c1531fc7ea824bbd5014d533	\N
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_0bc3e255bb10d7e5391cc0de	\N
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_effe14862028ec1ade2e6681	\N
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_bbf2cdd41b321292f79a85b4	\N
eea_tvv_range_4bee0f86234b7dbd8536b465	eea_hist_9aa963eb35055103bee210c6	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_ed6ca8eef51501bc19bcbbe6	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_2332f67dacfe2f69d329f450	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_c189c6d5e1aee59d00dc6ef1	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_43d5e0a901b23ce66f13cb9e	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_ec9021e858fa0b0f34c32ec9	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_f6e7259ff2fcbb878317f000	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_056b3784989d6b969e40f841	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	eea_hist_21b886dc8944d1d1cfe45fad	\N
eea_tvv_range_7e67f6ad7b8cc55aec011c04	current_cluster:4e9f0d3511a69e4b0ce9c824efa10c72	162
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_f758bb5dc15002b33ded0d38	\N
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_5345225df32dfb66f721d447	\N
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_e25e1cd06b6a95f0987ac179	\N
eea_tvv_range_e2a30dccae59deaccf7aa557	eea_hist_77c8bbd5bd9fc79b11100298	\N
eea_tvv_range_6a8938348c26a4524c355a50	eea_hist_b42660fc55de3804d1440ad2	\N
eea_tvv_range_6a8938348c26a4524c355a50	eea_hist_2d7b04e881feda1db320fb87	\N
eea_tvv_range_6a8938348c26a4524c355a50	eea_hist_f955d04aca0737f0a17f8cca	\N
eea_tvv_range_8fba7c9ad561f62b93ad87a1	eea_hist_32e9f429daa3acdf8f599d73	\N
eea_tvv_range_8fba7c9ad561f62b93ad87a1	eea_hist_d506fab1cc624f69b3c157d3	\N
eea_tvv_range_8fba7c9ad561f62b93ad87a1	eea_hist_eb0e9dd44bdf58ea22f04fb3	\N
eea_tvv_range_8fba7c9ad561f62b93ad87a1	eea_hist_54a3ab52c1e7581f1901acc5	\N
eea_tvv_range_73f43b7e61bda3bba2c0d8de	eea_hist_01ebdcd2e33de0b6e008aaef	\N
eea_tvv_range_73f43b7e61bda3bba2c0d8de	eea_hist_0351281993105d2d9d9bc24a	\N
eea_tvv_range_73f43b7e61bda3bba2c0d8de	eea_hist_1c506c341c4cbe9a9871c648	\N
eea_tvv_range_8f4bfb17468be20c5b783261	eea_hist_7c42aa0ea7759be364271a0a	\N
eea_tvv_range_8f4bfb17468be20c5b783261	eea_hist_3d792a6a20b6297352670b70	\N
eea_tvv_range_8f4bfb17468be20c5b783261	eea_hist_4524a326df0bc74cd35196df	\N
eea_tvv_range_8f4bfb17468be20c5b783261	eea_hist_384bb53a005e1c8c3ff04fc7	\N
eea_tvv_range_8f4bfb17468be20c5b783261	eea_hist_5f65c1f8157a5bea0540b838	\N
eea_tvv_range_4d612f2c4fea32734be7b35e	eea_hist_ac797a9be67785f4c88c1655	\N
eea_tvv_range_4d612f2c4fea32734be7b35e	eea_hist_07a692f4075b59832e267ad7	\N
eea_tvv_range_4d612f2c4fea32734be7b35e	eea_hist_d2f2f8469c257ee138782557	\N
eea_tvv_range_4d612f2c4fea32734be7b35e	eea_hist_734835fc6ea586fbae17c6ee	\N
eea_tvv_range_902bfaab249dd1389472ab63	eea_hist_128746b9782eac86f874dea4	\N
eea_tvv_range_902bfaab249dd1389472ab63	eea_hist_a62433e42582d463190a854d	\N
eea_tvv_range_902bfaab249dd1389472ab63	eea_hist_df71e43ac8b8e8b768d5cffd	\N
eea_tvv_range_c63b5d39babf9ea7a621f494	eea_hist_e8188113b95e9782becb0ad4	\N
eea_tvv_range_c63b5d39babf9ea7a621f494	eea_hist_57f6f56d33294bb0e28d2a9f	\N
eea_tvv_range_c63b5d39babf9ea7a621f494	eea_hist_779e1675fbf12c0eb9c1ebca	\N
eea_tvv_range_c63b5d39babf9ea7a621f494	eea_hist_e7a6eda6da9e63e21b36f8e6	\N
eea_tvv_range_b3bcbb46df834102b45b2a3a	eea_hist_471426bc9d01270ca1f65c21	\N
eea_tvv_range_b3bcbb46df834102b45b2a3a	eea_hist_00c177fe0be9c47247583372	\N
eea_tvv_range_d8ee559e5f6186378f5d78ac	eea_hist_22e1e9f5563a184cea5071b5	\N
eea_tvv_range_d8ee559e5f6186378f5d78ac	eea_hist_befea6290e4f2291094b2a71	\N
eea_tvv_range_d8ee559e5f6186378f5d78ac	current_cluster:21dc4c9c2f2a33517319f10d46685499	520
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_d47c2f8297e1356952943c0f	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_9530d0247094315c2f9ccb58	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_c255e5da90562c6b82210499	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_2b934e3914a7b3cf36df684d	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_02fbd8d683c96a026a453731	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_78037de22c1b245deaba0bdf	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_639752036991ccf6cd3133ea	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_b4f5988f4294f005ebc56dd4	\N
eea_tvv_range_68243d18a3fd622cab76d223	eea_hist_ef31d01113107bee7d9ac12e	\N
eea_tvv_range_77ebab6acba9d295dabcdcab	eea_hist_c21ff8c937501efa63b805a3	\N
eea_tvv_range_77ebab6acba9d295dabcdcab	eea_hist_dba6dea946adceefb67d607a	\N
eea_tvv_range_77ebab6acba9d295dabcdcab	eea_hist_37d5c8ebe4b24d1c009eee8e	\N
eea_tvv_range_77ebab6acba9d295dabcdcab	eea_hist_b1ccfef0ec9a6886ee1eb2b9	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_9e547fadc45c64a1b05609fd	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_d7af0e2c895627b1f6a86fa6	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_633790e54b1287c0717da6f5	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_c4cfc259914c7ff1538be9df	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_74e4387dbdea38cb2fe3e4d6	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_47e98cc5b414b7e8e60a3dd0	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_c80242e8a40044e695bbc163	\N
eea_tvv_range_48433074bc1a43216a967bdb	eea_hist_35dff40db5af83f91a4fa5a3	\N
eea_tvv_range_d676a526b16fe71f6115c31f	eea_hist_f13ddfe95d457faa5a2bd7b7	\N
eea_tvv_range_d676a526b16fe71f6115c31f	eea_hist_44cf8b302d64b3032a7bea99	\N
eea_tvv_range_d676a526b16fe71f6115c31f	eea_hist_180a1139a81bf86c4fdbb6b3	\N
eea_tvv_range_d676a526b16fe71f6115c31f	eea_hist_d6301bdfb04c0442795d686e	\N
eea_tvv_range_6c73ad668289ffd52de8389d	eea_hist_35fb0f7809ee80c13c7206d6	\N
eea_tvv_range_6c73ad668289ffd52de8389d	eea_hist_1f99deb10d10d223a02c6dcd	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_48c4aed9b2fb28088e483fa9	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_d6a77bb89b40b58de1572867	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_b0f8c48f7bcd313242f2dbdb	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_e816d57ad856979a733b9ddc	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_42542494579fb979e674137f	\N
eea_tvv_range_1357b8dae2ccd7772853ac01	eea_hist_293a818b1234259231c0ed8f	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_47fb803c3e2b97bc2ef66afd	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_feab4eab37325ed4a6bad6f0	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_87adf5306c425f84284149d9	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_3949dd4dd33306ef9a657797	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_33be998c795e92fec3c3be17	\N
eea_tvv_range_ccb301f662cbba33717c7e2c	eea_hist_387ac2f0bd4171276bea5fa1	\N
eea_tvv_range_827b688a98dbde9096001117	eea_hist_b7f8092d9368bf8147cd51f5	\N
eea_tvv_range_827b688a98dbde9096001117	eea_hist_364b8545d87e081b5bdce6f9	\N
eea_tvv_range_827b688a98dbde9096001117	eea_hist_1423f52c11a28a376fafc668	\N
eea_tvv_range_827b688a98dbde9096001117	eea_hist_c6ac74d5dc29a52759b6cf0f	\N
eea_tvv_range_827b688a98dbde9096001117	eea_hist_9226727b86fcf03b5697cf0a	\N
eea_tvv_range_1af795b2f1f1e21244c59e2d	eea_hist_6b9b346d84c108a0bfc790bd	\N
eea_tvv_range_1af795b2f1f1e21244c59e2d	eea_hist_3c132e913335d02a0c762808	\N
eea_tvv_range_1af795b2f1f1e21244c59e2d	eea_hist_9edc91072a50addb80f16ee2	\N
eea_tvv_range_1af795b2f1f1e21244c59e2d	eea_hist_6a2c897456b5aa358cb98b6e	\N
eea_tvv_range_a1577eb8fa8c8faac8ab227a	eea_hist_6e719f98841a2253f4f2ba64	\N
eea_tvv_range_a1577eb8fa8c8faac8ab227a	eea_hist_7d4d37c1f60ab431a28f89b4	\N
eea_tvv_range_a1577eb8fa8c8faac8ab227a	eea_hist_030834ccb4caf307ddad7fad	\N
eea_tvv_range_a1577eb8fa8c8faac8ab227a	eea_hist_7a8ba686b4a795bc8f1e0ccb	\N
eea_tvv_range_a1577eb8fa8c8faac8ab227a	eea_hist_d605693bde1649c23ea40f67	\N
eea_tvv_range_26db1d61d288bb9bd7bbf614	eea_hist_7daed1fb5ab51399f25e2d4c	\N
eea_tvv_range_26db1d61d288bb9bd7bbf614	eea_hist_6aaf9a12c5ad31be676aac50	\N
eea_tvv_range_dd4c5c4f7bee4808bd919bb1	eea_hist_c6264fceabc4f3925c41fc24	\N
eea_tvv_range_dd4c5c4f7bee4808bd919bb1	eea_hist_3c5d5977d2ab3dfaf690369e	\N
eea_tvv_range_dd4c5c4f7bee4808bd919bb1	eea_hist_5798ed4bdcb9ea947559b038	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_6b01b0646dcf0de061fad35b	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_6de021c04c68fb7a514e7779	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_70818488ea7c2c7d9f1e4aa0	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_7bee83f3014580df3198b774	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_cb14b031888d4a6755add8c5	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_53f1e5805f38d75f410689da	\N
eea_tvv_range_1a584ca50aecc7da95473899	eea_hist_11a3d2f89a8093ef22caa268	\N
eea_tvv_range_639c33ed2ae904e646076745	eea_hist_a031dc680d7182014431bdb9	\N
eea_tvv_range_639c33ed2ae904e646076745	eea_hist_47e7a9b956e1c412a0bdd35a	\N
eea_tvv_range_639c33ed2ae904e646076745	eea_hist_10b32643d2fd699653bcb2d0	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_ff7dbfe55a87cf3ebe440577	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_bc8436415f725fd45bfb6e80	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_5d4112eb837515e8c59d08ac	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_2649f7f3598195d6023f228d	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_85dacb0fb57c5660c35f831f	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_fb78cd5f2fd76043cb3c261b	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e483953cca8a0412681b9e1a	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e92fd88c77af0cb30a33159f	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_e59dc9119480adee62010f85	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_df912dba1fdd0e9864f5776d	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_9d35de6b1ca4e3a9da67c78f	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_aaff8479d34df2eb817594a9	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_991df7648c415876cfa8fd30	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_470f7aee27e56c4b987feaae	\N
eea_tvv_range_d20657a78815a2e94a5f5ee1	eea_hist_6f88d72d2b68e5adadcf4cbc	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_6b0c843f85dd8e9a8a7a7a39	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_a8899348726e9dc11668fd9a	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_573c844893509ccd5c9317b4	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_8844f9774f3ac00b70dca523	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_d9e5fc9e5989fcfd67aa65c7	\N
eea_tvv_range_99ed4627729f7fde82c3f5bc	eea_hist_d00c8866f509848077788ade	\N
eea_tvv_range_afca1500d011b0a54f1fd0b0	eea_hist_b71f1dadc116dfd2f153f8ae	\N
eea_tvv_range_afca1500d011b0a54f1fd0b0	eea_hist_c5c304e55c7addc6c9fcd196	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_c0ad36510f9f6fd027ba4d32	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_02930cab8de9df15a2cbf1c6	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_eedd1e2abc5e226adfb7d0df	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_45ad5283f9d90f3a5415b43e	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_68c1ce98494151c88d1c907b	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_515d59fc6d858e408cdec1b4	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_dcdc11905663f6ed068357e5	\N
eea_tvv_range_4c5396cbd34b0fa3228e43ef	eea_hist_09b8224a732942ec5bd0d0f7	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_3e25c73c8631383b1c028e98	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_232adc941ea2da2f7d18cea2	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_c9165374a3f1fc4225c77db4	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_d6d4fa153c975801cb16cd34	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_da944e79cc6a41ba571fef54	\N
eea_tvv_range_ee2aa8ff2288250d841851d7	eea_hist_b043e9a1c76911d909cd03c3	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_c34d66bd4622a855d2983870	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_17672b03c927eb780b2c4e14	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_5492cde17208e309cdc33e6e	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_76ffded8379c63f6afe7c786	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_7cab24c57a7dd3bd920d640f	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_b06e86d2fbbbc4a43167ce50	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_7e50073f32dee1ac9ef641aa	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_d8bb16a5b990aa29a6284940	\N
eea_tvv_range_80d0ce3c49fbaaa4c0904154	eea_hist_24b8e8d0dce4fab8c96aa492	\N
eea_tvv_range_a6fdfd513b565ee139284cd5	eea_hist_2cc39bb85987d595dd1314b9	\N
eea_tvv_range_a6fdfd513b565ee139284cd5	eea_hist_359950ecfa3dd9bede20a104	\N
eea_tvv_range_a6fdfd513b565ee139284cd5	eea_hist_fa6d6ad3ddce8150c7ee74e5	\N
eea_tvv_range_e9fc7a7722606d3e0340d2e6	eea_hist_c9a06fd07358bdbbcb32e61d	\N
eea_tvv_range_e9fc7a7722606d3e0340d2e6	eea_hist_bc3a5aea322499b7c8b8c490	\N
eea_tvv_range_e9fc7a7722606d3e0340d2e6	eea_hist_d2be7a463b3b4483c7d818b6	\N
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_917550a27b742aff483473f5	\N
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_c9ddf5237e8b59791f6ea0ad	\N
eea_tvv_range_02d57f2ad1ecb9326eb7965a	eea_hist_d8a7de17dafa3475bedb05a2	\N
eea_tvv_range_71bc772a15351be3e1fd6c0a	eea_hist_7a94eaef94aee4a394b64503	\N
eea_tvv_range_71bc772a15351be3e1fd6c0a	current_cluster:bf6a5115de774aba99acc425ecaf8960	17
eea_tvv_range_c329c5d6c30331ba18fcd1d0	eea_hist_5b05748fc10ae7d9d8e50218	\N
eea_tvv_range_c329c5d6c30331ba18fcd1d0	eea_hist_6fc308d756b75c099dc641f9	\N
eea_tvv_range_c329c5d6c30331ba18fcd1d0	eea_hist_ca5c1f4f2079112be68c4839	\N
eea_tvv_range_c329c5d6c30331ba18fcd1d0	eea_hist_3d0c53ebc8ae10f97b4cca0c	\N
eea_tvv_range_c329c5d6c30331ba18fcd1d0	eea_hist_18aef52fe278ef3f3772dcab	\N
eea_tvv_range_94cccbbcef16921e7057a573	eea_hist_83cc378fe5fd6c3fa05d667e	\N
eea_tvv_range_94cccbbcef16921e7057a573	eea_hist_3f284914813d99f7d35b6885	\N
eea_tvv_range_94cccbbcef16921e7057a573	eea_hist_ad2a3d671b0c5a5e1c3a65d5	\N
eea_tvv_range_94cccbbcef16921e7057a573	eea_hist_9a9930b3f042a87d9e2065d6	\N
eea_tvv_range_94cccbbcef16921e7057a573	eea_hist_c856351814a5df1c67590803	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_c6888bd633e674923682d65b	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_f35dd8be096088ff2366c642	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_220422de7332e4f2b0d59454	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_232fbf232b64e06c93642c16	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_5d4e0903e354654f3bd4480c	\N
eea_tvv_range_bf4f845e4e81e29a8f6368c4	eea_hist_275279c8fdffea080377622d	\N
eea_tvv_range_e677ed68824a197ed572f415	eea_hist_b54b230f4956a318dc851be1	\N
eea_tvv_range_e677ed68824a197ed572f415	eea_hist_39945574ccec370d131a964f	\N
eea_tvv_range_e677ed68824a197ed572f415	eea_hist_e19f6b24f4eac548c360162f	\N
eea_tvv_range_001c0ff38d76a66183c8fbeb	eea_hist_e764dee2559aaa8daa26571b	\N
eea_tvv_range_001c0ff38d76a66183c8fbeb	eea_hist_b656e936b318a25aa2c7233d	\N
eea_tvv_range_001c0ff38d76a66183c8fbeb	eea_hist_d867e2a20216ec0af31c2f73	\N
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_0c3181cb2bb195de469a8bfd	\N
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_7c84a54818703202b8ad07ba	\N
eea_tvv_range_64c40eebe417efbfdc364a3d	eea_hist_7d89fd589c1c819c724a53a0	\N
eea_tvv_range_b90440f21502b239ddd33cf3	eea_hist_6e9a08176d56c684361b7c4a	\N
eea_tvv_range_b90440f21502b239ddd33cf3	eea_hist_03604d6ae30da70980d2d742	\N
eea_tvv_range_c5efb7bc8b5e05534b183573	eea_hist_e31df591bb69d6285e570a88	\N
eea_tvv_range_c5efb7bc8b5e05534b183573	eea_hist_4b2d02a3a8dd47a7167d11e1	\N
eea_tvv_range_c5efb7bc8b5e05534b183573	eea_hist_3139cd9dcdf69a16fa0dbef0	\N
eea_tvv_range_c5efb7bc8b5e05534b183573	eea_hist_1a2ff51ff92836d3202d3e20	\N
eea_tvv_range_c5efb7bc8b5e05534b183573	eea_hist_0f45d972d011e5ec1e94a0ec	\N
eea_tvv_range_97550dcdba8d6dd809e704a6	eea_hist_ab515bf928b97d113f4af113	\N
eea_tvv_range_97550dcdba8d6dd809e704a6	eea_hist_f57bb288d3a77079c8004320	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_ed5edc560f662839437bb653	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_a71902abca01cc0f1347f8ff	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_a1d8fa6a92a04d42c29d6375	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_6a437eb18bd9d35f0b83d119	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_f5ee708c2c5ac835ec410fc3	\N
eea_tvv_range_866c2e97cae883cd31724a9b	eea_hist_ee9dd8d3ed72895c6cdc855d	\N
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_b3ff36f3b92fe34f6d62a747	\N
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_0f9f207341dce79f6ce10a29	\N
eea_tvv_range_047c81ee7a7828f26c10c052	eea_hist_2d64b4b73195fa2aac31fe2a	\N
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	eea_hist_3788a50e23c54b8c46a2b767	\N
eea_tvv_range_0427d82dbc2123d0c6d4bc0d	eea_hist_525856816b628cb6f4cce4e0	\N
eea_tvv_range_90c1ea35ec005234a8199323	eea_hist_30e140051ae88954dc2ba867	\N
eea_tvv_range_90c1ea35ec005234a8199323	eea_hist_da43d874e7633e59ab9a0115	\N
eea_tvv_range_90c1ea35ec005234a8199323	eea_hist_c480622fd38e2cd580a2148b	\N
eea_tvv_range_90c1ea35ec005234a8199323	eea_hist_ccfb7b0c16906235c5cd5d00	\N
eea_tvv_range_90c1ea35ec005234a8199323	eea_hist_10b45a976a8bd919adcd18d9	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_f5e8a6e04264d77804c4ddc3	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_94dbf9f9c1d8dbe88f136a7f	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_c4be69c0df94e8eb75d253fe	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_0b5a79beb222dbdd73bae088	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_597755e227599ab907b56c43	\N
eea_tvv_range_54ef9c3f207862a269b1906d	eea_hist_ce721ffd7c2a86f62b963d36	\N
eea_tvv_range_5232af4372823904e07fa21c	eea_hist_430a8031567956647f538efc	\N
eea_tvv_range_5232af4372823904e07fa21c	eea_hist_a5bae9374b859a708eeaa345	\N
eea_tvv_range_5232af4372823904e07fa21c	eea_hist_73c10ccda909e4851bdac6ec	\N
eea_tvv_range_323105898c7dea4a2855af87	eea_hist_793c1c96cf9aadc585ae5672	\N
eea_tvv_range_323105898c7dea4a2855af87	eea_hist_6ac431594154dbc45b9157b7	\N
eea_tvv_range_323105898c7dea4a2855af87	eea_hist_853186f705ce1c4194589386	\N
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_41e83bf4e8506d1452130f4e	\N
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_c7513a781da9e95d81fb7940	\N
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_66e1e1830663a95451e78e1f	\N
eea_tvv_range_b91f1ad326d18e33799c688d	eea_hist_46a40a1bb8723baef8a3f7d1	\N
eea_tvv_range_b3d8df21557dac705ebf8047	eea_hist_c7da1577d63734c13b574c2e	\N
eea_tvv_range_b3d8df21557dac705ebf8047	eea_hist_929a70477e705f2a7eae239a	\N
eea_tvv_range_b3d8df21557dac705ebf8047	eea_hist_38a235249343348ae0429420	\N
eea_tvv_range_b3d8df21557dac705ebf8047	eea_hist_023aa45cde76553608cae069	\N
eea_tvv_range_833e4dbefa42a94f164d50ba	eea_hist_65c545be4ebd6763bed84865	\N
eea_tvv_range_833e4dbefa42a94f164d50ba	eea_hist_7901be51a01eef886914c19b	\N
eea_tvv_range_833e4dbefa42a94f164d50ba	eea_hist_ca3ee9a2b10fbc81eda9fa58	\N
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	eea_hist_360b76642b24b0300c10017e	\N
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	eea_hist_88a02246c80d77874ba0698e	\N
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	eea_hist_7e65bdadaecddbabdfea2874	\N
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	eea_hist_334a9957c41e4c5539e0af9b	\N
eea_tvv_range_49ca1e0ad44b6b5389b9f73e	eea_hist_14cb327587bb7595592ea1b6	\N
eea_tvv_range_14fe0cd144c151d5b9d8fcb8	eea_hist_6a99892b26749d8facb1cf95	\N
eea_tvv_range_14fe0cd144c151d5b9d8fcb8	eea_hist_d7ea19fe3bb14ab577f8e1a4	\N
eea_tvv_range_14fe0cd144c151d5b9d8fcb8	eea_hist_6bb3fb814a282ab7ded26dc0	\N
eea_tvv_range_5d2fca6e7a6ebb0f226ac3b7	eea_hist_d85a200fe5413c32077ebbb9	\N
eea_tvv_range_5d2fca6e7a6ebb0f226ac3b7	eea_hist_d42cd01ca2465da4e438e877	\N
eea_tvv_range_5d2fca6e7a6ebb0f226ac3b7	eea_hist_4a6887a909d5f08c1f2f3b01	\N
eea_tvv_range_ef097eb9fedb6e26b8233d2e	eea_hist_d43b12738463c91812047142	\N
eea_tvv_range_ef097eb9fedb6e26b8233d2e	eea_hist_9f667ff394f552520caa385e	\N
eea_tvv_range_ef097eb9fedb6e26b8233d2e	eea_hist_8bdf5a65ba10d59f6b831098	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_932759086bb0f54cffa78540	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_481f346a2a03ec666bb20282	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_ef105c3969bdadfdd4bcc7f9	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_47a5a16dae48d53f2fcf262d	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_777c913d580ab6df0562f70a	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_b258f18faa7f1cde9ab651c3	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_944ffb525d8158c39524b5a7	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_2af4b1b453d8cd52466cb53d	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_6d749d76c6cd10f2f87839d4	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_76d281df7c02a2bbc40be2f0	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_e72fd127e31f9c082cb98ce9	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_87bc0927b34966ce4f4f43e4	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_b2ae10b279429854e6c66948	\N
eea_tvv_range_3ca128b74722127bd3f4bca0	eea_hist_64ad36a5907aae9cff52c978	\N
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_d086b6897585d208d0b1d018	\N
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_2ce9d43759ba47464c269760	\N
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_a889227a91539c7e9ea27515	\N
eea_tvv_range_d8409f3e3e794d2717c71355	eea_hist_e6c753e91475f0be07d18b5b	\N
eea_tvv_range_76b742d5f4e5ba5c2c68b001	eea_hist_c68245ab299133b6117a2e31	\N
eea_tvv_range_76b742d5f4e5ba5c2c68b001	eea_hist_0e25af94b5ab28792bf999ad	\N
eea_tvv_range_76b742d5f4e5ba5c2c68b001	eea_hist_aaf0c7760e37a31d7b112810	\N
eea_tvv_range_e85edc8d3d15c62f872a9b1f	eea_hist_2d2a281fdd0f43edce965d4b	\N
eea_tvv_range_e85edc8d3d15c62f872a9b1f	eea_hist_711f3157de7a3fdef2df5988	\N
eea_tvv_range_e85edc8d3d15c62f872a9b1f	eea_hist_6e7da2982bdc945427e847ce	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_5ed8d53bd7ed5addb719343d	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_2575f05146d0bbb0fc5989be	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_f56bf4af1e201d92c3b59567	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_a33137f3d9bbbbd2d3a96b27	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_885374e82b52812ef8e35b3d	\N
eea_tvv_range_e0ed180f4aaa34686852446c	eea_hist_d8d075c2ff92798f6a4f7e06	\N
eea_tvv_range_2a605bfaab9e06b5de513906	eea_hist_ae10038814750d25930970d8	\N
eea_tvv_range_2a605bfaab9e06b5de513906	eea_hist_921b16d967a510a62bb0bea4	\N
eea_tvv_range_2a605bfaab9e06b5de513906	eea_hist_a823b4dd05a31d0c9d529867	\N
eea_tvv_range_2a605bfaab9e06b5de513906	eea_hist_75e31d713f020a22be3fc125	\N
eea_tvv_range_2a605bfaab9e06b5de513906	eea_hist_63d5994e9d2e1da453143f12	\N
eea_tvv_range_1543e9caa83e1abc7f88e00d	eea_hist_c689b4226654903b9ba3a265	\N
eea_tvv_range_1543e9caa83e1abc7f88e00d	eea_hist_ca2d26e9ac2ec8bc1e169d9e	\N
eea_tvv_range_1543e9caa83e1abc7f88e00d	eea_hist_c64bf0d604572a5c19715aca	\N
eea_tvv_range_b67d4d668490c611598f8737	eea_hist_c032af4fbc1bda6642b4b779	\N
eea_tvv_range_b67d4d668490c611598f8737	eea_hist_a635bbb44622bf77ff42c1bf	\N
eea_tvv_range_b67d4d668490c611598f8737	eea_hist_74346792aa4a000874ac3f5f	\N
eea_tvv_range_b67d4d668490c611598f8737	eea_hist_dfa2b660812bfd463cf7edb1	\N
eea_tvv_range_6b3287cc4ba06d8828a33f98	eea_hist_5dd83f754527dde489d6f7bf	\N
eea_tvv_range_6b3287cc4ba06d8828a33f98	eea_hist_9d6121ea3a0acdd6e51b21fe	\N
eea_tvv_range_3e94dff0cbe6bb726e3e5115	eea_hist_0e8c94026947136d821d702a	\N
eea_tvv_range_3e94dff0cbe6bb726e3e5115	eea_hist_8ac3004f4c8901e4c5212312	\N
eea_tvv_range_3967e199e585f3bbefe6995c	eea_hist_90a0802781d6332b0d7c6f5a	\N
eea_tvv_range_3967e199e585f3bbefe6995c	current_cluster:d7622fe205ef4c12d79bd340eb6f27be	691
eea_tvv_range_61127ba0fcab24af0cc7a11a	eea_hist_5be65f25d7eda3a998aa04b0	\N
eea_tvv_range_61127ba0fcab24af0cc7a11a	eea_hist_e84d069f4e4d7032860ea59c	\N
eea_tvv_range_61127ba0fcab24af0cc7a11a	eea_hist_4a7480cf8dbe8ed2082f0999	\N
eea_tvv_range_61127ba0fcab24af0cc7a11a	eea_hist_4a3b6b671769dd42a783b66c	\N
eea_tvv_range_61127ba0fcab24af0cc7a11a	eea_hist_7fa3b4bbf143874efc726bc6	\N
eea_tvv_range_fb53c37b718a8274c2ba69be	eea_hist_cd9f25195c8d00abf179171d	\N
eea_tvv_range_fb53c37b718a8274c2ba69be	eea_hist_fd2d31e7373d92eb1b24c72a	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_a4c30425cabfcfb2407ce4cb	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_217aa561ab5761f95af0acf4	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_e827755812e9b71716f785ce	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_f949ec8353f34b7cda946ac1	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_06df52bbfc3831084472708d	\N
eea_tvv_range_a71c770e8e3dda0a0dff4ce6	eea_hist_bda7a32da31050c3b2a12025	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_ac8f737a4e08a741ff6a10ae	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_3d0e59842446caa6da6ecf0f	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_3d8c5e04d00867f94ff3e62d	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_35071ca84b2b2bc9f6052c19	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_8d7503c631486b29f3bbe839	\N
eea_tvv_range_028eeb52f9c9726ad083564f	eea_hist_ebd12bff1249a5af23e5493f	\N
eea_tvv_range_4796d984e254994812b810c1	eea_hist_a23d69e56041671746bb68ef	\N
eea_tvv_range_4796d984e254994812b810c1	eea_hist_93e96571d2475a1178478dd4	\N
eea_tvv_range_4796d984e254994812b810c1	eea_hist_360c181a0ba91614b4e54c45	\N
eea_tvv_range_4796d984e254994812b810c1	eea_hist_ac444c76692b9a07aa1ba4c7	\N
eea_tvv_range_7de15367d79b479652752133	eea_hist_1703382c4f07f1b9f779c6ce	\N
eea_tvv_range_7de15367d79b479652752133	eea_hist_15716d80d06017904db13c82	\N
eea_tvv_range_7de15367d79b479652752133	eea_hist_8cd00acb4da09464b5ef1325	\N
eea_tvv_range_7de15367d79b479652752133	eea_hist_1b936c3df7f8cc7cc08a70d5	\N
eea_tvv_range_fbd7ff5408c27ca764048f00	eea_hist_d591b8ce1951cd4cff63d250	\N
eea_tvv_range_fbd7ff5408c27ca764048f00	eea_hist_b3aa89f995d86696719f40e7	\N
eea_tvv_range_fbd7ff5408c27ca764048f00	eea_hist_3a7501467cbc8de290fed1a5	\N
eea_tvv_range_fbd7ff5408c27ca764048f00	eea_hist_12fef95027b2574035e6f469	\N
eea_tvv_range_7bdf840c5104410990a08d72	eea_hist_ae1faa04815298bf1b25e17f	\N
eea_tvv_range_7bdf840c5104410990a08d72	eea_hist_36f4ab83903fe504e8e9bb44	\N
eea_tvv_range_7bdf840c5104410990a08d72	eea_hist_503d9dcd55ef1fdf6877d805	\N
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_e36fcb592335f567c78cbece	\N
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_0e1b2ad903cca7fad2013dc3	\N
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_9c749d227e6db738ce845186	\N
eea_tvv_range_060eab61f56173ecbed3c2da	eea_hist_c0ffbae15696a58c15d31e10	\N
eea_tvv_range_d992ad1d436b6f12f4e498f8	eea_hist_8c6c927ff660967ff449fd82	\N
eea_tvv_range_d992ad1d436b6f12f4e498f8	eea_hist_7a8da03f4900a93fda08f4ec	\N
eea_tvv_range_d992ad1d436b6f12f4e498f8	eea_hist_64444cf1f461e42dfa995b62	\N
eea_tvv_range_d992ad1d436b6f12f4e498f8	eea_hist_f5e9259a53989464d32d21ee	\N
eea_tvv_range_d992ad1d436b6f12f4e498f8	eea_hist_ec82004b61364ebc150ce7f7	\N
eea_tvv_range_8defa028f5af2dc157aa2a7c	eea_hist_6ece071fb491835558746240	\N
eea_tvv_range_8defa028f5af2dc157aa2a7c	eea_hist_c9ffa470c9f43ca443d698fc	\N
eea_tvv_range_598fce2c48c29b5a2d159ca3	eea_hist_e6eb24737db20a48555ef6c5	\N
eea_tvv_range_598fce2c48c29b5a2d159ca3	eea_hist_a45f8ab62b8e964cc62cdf0e	\N
eea_tvv_range_598fce2c48c29b5a2d159ca3	eea_hist_37ff4017f6004f7955df2c20	\N
eea_tvv_range_598fce2c48c29b5a2d159ca3	eea_hist_f6b3e3f90c326057c1d30dc6	\N
eea_tvv_range_598fce2c48c29b5a2d159ca3	eea_hist_29b0e53c284391cdea24a60d	\N
eea_tvv_range_383fdd4e7abbf957d0fcf258	eea_hist_9b4de49fceb3fc4f3a1a9e2c	\N
eea_tvv_range_383fdd4e7abbf957d0fcf258	eea_hist_5c0f9a3002ff32326199dbbe	\N
eea_tvv_range_383fdd4e7abbf957d0fcf258	current_cluster:8ac03974588c11bfedf5a43f2a1d7628	316
eea_tvv_range_0fc16062f80b6ff177361fc8	eea_hist_c6650cab3f1abd7dfb5919c5	\N
eea_tvv_range_0fc16062f80b6ff177361fc8	current_cluster:488c95a2c77c52812eb2fbde62970f8b	317
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_d2b36f58e983b870dc5d9cfe	\N
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_a0ed3f6157b19512cbc5dfaa	\N
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_055340bfdd985bf8da706ef3	\N
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_ea1181e1862671c61ce78ada	\N
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_6100aa040f49b3b971b98b64	\N
eea_tvv_range_cdf6cdfbb6e4f3d6e8a8406b	eea_hist_aa6b48cf8f6e94ceac1baee8	\N
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_40ee68fc074806d24b041e7f	\N
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_12c8e4dc3c8ff348e4eb6b2f	\N
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_bb40dab2a1f6a01a6c481224	\N
eea_tvv_range_10ac6b7572f1bc89bc9fbfd4	eea_hist_b3a116c51109b14e50299f66	\N
eea_tvv_range_8fd3dee68f48f0d6384058f3	eea_hist_f5ca911b780d21a25395390c	\N
eea_tvv_range_8fd3dee68f48f0d6384058f3	eea_hist_89d8737b63e0f9f0ddbe79b0	\N
eea_tvv_range_d72ebd91e36ccd0781af7ebb	eea_hist_6c21c793e15085ae4e8bcd71	\N
eea_tvv_range_d72ebd91e36ccd0781af7ebb	eea_hist_ca8f1b1322bc79a1ea73a627	\N
eea_tvv_range_d72ebd91e36ccd0781af7ebb	current_cluster:dd1c6ee13e014fc401b97da1f8d33f85	143
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_9fb18dff7e3deb24cf92fa8f	\N
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_441f56ca3a12eee5397045a1	\N
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_17d339593b4d774a539fca8c	\N
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_dae41f9870f69c1d2b007e72	\N
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_9b3ad2a6f2f862d82d1367e8	\N
eea_tvv_range_53a9ee9c00b3fb373b3702bc	eea_hist_93b7b46db567be23cfaa080b	\N
eea_tvv_range_8aff95585589d1d68b2ce8b8	eea_hist_a39bd8a8aac2e946e45ff134	\N
eea_tvv_range_8aff95585589d1d68b2ce8b8	eea_hist_71304a482dc1900407ab0278	\N
eea_tvv_range_72bd7e5155beccab0f212b4e	eea_hist_fd7cdb89e37fd51ef34b569d	\N
eea_tvv_range_72bd7e5155beccab0f212b4e	eea_hist_847ad60273e9ead81dd2b2d3	\N
eea_tvv_range_72bd7e5155beccab0f212b4e	eea_hist_566074464f2234de1e2d171a	\N
eea_tvv_range_c83dc0b262fa120356f8c89f	eea_hist_b19078fbc25f27a414010efe	\N
eea_tvv_range_c83dc0b262fa120356f8c89f	eea_hist_4c22172ca3b9b361a0c1036a	\N
eea_tvv_range_c83dc0b262fa120356f8c89f	eea_hist_0b718b680954810b3e59328f	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_1b6df7cff074b87df726f868	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_b20ae7128bf2025412bfc28c	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_0cc362e2c00e12b3c07aa9d4	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_ea228d292b39a09d71884a90	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_3b3fe1b3f70e842467beab85	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_c9c704afd3f7f2760e8a3fcd	\N
eea_tvv_range_bc2ba9a36592b03d91295983	eea_hist_02c3812307056622f3d4791f	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_253a15d267fc802368b2c64e	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_604063a045d1f57c26f8b5aa	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_187960b7c20449ab62cf45be	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_90e8ff9fc920dbf999d5e348	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_65cc8be58d4b60c11bf2aefa	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_a4acb8cf5ac2ac3b75c28103	\N
eea_tvv_range_f50f9613ca6578072db6ef72	eea_hist_51f2d0d3f953621e0beffe79	\N
eea_tvv_range_35100acf6d36ccc23497747b	eea_hist_1d86e6a809748a830934f28f	\N
eea_tvv_range_35100acf6d36ccc23497747b	eea_hist_a59f47f0d4ccc222878e7790	\N
eea_tvv_range_35100acf6d36ccc23497747b	eea_hist_41f415d2e531d93cbb12b801	\N
eea_tvv_range_35100acf6d36ccc23497747b	eea_hist_69aa78d3ea11a98bc3108649	\N
eea_tvv_range_35100acf6d36ccc23497747b	eea_hist_fcc770fd0054c368794dd036	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_afc0b30a7a15ca267ab4a7e3	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_7e642d52b93978d0968596d2	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_887c9e10eddabc8ef0bc0862	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_6162188c60b5c360603ae935	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_65be3e122702c352eb3e1d1e	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_e2fcfa54ff85f1d148672087	\N
eea_tvv_range_aed730038cd3fb5a1c1eca30	eea_hist_4a3291a9f13caf10d28c43c7	\N
eea_tvv_range_7b2594cb5e1e3f64592993cc	eea_hist_a18460884139a6849f896f71	\N
eea_tvv_range_7b2594cb5e1e3f64592993cc	eea_hist_477f219a430d2214c10ed479	\N
eea_tvv_range_7b2594cb5e1e3f64592993cc	eea_hist_8281312b6a6b37dc6a8dc265	\N
eea_tvv_range_7b2594cb5e1e3f64592993cc	eea_hist_bd78910f2e64a1f7ec756006	\N
eea_tvv_range_82c992497b5738ddee843d68	eea_hist_93b6a1f38ce46bef2dc34e89	\N
eea_tvv_range_82c992497b5738ddee843d68	eea_hist_33f50697eacb8ba389142109	\N
eea_tvv_range_82c992497b5738ddee843d68	eea_hist_5cbb9d29efd65f52e3d5aac0	\N
eea_tvv_range_82c992497b5738ddee843d68	eea_hist_9e8b9a471c908f7a0b8d707e	\N
eea_tvv_range_82c992497b5738ddee843d68	eea_hist_5ddf3ac645ce8016fd2a673b	\N
eea_tvv_range_453c1cc36296d9e163b8a322	eea_hist_e14bc657ba408c14e4075030	\N
eea_tvv_range_453c1cc36296d9e163b8a322	eea_hist_015e64abc344a0beac6904fd	\N
eea_tvv_range_453c1cc36296d9e163b8a322	current_cluster:a50c1573be82a956ed014cac6db2eb4b	169
eea_tvv_range_a16851e39c41f2e6b2ea3ca6	eea_hist_f14a5cae7fd54cbf55166b72	\N
eea_tvv_range_a16851e39c41f2e6b2ea3ca6	eea_hist_a52aaeb5d7001c65f24b8fd2	\N
eea_tvv_range_a16851e39c41f2e6b2ea3ca6	eea_hist_3a66e8032675204823bf38f9	\N
eea_tvv_range_47b72923bfedc619a38c8de8	eea_hist_81f8e966607b54fe76925c30	\N
eea_tvv_range_47b72923bfedc619a38c8de8	current_cluster:0184e0b7375a3edf0b523fd6d3d45623	207
eea_tvv_range_6a54b68e95a4b202f57963d8	eea_hist_c7dab6bdb38106a7876edfc5	\N
eea_tvv_range_6a54b68e95a4b202f57963d8	current_cluster:159963bae9d679937c118efd98418226	857
eea_tvv_range_8f5469abedb50041ed276520	eea_hist_7f23da7c06a6dfebe6440095	\N
eea_tvv_range_8f5469abedb50041ed276520	eea_hist_75bfb933a9a2c053910c6413	\N
eea_tvv_range_8f5469abedb50041ed276520	eea_hist_082d8c7b7af9563bafc8b90a	\N
eea_tvv_range_8f5469abedb50041ed276520	eea_hist_c7e7ee382cc8e88cf5543d93	\N
eea_tvv_range_dc7f223ca86d7788eb12d296	eea_hist_173a050a1fe87bde3c7bad46	\N
eea_tvv_range_dc7f223ca86d7788eb12d296	eea_hist_f076f8836cc4dcf8327785a6	\N
eea_tvv_range_97929dcd6e3ea2eed4151eec	eea_hist_1475268ad1de9ca65212bd20	\N
eea_tvv_range_97929dcd6e3ea2eed4151eec	eea_hist_c9646cf522f3f98fbe1f6057	\N
eea_tvv_range_97929dcd6e3ea2eed4151eec	eea_hist_a83244705ccac01eff531305	\N
eea_tvv_range_2947e0f1fab83a74599d81dd	eea_hist_bad47d0bd8a206e97674e64c	\N
eea_tvv_range_2947e0f1fab83a74599d81dd	eea_hist_a2b56c81bdafe5161f897605	\N
eea_tvv_range_2947e0f1fab83a74599d81dd	eea_hist_ee0204631f05f11334150819	\N
eea_tvv_range_edfcc19fcb890a52733ab2ab	eea_hist_feb34537572eb5eb79c1cd48	\N
eea_tvv_range_edfcc19fcb890a52733ab2ab	eea_hist_942f92c9a5c54b9782efd23f	\N
eea_tvv_range_edfcc19fcb890a52733ab2ab	eea_hist_89665dcf108248fe7c0f1ea6	\N
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	eea_hist_f70ec372a87fd742fa685595	\N
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	eea_hist_5aaa3b92a2442cbb28617be8	\N
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	eea_hist_98afbf3defee2b9214a3f6d1	\N
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	eea_hist_dfa6d39cef19694047e7a541	\N
eea_tvv_range_ed7c90fa9957fd07fd6c5f47	eea_hist_fd8b72df1e4d357b88042d6b	\N
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	eea_hist_061714884989b55698b673fa	\N
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	eea_hist_e629b09db9bf1d92e1f868e0	\N
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	eea_hist_f773b7f3fbc07fd2e1f43cfe	\N
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	eea_hist_b0020368c843d7fe14480d08	\N
eea_tvv_range_ae9c6e2212ec4c2a86a7b59d	eea_hist_8a8ee35f587746623cf42bc7	\N
eea_tvv_range_dd35bdf19323d624e1ce7120	eea_hist_0e6ea7740c17db63b0edaf9f	\N
eea_tvv_range_dd35bdf19323d624e1ce7120	eea_hist_4dcd222c24d17907edd0ea25	\N
eea_tvv_range_dd35bdf19323d624e1ce7120	eea_hist_cecf88b1fb4cb7954626dda9	\N
eea_tvv_range_dd35bdf19323d624e1ce7120	eea_hist_914fbee405347ab0e3f4a8f3	\N
eea_tvv_range_e53ba38e935652193c9f7bad	eea_hist_754be52f80dccd1771ba9e86	\N
eea_tvv_range_e53ba38e935652193c9f7bad	eea_hist_b56e8aebe42814a045fecda9	\N
eea_tvv_range_e53ba38e935652193c9f7bad	eea_hist_a3ec4207929fdb4dde251f29	\N
eea_tvv_range_e53ba38e935652193c9f7bad	eea_hist_3b1bfc89a20a6b3edb1ca17f	\N
eea_tvv_range_4947f1204ebe93041338840b	eea_hist_3293ef2ff0ee98948c9c4f0a	\N
eea_tvv_range_4947f1204ebe93041338840b	eea_hist_3c002aedf0417d760d296180	\N
eea_tvv_range_4947f1204ebe93041338840b	eea_hist_aaeb6c5e6af6a4c57850fbcb	\N
eea_tvv_range_4947f1204ebe93041338840b	eea_hist_9bf0f562806d6021e992cf92	\N
eea_tvv_range_96bb43f8fb4041d6eb05ff32	eea_hist_6bc55162e3b9ca2de6e6965a	\N
eea_tvv_range_96bb43f8fb4041d6eb05ff32	eea_hist_ad60cb102fa14401c672cfcb	\N
eea_tvv_range_96bb43f8fb4041d6eb05ff32	eea_hist_621c2404fabbd2391fd5dd2a	\N
eea_tvv_range_95b6b6fddcfb90be212d2c1d	eea_hist_5c0c3ead561a61674fe1262b	\N
eea_tvv_range_95b6b6fddcfb90be212d2c1d	eea_hist_88a73a53a58f34239725b38e	\N
eea_tvv_range_a0e1071c6250e5bb05cc0b43	eea_hist_9a9bf837c30e4399288f1d88	\N
eea_tvv_range_a0e1071c6250e5bb05cc0b43	current_cluster:2cfaa630423eb94f4ddeb61fe8aad42f	698
eea_tvv_range_53c7b9ab4b46df2d45c01f05	eea_hist_9f6440f0b26f2b0595f36f59	\N
eea_tvv_range_53c7b9ab4b46df2d45c01f05	eea_hist_679d54919e8a7b9c6be1bf03	\N
eea_tvv_range_53c7b9ab4b46df2d45c01f05	eea_hist_41d48990585d50ecd6ae750d	\N
eea_tvv_range_53c7b9ab4b46df2d45c01f05	eea_hist_85423622ca29481f27575b57	\N
eea_tvv_range_53c7b9ab4b46df2d45c01f05	eea_hist_7265e148acabe95ce90a8f83	\N
eea_tvv_range_d2302e557d4aab51c68c6120	eea_hist_f3b6e00fbc5ae83479e4c326	\N
eea_tvv_range_d2302e557d4aab51c68c6120	eea_hist_7b2571a15c93a5bee882ffc9	\N
eea_tvv_range_93e22acbdc675ab4552c407e	eea_hist_82eeb68c029dc162fb4be6ec	\N
eea_tvv_range_93e22acbdc675ab4552c407e	eea_hist_9037dbcfc0ea92ee5b07de31	\N
eea_tvv_range_93e22acbdc675ab4552c407e	eea_hist_895f80ffee46bac31466729a	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_4ea57136af299d67fbcc2974	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_abfa04c433c8544e2de4c8b0	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_0dfa41bb3db2b8f9ed78b727	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_c7e1ccde91f6191210c696fd	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_c42f5d436b412a0172c77f6b	\N
eea_tvv_range_cd7fd664ac46f89d5c6a2fed	eea_hist_6a01f069f79011f02cb9f79f	\N
eea_tvv_range_f8a6c9c08350711b341ad5d8	eea_hist_789892baef1d2899856690c8	\N
eea_tvv_range_f8a6c9c08350711b341ad5d8	eea_hist_9bcca81e6efb23c255cfe5d8	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_55d7aaae9f85afb488b8c000	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_fe44830d52d81151e3f5e02c	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_c5bacb678bffa38f7a2287b7	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_36a7a2732e4a22e452acd892	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_4204a6eb86eb08c605e82f86	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_782481fc22f5236b27d978a5	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_9283c2319bfb79e910202d2c	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_1692201dfe73943f236aa173	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_4e945845515c61473c8c8cde	\N
eea_tvv_range_12906e00373735e0352ae13e	eea_hist_f113f2b126ead4042db67734	\N
eea_tvv_range_1c80b1dfb0b459132c7286cb	eea_hist_468d1e6bbc999e7da5a1f585	\N
eea_tvv_range_1c80b1dfb0b459132c7286cb	eea_hist_dd12261625d5b7d200d3f6ff	\N
eea_tvv_range_1c80b1dfb0b459132c7286cb	eea_hist_df7a20e5d5ec7742bdad6638	\N
eea_tvv_range_1c80b1dfb0b459132c7286cb	eea_hist_c628d38c350ce265342ba508	\N
eea_tvv_range_1c80b1dfb0b459132c7286cb	eea_hist_21509f112c2b6c2fc7b70b0c	\N
eea_tvv_range_1c66d78d1fe58caefb1f19c2	eea_hist_3e6404701a03963cce98d79e	\N
eea_tvv_range_1c66d78d1fe58caefb1f19c2	eea_hist_b93b218e29e20e7e91d280ee	\N
eea_tvv_range_1c66d78d1fe58caefb1f19c2	eea_hist_132a0e116d708937a48925de	\N
eea_tvv_range_1c66d78d1fe58caefb1f19c2	eea_hist_bc5af2feca3ea2c2f5dce92f	\N
eea_tvv_range_fda0d304b6d84d3cfcf468fa	eea_hist_4689befb1b422aa8f3546dc4	\N
eea_tvv_range_fda0d304b6d84d3cfcf468fa	eea_hist_56ca4acb7cf43ad11e7527e5	\N
eea_tvv_range_fda0d304b6d84d3cfcf468fa	eea_hist_42557a84db5d99bc040b9cb1	\N
eea_tvv_range_fda0d304b6d84d3cfcf468fa	eea_hist_70396ab2ed4dd17df556a4f7	\N
eea_tvv_range_fda0d304b6d84d3cfcf468fa	eea_hist_4b89575dda7dd55fb1a9bf36	\N
eea_tvv_range_fd9b8cb341a0c79212c721d8	eea_hist_cc5e2c630c56131ddf2d6c1e	\N
eea_tvv_range_fd9b8cb341a0c79212c721d8	eea_hist_3a56f7e5b186adcd4bf318fc	\N
eea_tvv_range_fd9b8cb341a0c79212c721d8	eea_hist_ec7fd7cba31b6a6b0b8f6533	\N
eea_tvv_range_fd9b8cb341a0c79212c721d8	eea_hist_cd5449254d989532d18a2f78	\N
eea_tvv_range_7238413e708e835d16ec41bc	eea_hist_13aefe10ed9190e64028473f	\N
eea_tvv_range_7238413e708e835d16ec41bc	eea_hist_2201eb08592c7451d0ce06a4	\N
eea_tvv_range_7238413e708e835d16ec41bc	eea_hist_30feda91b9de544a160f7d86	\N
eea_tvv_range_7238413e708e835d16ec41bc	eea_hist_b5f075380bff46027c8fe9bf	\N
eea_tvv_range_7238413e708e835d16ec41bc	eea_hist_c284810c293ba12b4bd04c09	\N
eea_tvv_range_93e18f63f018676cc13da084	eea_hist_630b08eab0302444c68c1c4f	\N
eea_tvv_range_93e18f63f018676cc13da084	eea_hist_22e56dc447aa691d8a432f25	\N
eea_tvv_range_93e18f63f018676cc13da084	eea_hist_35970550987668ade8eba61c	\N
eea_tvv_range_89b5930b53d45c4cf7299c1f	eea_hist_2cacbdb165e62c0d330acd09	\N
eea_tvv_range_89b5930b53d45c4cf7299c1f	eea_hist_2c85553654aefef957188af1	\N
eea_tvv_range_89b5930b53d45c4cf7299c1f	eea_hist_b4b213a9c0f6c1c5823f5eac	\N
eea_tvv_range_89b5930b53d45c4cf7299c1f	eea_hist_b51f0934ab7c146c6a5713de	\N
eea_tvv_range_89b5930b53d45c4cf7299c1f	eea_hist_600438015ff8b312b3e7c0f0	\N
eea_tvv_range_ce2648c1dabc8f523c23b890	eea_hist_a28422956141e0bd4ca1cb25	\N
eea_tvv_range_ce2648c1dabc8f523c23b890	eea_hist_53361e10e6182524d590d387	\N
eea_tvv_range_ce2648c1dabc8f523c23b890	eea_hist_732a53331c69fbe77fdb3445	\N
eea_tvv_range_ce2648c1dabc8f523c23b890	eea_hist_29d64eca34b7188452637606	\N
eea_tvv_range_ce2648c1dabc8f523c23b890	eea_hist_256ad353dc26c04b237f75b2	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_413367286c0b69240d46525c	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_c49e642958eb0c2fb58000d3	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_cbbe86f5b3dfe51d702755f3	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_39daa779d804e00dded598e5	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_4eda41dda6924349efc59c4f	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_b44eb757404211e31f46cc83	\N
eea_tvv_range_f4fdb5aea32cd792a8302882	eea_hist_dd224fd9c236eea7cbe9507e	\N
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	eea_hist_8a9638123b1a5da46702896d	\N
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	eea_hist_473b17795b56b89e0e1497ae	\N
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	eea_hist_aa0f870ddcb646e209027f63	\N
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	eea_hist_4aca19e84b6fc1802e0486fb	\N
eea_tvv_range_b4847e4e6fb64a832b3e7c9d	eea_hist_1f98b7c173a147ebe4c544e4	\N
eea_tvv_range_0fdf13c916f9979dd1dc9814	eea_hist_f603693863b7ddeaed213e9d	\N
eea_tvv_range_0fdf13c916f9979dd1dc9814	eea_hist_a888b050a4419360401aa0d9	\N
eea_tvv_range_0fdf13c916f9979dd1dc9814	eea_hist_5b4ba3187e2d5575b3b83337	\N
eea_tvv_range_0fdf13c916f9979dd1dc9814	eea_hist_acebae62f2760889190b1974	\N
eea_tvv_range_0fdf13c916f9979dd1dc9814	eea_hist_fa12fbdd72d1035f3a8a9859	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_cc3bca47d4b98bfccd550f99	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_42a5df86c8de81e9bd664a89	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_3dc8e4169f8ff825ed686d54	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_56058d7d9e367910e797e92d	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_88d10e9dbf53c635e67ce20c	\N
eea_tvv_range_455cf47a434a3fff934f735b	eea_hist_b46c9811cff66b26640ae949	\N
eea_tvv_range_ecc4e2c65520f29a486f8842	eea_hist_5d06635e3fa386cfa7d689d9	\N
eea_tvv_range_ecc4e2c65520f29a486f8842	eea_hist_cee5d46dc1362ae402cc0a1f	\N
eea_tvv_range_ecc4e2c65520f29a486f8842	eea_hist_fc97565034b156997fe40512	\N
eea_tvv_range_672744b5c82ddb5c7b74e04b	eea_hist_fea1d368ccc4d7b3ef9b0cab	\N
eea_tvv_range_672744b5c82ddb5c7b74e04b	eea_hist_76e3d94fd758de0866752c6c	\N
eea_tvv_range_672744b5c82ddb5c7b74e04b	eea_hist_f5f73f54d98769a1c4f1268b	\N
eea_tvv_range_cab9903f4dd9c95aab970590	eea_hist_968c43dbc86d48c989319212	\N
eea_tvv_range_cab9903f4dd9c95aab970590	eea_hist_4e754f6bf3443b5d108eee66	\N
eea_tvv_range_cab9903f4dd9c95aab970590	eea_hist_7fef1c718447431f5bd394c4	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_51a89ddcbeabc0e9d81fb90e	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_d9cec349dc088c891428e050	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_c0ae0ebd0921cae279f25a75	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_877ce73cfadc3aad7ca90d06	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_31e3d7b7a95b50c059f440d5	\N
eea_tvv_range_630d172b55f859b4be6ed947	eea_hist_e4b68580e578674aa960e84d	\N
eea_tvv_range_477435c9d2b7a1c0b33783f9	eea_hist_dbb57954ec01c71b6e1f61c6	\N
eea_tvv_range_477435c9d2b7a1c0b33783f9	eea_hist_d996c566e24c7395887ad6ac	\N
eea_tvv_range_477435c9d2b7a1c0b33783f9	eea_hist_c092816d846db8ca12379509	\N
eea_tvv_range_a45cc4f99d643e9ab427b049	eea_hist_915a94a3f59e41a4b906d35f	\N
eea_tvv_range_a45cc4f99d643e9ab427b049	eea_hist_0dd1578166f06e5d637ef6aa	\N
eea_tvv_range_a45cc4f99d643e9ab427b049	eea_hist_88f9949776e8648f0ad6f166	\N
eea_tvv_range_0b83d92ac545a8fd03794c97	eea_hist_2587bcfa4529b727697025c7	\N
eea_tvv_range_0b83d92ac545a8fd03794c97	eea_hist_2ce6e4938cc939443cb6f716	\N
eea_tvv_range_0b83d92ac545a8fd03794c97	eea_hist_1102434622675380fe3116e5	\N
eea_tvv_range_0b83d92ac545a8fd03794c97	eea_hist_6e51e17a8d9b9f396d574727	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_f73a3f203d188ef1fba25302	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_db713dffedda756408ec777c	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_4c972f6e069f244ade11842f	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_5a6f7e7f06d67f5e2dbb86a2	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_5e0b55ed4219a0ad8070c370	\N
eea_tvv_range_0b82607902ef002a02b72517	eea_hist_c2e7e9e9430decdfc3a0ecb3	\N
eea_tvv_range_8a78c319fa02cdf9cdcfb58a	eea_hist_4f59e6185b0516c06c10e309	\N
eea_tvv_range_8a78c319fa02cdf9cdcfb58a	eea_hist_3cdd9c36b15b4b236073ad87	\N
eea_tvv_range_8a78c319fa02cdf9cdcfb58a	eea_hist_beaf760b63de3bf810c9fe01	\N
eea_tvv_range_8a78c319fa02cdf9cdcfb58a	eea_hist_f3e842b039f4a0ca54f1d84c	\N
eea_tvv_range_a8ceabd3f7cf1ec109aa1013	eea_hist_d28939b0fc4cc6e3e57213ee	\N
eea_tvv_range_a8ceabd3f7cf1ec109aa1013	eea_hist_cd58bd9ce88608e44dbe2c67	\N
eea_tvv_range_a8ceabd3f7cf1ec109aa1013	eea_hist_cf55eab3ee90043f0c986b52	\N
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	eea_hist_a878adcf845dfa972b48104a	\N
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	eea_hist_93bc84a74a494389ab18376b	\N
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	eea_hist_275b3155468701856bbebdee	\N
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	eea_hist_3ee017b6c4ec74826285bd48	\N
eea_tvv_range_f8c60f7ccc2ec01b0dbbac82	eea_hist_37d1b071b76375d53c97ea0f	\N
eea_tvv_range_dc8c09b62ebfab182c6da673	eea_hist_e8efe56f3431e10f9820e8b5	\N
eea_tvv_range_dc8c09b62ebfab182c6da673	eea_hist_ea76505de57a4e3f152d88d5	\N
eea_tvv_range_dc8c09b62ebfab182c6da673	eea_hist_6179d6b0afe0b825971bac8e	\N
eea_tvv_range_e90ed861c9138376e7bab69a	eea_hist_4c126bd5407dd8791e1d8a77	\N
eea_tvv_range_e90ed861c9138376e7bab69a	eea_hist_74aa97fabf311e4f6527bd11	\N
eea_tvv_range_e90ed861c9138376e7bab69a	eea_hist_b234aaf1a0fe253edb7175f4	\N
eea_tvv_range_2253aa2817a9d6b6f607e0d9	eea_hist_0e0cac844f54e25c96af0276	\N
eea_tvv_range_2253aa2817a9d6b6f607e0d9	eea_hist_27e8cb8a05a32bbc529b7e82	\N
eea_tvv_range_2253aa2817a9d6b6f607e0d9	eea_hist_3ad31de5a13bc15e7ce611d7	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_5b3b7bba3c54a69a86c78ebd	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_fbbd39fd744bd40cd0a09ccb	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_6da8b7cd6ed9dfc35a1f430c	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_beb025e7e45da658c0681b9e	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_166d6bec993e93320bfbc7cb	\N
eea_tvv_range_65017a52e381c89d8946a56f	eea_hist_909777e864b4b1cf365d4190	\N
eea_tvv_range_fa874a71cb7406d428bd254d	eea_hist_e0b05bea80a76b5793343e75	\N
eea_tvv_range_fa874a71cb7406d428bd254d	eea_hist_852992cfc0ce2ad9636f8954	\N
eea_tvv_range_fa874a71cb7406d428bd254d	eea_hist_f82c5f9a9f5f12bf6d411396	\N
eea_tvv_range_fa874a71cb7406d428bd254d	eea_hist_a9d54e11f8445fd2442dbdc4	\N
eea_tvv_range_99f3ce5b583a271a87b4c4fd	eea_hist_3c81fa5bbeb72ccfd04f71ba	\N
eea_tvv_range_99f3ce5b583a271a87b4c4fd	eea_hist_b7c86a24db3cc0d3b7e4e646	\N
eea_tvv_range_99f3ce5b583a271a87b4c4fd	eea_hist_ccdf3f6aa1756d0e3d714f23	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_02045200ff798c9e7f521fcf	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_3fb3d3af6a00349e2e3f4695	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_25d8bf0538baa7ba37a6dc37	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_a846934e138e971851fb10a1	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_af9f32edc4b5babf090d85f6	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_848262bc1dcf11f0195835ef	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_0dc8a326a43b61e1128f1ccb	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_259286a46c200108ef2634e9	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_d49416798c457d3a089143be	\N
eea_tvv_range_7a255b5be155a44519487280	eea_hist_dc8cc454758ddd7aabfe3747	\N
eea_tvv_range_b382426313f42bab465cf7aa	eea_hist_300791d6d0b33a5ad2c972cb	\N
eea_tvv_range_b382426313f42bab465cf7aa	eea_hist_44384010423ef1975c8e02c8	\N
eea_tvv_range_b382426313f42bab465cf7aa	eea_hist_0f8c6bc2582661a62fdd17cb	\N
eea_tvv_range_b382426313f42bab465cf7aa	eea_hist_fa4ae8f323a6cff6482cb92a	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_85646f30963ccc7ca2965881	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_6de8f4e1b13d8e9ac17862d5	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_5267ffc671a4515cfd70c934	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_ea4335818d32bd8eb91c7bf0	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_b05da46603dcb327556cd2f2	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_afaedfcd12f38ee609cee290	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_45752d2983573fe441c78215	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_441e04b22bbb1c376d6b90d2	\N
eea_tvv_range_5845c37f8e7bc3324e10efcd	eea_hist_ccf486a41b8c34d7976b1ef8	\N
eea_tvv_range_5f34da56dd26713c0eabf21e	eea_hist_f8b3a6d90a4d523937ea5807	\N
eea_tvv_range_5f34da56dd26713c0eabf21e	eea_hist_d62fe83e753ec2fb819420dc	\N
eea_tvv_range_5f34da56dd26713c0eabf21e	eea_hist_bdb6fd564174f4aa153f10c1	\N
eea_tvv_range_9758585cfebe2318a443f120	eea_hist_db3737902a1c0885025fabe5	\N
eea_tvv_range_9758585cfebe2318a443f120	eea_hist_417488158476eb4109b3adc4	\N
eea_tvv_range_9758585cfebe2318a443f120	eea_hist_322c534308384b51d37097cc	\N
eea_tvv_range_e7c590bacbcea53b39680504	eea_hist_02fff95693cbfff8fc620968	\N
eea_tvv_range_e7c590bacbcea53b39680504	eea_hist_222887e9e92a9c4e24d29604	\N
eea_tvv_range_e7c590bacbcea53b39680504	eea_hist_8281799949e1bcd52738d7dd	\N
eea_tvv_range_e7c590bacbcea53b39680504	eea_hist_1ce1dc34d7363dba626c00fb	\N
eea_tvv_range_354c659404c6ffaae27883c9	eea_hist_4d2e1c1ca2491e45b7819799	\N
eea_tvv_range_354c659404c6ffaae27883c9	eea_hist_575802498a97a26c81eb68c0	\N
eea_tvv_range_354c659404c6ffaae27883c9	eea_hist_40f8d03e2a0b5e4512eccaa7	\N
eea_tvv_range_354c659404c6ffaae27883c9	eea_hist_8a52be1a7016a3513060a81c	\N
eea_tvv_range_ecb88a9f8e31b7d49082347f	eea_hist_62d2aa46aa6ed42d4047fe47	\N
eea_tvv_range_ecb88a9f8e31b7d49082347f	eea_hist_21b12ffc25d00416f8f17152	\N
eea_tvv_range_ecb88a9f8e31b7d49082347f	eea_hist_47daeccb1c311722457587ff	\N
eea_tvv_range_ecb88a9f8e31b7d49082347f	eea_hist_dcb027c0b784ed37f058dbc0	\N
eea_tvv_range_417d9bb3b7d39791a99d5d46	eea_hist_da2cdcc3d25b75098808d491	\N
eea_tvv_range_417d9bb3b7d39791a99d5d46	eea_hist_748d534e0730b0c5443a1d54	\N
eea_tvv_range_417d9bb3b7d39791a99d5d46	eea_hist_67b621094714b054ae043ba4	\N
eea_tvv_range_417d9bb3b7d39791a99d5d46	eea_hist_a6a2bcc4b0556c5e6a906b00	\N
eea_tvv_range_417d9bb3b7d39791a99d5d46	eea_hist_9f5aa59abf708c105287bf17	\N
eea_tvv_range_d4c9144b751b4b2e94573c23	eea_hist_35f1fccdc659e515a256882a	\N
eea_tvv_range_d4c9144b751b4b2e94573c23	eea_hist_a4d202634824d6831d59431f	\N
eea_tvv_range_d4c9144b751b4b2e94573c23	eea_hist_f72adaa32db89b9af8540505	\N
eea_tvv_range_d4c9144b751b4b2e94573c23	eea_hist_ee042cdf13bc9217fa00585e	\N
eea_tvv_range_d4c9144b751b4b2e94573c23	eea_hist_4e2df852b4d2cd8cf922ba73	\N
eea_tvv_range_1c04fddf2c153e7e6a509d54	eea_hist_e9333a9ace851fa06bdeedb5	\N
eea_tvv_range_1c04fddf2c153e7e6a509d54	eea_hist_39d43f38e3dd0e8e0ac19a20	\N
eea_tvv_range_1c04fddf2c153e7e6a509d54	eea_hist_13557b747f983921165d2d52	\N
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	eea_hist_f4ddb12fde157357da01555b	\N
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	eea_hist_8e54673961cdfeb7c871e65b	\N
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	eea_hist_d6a417722d493beebc241c00	\N
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	eea_hist_08f421de37417ba2d6d2a676	\N
eea_tvv_range_f0c648b9c9c95f8175e8bfc2	eea_hist_ba4e1444404d420d518b0a54	\N
eea_tvv_range_276de688e07be977ad95ecfc	eea_hist_65fbf5f818600709de533860	\N
eea_tvv_range_276de688e07be977ad95ecfc	eea_hist_7ee7511fbc96d665ccd83177	\N
eea_tvv_range_276de688e07be977ad95ecfc	eea_hist_8a4da8350540f24a4e8a6cbf	\N
eea_tvv_range_276de688e07be977ad95ecfc	eea_hist_ed5429d809257027a1e6c394	\N
eea_tvv_range_6c98e4a9acb252dbfb823fe5	eea_hist_5dc80c81a41ef1a22af66713	\N
eea_tvv_range_6c98e4a9acb252dbfb823fe5	eea_hist_915f5e7018b482ef77b3ba45	\N
eea_tvv_range_6c98e4a9acb252dbfb823fe5	eea_hist_bb359bb86aec6b26b7c899f0	\N
eea_tvv_range_6c98e4a9acb252dbfb823fe5	eea_hist_c9d3bce4a529caaf951b3a32	\N
eea_tvv_range_6c98e4a9acb252dbfb823fe5	eea_hist_dd5b759bfd7b79a719232d6e	\N
eea_tvv_range_ab46686ab32b6a6913825315	eea_hist_ef4148257587e11d56567f0b	\N
eea_tvv_range_ab46686ab32b6a6913825315	eea_hist_4ed66ba45c0702c9dd39b702	\N
eea_tvv_range_ab46686ab32b6a6913825315	eea_hist_8dcd43a4af4e790ed7f8f57e	\N
eea_tvv_range_5baf406053bab361c4f88e25	eea_hist_de7a58bc2fdba6bb862bf345	\N
eea_tvv_range_5baf406053bab361c4f88e25	eea_hist_cb8475c5f69a4d6418ee7980	\N
eea_tvv_range_5baf406053bab361c4f88e25	eea_hist_7ff9778572f67924599fa17a	\N
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_678d0dc7583277059cec7817	\N
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_921da1511844f4532f9e15ae	\N
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_56f42788575e75ab8e1458af	\N
eea_tvv_range_7658befce6581ea88d7aafa1	eea_hist_cea6a3f20c82d0f8b4e78971	\N
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_7d551ec5b2a515f09ab97037	\N
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_61a0205c230e9a829f52852d	\N
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_8736b5eb601dcd34032bfac6	\N
eea_tvv_range_805f5b1c828eeb99a5eb5522	eea_hist_b88c5454700f4198e3833126	\N
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_644d66343c35ccca02bd7a12	\N
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_9ed63aaf1a19014616542d4e	\N
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_a80319f1808c0fbdee409006	\N
eea_tvv_range_c314eb91005a3f446b8d8965	eea_hist_2e4f9db7253e1446f1bfb07d	\N
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_785d100368718cb2b1faa778	\N
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_c2bf2ee1059af795590e7d8c	\N
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_e4bd4f8542f3494ec7e2b386	\N
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_91c47a6887814d25040b5b0c	\N
eea_tvv_range_c2bcaee26b58a35889240c54	eea_hist_3faa864a9b7930595252aea3	\N
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_7852e57b4282d08703b89c5e	\N
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_f95cb4d99e8955c74f84c4a9	\N
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_f4f67baf049abdae0ac993af	\N
eea_tvv_range_29d1a4f35d58e622b4dd9364	eea_hist_6f51333909860ad122b86f03	\N
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	eea_hist_d9427132f9adf1909b1eb985	\N
eea_tvv_range_b4ec7a198d0a8fd95b7f0cb4	eea_hist_ea8332d9496a8f03e931d1a2	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_fd97a74b9c2c90a6c5ceefb0	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_a1ca47e1cc54e52687a21b4d	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_5688792e9fec904454e4477d	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_7941c0e679d4c58a87b9fe67	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_322cbf7e0a15bf0d6d5af5c9	\N
eea_tvv_range_a20165adbb4c327e2853a2e5	eea_hist_7e7d2cbd70a1800ffede40d2	\N
eea_tvv_range_5145e9e7ddcb670a5dab3b84	eea_hist_e58a2e2331f21cf81a2313a1	\N
eea_tvv_range_5145e9e7ddcb670a5dab3b84	eea_hist_2e2d75a5594841c75337ffbf	\N
eea_tvv_range_3a910a9e79648c4cc3fe92bb	eea_hist_fce3af3dd49a6fdf33f0074f	\N
eea_tvv_range_3a910a9e79648c4cc3fe92bb	eea_hist_fd2ea740d82fa4bcfeb3f1b4	\N
eea_tvv_range_ddec42aa3efd253bc3d17a82	eea_hist_3acd19b2256ffafefc95d636	\N
eea_tvv_range_ddec42aa3efd253bc3d17a82	eea_hist_c0ae6c1dffe7f212c654db35	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_b60a8b0bb73fc1a754e3bc8e	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_b917423963d2f64e9553b7f9	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_a037e9e2450394176b2268e4	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_c97a9a7cdd7d6c5ed63720d8	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_d62f0f39e77412c3b4730dd6	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_6e8f1bb1344f65b7e9d7978b	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_86fb5e96e6d859c83ac46167	\N
eea_tvv_range_4fb3fe9ae166789fa7e694a1	eea_hist_764914210dfd4224d78d36bd	\N
eea_tvv_range_ff9bad5bd693d87d95c2110f	eea_hist_119dcf3f446e04cfd44b552c	\N
eea_tvv_range_ff9bad5bd693d87d95c2110f	eea_hist_6ba974216464843b852960dc	\N
eea_tvv_range_ff9bad5bd693d87d95c2110f	eea_hist_e402199612a17fdf581a8c07	\N
eea_tvv_range_0eafb247a2062fb89366bc7d	eea_hist_4b2ab8dc54573dbba5daacf5	\N
eea_tvv_range_0eafb247a2062fb89366bc7d	eea_hist_69f93f4df13dbc2448967943	\N
eea_tvv_range_0eafb247a2062fb89366bc7d	eea_hist_33037d48ceb802319a76e8a0	\N
eea_tvv_range_64d3ae123660f5eac84d5afe	eea_hist_000bce7fe6f95c73cbf9581e	\N
eea_tvv_range_64d3ae123660f5eac84d5afe	eea_hist_95c50f4adf3f19ef1552d6f3	\N
eea_tvv_range_64d3ae123660f5eac84d5afe	eea_hist_daafd44c6f72b6c7157bf734	\N
eea_tvv_range_64d3ae123660f5eac84d5afe	eea_hist_8719ac19a3432af072bb1565	\N
eea_tvv_range_72c81b2220e765b7713b3224	eea_hist_4d01f0e27c0b2ab08ad0b85f	\N
eea_tvv_range_72c81b2220e765b7713b3224	eea_hist_c4e269bdeccbb4d9095bdea8	\N
eea_tvv_range_72c81b2220e765b7713b3224	eea_hist_58cee28f0103bcaaa47a1474	\N
eea_tvv_range_72c81b2220e765b7713b3224	eea_hist_73c2f86a22a11a162d890824	\N
eea_tvv_range_72c81b2220e765b7713b3224	eea_hist_d75eae5ad1a2975d521bc2d6	\N
eea_tvv_range_47e7c51cade5bfe5c22027d4	eea_hist_31f959ce13a58c8a01961c7f	\N
eea_tvv_range_47e7c51cade5bfe5c22027d4	eea_hist_c8ed4e1c45d597678e9d33ce	\N
eea_tvv_range_47e7c51cade5bfe5c22027d4	eea_hist_9dbda84972c541a704952ece	\N
eea_tvv_range_47e7c51cade5bfe5c22027d4	eea_hist_05bb8bb2673547bb7758020d	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_806ee61e7a1f980bd94c0ca8	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_9c2321493516464e4417a44f	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_1f3df38a623574179815d2c1	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_7f56c27ae94a26d025639d03	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_03c1bb513aee6b34e5652c46	\N
eea_tvv_range_a3e39acb5fe6ff5e81571938	eea_hist_b0888375bfd765f21f74fc41	\N
eea_tvv_range_d588df970e3a98b2424fa683	eea_hist_9327aae62ebc312df1e9818c	\N
eea_tvv_range_d588df970e3a98b2424fa683	eea_hist_121a8e00b034e1f7969cc707	\N
eea_tvv_range_d588df970e3a98b2424fa683	eea_hist_b454018255ed5c092859548f	\N
eea_tvv_range_1d97da5fb1efb7dbbd9aa4b2	eea_hist_69f6a740738a4c63c99b5abc	\N
eea_tvv_range_1d97da5fb1efb7dbbd9aa4b2	eea_hist_512d4c440958e89d6231b05a	\N
eea_tvv_range_1d97da5fb1efb7dbbd9aa4b2	eea_hist_91d65372e35d7244cdc908f7	\N
eea_tvv_range_87a7fccc941740c4c85daa32	eea_hist_d6091f26c2e9206d699a15ba	\N
eea_tvv_range_87a7fccc941740c4c85daa32	eea_hist_256bd9377e21f24e6ffd0d3f	\N
eea_tvv_range_87a7fccc941740c4c85daa32	eea_hist_932f5c5a9bb893c8f1ad9576	\N
eea_tvv_range_87a7fccc941740c4c85daa32	eea_hist_c79cb21ff249fd949a2e7f4f	\N
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_b0361f88298698d36fdc0277	\N
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_27f15bcb45f304fdc27d758a	\N
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_f10320cb21fa89e6a57e7b1d	\N
eea_tvv_range_da341fdd8155dd711b988db6	eea_hist_ed691f0df2cef4982d64b729	\N
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	eea_hist_8ee95a0f9c78ae6f155899bb	\N
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	eea_hist_ffab28761130fc47d4eae3bd	\N
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	eea_hist_2b9a0833ee91b1180d73bdd8	\N
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	eea_hist_096e09abad936113dc9d7caa	\N
eea_tvv_range_0a3d13ffc9e248eb3c53a53e	eea_hist_2e44cd4909de5d9392652973	\N
eea_tvv_range_64b2cb138749ece19e352d9f	eea_hist_53945b94deb2a115d952b383	\N
eea_tvv_range_64b2cb138749ece19e352d9f	eea_hist_d08d3d5e89ea74336870fe4f	\N
eea_tvv_range_64b2cb138749ece19e352d9f	eea_hist_a91418f52e8e9fcb7016742d	\N
eea_tvv_range_64b2cb138749ece19e352d9f	eea_hist_bce5d19b39864fb2fa4b0a9b	\N
eea_tvv_range_32066abfa064c9d28b2ac382	eea_hist_a10602265f2b2d40f138b8d3	\N
eea_tvv_range_32066abfa064c9d28b2ac382	eea_hist_7ceb7fc1f732ba9b7cf43085	\N
eea_tvv_range_f23d2f3b2e623854eb129baa	eea_hist_72ab8ef6919806243e9be11b	\N
eea_tvv_range_f23d2f3b2e623854eb129baa	eea_hist_60069176113ea946c6365415	\N
eea_tvv_range_f23d2f3b2e623854eb129baa	eea_hist_22f3a13fcb017fda730ba36e	\N
eea_tvv_range_f23d2f3b2e623854eb129baa	eea_hist_859bc826715b5e0d4ce00a90	\N
eea_tvv_range_f23d2f3b2e623854eb129baa	eea_hist_7d462c734728865f35b70a8a	\N
eea_tvv_range_2bcb68cbf6cd2a550dfaefe4	eea_hist_7ac9895115ee07bc8b3d3696	\N
eea_tvv_range_2bcb68cbf6cd2a550dfaefe4	eea_hist_e40c71409b25c406f8664972	\N
eea_tvv_range_2bcb68cbf6cd2a550dfaefe4	eea_hist_1a06ac03444ee035dbc23f7b	\N
eea_tvv_range_2bcb68cbf6cd2a550dfaefe4	eea_hist_6e3ed97d026bf8eea71d60d2	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_19a5d9e3cc92c585da0107c2	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_452a36d65aa4e7e1e60b40c5	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_41b753db058d4d826f1e91e0	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_25d43c7febc573eb3907dbbd	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_31c5ad756daacebb39497746	\N
eea_tvv_range_b9b4f11a39ce50bfb2ff9648	eea_hist_3045f53c4fc74146fc599612	\N
eea_tvv_range_aede9d226dab4d5dd34e82b2	eea_hist_edfa13cc7892e43df3e23bbf	\N
eea_tvv_range_aede9d226dab4d5dd34e82b2	eea_hist_67eb46b54a890e7b6496d426	\N
eea_tvv_range_aede9d226dab4d5dd34e82b2	eea_hist_980d0cd00c331e0d057a97d0	\N
eea_tvv_range_aede9d226dab4d5dd34e82b2	eea_hist_aead1c1bec3c2f44a7370811	\N
eea_tvv_range_6a24111cc6a16cda4e93912c	eea_hist_0655bc12b1b785a5cb8d570a	\N
eea_tvv_range_6a24111cc6a16cda4e93912c	eea_hist_d280b21e9ece2f8c7b7fb8e4	\N
eea_tvv_range_6a24111cc6a16cda4e93912c	eea_hist_cc9bfd0df0d9df06fa5403a8	\N
eea_tvv_range_6a24111cc6a16cda4e93912c	eea_hist_5bb6a9e0e2fbdea1b22c161b	\N
eea_tvv_range_13a5d1634bf4f59ec89e5de1	eea_hist_b78af2d6062ea9752652581f	\N
eea_tvv_range_13a5d1634bf4f59ec89e5de1	eea_hist_6d6ec87d72440c0fc50db001	\N
eea_tvv_range_13a5d1634bf4f59ec89e5de1	eea_hist_2b163daac05e8a8469b27859	\N
eea_tvv_range_13a5d1634bf4f59ec89e5de1	eea_hist_02a891cb5dc851f8da692b45	\N
eea_tvv_range_13a5d1634bf4f59ec89e5de1	eea_hist_4461e72dd386d2bc3ef350e8	\N
eea_tvv_range_200a91e682e194f9a4219380	eea_hist_da0cf089eaca986e61e2e49b	\N
eea_tvv_range_200a91e682e194f9a4219380	eea_hist_bde6d8b9c37aff51a90ec715	\N
eea_tvv_range_200a91e682e194f9a4219380	eea_hist_43f5d7f9428be5f4ac2bdab3	\N
eea_tvv_range_200a91e682e194f9a4219380	eea_hist_ae7af8a490347130285e8ea9	\N
eea_tvv_range_d0129463eb68d0543ad55a8c	eea_hist_a852ef0b8264eeb0a86d6a70	\N
eea_tvv_range_d0129463eb68d0543ad55a8c	eea_hist_12b8d81177ed76aceb63a8b0	\N
eea_tvv_range_d0129463eb68d0543ad55a8c	eea_hist_a238885549f293059153ca0f	\N
eea_tvv_range_1a8cb77f762f9ea465c85162	eea_hist_d3e29cabaac59a9112c40816	\N
eea_tvv_range_1a8cb77f762f9ea465c85162	eea_hist_6e48fef123da74f6ea922f7f	\N
eea_tvv_range_1a8cb77f762f9ea465c85162	eea_hist_70f6b7901226e9c16c587780	\N
eea_tvv_range_1a8cb77f762f9ea465c85162	eea_hist_f0154dd7923d6a6bc1e91247	\N
eea_tvv_range_1a8cb77f762f9ea465c85162	eea_hist_c5c178e46d109a73608c9324	\N
eea_tvv_range_e1fa08c18fc2663ea3990d28	eea_hist_20b89fd315e34ced7309d798	\N
eea_tvv_range_e1fa08c18fc2663ea3990d28	eea_hist_ffda4c24e9ac4e0d3e96f66f	\N
eea_tvv_range_e1fa08c18fc2663ea3990d28	eea_hist_f18c16ee3ea6b384c617e36c	\N
eea_tvv_range_e1fa08c18fc2663ea3990d28	eea_hist_9d64f9d9138b06f517f80e0f	\N
eea_tvv_range_e1fa08c18fc2663ea3990d28	eea_hist_d49c77163f30fb48732f2794	\N
eea_tvv_range_0ba252f18c6d733c8c8254db	eea_hist_c07b0c18d1aa477ec47d3e19	\N
eea_tvv_range_0ba252f18c6d733c8c8254db	eea_hist_14121c4bac9335726f296947	\N
eea_tvv_range_0ba252f18c6d733c8c8254db	eea_hist_a1c2085a7d4c692ef585bf38	\N
eea_tvv_range_042141d3362cd21f79687718	eea_hist_8bf6918f1d45fe7cb974fbb6	\N
eea_tvv_range_042141d3362cd21f79687718	eea_hist_04320433731bfc2e0d9c9963	\N
eea_tvv_range_042141d3362cd21f79687718	eea_hist_4eac5a738706ddad0568ef8c	\N
eea_tvv_range_583e68cd88dd0f4cc37550b7	eea_hist_52f634fe99c055870615eb4e	\N
eea_tvv_range_583e68cd88dd0f4cc37550b7	eea_hist_df5301fa7b7d92b4bab535b9	\N
eea_tvv_range_583e68cd88dd0f4cc37550b7	eea_hist_0d581a7e526273260f369395	\N
eea_tvv_range_583e68cd88dd0f4cc37550b7	current_cluster:3778ed32ffce8f973978a4f34fab84b2	632
eea_tvv_range_583e68cd88dd0f4cc37550b7	current_cluster:a14a3fe45f09ad52c8c5717dc6347b83	632
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_888b104e69e1dc3b5ae79ee6	\N
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_f2c5d163d686c2bd09b830af	\N
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_45a98effadafbb699fa2aa18	\N
eea_tvv_range_83ced3db4202e310ba851f54	eea_hist_81d6fb2f2535244e5b92a3cd	\N
eea_tvv_range_23e92951a207a9084c6d4b44	eea_hist_a6f73e1f03bc68ea9b6daff9	\N
eea_tvv_range_23e92951a207a9084c6d4b44	eea_hist_19b13aa4496d91ffc08bc762	\N
eea_tvv_range_23e92951a207a9084c6d4b44	eea_hist_1ee57dd28ee0acc5b823f102	\N
eea_tvv_range_23e92951a207a9084c6d4b44	eea_hist_d6d44db8aeb0e0bebb2045e3	\N
eea_tvv_range_23e92951a207a9084c6d4b44	eea_hist_f86276bebbe37e5530173b85	\N
eea_tvv_range_6fe729cbe384acc087a055c1	eea_hist_27504e305a8c4c35160c4e5a	\N
eea_tvv_range_6fe729cbe384acc087a055c1	eea_hist_a494b652ae524a6a7efbc7ae	\N
eea_tvv_range_6fe729cbe384acc087a055c1	eea_hist_3e3f0b3c033d73cf9bad5f38	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_b22e88191e52592a4f6a47c6	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_01a186d0703a7487e35e4ad8	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_299612ab66f03eae9c33fb35	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_39b91a700687e53eb7aeb1f2	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_1feb79cbb3e514d255cfac4b	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_f725b36200f64b7cbf7c1868	\N
eea_tvv_range_8115b1e02381582ef55109eb	eea_hist_c933fa1222335343cc71f451	\N
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	eea_hist_194d42de592939ab4ae2dc66	\N
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	eea_hist_ae8bdcb65c7a72d6891c961d	\N
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	eea_hist_eb82c7515c832ba461bc4fdc	\N
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	eea_hist_4149f2218074aa786e052ad6	\N
eea_tvv_range_f1cca1ea2c8ce79e73ce2788	eea_hist_97dbd69fe8258c90b969f9f2	\N
eea_tvv_range_0b34ff3fa3ad9b42a90d65f3	eea_hist_a5e37da91a63d79d6b8cf944	\N
eea_tvv_range_0b34ff3fa3ad9b42a90d65f3	eea_hist_de8c82336901457eccd7b7d2	\N
eea_tvv_range_0b34ff3fa3ad9b42a90d65f3	eea_hist_fa35d49e802c1e4323e0afdf	\N
eea_tvv_range_0b34ff3fa3ad9b42a90d65f3	eea_hist_517c637d633a5819e12a3705	\N
eea_tvv_range_87d111c6f0b89df412b016fa	eea_hist_bdae5c66afc824b323d8f687	\N
eea_tvv_range_87d111c6f0b89df412b016fa	eea_hist_2c07e3d9c2123ba99a3ac562	\N
eea_tvv_range_c670e919943408dee12ab561	eea_hist_38974b6baaf3f5bb84896f2c	\N
eea_tvv_range_c670e919943408dee12ab561	eea_hist_d031f4c3aaf6c6c08d24c772	\N
eea_tvv_range_875c7ffb98c648352078455d	eea_hist_ac9ad039f01a90d932b4f661	\N
eea_tvv_range_875c7ffb98c648352078455d	eea_hist_5f9b5dc5fcf2378d16a8b371	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_3299512b6317992051cf7ddf	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_36db56bffbfef5bc427a2dd1	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_02c5ced8e335e8b76373ee6d	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_71ef2839a3a2b6d7351260d9	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_3a4cdc463787577cb49ec381	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_58aab05fe112c770dd1a02e8	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_6e98201e08a2845ac61865e7	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_54e2fb4a9a218bb501766c3c	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_e15976970ff67226d1912515	\N
eea_tvv_range_2d396b1671f9e0fa1b594ae4	eea_hist_0e7415b350efa3b6c99fdd7d	\N
eea_tvv_range_2b2027b85d7a0261c2054042	eea_hist_969f1b8a6662c9cde9c0ff55	\N
eea_tvv_range_2b2027b85d7a0261c2054042	eea_hist_9d90704ecd7f55dfb3169aaf	\N
eea_tvv_range_2b2027b85d7a0261c2054042	eea_hist_24e04c29522303f55b0987f3	\N
eea_tvv_range_2b2027b85d7a0261c2054042	eea_hist_893c511dbc53d6e24341ec9c	\N
eea_tvv_range_46cc622777603670680e29d0	eea_hist_e834a0cae0b513755db77bdd	\N
eea_tvv_range_46cc622777603670680e29d0	eea_hist_b75620502d26508fa7e23bc1	\N
eea_tvv_range_46cc622777603670680e29d0	eea_hist_5db21b22e6a9cc4a8e4b7e30	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_eb46f60bc31801367d9bf82e	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_b26ffba719567487b8702ddb	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_e97350cc828ea37206637a72	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_75097129bd3ee860fee7b241	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_a658d132679e7cf5286f5143	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_5ce081bd8145eec0080f2f44	\N
eea_tvv_range_9216e6290ffd7726ec6f13ff	eea_hist_91b4e6d83734a55016b6a4ae	\N
eea_tvv_range_498fe673f75b56cf5aa7049d	eea_hist_457f01d68d14b5b480387319	\N
eea_tvv_range_498fe673f75b56cf5aa7049d	eea_hist_032fc89e73425b96748e956c	\N
eea_tvv_range_498fe673f75b56cf5aa7049d	eea_hist_d12ad838f800c7dec49f6ba5	\N
eea_tvv_range_498fe673f75b56cf5aa7049d	eea_hist_ce1a774e5dd6fc70a8c65336	\N
eea_tvv_range_498fe673f75b56cf5aa7049d	eea_hist_aae99f51bef82e4040202307	\N
eea_tvv_range_1bd5d15638a6c8848d2c5b6f	eea_hist_53094b846d57e5a08c9612b9	\N
eea_tvv_range_1bd5d15638a6c8848d2c5b6f	eea_hist_a2e6e7cc00ff7edca9c3afc6	\N
eea_tvv_range_1bd5d15638a6c8848d2c5b6f	eea_hist_8c2186533d4dc9dac7f37e18	\N
eea_tvv_range_1bd5d15638a6c8848d2c5b6f	current_cluster:5534b996e1b85cd5f3f19179a2632f26	258
eea_tvv_range_7067e894ccceb518d2ea7187	eea_hist_c163aac506073f44e75f99a9	\N
eea_tvv_range_7067e894ccceb518d2ea7187	current_cluster:7df102fd1d35d8745bea66c1fe09748e	256
eea_tvv_range_ffa080fec4e0fd9412a072d4	eea_hist_2375c70062f2edf9fa07c7db	\N
eea_tvv_range_ffa080fec4e0fd9412a072d4	eea_hist_b963932ba30dcdd8dab38ac9	\N
eea_tvv_range_ffa080fec4e0fd9412a072d4	eea_hist_9f9125b3a586bff9e8463d27	\N
eea_tvv_range_7350b9e204a7f8c1f3585254	eea_hist_33397abd872f71b0f33594a7	\N
eea_tvv_range_7350b9e204a7f8c1f3585254	eea_hist_d45dbac5fe3e1b9ce8c8813c	\N
eea_tvv_range_7350b9e204a7f8c1f3585254	eea_hist_06fe2250ba84ccb46f4b04fd	\N
eea_tvv_range_7350b9e204a7f8c1f3585254	current_cluster:3b34560cbaa2baa8a994c5cb791bd445	1138
eea_tvv_range_7fc38bbd2f425db16c4748e1	eea_hist_cacb50c1d214c53282f3d1cf	\N
eea_tvv_range_7fc38bbd2f425db16c4748e1	eea_hist_909679310b5c9e63992969f6	\N
eea_tvv_range_7fc38bbd2f425db16c4748e1	eea_hist_cca4d1b4ba4ed498aeadf45a	\N
eea_tvv_range_7fc38bbd2f425db16c4748e1	eea_hist_c3cc011ccc511952959fcd8d	\N
eea_tvv_range_7fc38bbd2f425db16c4748e1	eea_hist_2287a23c1806d601b031f483	\N
eea_tvv_range_720775527af699ff5772c18c	eea_hist_9395355b462b42d09050a6b3	\N
eea_tvv_range_720775527af699ff5772c18c	eea_hist_c7f249ad67f5b960761f0263	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_513686b255e37f19995be8a4	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_d7b9213ccdf92f290d970420	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_a2ef2fdd64170e21de3340fd	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_573a12d8d4a06c8f9bc54e04	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_ba58719ecff590039714cc02	\N
eea_tvv_range_bcde49674783397645a53d96	eea_hist_5d4a70511e15ed0038061fa0	\N
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	eea_hist_a25ce8436b736b2dbc6f55bd	\N
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	eea_hist_cef3768158ad2ebb5fedcbe5	\N
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	eea_hist_b0d3d2be019b990969e443b8	\N
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	eea_hist_cce8f0782d74b5a9d707a5b7	\N
eea_tvv_range_8a8683b6bf3f75d7e57a3a90	eea_hist_eb71d49be9ca5d7d92fa9265	\N
eea_tvv_range_cc965d93449d74e70010f947	eea_hist_e90acde18bf643c0d384f8dc	\N
eea_tvv_range_cc965d93449d74e70010f947	eea_hist_a75532a91de82dfaf9bd55d0	\N
eea_tvv_range_827aadc0a8050237399724aa	eea_hist_5d789b1a7325de2dff083e87	\N
eea_tvv_range_827aadc0a8050237399724aa	eea_hist_20504062dc54eda7586ed31e	\N
eea_tvv_range_55a798a56259c4bac62310d9	eea_hist_021fd85e26b9822b6f22e3e5	\N
eea_tvv_range_55a798a56259c4bac62310d9	eea_hist_f6f365e5bca99f486a7aa312	\N
eea_tvv_range_55a798a56259c4bac62310d9	eea_hist_78ded0121562f1f8dfe69709	\N
eea_tvv_range_5445c6e1ba426e713d3da3b0	eea_hist_227939d8f608dd0cf35bf587	\N
eea_tvv_range_5445c6e1ba426e713d3da3b0	eea_hist_92d108917ecf00446ebdba7c	\N
eea_tvv_range_5445c6e1ba426e713d3da3b0	eea_hist_c17a2d6f2e2ce4beea2ed727	\N
eea_tvv_range_5445c6e1ba426e713d3da3b0	eea_hist_a8c7396ed5901a28d39c6217	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_5896edfcde3916f1b2cc306c	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_e159e4d96fb4e399bd6fa0ea	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_33fa3f6da5c6f551e8abcedb	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_0a6f5fa3cdb21b55e22468cf	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_1118b7f9a627800d07a39c5c	\N
eea_tvv_range_6ad45a3a501aa95abeac7b74	eea_hist_9ffb485eeab19b04cc585b78	\N
eea_tvv_range_50413d5a19de73b9d18692c7	eea_hist_df21fbb807f3f312024fa7fa	\N
eea_tvv_range_50413d5a19de73b9d18692c7	eea_hist_babd9b1efe62c912d9185f7c	\N
eea_tvv_range_143dc4bed19509fd2766f8c3	eea_hist_f71e0ada9d63a11c69ef44a3	\N
eea_tvv_range_143dc4bed19509fd2766f8c3	current_cluster:6f8dcf3527e39d6761d217c532f0b4a9	570
eea_tvv_range_555c13b77ea4a7eedd253df0	eea_hist_fc33bb3be574f78f3b2e0e0f	\N
eea_tvv_range_555c13b77ea4a7eedd253df0	current_cluster:cae50415676d3961c9919308b5bde37c	569
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_86f4ab4aaaad849a0201ac2c	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_37d9b4048f38cc06c7c438c5	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_cc822de6a23279edfaba2aa8	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_5fefa3dfdb81c40da64f7b54	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_7c435da4918d182ecde02b40	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_4695e57b513a946f0f5a1945	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_0c7ca1f54f16f238be6b0805	\N
eea_tvv_range_0a3978c95411afe794a0a3d7	eea_hist_f967391d0f166a2142d40041	\N
eea_tvv_range_7acc4728631972c563b922cf	eea_hist_6d3cc2b5bc995f37e525d746	\N
eea_tvv_range_7acc4728631972c563b922cf	eea_hist_1316af230504740859969484	\N
eea_tvv_range_7acc4728631972c563b922cf	eea_hist_80debe1637fb869224bc2b83	\N
eea_tvv_range_7acc4728631972c563b922cf	eea_hist_d9fee6266d9d94102db46374	\N
eea_tvv_range_72a5cb1963c0a360addef0fb	eea_hist_f7642d4c1117d687128e94b3	\N
eea_tvv_range_72a5cb1963c0a360addef0fb	eea_hist_1f1694b27f0b5942520a3556	\N
eea_tvv_range_72a5cb1963c0a360addef0fb	eea_hist_ae89394fbb437b99b19ed158	\N
eea_tvv_range_7481dc165423b3ebfe85921d	eea_hist_b56469e9c65e7096ee724ece	\N
eea_tvv_range_7481dc165423b3ebfe85921d	eea_hist_ca5451ab18945c9d5e5395ae	\N
eea_tvv_range_7481dc165423b3ebfe85921d	eea_hist_b4b910ac7dc939ef294b09c7	\N
eea_tvv_range_543b4c4c3ec3f9a6e4d51caa	eea_hist_796ebd56ef619b2216d42d00	\N
eea_tvv_range_543b4c4c3ec3f9a6e4d51caa	current_cluster:54d35b5a7e9f5d7a19dcec7c3952113c	311
eea_tvv_range_53de10fa0ff350a1bd25e47b	eea_hist_bed3fbb973c3b78401ae8bd9	\N
eea_tvv_range_53de10fa0ff350a1bd25e47b	eea_hist_3719dc55407915cc0f48d338	\N
eea_tvv_range_53de10fa0ff350a1bd25e47b	eea_hist_8e706ae26dfd2ede47d35265	\N
eea_tvv_range_53de10fa0ff350a1bd25e47b	eea_hist_88fa03784ff69c027f90aaf4	\N
eea_tvv_range_53de10fa0ff350a1bd25e47b	eea_hist_38acd09dda98eb9c93add729	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_c13f3e75e11e025927657fc1	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_9fdbc7e17f206ea3885f0066	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_5c4486fe1315a498adeb59a3	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_786a184e82e8ad589e914233	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_5a29cd37211aff12b79229f2	\N
eea_tvv_range_c552ca397bd1211665af3711	eea_hist_2df932f8038ecacdf5f24cdc	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_c04f42fd1cd5ee3c285ae012	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_515c7357d49b3a18e74bbe6e	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_8efa05e214110530977d2e31	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_aecb4ed9b88d9fe3a5887453	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_cf730db1aee3910b453d9e83	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_b7f1a4555ff18e7cff7f6aca	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_38611fb848bc286cc2d9400f	\N
eea_tvv_range_2aaedb68184f556651b85292	eea_hist_40730231c80205e83579801d	\N
eea_tvv_range_2e8a5c31f4c4d250c47a29cc	eea_hist_4e3be2ec0526e7717bbf91f5	\N
eea_tvv_range_2e8a5c31f4c4d250c47a29cc	eea_hist_20d8a4d8a67b1683a4b0247a	\N
eea_tvv_range_2e8a5c31f4c4d250c47a29cc	eea_hist_32319b7f3d111d0ccdd92bdc	\N
eea_tvv_range_2e8a5c31f4c4d250c47a29cc	eea_hist_d19bd8f60b8723156196d52f	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_98a747264ed3c45df895fd6f	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_a07c2b5496cfce69615a4be3	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_103a51a4fd93793b7746500c	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_ba8bfa7376711466bf48e4cc	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_bf70d49e3343e190d93909bb	\N
eea_tvv_range_0cb22995f4d6fd0674a7379a	eea_hist_c4235275f5573c29ec3fb29d	\N
eea_tvv_range_e13f8ec9f562f31f0ea4a0fa	eea_hist_7d024e50567d02c21621e57f	\N
eea_tvv_range_e13f8ec9f562f31f0ea4a0fa	eea_hist_e6c6c0cce5045b60b7eb220b	\N
eea_tvv_range_e13f8ec9f562f31f0ea4a0fa	current_cluster:78c8b68fb30a303e2d1a4218c63095ad	809
eea_tvv_range_335be9fc901d1f0a152c232d	eea_hist_6f7811f6bce462c126ac6973	\N
eea_tvv_range_335be9fc901d1f0a152c232d	eea_hist_a54e16b8e901fd6ee841b4ff	\N
eea_tvv_range_81f3b105b5c8dea0d620ec54	eea_hist_f2c9debbc76ff9bebb0d99fe	\N
eea_tvv_range_81f3b105b5c8dea0d620ec54	current_cluster:6f1acf133751ad74564c6d085e968860	810
eea_tvv_range_f4953da80e33d14976995c14	eea_hist_1d163266c9b4343685d2adfd	\N
eea_tvv_range_f4953da80e33d14976995c14	eea_hist_1681077a43cf810aaa59e19e	\N
eea_tvv_range_f4953da80e33d14976995c14	current_cluster:4a349b9b9109e79932ac9805deae020a	872
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_33251b41149dd271d6d599b0	\N
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_a422562e349241d3c709e5ed	\N
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_9413cdf0584a65c7d8b8234a	\N
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_31e8b4cd55251830b5792421	\N
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_21b2675658c6f27eb0fe2230	\N
eea_tvv_range_42bffd751310f5b523ab4f9c	eea_hist_83fd7a345544461629136a65	\N
eea_tvv_range_5ec74fd01d826cb9fda7659c	eea_hist_0587e0a9ee0d74e6617118b3	\N
eea_tvv_range_5ec74fd01d826cb9fda7659c	eea_hist_47aad0ee893e38fcf1ef50d0	\N
eea_tvv_range_5ec74fd01d826cb9fda7659c	eea_hist_48bb9a8493b3a19fefead4e7	\N
eea_tvv_range_5ec74fd01d826cb9fda7659c	eea_hist_dcf66b81a7c4d38b63cf6890	\N
eea_tvv_range_5ec74fd01d826cb9fda7659c	eea_hist_f7294612448b86063a21a69a	\N
eea_tvv_range_8fadc394c9a0814cc55d3d7c	eea_hist_5e3e6c30565410ff7d23f82d	\N
eea_tvv_range_8fadc394c9a0814cc55d3d7c	eea_hist_e240587b379e07d3b109c2f1	\N
eea_tvv_range_8fadc394c9a0814cc55d3d7c	eea_hist_7784cb934eced10e919eed54	\N
eea_tvv_range_8fadc394c9a0814cc55d3d7c	eea_hist_7680ccfc59da8aa432a06343	\N
eea_tvv_range_87c21bc4605eb129a92fd9e4	eea_hist_36d38045117b7b6bb4fa2309	\N
eea_tvv_range_87c21bc4605eb129a92fd9e4	eea_hist_54ff3dfa496d30aacd0ab938	\N
eea_tvv_range_87c21bc4605eb129a92fd9e4	eea_hist_0c2cf00fe313bf87a8d39eb5	\N
eea_tvv_range_87c21bc4605eb129a92fd9e4	eea_hist_18b7c217b45e96b8e4dc6c21	\N
eea_tvv_range_35270407c6906fd5d72971a6	eea_hist_0c0df0228548861d4c389ab8	\N
eea_tvv_range_35270407c6906fd5d72971a6	eea_hist_f27c34216d047f62557a5d10	\N
eea_tvv_range_76420b11e12c72af3700312f	eea_hist_da4cd6f99d911208810832cf	\N
eea_tvv_range_76420b11e12c72af3700312f	eea_hist_94958364483202a9032c8c8d	\N
eea_tvv_range_e55b50149cab0c91ee6b919c	eea_hist_5d2eea218d630f7038a1a65d	\N
eea_tvv_range_e55b50149cab0c91ee6b919c	eea_hist_78f20aa3802ae865e67c1cba	\N
eea_tvv_range_e55b50149cab0c91ee6b919c	eea_hist_422563d0c4d1f06a405f6bc5	\N
eea_tvv_range_e55b50149cab0c91ee6b919c	eea_hist_85a571951babe9916e454ea1	\N
eea_tvv_range_e55b50149cab0c91ee6b919c	eea_hist_02557cbbf7ce4af9bb6e2763	\N
eea_tvv_range_06f1f047f22395d777cd4ebe	eea_hist_e7279bfa989b68a0704675a0	\N
eea_tvv_range_06f1f047f22395d777cd4ebe	eea_hist_cc266efdb17360a28415679b	\N
eea_tvv_range_06f1f047f22395d777cd4ebe	eea_hist_b55f4f4655df4e185bcf1c32	\N
eea_tvv_range_bbd8a435c9f4ee2f23e9dd8c	eea_hist_d5c52d261d6081e5ad736964	\N
eea_tvv_range_bbd8a435c9f4ee2f23e9dd8c	eea_hist_386eeda71cd154717839181a	\N
eea_tvv_range_bbd8a435c9f4ee2f23e9dd8c	eea_hist_0bb240060a1bb62285a146f3	\N
eea_tvv_range_bbd8a435c9f4ee2f23e9dd8c	eea_hist_e8992585b4ff7a4a4feec102	\N
eea_tvv_range_ae60fcddc5adac1638fb215a	eea_hist_840640047c658983d80e3892	\N
eea_tvv_range_ae60fcddc5adac1638fb215a	eea_hist_93d4b6e1dbfb46112ed548f4	\N
eea_tvv_range_ae60fcddc5adac1638fb215a	eea_hist_24e0379a59005e6cc7399e55	\N
eea_tvv_range_ae60fcddc5adac1638fb215a	eea_hist_f517331250daefa44c1cc835	\N
eea_tvv_range_157223fb938208ca0fa1681b	eea_hist_6e54d891bb5a7d4bddc95a4f	\N
eea_tvv_range_157223fb938208ca0fa1681b	eea_hist_4f66ec92cd3fcb6999ef0d53	\N
eea_tvv_range_157223fb938208ca0fa1681b	eea_hist_901e57dcbbaf8a81af1237af	\N
eea_tvv_range_ecbdd3a49f65f313f6250a79	eea_hist_276f44ad6df2dff7fddb267b	\N
eea_tvv_range_ecbdd3a49f65f313f6250a79	eea_hist_56be51ebd36144ba791c4ceb	\N
eea_tvv_range_ecbdd3a49f65f313f6250a79	eea_hist_d618c82f68b2a431174d7095	\N
eea_tvv_range_ef51a01c33cd634cfcc9a30c	eea_hist_4164468eb06d4d5ee5fff679	\N
eea_tvv_range_ef51a01c33cd634cfcc9a30c	eea_hist_e1e81f658609b54b1788ba34	\N
eea_tvv_range_ef51a01c33cd634cfcc9a30c	eea_hist_efc326f395697e0ec70d166a	\N
eea_tvv_range_b358afab7ec782a60b1c4b56	eea_hist_365a4da7817d768cb7440b99	\N
eea_tvv_range_b358afab7ec782a60b1c4b56	eea_hist_baeed0558e9620729ad0e9ea	\N
eea_tvv_range_b358afab7ec782a60b1c4b56	eea_hist_dea0ceaaf9835cd34d348070	\N
eea_tvv_range_b358afab7ec782a60b1c4b56	eea_hist_e9fefa3d308801838fde81ff	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_1d8b224d62797a1b4d73d02b	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_3d55e428536d5e77693793b4	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_a62194de732842e7af1fd0d0	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_1139618975cb253cd1549bc6	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_5b1b1d203d9ad360c71beaf3	\N
eea_tvv_range_c76e82caa7851026fe51077f	eea_hist_9dc12d75676a3363737e60fc	\N
eea_tvv_range_d5cf034c01c48aa4b12fe58d	eea_hist_e2205d94dec84f8832f3380a	\N
eea_tvv_range_d5cf034c01c48aa4b12fe58d	eea_hist_454df98b3db095363b698835	\N
eea_tvv_range_d5cf034c01c48aa4b12fe58d	eea_hist_1c51bce40cc2f5c21a865bb3	\N
eea_tvv_range_d5cf034c01c48aa4b12fe58d	eea_hist_2f45271c6346ba2749fe4e85	\N
eea_tvv_range_d5cf034c01c48aa4b12fe58d	eea_hist_95fd3ef052e749e5410c3b9b	\N
eea_tvv_range_917d9eef14f04f7c84760a34	eea_hist_72b56eac4212a83ca34307a1	\N
eea_tvv_range_917d9eef14f04f7c84760a34	eea_hist_464a967cb8b6f4875a104d4d	\N
eea_tvv_range_917d9eef14f04f7c84760a34	eea_hist_529fb700c7413dcdb946045c	\N
eea_tvv_range_6d0a3247481f6862b6e28970	eea_hist_b6bb77cd233d6cefef7196be	\N
eea_tvv_range_6d0a3247481f6862b6e28970	eea_hist_2fdb6f4b82ba833108f8e58b	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_9f213272f20f1e698daf2144	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_871ef52339f2586895def41d	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_4ca94ea8deead4821f028346	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_8c4cffb57efdbdfa21151bd2	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_db280370b75b9080afae501b	\N
eea_tvv_range_e4c0dd8895125c5a54c24373	eea_hist_d8f192a7154f8e32c85763b2	\N
eea_tvv_range_480e6785828019fbe74b5a2b	eea_hist_ca495c4eafb09de7e93c5afd	\N
eea_tvv_range_480e6785828019fbe74b5a2b	eea_hist_6e994b7be8259ca183d683e0	\N
eea_tvv_range_480e6785828019fbe74b5a2b	eea_hist_23cd67f6359fc99d8e4abdfb	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_01e7cd53710a41ac21ff7f1f	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_eddaf1f9685f114ed869f7d7	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_b333f1345059eab49feef397	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_b9b796b270e0e9c7ddbf5a61	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_d90cf0e48e089c2c46adbd81	\N
eea_tvv_range_3d41e0d33039a7a4bb8b9018	eea_hist_f69de28bb891bc4fb39ef3a3	\N
eea_tvv_range_871ae6965dbae862ee24a407	eea_hist_85adfec701183dbd45c87a33	\N
eea_tvv_range_871ae6965dbae862ee24a407	eea_hist_4d36972e0b6c86351a6adb14	\N
eea_tvv_range_871ae6965dbae862ee24a407	eea_hist_4325a11f245410bf12e9d6a1	\N
eea_tvv_range_871ae6965dbae862ee24a407	eea_hist_5268265094fcd73a35454a45	\N
eea_tvv_range_7f11ad7744331613741b7d3f	eea_hist_3e6fd6933f2bab483f13eebc	\N
eea_tvv_range_7f11ad7744331613741b7d3f	eea_hist_be3fd285f285f9d565ec5577	\N
eea_tvv_range_7f11ad7744331613741b7d3f	eea_hist_f27b544d3500dd9330d98c01	\N
eea_tvv_range_7f11ad7744331613741b7d3f	eea_hist_edd5d4b75d6fd3aa2b640daa	\N
eea_tvv_range_52e99c24887338a9240cb96b	eea_hist_52e7ab773061465e347c12fb	\N
eea_tvv_range_52e99c24887338a9240cb96b	eea_hist_9fa3d36cb3d5f0d0225e6507	\N
eea_tvv_range_52e99c24887338a9240cb96b	eea_hist_15096297d0b84240aada079f	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_1faa60a8abb6c34617e1ec13	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_8dd7193de8b7b182427dc1f4	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_e17a226a9aaccad97be3c6ad	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_d44948681d966d82812b30ef	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_2a12a95cd52172f18a6f0703	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_e0866273d7f0c32284189406	\N
eea_tvv_range_cb8f190772d50fa0675d29d8	eea_hist_2f00f494aba79ca40b68b43f	\N
eea_tvv_range_74a636d550454d3c8cd55af9	eea_hist_816addb76030b537bf0b6fca	\N
eea_tvv_range_74a636d550454d3c8cd55af9	eea_hist_6fc127dd56f774914e26365e	\N
eea_tvv_range_74a636d550454d3c8cd55af9	eea_hist_9f81fde8f263689cbf5beede	\N
eea_tvv_range_74a636d550454d3c8cd55af9	eea_hist_9d85970dd4b53729ad9eb353	\N
eea_tvv_range_74a636d550454d3c8cd55af9	eea_hist_a8ee7e0eefa1329b5b1d10ba	\N
eea_tvv_range_c244ef2cdfbeecec4ce211eb	eea_hist_72b7840d329c96accb9f6227	\N
eea_tvv_range_c244ef2cdfbeecec4ce211eb	eea_hist_4a299353fb2fe75dea91f76d	\N
eea_tvv_range_c244ef2cdfbeecec4ce211eb	eea_hist_953098daa2305f4c46a31133	\N
eea_tvv_range_3f5ffea7a7a3667ed9fdb5dd	eea_hist_2112f18637294f63d7b0cd45	\N
eea_tvv_range_3f5ffea7a7a3667ed9fdb5dd	eea_hist_144b191e43de865eb87ee43b	\N
eea_tvv_range_d608f551e2ff2368194c73fd	eea_hist_6b89a792e8bc2363b737ccba	\N
eea_tvv_range_d608f551e2ff2368194c73fd	eea_hist_8b894d8e9c8cb55a2bee785c	\N
eea_tvv_range_d608f551e2ff2368194c73fd	eea_hist_36764a64bd9816061f6a6f92	\N
eea_tvv_range_d608f551e2ff2368194c73fd	eea_hist_357e53ebd7dd65fc14e13bae	\N
eea_tvv_range_d608f551e2ff2368194c73fd	eea_hist_fc73d620e8c78e7cfcc11e2b	\N
eea_tvv_range_0c243e9f0ef57c4e05178369	eea_hist_54b548aa36ea6a28d7f16171	\N
eea_tvv_range_0c243e9f0ef57c4e05178369	eea_hist_eb8087776db59e81c0e26717	\N
eea_tvv_range_0c243e9f0ef57c4e05178369	eea_hist_807e68350ca86a0b7a90ccaf	\N
eea_tvv_range_0c243e9f0ef57c4e05178369	eea_hist_5e3a01e29df5ea1612ae0a40	\N
eea_tvv_range_0c243e9f0ef57c4e05178369	eea_hist_ded5e1e51483d39c759bae4f	\N
eea_tvv_range_8c13287079c2bbe5aeffdfca	eea_hist_1c86581d4f52df497aadebe1	\N
eea_tvv_range_8c13287079c2bbe5aeffdfca	eea_hist_f517e315462c2610dcbc695b	\N
eea_tvv_range_8c13287079c2bbe5aeffdfca	eea_hist_3c651f05e5e7132736d940dd	\N
eea_tvv_range_2b10aecbc5e9973a928d518a	eea_hist_77b018e354ded51a8219cd5d	\N
eea_tvv_range_2b10aecbc5e9973a928d518a	eea_hist_3d679582e1114c2e1cb63dbc	\N
eea_tvv_range_2b10aecbc5e9973a928d518a	eea_hist_cee1da6556861b7aaf5b915d	\N
eea_tvv_range_2b10aecbc5e9973a928d518a	eea_hist_e35b04f7bf7b687f592abecc	\N
eea_tvv_range_38cc1f01e360c261f52d638a	eea_hist_e18348c71efa6504933b87dd	\N
eea_tvv_range_38cc1f01e360c261f52d638a	eea_hist_fe50dc12d5eb43315532fd5f	\N
eea_tvv_range_38cc1f01e360c261f52d638a	eea_hist_5376a204e8dd7dbb9497e4f4	\N
eea_tvv_range_fa3a369c99f5ce1bf4bf1931	eea_hist_c1ed9ae56edc23c98563ec16	\N
eea_tvv_range_fa3a369c99f5ce1bf4bf1931	eea_hist_51103c41cca97346e07a64bf	\N
eea_tvv_range_fa3a369c99f5ce1bf4bf1931	eea_hist_82e491f2a00558d066831245	\N
eea_tvv_range_fd30e8ededb9bb612bb83af4	eea_hist_daa7463e1370b05c4030d9c4	\N
eea_tvv_range_fd30e8ededb9bb612bb83af4	eea_hist_f38c77d72c4969a55286486e	\N
eea_tvv_range_7f2e3b4ed59589bb128a1c41	eea_hist_c18554650d71c588c4c7c55f	\N
eea_tvv_range_7f2e3b4ed59589bb128a1c41	eea_hist_2ffc881a4e41b1ea88fd9088	\N
eea_tvv_range_7f2e3b4ed59589bb128a1c41	eea_hist_65157b8439d31e7fc340694a	\N
eea_tvv_range_7f2e3b4ed59589bb128a1c41	eea_hist_7716d357236e22834add71c6	\N
eea_tvv_range_20b0472ddecdb4c6cf668dc9	eea_hist_f9a458ecdc3318876fbce717	\N
eea_tvv_range_20b0472ddecdb4c6cf668dc9	eea_hist_05705af8a589b33e77d1f339	\N
eea_tvv_range_20b0472ddecdb4c6cf668dc9	eea_hist_35a55eb96399f9b1e09868a5	\N
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	eea_hist_4d97d91244e4c5515d33ea98	\N
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	eea_hist_ff25823cc1f973a7500b6ed6	\N
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	eea_hist_8886fdf4ca0d544b068a2ba6	\N
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	eea_hist_67b1c3eb8fb1f25d6a2ebe02	\N
eea_tvv_range_c29bc4cf1c7c013b9ca06cc2	eea_hist_f315324d076b85593f0a8c3c	\N
eea_tvv_range_d696a67b706779f686737a8e	eea_hist_f8b0a04d7e7df4edbc7595f7	\N
eea_tvv_range_d696a67b706779f686737a8e	eea_hist_144ff0baa61d91521b6225be	\N
eea_tvv_range_d696a67b706779f686737a8e	eea_hist_77b048ca1feb0bf1bbbe1f58	\N
eea_tvv_range_de21186819d0c3ed6721b6b4	eea_hist_4a9efce7d8b6fc010ed59c70	\N
eea_tvv_range_de21186819d0c3ed6721b6b4	eea_hist_7a32b50eacc835d145228290	\N
eea_tvv_range_de21186819d0c3ed6721b6b4	eea_hist_5624486a92d76cbdc3913d8d	\N
eea_tvv_range_cdc1ade42f8a28462921ebb4	eea_hist_abaebe4cad1e7d8c50035526	\N
eea_tvv_range_cdc1ade42f8a28462921ebb4	eea_hist_2be4ed642f786b54b907b086	\N
eea_tvv_range_cdc1ade42f8a28462921ebb4	eea_hist_22357738a090a2521e38df04	\N
eea_tvv_range_cdc1ade42f8a28462921ebb4	eea_hist_d477a5ff4d7e9bb314b90d0a	\N
eea_tvv_range_cdc1ade42f8a28462921ebb4	eea_hist_8307b57a18a2a03090989d0b	\N
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	eea_hist_b389017c286cc53ff307d0db	\N
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	eea_hist_668a713e40bb997125ac6b34	\N
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	eea_hist_cb349b28e427937dcde592a5	\N
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	eea_hist_6875903f6cd180e4ab54ab58	\N
eea_tvv_range_f2e8cf67c3d2bbd7e9e0f07d	eea_hist_f3abf88cd714a045274cfcb7	\N
eea_tvv_range_93864f48bcedb3e1dcf7b395	eea_hist_f4b82bf843664f9953e5d40c	\N
eea_tvv_range_93864f48bcedb3e1dcf7b395	eea_hist_46c8e16fbe799e777602996b	\N
eea_tvv_range_93864f48bcedb3e1dcf7b395	eea_hist_ba4e49b2a7186b419426604b	\N
eea_tvv_range_93864f48bcedb3e1dcf7b395	eea_hist_97dd68e41f7fe9b21975d263	\N
eea_tvv_range_06bbe2759dd5940388b11f11	eea_hist_561315e85cdeae8fb9c0116f	\N
eea_tvv_range_06bbe2759dd5940388b11f11	eea_hist_72b3bdd97d4742f3f2443086	\N
eea_tvv_range_06bbe2759dd5940388b11f11	eea_hist_990baaca1a545ea2b251ed14	\N
eea_tvv_range_56b188f0c6a744fe34510253	eea_hist_f1d2cf42515180765f54721b	\N
eea_tvv_range_56b188f0c6a744fe34510253	eea_hist_1dadcdcfc9a1e310af3b86af	\N
eea_tvv_range_56b188f0c6a744fe34510253	eea_hist_766ff743ff771ef2533c4ae9	\N
eea_tvv_range_56b188f0c6a744fe34510253	eea_hist_adb81106a4a2303e53c66e1e	\N
eea_tvv_range_f392de5f48c15770c4169b3f	eea_hist_175b42dd3510a201ff7b966c	\N
eea_tvv_range_f392de5f48c15770c4169b3f	eea_hist_253e2eb11c55c98916fd5ef1	\N
eea_tvv_range_f392de5f48c15770c4169b3f	eea_hist_35cc9cc32e40265a26a8fa11	\N
eea_tvv_range_f1c182be3b7370b276488ce1	eea_hist_41b88d3c1b83ac0b975298cf	\N
eea_tvv_range_f1c182be3b7370b276488ce1	eea_hist_39edc0f24c4cc2f0f7e0dd26	\N
eea_tvv_range_f1c182be3b7370b276488ce1	eea_hist_2e4ca734aa72d1147dfc98c7	\N
eea_tvv_range_f1c182be3b7370b276488ce1	eea_hist_bd213ad31682bbfadc48c8ab	\N
eea_tvv_range_299e0197c21d6a4145553a10	eea_hist_08e34520ba0178493910d62d	\N
eea_tvv_range_299e0197c21d6a4145553a10	eea_hist_7c7621decec63ee44e29583c	\N
eea_tvv_range_299e0197c21d6a4145553a10	eea_hist_10586dd6158cc619a5b51fca	\N
eea_tvv_range_299e0197c21d6a4145553a10	eea_hist_8b3769eebb36878874edcc2f	\N
eea_tvv_range_30240626d7153a09d8dd526a	eea_hist_50b8a5bf8a97dc0db0a152aa	\N
eea_tvv_range_30240626d7153a09d8dd526a	eea_hist_47f14c237217122d47536dee	\N
eea_tvv_range_30240626d7153a09d8dd526a	eea_hist_7dd5c3d59b38be3441f37816	\N
eea_tvv_range_db012011cecc0738c0be86a1	eea_hist_694c7b0489154e225c4272d1	\N
eea_tvv_range_db012011cecc0738c0be86a1	eea_hist_3d174e5202e7312192646dd9	\N
eea_tvv_range_db012011cecc0738c0be86a1	eea_hist_429e24aa130e24a3f8bbf3ec	\N
eea_tvv_range_f216b41a65b6f27b10c2caf1	eea_hist_434c8111e00e2fa917040159	\N
eea_tvv_range_f216b41a65b6f27b10c2caf1	eea_hist_1e8159ee5392794e11d58cb6	\N
eea_tvv_range_f216b41a65b6f27b10c2caf1	eea_hist_e5c56cbbd6a47a28254115bf	\N
eea_tvv_range_24934a378a7caf7ef95b1e4c	eea_hist_f69bb0ccee507e9e8eb6e4d5	\N
eea_tvv_range_24934a378a7caf7ef95b1e4c	eea_hist_9318b0fbbaba6d806dc9d61b	\N
eea_tvv_range_24934a378a7caf7ef95b1e4c	eea_hist_ec5808678e0083fe499fcfa6	\N
eea_tvv_range_effe7ed5580b2377350e11c7	eea_hist_a2cebd5735a177cc3cef68a2	\N
eea_tvv_range_effe7ed5580b2377350e11c7	eea_hist_3465b7dd24ce374ed23cb575	\N
eea_tvv_range_effe7ed5580b2377350e11c7	current_cluster:2aa7fecee16455301db766c157ffb865	707
eea_tvv_range_a42b4580514463993537f995	eea_hist_51eaf2b31a0583843d01365d	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_f2543b74f677b662f4275e91	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_966c2a0b5041929a010a863b	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_833d26282b40a5fa925db618	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_fa0530147e53e45c014d3cd7	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_71cb8125ac309182732fd39a	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_d58f424fdc1c02d17a614e25	\N
eea_tvv_range_a42b4580514463993537f995	eea_hist_bea79a682fbdbfb5f6d8033d	\N
eea_tvv_range_1f302fd88084452785dd4bce	eea_hist_1d147b3fc47f95cdd52538ed	\N
eea_tvv_range_1f302fd88084452785dd4bce	eea_hist_bc7d0750a0645ec291d5d603	\N
eea_tvv_range_1f302fd88084452785dd4bce	eea_hist_2337b0f145be776cf75a3943	\N
eea_tvv_range_6be9a0d6dc086c42e60d1b48	eea_hist_398da43680cd7bce41f97284	\N
eea_tvv_range_6be9a0d6dc086c42e60d1b48	eea_hist_488fea1c09077096774481a8	\N
eea_tvv_range_6be9a0d6dc086c42e60d1b48	eea_hist_3d03d3abf5fe9112cc0990ca	\N
eea_tvv_range_6be9a0d6dc086c42e60d1b48	eea_hist_930238ee61ec2c7be3933046	\N
eea_tvv_range_91d89978bded7af935171054	eea_hist_913d2d6ec4498b1dde37f54d	\N
eea_tvv_range_91d89978bded7af935171054	eea_hist_94f82362536bdcaf55040f22	\N
eea_tvv_range_91d89978bded7af935171054	eea_hist_040ef4d7d1f7b57c518def6f	\N
eea_tvv_range_91d89978bded7af935171054	eea_hist_0836ede1582af2cc85d3ccb3	\N
eea_tvv_range_36e0aca970be5304085bf1cb	eea_hist_d66d45209edc6577569a362a	\N
eea_tvv_range_36e0aca970be5304085bf1cb	eea_hist_8680ab44a188310675b1b01f	\N
eea_tvv_range_36e0aca970be5304085bf1cb	eea_hist_aa86c6ca219c77a98db53a24	\N
eea_tvv_range_36e0aca970be5304085bf1cb	eea_hist_0d7807e0bcf9ed49a440ecef	\N
eea_tvv_range_dc5d0550dd0867fb490091a9	eea_hist_a8adbdbafea9bc2a4832eb74	\N
eea_tvv_range_dc5d0550dd0867fb490091a9	eea_hist_40ad0ce2501b7085315f2256	\N
eea_tvv_range_dc5d0550dd0867fb490091a9	eea_hist_992c39345f7c74e6c4fecfe9	\N
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_2fdc0304d2aa951ebc7d9ecb	\N
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_31c437e54e6747de6abddff2	\N
eea_tvv_range_5b57841b9ca0dccdbfff958a	eea_hist_95e2054069c7b79afabba66a	\N
eea_tvv_range_665613abf36a497cb72cfb11	eea_hist_fa21a5794f2f000b31e77532	\N
eea_tvv_range_665613abf36a497cb72cfb11	eea_hist_39c172de5e1bf3e8b71c556c	\N
eea_tvv_range_665613abf36a497cb72cfb11	eea_hist_f8c8a1310bdbdf2b78a83e66	\N
eea_tvv_range_665613abf36a497cb72cfb11	eea_hist_38ba2a7a621d030d4f688802	\N
eea_tvv_range_665613abf36a497cb72cfb11	eea_hist_bd18d3fb3bb9b2e110991432	\N
eea_tvv_range_5045055080e5170317894640	eea_hist_8e0f4896cbcf259a2edbfa81	\N
eea_tvv_range_5045055080e5170317894640	eea_hist_7ec7a3af751d6f8155441828	\N
eea_tvv_range_5045055080e5170317894640	eea_hist_a35c2c0921329fd2a591e13a	\N
eea_tvv_range_5045055080e5170317894640	eea_hist_74c91d7fdae21a169d788477	\N
eea_tvv_range_67d186621ad27d99b9f7c0e0	eea_hist_c3c5ed6754df17aed6c08667	\N
eea_tvv_range_67d186621ad27d99b9f7c0e0	eea_hist_f4c7e52adb4b4cbd7bf806c3	\N
eea_tvv_range_67d186621ad27d99b9f7c0e0	eea_hist_d9e77f2bd74c59b70027c61c	\N
eea_tvv_range_67d186621ad27d99b9f7c0e0	eea_hist_382a45b94cb5fb0fbf4fd7f5	\N
eea_tvv_range_bfa735595d760dbb764bcc2e	eea_hist_9b340f6f48ede0816bccb1b6	\N
eea_tvv_range_bfa735595d760dbb764bcc2e	eea_hist_59d4cab98badb6d50d384f0f	\N
eea_tvv_range_bfa735595d760dbb764bcc2e	eea_hist_fdd3a34e9b310ace76dd2b4b	\N
eea_tvv_range_53abd1c539af2eb4d63186ed	eea_hist_3d529144b2f5192f13244d11	\N
eea_tvv_range_53abd1c539af2eb4d63186ed	eea_hist_10546f9b3d1716faa4ef9e59	\N
eea_tvv_range_e9e11ac65f26f9ad98e7365f	eea_hist_ffe4c2dbe72770464874ed92	\N
eea_tvv_range_e9e11ac65f26f9ad98e7365f	eea_hist_a6bfacb9887a43b2a912620c	\N
eea_tvv_range_e9e11ac65f26f9ad98e7365f	eea_hist_c402291edefd87319f444824	\N
eea_tvv_range_98f3a27aa3218997e845542c	eea_hist_fd9c3fa37f2d972372b66052	\N
eea_tvv_range_98f3a27aa3218997e845542c	eea_hist_99993c1e99a78357cd78268b	\N
eea_tvv_range_98f3a27aa3218997e845542c	eea_hist_4133fc16fb357aa5d5598a15	\N
eea_tvv_range_98f3a27aa3218997e845542c	eea_hist_17b9e547b6372d6c25cd15d8	\N
eea_tvv_range_e89a67dc1f0a1fff4a2c6930	eea_hist_a85499089f8c951fbfb18bfb	\N
eea_tvv_range_e89a67dc1f0a1fff4a2c6930	eea_hist_b011147c59a554da1ae1135d	\N
eea_tvv_range_e89a67dc1f0a1fff4a2c6930	eea_hist_692c53cf3f8713da389a9896	\N
eea_tvv_range_1499e02f91a13b39557e5e67	eea_hist_401c81fabf8ce80b9e3086ce	\N
eea_tvv_range_1499e02f91a13b39557e5e67	eea_hist_6bb5e773a6627df09e30e059	\N
eea_tvv_range_1499e02f91a13b39557e5e67	eea_hist_f832c3496972383d2c03c476	\N
\.
