document.addEventListener("DOMContentLoaded", () => {
    const btn = document.getElementById("btnSimular");
    const status = document.getElementById("status");
    const alertBox = document.getElementById("alertBox");
    const alertTitle = document.getElementById("alertTitle");
    const alertText = document.getElementById("alertText");

    const temp = document.getElementById("temp");
    const vib = document.getElementById("vib");
    const rpm = document.getElementById("rpm");

    let falha = false;

    btn.addEventListener("click", () => {
        falha = !falha;

        if (falha) {
            status.textContent = "Falha Detectada";
            status.classList.remove("normal");
            status.classList.add("alerta");

            temp.textContent = "98 °C";
            vib.textContent = "7.8 mm/s";
            rpm.textContent = "1600 RPM";

            alertBox.style.borderLeftColor = "#e74c3c";
            alertTitle.textContent = "Alerta Inteligente";
            alertText.textContent =
                "O sistema identificou padrões anormais nos sensores, indicando possível falha no motor.";
        } else {
            status.textContent = "Operação Normal";
            status.classList.remove("alerta");
            status.classList.add("normal");

            temp.textContent = "82 °C";
            vib.textContent = "4.1 mm/s";
            rpm.textContent = "1750 RPM";

            alertBox.style.borderLeftColor = "#1abc9c";
            alertTitle.textContent = "Sistema Estável";
            alertText.textContent =
                "Os sensores indicam funcionamento dentro dos parâmetros esperados.";
        }
    });
});
