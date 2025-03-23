function showUserLogin() {
    document.getElementById("userLogin").style.display = "block";
    document.getElementById("adminLogin").style.display = "none";
    document.getElementById("userButton").classList.add("selected");
    document.getElementById("adminButton").classList.remove("selected");
    clearErrorMessages();
}

function showAdminLogin() {
    document.getElementById("userLogin").style.display = "none";
    document.getElementById("adminLogin").style.display = "block";
    document.getElementById("adminButton").classList.add("selected");
    document.getElementById("userButton").classList.remove("selected");
    clearErrorMessages();
}

function userLogin() {
    var userId = document.getElementById("userId").value;
    var password = document.getElementById("userPassword").value;

    if (!userId || !password) {
        alert("All fields are required!");
        return;
    }

    // Submit the form to the LoginHandlerServlet
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "LoginHandlerServlet";
    form.innerHTML = `
        <input type="hidden" name="userId" value="${userId}">
        <input type="hidden" name="password" value="${password}">
    `;
    document.body.appendChild(form);
    form.submit();
}

function adminLogin() {
    var adminId = document.getElementById("adminId").value;
    var password = document.getElementById("adminPassword").value;

    if (!adminId || !password) {
        alert("All fields are required!");
        return;
    }

    // Submit the form to the LoginHandlerServlet
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "LoginHandlerServlet";
    form.innerHTML = `
        <input type="hidden" name="adminId" value="${adminId}">
        <input type="hidden" name="password" value="${password}">
    `;
    document.body.appendChild(form);
    form.submit();
}

// Show user login by default
showUserLogin();