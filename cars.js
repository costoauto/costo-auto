const cars = [
  {
    id: "fiat-panda-1",
    brand: "Fiat",
    model: "Panda",
    fuel: "petrol",
    consumption: 5.0,
    kw: 51,
    category: "city"
  },
  {
    id: "fiat-500-1",
    brand: "Fiat",
    model: "500",
    fuel: "petrol",
    consumption: 4.8,
    kw: 51,
    category: "city"
  },
  {
    id: "vw-golf-8",
    brand: "Volkswagen",
    model: "Golf",
    fuel: "petrol",
    consumption: 6.5,
    kw: 90,
    category: "compact"
  },
  {
    id: "audi-a3-8y",
    brand: "Audi",
    model: "A3",
    fuel: "petrol",
    consumption: 6.8,
    kw: 110,
    category: "compact"
  },
  {
    id: "bmw-serie1-f40",
    brand: "BMW",
    model: "Serie 1",
    fuel: "petrol",
    consumption: 7.2,
    kw: 120,
    category: "compact"
  },
  {
    id: "toyota-yaris-4",
    brand: "Toyota",
    model: "Yaris",
    fuel: "hybrid",
    consumption: 4.2,
    kw: 85,
    category: "city"
  },
  {
    id: "nissan-qashqai-j12",
    brand: "Nissan",
    model: "Qashqai",
    fuel: "petrol",
    consumption: 7.0,
    kw: 140,
    category: "suv"
  },
  {
    id: "vw-tiguan-2",
    brand: "Volkswagen",
    model: "Tiguan",
    fuel: "diesel",
    consumption: 7.5,
    kw: 150,
    category: "suv"
  },
  {
    id: "tesla-model3",
    brand: "Tesla",
    model: "Model 3",
    fuel: "electric",
    consumption: 0,
    kw: 208,
    category: "electric"
  }
,
{
  "id": "fiat-panda",
  "brand": "Fiat",
  "model": "Panda",
  "fuel": "hybrid",
  "consumption": 5.0,
  "kw": 51,
  "category": "city",
  "price_new": 15950
},
{
  "id": "fiat-500",
  "brand": "Fiat",
  "model": "500",
  "fuel": "hybrid",
  "consumption": 4.8,
  "kw": 51,
  "category": "city",
  "price_new": 17900
},
{
  "id": "fiat-punto",
  "brand": "Fiat",
  "model": "Punto",
  "fuel": "petrol",
  "consumption": 5.8,
  "kw": 57,
  "category": "city",
  "price_new": 14500
},
{
  "id": "dacia-sandero",
  "brand": "Dacia",
  "model": "Sandero",
  "fuel": "petrol",
  "consumption": 5.7,
  "kw": 67,
  "category": "city",
  "price_new": 13500
},
{
  "id": "dacia-duster",
  "brand": "Dacia",
  "model": "Duster",
  "fuel": "petrol",
  "consumption": 6.8,
  "kw": 110,
  "category": "suv",
  "price_new": 20900
},
{
  "id": "renault-clio",
  "brand": "Renault",
  "model": "Clio",
  "fuel": "hybrid",
  "consumption": 5.0,
  "kw": 90,
  "category": "city",
  "price_new": 19500
},
{
  "id": "renault-captur",
  "brand": "Renault",
  "model": "Captur",
  "fuel": "hybrid",
  "consumption": 5.3,
  "kw": 90,
  "category": "suv",
  "price_new": 23900
},
{
  "id": "peugeot-208",
  "brand": "Peugeot",
  "model": "208",
  "fuel": "petrol",
  "consumption": 5.4,
  "kw": 75,
  "category": "city",
  "price_new": 17500
},
{
  "id": "peugeot-2008",
  "brand": "Peugeot",
  "model": "2008",
  "fuel": "petrol",
  "consumption": 5.9,
  "kw": 96,
  "category": "suv",
  "price_new": 24900
},
{
  "id": "citroen-c3",
  "brand": "Citroen",
  "model": "C3",
  "fuel": "petrol",
  "consumption": 5.5,
  "kw": 75,
  "category": "city",
  "price_new": 16500
}
  ,
{
  "id": "volkswagen-golf",
  "brand": "Volkswagen",
  "model": "Golf",
  "fuel": "petrol",
  "consumption": 6.5,
  "kw": 110,
  "category": "compact",
  "price_new": 29900
},
{
  "id": "volkswagen-polo",
  "brand": "Volkswagen",
  "model": "Polo",
  "fuel": "petrol",
  "consumption": 5.4,
  "kw": 70,
  "category": "city",
  "price_new": 19900
},
{
  "id": "volkswagen-tiguan",
  "brand": "Volkswagen",
  "model": "Tiguan",
  "fuel": "diesel",
  "consumption": 7.5,
  "kw": 150,
  "category": "suv",
  "price_new": 38900
},
{
  "id": "toyota-yaris",
  "brand": "Toyota",
  "model": "Yaris",
  "fuel": "hybrid",
  "consumption": 4.2,
  "kw": 85,
  "category": "city",
  "price_new": 23900
},
{
  "id": "toyota-corolla",
  "brand": "Toyota",
  "model": "Corolla",
  "fuel": "hybrid",
  "consumption": 4.5,
  "kw": 122,
  "category": "compact",
  "price_new": 28900
},
{
  "id": "toyota-yaris-cross",
  "brand": "Toyota",
  "model": "Yaris Cross",
  "fuel": "hybrid",
  "consumption": 4.6,
  "kw": 85,
  "category": "suv",
  "price_new": 28900
},
{
  "id": "ford-focus",
  "brand": "Ford",
  "model": "Focus",
  "fuel": "petrol",
  "consumption": 6.2,
  "kw": 110,
  "category": "compact",
  "price_new": 25900
},
{
  "id": "ford-puma",
  "brand": "Ford",
  "model": "Puma",
  "fuel": "petrol",
  "consumption": 5.8,
  "kw": 92,
  "category": "suv",
  "price_new": 26900
},
{
  "id": "ford-kuga",
  "brand": "Ford",
  "model": "Kuga",
  "fuel": "hybrid",
  "consumption": 6.0,
  "kw": 140,
  "category": "suv",
  "price_new": 34900
},
{
  "id": "honda-civic",
  "brand": "Honda",
  "model": "Civic",
  "fuel": "hybrid",
  "consumption": 4.8,
  "kw": 134,
  "category": "compact",
  "price_new": 33900
}
  ,
{
  "id": "bmw-serie1",
  "brand": "BMW",
  "model": "Serie 1",
  "fuel": "petrol",
  "consumption": 7.2,
  "kw": 120,
  "category": "premium",
  "price_new": 35900
},
{
  "id": "bmw-serie3",
  "brand": "BMW",
  "model": "Serie 3",
  "fuel": "diesel",
  "consumption": 6.0,
  "kw": 150,
  "category": "premium",
  "price_new": 47900
},
{
  "id": "bmw-x1",
  "brand": "BMW",
  "model": "X1",
  "fuel": "petrol",
  "consumption": 7.0,
  "kw": 140,
  "category": "suv",
  "price_new": 43900
},
{
  "id": "audi-a3",
  "brand": "Audi",
  "model": "A3",
  "fuel": "petrol",
  "consumption": 6.8,
  "kw": 110,
  "category": "premium",
  "price_new": 34900
},
{
  "id": "audi-a4",
  "brand": "Audi",
  "model": "A4",
  "fuel": "diesel",
  "consumption": 5.8,
  "kw": 150,
  "category": "premium",
  "price_new": 46900
},
{
  "id": "audi-q3",
  "brand": "Audi",
  "model": "Q3",
  "fuel": "petrol",
  "consumption": 7.2,
  "kw": 150,
  "category": "suv",
  "price_new": 43900
},
{
  "id": "mercedes-classe-a",
  "brand": "Mercedes-Benz",
  "model": "Classe A",
  "fuel": "petrol",
  "consumption": 6.5,
  "kw": 120,
  "category": "premium",
  "price_new": 38900
},
{
  "id": "mercedes-classe-c",
  "brand": "Mercedes-Benz",
  "model": "Classe C",
  "fuel": "diesel",
  "consumption": 6.2,
  "kw": 160,
  "category": "premium",
  "price_new": 51900
},
{
  "id": "mercedes-glc",
  "brand": "Mercedes-Benz",
  "model": "GLC",
  "fuel": "hybrid",
  "consumption": 6.8,
  "kw": 180,
  "category": "suv",
  "price_new": 61900
},
{
  "id": "alfa-giulia",
  "brand": "Alfa Romeo",
  "model": "Giulia",
  "fuel": "petrol",
  "consumption": 7.0,
  "kw": 147,
  "category": "premium",
  "price_new": 45900
},
{
  "id": "alfa-stelvio",
  "brand": "Alfa Romeo",
  "model": "Stelvio",
  "fuel": "petrol",
  "consumption": 7.5,
  "kw": 206,
  "category": "suv",
  "price_new": 58900
},
{
  "id": "tesla-model3",
  "brand": "Tesla",
  "model": "Model 3",
  "fuel": "electric",
  "consumption": 0,
  "kw": 208,
  "category": "electric",
  "price_new": 42900
},
{
  "id": "tesla-modely",
  "brand": "Tesla",
  "model": "Model Y",
  "fuel": "electric",
  "consumption": 0,
  "kw": 255,
  "category": "suv",
  "price_new": 46900
}
  ,
{
  "id": "kia-sportage",
  "brand": "Kia",
  "model": "Sportage",
  "fuel": "hybrid",
  "consumption": 6.0,
  "kw": 132,
  "category": "suv",
  "price_new": 35900
},
{
  "id": "kia-stonic",
  "brand": "Kia",
  "model": "Stonic",
  "fuel": "petrol",
  "consumption": 5.5,
  "kw": 74,
  "category": "suv",
  "price_new": 22900
},
{
  "id": "hyundai-tucson",
  "brand": "Hyundai",
  "model": "Tucson",
  "fuel": "hybrid",
  "consumption": 6.2,
  "kw": 132,
  "category": "suv",
  "price_new": 37900
},
{
  "id": "hyundai-i20",
  "brand": "Hyundai",
  "model": "i20",
  "fuel": "petrol",
  "consumption": 5.3,
  "kw": 74,
  "category": "city",
  "price_new": 19900
},
{
  "id": "mazda-cx30",
  "brand": "Mazda",
  "model": "CX-30",
  "fuel": "petrol",
  "consumption": 6.2,
  "kw": 110,
  "category": "suv",
  "price_new": 29900
},
{
  "id": "mazda-3",
  "brand": "Mazda",
  "model": "3",
  "fuel": "petrol",
  "consumption": 6.0,
  "kw": 122,
  "category": "compact",
  "price_new": 28900
},
{
  "id": "jeep-renegade",
  "brand": "Jeep",
  "model": "Renegade",
  "fuel": "petrol",
  "consumption": 6.8,
  "kw": 120,
  "category": "suv",
  "price_new": 32900
},
{
  "id": "jeep-compass",
  "brand": "Jeep",
  "model": "Compass",
  "fuel": "hybrid",
  "consumption": 6.5,
  "kw": 130,
  "category": "suv",
  "price_new": 38900
},
{
  "id": "suzuki-vitara",
  "brand": "Suzuki",
  "model": "Vitara",
  "fuel": "hybrid",
  "consumption": 5.6,
  "kw": 95,
  "category": "suv",
  "price_new": 25900
},
{
  "id": "suzuki-swift",
  "brand": "Suzuki",
  "model": "Swift",
  "fuel": "petrol",
  "consumption": 5.2,
  "kw": 66,
  "category": "city",
  "price_new": 18900
},
{
  "id": "mg-zs",
  "brand": "MG",
  "model": "ZS",
  "fuel": "petrol",
  "consumption": 6.8,
  "kw": 106,
  "category": "suv",
  "price_new": 22900
},
{
  "id": "mg4",
  "brand": "MG",
  "model": "MG4",
  "fuel": "electric",
  "consumption": 0,
  "kw": 150,
  "category": "electric",
  "price_new": 29900
}
];
