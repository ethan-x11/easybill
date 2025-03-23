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
            List<Consumer> consumers = consumerService.searchConsumers(query, filter);
            out.println("[");
            for (int i = 0; i < consumers.size(); i++) {
                Consumer consumer = consumers.get(i);
                out.println("{");
                out.println("\"consumerId\": \"" + consumer.getConsumerId() + "\",");
                out.println("\"name\": \"" + consumer.getName() + "\",");
                out.println("\"email\": \"" + consumer.getEmail() + "\",");
                out.println("\"countryCode\": \"" + consumer.getCountryCode() + "\",");
                out.println("\"mobileNumber\": \"" + consumer.getMobileNumber() + "\",");
                out.println("\"userId\": \"" + consumer.getUserId() + "\"");
                out.println("}");
                if (i < consumers.size() - 1) {
                    out.println(",");
                }
            }
            out.println("]");
        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"An error occurred while searching for consumers.\"}");
        }
    }
}