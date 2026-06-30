const cars = {
  panda: { name: "Fiat Panda", consumption: 5.0, kw: 51, category: "city" },
  500: { name: "Fiat 500", consumption: 4.8, kw: 51, category: "city" },
  yaris: { name: "Toyota Yaris", consumption: 4.5, kw: 85, category: "city" },

  golf: { name: "Volkswagen Golf", consumption: 6.5, kw: 90, category: "compact" },
  a3: { name: "Audi A3", consumption: 6.8, kw: 110, category: "compact" },
  serie1: { name: "BMW Serie 1", consumption: 7.2, kw: 120, category: "compact" },

  corolla: { name: "Toyota Corolla", consumption: 5.5, kw: 122, category: "compact" },

  qashqai: { name: "Nissan Qashqai", consumption: 7.0, kw: 140, category: "suv" },
  tiguan: { name: "Volkswagen Tiguan", consumption: 7.5, kw: 150, category: "suv" },

  model3: { name: "Tesla Model 3", consumption: 0, kw: 208, category: "electric" }
};
function calculate(carKey, km) {
  const car = cars[carKey];
  if (!car) return null;

  const fuelPrice = 1.85;

  // carburante (0 per elettrica)
  const fuelCost =
    car.consumption === 0
      ? 30
      : (car.consumption / 100) * km * fuelPrice / 12;

  const insuranceYear = 300 + car.kw * 3.2;
  const insurance = insuranceYear / 12;

  const taxYear =
    car.category === "electric" ? 0 : car.kw * 2.3;

  const tax = taxYear / 12;

  let maintenance = 35;
  if (car.category === "suv") maintenance = 60;
  if (car.category === "electric") maintenance = 25;

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
