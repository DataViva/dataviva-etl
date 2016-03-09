-- INSERT BRAZIL

INSERT into stat_ybhs (year, bra_id, hs_id, trade_balance, export_val, weight_value_export, import_val, weight_value_import, pci, rca, distance, opp_gain, top_municipality_export, municipality_export, top_municipality_import, municipality_import, top_export_destiny, top_export_value, top_import_origin, top_import_value)
SELECT year, 0 as Brazil, hs_id as Product, export_val - import_val as Trade_Balance, export_val, export_kg/export_val as Weight_Value_Export, import_val, import_kg/import_val as Weight_Value_Import, pci, NULL as RCA, NULL as Distance, NULL as Opp_gain,
(select name_pt from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymp.hs_id order by export_val desc limit 1) as Top_Municipality_Export,
(select export_val from dataviva.secex_ymbp where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymp.hs_id order by export_val desc limit 1) as Municipality_Export,
(select name_pt from dataviva.secex_ymbp a INNER JOIN dataviva.attrs_bra b ON a.bra_id = b.id where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymp.hs_id order by import_val desc limit 1) as Top_Municipality_Import,
(select import_val from dataviva.secex_ymbp where year = '2014' and month = '0' and bra_id_len = '9' and hs_id = dataviva.secex_ymp.hs_id order by import_val desc limit 1) as Municipality_Import,
(select wld_id from dataviva.secex_ympw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymp.hs_id order by export_val desc limit 1) as Top_Export_Destiny,
(select export_val from dataviva.secex_ympw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymp.hs_id order by export_val desc limit 1) as Top_Export_Value,
(select wld_id from dataviva.secex_ympw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymp.hs_id order by import_val desc limit 1) as Top_Import_Origin,
(select import_val from dataviva.secex_ympw where year = '2014' and month = '0' and wld_id_len = 5 and hs_id = dataviva.secex_ymp.hs_id order by import_val desc limit 1) as Top_Import_Value
 from dataviva.secex_ymp where year = '2014' and month = '0';

 -- INSERT LOCATIONS

