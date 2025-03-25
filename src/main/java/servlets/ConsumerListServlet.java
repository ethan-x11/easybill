package servlets;

import models.Consumer;
import services.ConsumerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import dao.ConsumerWithBillInfo;

@WebServlet("/ConsumerListServlet")
public class ConsumerListServlet extends HttpServlet {
    private ConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        this.consumerService = new ConsumerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String filter = request.getParameter("filter");
        try {
            List<ConsumerWithBillInfo> consumers = consumerService.searchConsumers(query, filter);
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(buildJsonResponse(consumers));
        } catch (SQLException e) {
            throw new ServletException("Error retrieving consumers", e);
        }
    }

    private String buildJsonResponse(List<ConsumerWithBillInfo> consumers) {
        StringBuilder json = new StringBuilder("[");
        for (int i = 0; i < consumers.size(); i++) {
        	ConsumerWithBillInfo consumer = consumers.get(i);
            json.append("{")
                .append("\"consumerId\":").append(consumer.getConsumerId()).append(",")
                .append("\"name\":\"").append(consumer.getName()).append("\",")
                .append("\"email\":\"").append(consumer.getEmail()).append("\",")
                .append("\"countryCode\":\"").append(consumer.getCountryCode()).append("\",")
                .append("\"mobileNumber\":\"").append(consumer.getMobileNumber()).append("\",")
                .append("\"userId\":\"").append(consumer.getUserId()).append("\",")
                .append("\"latestBillAmount\":").append(consumer.getLatestBillAmount()).append(",")
                .append("\"latestBillMonth\":\"").append(consumer.getLatestBillMonth()).append("\",")
                .append("\"latestBillDate\":\"").append(consumer.getLatestBillDate()).append("\"")
                .append("}");
            if (i < consumers.size() - 1) {
                json.append(",");
            }
        }
        json.append("]");
        return json.toString();
    }
}