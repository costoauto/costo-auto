const autoDatabase = [
  {
    nome: "panda",
    titolo: "Fiat Panda 1.0 Hybrid",
    consumo: 5.0,
    kw: 51
  },
  {
    nome: "golf",
    titolo: "Volkswagen Golf 2.0 TDI",
    consumo: 5.5,
    kw: 110
  },
  {
    nome: "bmw",
    titolo: "BMW Serie 1 118d",
    consumo: 5.8,
    kw: 110
  }
];

function handleKey(event) {
  if (event.key === "Enter") {
    cercaAuto();
  }
}

function cercaAuto() {

  const input = document.getElementById("search").value.toLowerCase();
  const km = Number(document.getElementById("km").value);
  const result = document.getElementById("result");

  const found = autoDatabase.find(a =>
    input.includes(a.nome)
  );

  if (!found) {
    result.innerHTML = "<p>❌ Auto non trovata</p>";
    return;
  }

  if (!km || km <= 0) {
    result.innerHTML = "<p>Inserisci km annui validi</p>";
    return;
  }

  // ⛽ carburante
  const prezzo = 1.8;
  const litri = (found.consumo / 100) * km;
  const carburanteBase = (litri * prezzo) / 12;

  const carburanteMin = carburanteBase * 0.9;
  const carburanteMax = carburanteBase * 1.1;

  // 🛡 assicurazione
  let assBase;
  if (found.kw < 70) assBase = 50;
  else if (found.kw < 100) assBase = 70;
  else assBase = 100;

  const assicurazioneMin = assBase * 0.8;
  const assicurazioneMax = assBase * 1.3;

  // 🏛 bollo
  const bollo = (found.kw * 1.5) / 12;

  // 🔧 manutenzione
  const manutenzioneMin = 35;
  const manutenzioneMax = 60;

  // 💰 totale
  const totaleMin =
    carburanteMin +
    assicurazioneMin +
    bollo +
    manutenzioneMin;

  const totaleMax =
    carburanteMax +
    assicurazioneMax +
    bollo +
    manutenzioneMax;

  result.innerHTML = `
    <h2>${found.titolo}</h2>

    <p><strong>Costo stimato mensile:</strong></p>

    <p style="font-size:22px">
      <strong>${Math.round(totaleMin)} – ${Math.round(totaleMax)} €</strong>
    </p>

    <hr>

    <p>⛽ Carburante: ${Math.round(carburanteMin)} – ${Math.round(carburanteMax)} €</p>
    <p>🛡 Assicurazione: ${Math.round(assicurazioneMin)} – ${Math.round(assicurazioneMax)} €</p>
    <p>🏛 Bollo: ${Math.round(bollo)} €</p>
    <p>🔧 Manutenzione: ${manutenzioneMin} – ${manutenzioneMax} €</p>

    <hr>

    <p style="font-size:12px;color:#666;">
      Stima basata su medie nazionali. Non è un preventivo ufficiale.
    </p>
  `;
}