function registerCustomer() {
    var consumerId = document.getElementById("consumerId").value;
    var customerName = document.getElementById("customerName").value;
    var email = document.getElementById("email").value;
    var countryCode = document.getElementById("countryCode").value;
    var mobileNumber = document.getElementById("mobileNumber").value;
    var userId = document.getElementById("userId").value;
    var password = document.getElementById("password").value;
    var confirmPassword = document.getElementById("confirmPassword").value;

    if (password !== confirmPassword) {
        alert("Passwords do not match!");
        return;
    }

    // Submit the form to the RegistrationHandlerServlet
    var form = document.createElement("form");
    form.method = "POST";
    form.action = "RegistrationHandlerServlet";
    form.innerHTML = `
        <input type="hidden" name="consumerId" value="${consumerId}">
        <input type="hidden" name="customerName" value="${customerName}">
        <input type="hidden" name="email" value="${email}">
        <input type="hidden" name="countryCode" value="${countryCode}">
        <input type="hidden" name="mobileNumber" value="${mobileNumber}">
        <input type="hidden" name="userId" value="${userId}">
        <input type="hidden" name="password" value="${password}">
    `;
    document.body.appendChild(form);
    form.submit();
}