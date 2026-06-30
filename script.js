const cars = {
  panda: {
    name: "Fiat Panda",
    consumption: 5,
    kw: 51,
    category: "city"
  },
  golf: {
    name: "Volkswagen Golf",
    consumption: 6.5,
    kw: 90,
    category: "compact"
  }
};

function normalize(str) {
  return str.toLowerCase().trim();
}

function calculate(carKey, km) {
  const car = cars[carKey];
  if (!car) return null;

  const fuelPrice = 1.85;

  const fuelCost =
    (car.consumption / 100) * km * fuelPrice / 12;

  const insurance = (300 + car.kw * 3.5) / 12;
  const tax = (car.kw * 2.5) / 12;

  let maintenance = 30;
  if (car.category === "compact") maintenance = 45;

  const total = fuelCost + insurance + tax + maintenance;

  return {
    name: car.name,
    fuel: fuelCost.toFixed(0),
    insurance: insurance.toFixed(0),
    tax: tax.toFixed(0),
    maintenance: maintenance.toFixed(0),
    total: total.toFixed(0)
  };
}

function resolveCar(input) {
  const val = normalize(input);

  if (val.includes("panda")) return "panda";
  if (val.includes("golf")) return "golf";

  return null;
}

function run() {
  const input = document.getElementById("car").value;
  const km = Number(document.getElementById("km").value);

  const key = resolveCar(input);
  const res = calculate(key, km);

  if (!res) {
    document.getElementById("result").innerHTML =
      "<p>Auto non trovata. Prova: panda o golf</p>";
    return;
  }

  document.getElementById("result").innerHTML = `
    <h2>${res.name}</h2>
    <p>Carburante: ${res.fuel}€</p>
    <p>Assicurazione: ${res.insurance}€</p>
    <p>Bollo: ${res.tax}€</p>
    <p>Manutenzione: ${res.maintenance}€</p>
    <h2>Totale: ${res.total}€ / mese</h2>
  `;
}
