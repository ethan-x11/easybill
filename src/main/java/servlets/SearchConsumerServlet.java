package servlets;

import models.Consumer;
import services.ConsumerService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;

import dao.ConsumerWithBillInfo;

@WebServlet("/SearchConsumerServlet")
public class SearchConsumerServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ConsumerService consumerService;

    @Override
    public void init() throws ServletException {
        this.consumerService = new ConsumerService();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        String filter = request.getParameter("filter");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            List<ConsumerWithBillInfo> consumers = consumerService.searchConsumers(query, filter);
            StringBuilder jsonBuilder = new StringBuilder();
            jsonBuilder.append("[");

            for (int i = 0; i < consumers.size(); i++) {
                Consumer consumer = consumers.get(i);
                jsonBuilder.append("{");
                jsonBuilder.append("\"consumerId\": \"").append(consumer.getConsumerId()).append("\",");
                jsonBuilder.append("\"name\": \"").append(consumer.getName()).append("\",");
                jsonBuilder.append("\"email\": \"").append(consumer.getEmail()).append("\",");
                jsonBuilder.append("\"countryCode\": \"").append(consumer.getCountryCode()).append("\",");
                jsonBuilder.append("\"mobileNumber\": \"").append(consumer.getMobileNumber()).append("\",");
                jsonBuilder.append("\"userId\": \"").append(consumer.getUserId()).append("\"");
                jsonBuilder.append("}");
                if (i < consumers.size() - 1) {
                    jsonBuilder.append(",");
                }
            }

            jsonBuilder.append("]");
            out.print(jsonBuilder.toString());
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"An error occurred while searching for consumers.\"}");
        }
    }
}