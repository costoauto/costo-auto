const cars = {
  "fiat panda": {
    name: "Fiat Panda",
    consumption: 5,
    kw: 51,
    category: "city"
  },
  "volkswagen golf": {
    name: "Volkswagen Golf",
    consumption: 6.5,
    kw: 90,
    category: "compact"
  }
};

function calculate(carKey, km) {
  const car = cars[carKey.toLowerCase()];
  if (!car) return null;

  const fuelPrice = 1.85;

  const fuelCost =
    (car.consumption / 100) * km * fuelPrice / 12;

  const insuranceYear = 300 + car.kw * 3.5;
  const insurance = insuranceYear / 12;

  const taxYear = car.kw * 2.5;
  const tax = taxYear / 12;

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

function run() {
  const car = document.getElementById("car").value;
  const km = Number(document.getElementById("km").value);

  const res = calculate(car, km);

  if (!res) {
    document.getElementById("result").innerHTML =
      "<p>Auto non trovata. Prova: fiat panda, volkswagen golf</p>";
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
