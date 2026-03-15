// ===============================
// CONTROLE GLOBAL
// ===============================
const chartInstances = {};
if (typeof MAQUINA_ID === "undefined") {
    let MAQUINA_ID = "<?= $id ?>";
}

// ===============================
// FUNÇÃO GENÉRICA FETCH JSON
// ===============================
async function fetchJSON(url) {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`Erro HTTP: ${response.status}`);
    return response.json();
}

// ===============================
// DASHBOARD: ATUALIZAÇÃO DE GRÁFICOS
// ===============================
async function atualizarDashboard() {
    if (!MAQUINA_ID) return;

    try {
        const maquinas = await fetchJSON(
            `api/grafico.php?id=${MAQUINA_ID}&t=${Date.now()}`
        );

        carregarGraficos(maquinas);
        processarAlertas(maquinas);

    } catch (erro) {
        console.error("Erro ao atualizar dashboard:", erro);
    }
}

function carregarGraficos(maquinas) {
    const container = document.getElementById("graficos-sensores");
    if (!container) return;

    maquinas.forEach(maquina => {
        Object.values(maquina.sensores).forEach(sensor => {
            if (!sensor.labels || !sensor.valores || sensor.labels.length !== sensor.valores.length) return;

            const dadosFormatados = sensor.labels.map((label, idx) => ({
                x: new Date(label.replace(' ', 'T')),
                y: sensor.valores[idx]
            }));

            // Atualiza gráfico existente
            if (chartInstances[sensor.id]) {
                chartInstances[sensor.id].data.datasets[0].data = dadosFormatados;
                chartInstances[sensor.id].update();
                return;
            }

            // Criação de novo gráfico
            const card = document.createElement("div");
            card.classList.add("grafico-card");
            card.style.height = "500px";

            const canvas = document.createElement("canvas");
            card.appendChild(canvas);
            container.appendChild(card);

            const ctx = canvas.getContext('2d');
            const gradient = ctx.createLinearGradient(0, 0, 0, 300);
            gradient.addColorStop(0, 'rgba(0, 255, 200, 0.5)');
            gradient.addColorStop(1, 'rgba(0, 255, 200, 0)');

            const chart = new Chart(canvas, {
                type: sensor.grafico,
                data: {
                    datasets: [{
                        label: `${sensor.nome} (${sensor.unidade})`,
                        data: dadosFormatados,
                        borderColor: 'rgba(0, 200, 180, 1)',
                        backgroundColor: gradient,
                        fill: true,
                        tension: 0.4,
                        pointRadius: 3,
                        pointHoverRadius: 6,
                        pointBackgroundColor: 'rgba(0, 255, 200, 1)',
                        pointHoverBackgroundColor: 'white',
                        borderWidth: 2
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    animation: { duration: 1000, easing: 'easeOutQuart' },
                    scales: {
                        x: {
                            type: 'time',
                            time: { unit: 'minute', stepSize: 1, displayFormats: { minute: 'HH:mm' } },
                            ticks: { color: 'white', autoSkip: true, maxRotation: 0 },
                            grid: { color: 'rgba(255,255,255,0.1)' }
                        },
                        y: {
                            beginAtZero: true,
                            ticks: { color: 'white' },
                            grid: { color: 'rgba(255,255,255,0.1)' }
                        }
                    },
                    plugins: {
                        legend: { labels: { color: '#00C2A8', font: { size: 14, weight: 'bold' } } },
                        tooltip: { mode: 'nearest', intersect: false, backgroundColor: 'rgba(0,0,0,0.7)', titleColor: 'white', bodyColor: 'white', padding: 10 }
                    }
                }
            });

            chartInstances[sensor.id] = chart;
        });
    });
}


function atualizarAlerta(nivel) {

    const area = document.getElementById("area-alerta");

    if (nivel === "NORMAL") {
        area.innerHTML = `
            <p class="alerta verde">
                🟢 Sistema operando normalmente
            </p>
        `;
    }

    if (nivel === "CRITICO") {
        area.innerHTML = `
            <p class="alerta amarelo">
                🟡 Nível crítico detectado!
                <button class="btn-tecnico">Chamar Técnico</button>
            </p>
        `;
    }

    if (nivel === "EMERGENCIA") {
        area.innerHTML = `
            <p class="alerta vermelho">
                🔴 EMERGÊNCIA!
                <button class="btn-emergencia">Desligar Máquina</button>
            </p>
        `;
    }
}

function processarAlertas(maquinas) {

    let nivelMaisGrave = "NORMAL";

    maquinas.forEach(maquina => {

        Object.values(maquina.sensores).forEach(sensor => {

            if (sensor.nivelRisco === "EMERGENCIA") {
                nivelMaisGrave = "EMERGENCIA";
            }
            else if (sensor.nivelRisco === "CRITICO" && nivelMaisGrave !== "EMERGENCIA") {
                nivelMaisGrave = "CRITICO";
            }

        });

    });

    atualizarAlerta(nivelMaisGrave);
}




// ===============================
// ÚLTIMA LEITURA
// ===============================
async function atualizarUltimaLeitura() {
    try {
        const res = await fetch(`api/leitura.php?getHora=1&id=${MAQUINA_ID}&t=${Date.now()}`);
        if (!res.ok) return;
        const text = await res.text();
        const el = document.getElementById("ultima-leitura");
        if (el) el.textContent = text.trim();
    } catch (err) {
        console.error("Erro ao atualizar última leitura:", err);
    }
}

// ===============================
// SENSORES (VALOR ATUAL)
// ===============================
async function atualizarSensores() {
    if (!MAQUINA_ID) return;

    try {
        const sensores = await fetchJSON(`api/sensores.php?id=${MAQUINA_ID}`);
        const container = document.getElementById("sensor-card");
        if (!container) return;

        container.innerHTML = "";
        sensores.forEach(sensor => {
            const card = document.createElement("div");
            card.classList.add("sensor-card");
            card.innerHTML = `
                <h3>${sensor.nomeExibicao || "Valor"}</h3>
                <p class="valor">${sensor.valorAtual ?? 0} <span>${sensor.unidade}</span></p>
            `;
            container.appendChild(card);
        });
    } catch (erro) {
        console.error("Erro ao atualizar sensores:", erro);
    }
}

document.addEventListener("DOMContentLoaded", () => {
    atualizarDashboard();
    atualizarUltimaLeitura();
    atualizarSensores();

    setInterval(atualizarDashboard, 10000);
    setInterval(atualizarUltimaLeitura, 1000);
    setInterval(atualizarSensores, 2000);
});