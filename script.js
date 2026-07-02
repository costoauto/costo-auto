let cars = [];

async function loadCars() {
  const res = await fetch("cars.json");
  cars = await res.json();
}

function normalize(str) {
  return str.toLowerCase().trim();
}

function findCar(input) {
  const val = normalize(input);

  return cars.find(car =>
    val.includes(car.model.toLowerCase()) ||
    val.includes(car.brand.toLowerCase()) ||
    val.includes(car.id.toLowerCase())
  );
}

function calculate(car, km) {
  const fuelPrice = 1.85;

  const fuelCost =
    car.fuel === "electric"
      ? 25
      : (car.consumption / 100) * km * fuelPrice / 12;

  const insurance = (300 + car.kw * 3.2) / 12;
  const tax = car.fuel === "electric" ? 0 : (car.kw * 2.3) / 12;

  let maintenance = 35;
  if (car.category === "suv") maintenance = 60;
  if (car.fuel === "electric") maintenance = 25;

  const total = fuelCost + insurance + tax + maintenance;

  return {
    name: car.brand + " " + car.model,
    fuel: fuelCost.toFixed(0),
    insurance: insurance.toFixed(0),
    tax: tax.toFixed(0),
    maintenance: maintenance.toFixed(0),
    total: total.toFixed(0)
  };
}

async function run() {
  console.log("AUTO TROVATA:", car);
  if (cars.length === 0) await loadCars();

  const input = document.getElementById("car").value;
  const km = Number(document.getElementById("km").value);
  const years = Number(document.getElementById("years").value);

  const car = findCar(input);
  console.log(car);
console.log(car.price_new);

  if (!car) {
    document.getElementById("result").innerHTML = "<p>Auto non trovata</p>";
    return;
  }

  const res = calculate(car, km);

const basePrice = Number(car.price_new) || 0;

const purchaseMonthly = basePrice > 0
  ? basePrice / (years * 12)
  : 0;

const totalMonthly = Number(res.total) + purchaseMonthly;

  const best = findCheapest(km);

  document.getElementById("result").innerHTML = `
    <h2>${res.name}</h2>

    <p>Carburante: ${res.fuel}€</p>
    <p>Assicurazione: ${res.insurance}€</p>
    <p>Bollo: ${res.tax}€</p>
    <p>Manutenzione: ${res.maintenance}</p>

    <hr>

    <p>🚗 Costo acquisto: ${purchaseMonthly.toFixed(0)}€ / mese (${years} anni)</p>

    <h2>Totale: ${totalMonthly.toFixed(0)}€ / mese</h2>

    <hr>

    <p>💡 Auto più economica: <b>${best.car.brand} ${best.car.model}</b></p>
    <p>👉 ${best.cost.toFixed(0)}€ / mese</p>
  `;
}


  <h2>Totale: ${res.total}€ / mese</h2>
    <p>🚗 Costo auto (acquisto): ${purchaseMonthly.toFixed(0)}€ / mese (${years} anni)</p>

<h2>Totale: ${(Number(res.total) + purchaseMonthly).toFixed(0)}€ / mese</h2>

<hr>

<p>💡 Auto più economica: <b>${best.car.brand} ${best.car.model}</b></p>
<p>👉 ${best.cost.toFixed(0)}€ / mese</p>
}
document.addEventListener("keydown", function(event) {
  if (event.key === "Enter") {
    run();
  }
});
function initKmSlider() {
  const kmInput = document.getElementById("km");
  const kmValue = document.getElementById("kmValue");

  if (!kmInput || !kmValue) return;

  const update = () => {
    kmValue.textContent = kmInput.value + " km";
  };

  kmInput.addEventListener("input", update);

  update(); // inizializza
}
window.addEventListener("DOMContentLoaded", () => {
  const kmInput = document.getElementById("km");
  const kmValue = document.getElementById("kmValue");

  const yearsInput = document.getElementById("years");
  const yearsValue = document.getElementById("yearsValue");

  if (kmInput && kmValue) {
    const updateKm = () => {
      kmValue.textContent = kmInput.value + " km";
    };
    kmInput.addEventListener("input", updateKm);
    updateKm();
  }

  if (yearsInput && yearsValue) {
    const updateYears = () => {
      yearsValue.textContent = yearsInput.value + " anni";
    };
    yearsInput.addEventListener("input", updateYears);
    updateYears();
  }
});
