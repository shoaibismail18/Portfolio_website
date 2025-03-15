document.addEventListener("DOMContentLoaded", function () {
    console.log("Portfolio Website Loaded!");

    // Dark Mode Toggle Button
    const toggleThemeBtn = document.createElement("button");
    toggleThemeBtn.innerText = "Dark Mode";
    toggleThemeBtn.style.position = "fixed";
    toggleThemeBtn.style.bottom = "20px";
    toggleThemeBtn.style.right = "20px";
    toggleThemeBtn.style.padding = "10px";
    toggleThemeBtn.style.cursor = "pointer";
    toggleThemeBtn.style.background = "#6a11cb";
    toggleThemeBtn.style.color = "white";
    toggleThemeBtn.style.border = "none";
    toggleThemeBtn.style.borderRadius = "5px";
    toggleThemeBtn.style.boxShadow = "0 4px 6px rgba(0, 0, 0, 0.1)";
    document.body.appendChild(toggleThemeBtn);

    // Check Local Storage for Dark Mode State
    let darkMode = localStorage.getItem("darkMode");

    if (darkMode === "enabled") {
        enableDarkMode();
    }

    // Toggle Dark Mode on Click
    toggleThemeBtn.addEventListener("click", function () {
        darkMode = localStorage.getItem("darkMode");

        if (darkMode !== "enabled") {
            enableDarkMode();
        } else {
            disableDarkMode();
        }
    });

    function enableDarkMode() {
        document.body.classList.add("dark-mode");
        localStorage.setItem("darkMode", "enabled");
        toggleThemeBtn.innerText = "Light Mode";
    }

    function disableDarkMode() {
        document.body.classList.remove("dark-mode");
        localStorage.setItem("darkMode", "disabled");
        toggleThemeBtn.innerText = "Dark Mode";
    }

    // Show Alert on Clicking Portfolio Title
    document.querySelector("header h1").addEventListener("click", function () {
        alert("Welcome to Shoaib's Portfolio!");
    });
});

// CSS for Dark Mode
const darkModeStyle = document.createElement("style");
darkModeStyle.innerText = `
    .dark-mode {
        background: #121212;
        color: #e0e0e0;
        transition: background 0.3s ease, color 0.3s ease;
    }
    .dark-mode header {
        background: linear-gradient(90deg, #1e1e1e, #3a3a3a);
    }
    .dark-mode .about-card, 
    .dark-mode .timeline, 
    .dark-mode .project-card {
        background: #222;
        color: white;
        box-shadow: 0 4px 8px rgba(255, 255, 255, 0.1);
    }
    .dark-mode a {
        color: #bb86fc;
    }
    .dark-mode a:hover {
        color: #ff4081;
    }
`;
document.head.appendChild(darkModeStyle);
