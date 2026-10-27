// Standalone UI regressions: no private snapshots, SQL data or network access required.
import fs from 'node:fs/promises';
import vm from 'node:vm';
import assert from 'node:assert/strict';
const source=await fs.readFile(new URL('../script.js',import.meta.url),'utf8');
const start=source.indexOf('const brandNameOverrides =');
const end=source.indexOf('\nfunction clearLoadingState(',start);
assert(start>=0&&end>start);
const context=vm.createContext({});vm.runInContext(source.slice(start,end),context,{timeout:1000});
const label=v=>context.formatVersionLabel(v,true);
assert.match(label({year_from:2025,year_to:2026,fuel_type:'petrol',hybrid_type:'hybrid',power_cv:110,
 system_power_cv:110,thermal_power_cv:100}),/^2025-2026.*110 CV \(100 CV termici\)/);
assert.doesNotMatch(label({fuel_type:'petrol',hybrid_type:'hybrid',power_cv:70}),/termici/);
assert.match(label({fuel_type:'petrol',hybrid_type:'hybrid',power_cv:65}),/65 CV/);
assert.match(label({fuel_type:'petrol/electric',hybrid_type:'plug_in_hybrid',system_power_cv:204,thermal_power_cv:150}),/204 CV \(150 CV termici\)/);
const descStart=source.indexOf('function getDepreciationDescription('),descEnd=source.indexOf('function formatEnergyUnitPrice(',descStart);
assert(descStart>=0&&descEnd>descStart);vm.runInContext(source.slice(descStart,descEnd),context);
assert.equal(context.getDepreciationDescription({depreciation_eur:1},{scenario_year_method:'coherent_existing_display_year'},
 {depreciation:'Stima con anno coerente e prezzo di riferimento'}),'Stima con anno coerente e prezzo di riferimento');
assert.match(context.getDepreciationDescription({depreciation_eur:null},{scenario_year_method:'coherent_existing_display_year'},{}),/Non disponibile/);
console.log('Frontend power labels: sistema/termico, ibride, PHEV e descrizioni degli anni coerenti ok');
