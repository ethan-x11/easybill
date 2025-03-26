package servlets;

import models.Bill;
import services.BillService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.io.BufferedReader;

@WebServlet("/ConsumerBillServlet")
public class ConsumerBillServlet extends HttpServlet {
    private BillService billService;

    @Override
    public void init() throws ServletException {
        this.billService = new BillService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String consumerId = request.getParameter("consumerId");
        String query = request.getParameter("query");
        if (query == null) {
            query = "";
        }
        try {
            List<Bill> bills = billService.searchBills(consumerId, query);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(buildJsonResponse(bills));
        } catch (SQLException e) {
            throw new ServletException("Error retrieving bills", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        StringBuilder jsonBuffer = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
        }

        String jsonString = jsonBuffer.toString();
        Bill bill = new Bill();
        bill.setBillId(request.getParameter("billId"));
        // Manually parse the JSON string
        jsonString = jsonString.replace("{", "").replace("}", "").replace("\"", "");
        String[] keyValuePairs = jsonString.split(",");
        for (String pair : keyValuePairs) {
            String[] entry = pair.split(":");
            String key = entry[0].trim();
            String value = entry[1].trim();

            System.out.println("Key: " + key + ", Value: " + value);

            switch (key) {
                case "billUnit":
                    bill.setUnit(Integer.parseInt(value));
                    break;
                case "billMonth":
                    bill.setMonth(value);
                    break;
                case "amount":
                    bill.setAmount(Double.parseDouble(value));
                    break;
                case "billDate":
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    try {
                        LocalDate localDate = LocalDate.parse(value, formatter);
                        bill.setDate(localDate.toString());

                        LocalDate dueDate = localDate.plusDays(15);
                        bill.setDueDate(dueDate.toString());
                    } catch (DateTimeParseException e) {
                        throw new ServletException("Error parsing date", e);
                    }
                    break;
                case "paymentStatus":
                    bill.setPaymentStatus(value);
                    break;
            }
        }

        try {
            int status = billService.updateBill(bill);
            System.out.println("Status: " + status);
            System.out.println("Bill ID: " + bill.getBillId());
            if (status == 0) {
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
            } else {
                response.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (SQLException e) {
            throw new ServletException("Error updating bill", e);
        }
    }

    private String buildJsonResponse(List<Bill> bills) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < bills.size(); i++) {
            Bill bill = bills.get(i);
            json.append("{")
                .append("\"billId\":\"").append(bill.getBillId()).append("\",")
                .append("\"consumerId\":").append(bill.getConsumerId()).append(",")
                .append("\"unit\":").append(bill.getUnit()).append(",")
                .append("\"month\":\"").append(bill.getMonth()).append("\",")
                .append("\"amount\":").append(bill.getAmount()).append(",")
                .append("\"date\":\"").append(bill.getDate()).append("\",")
                .append("\"dueDate\":\"").append(bill.getDueDate()).append("\",")
                .append("\"paymentStatus\":\"").append(bill.getPaymentStatus()).append("\",")
                .append("\"transactionId\":\"").append(bill.getTransactionId()).append("\",")
                .append("\"transactionDateTime\":\"").append(bill.getTransactionDateTime()).append("\"")
                .append("}");
            if (i < bills.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}