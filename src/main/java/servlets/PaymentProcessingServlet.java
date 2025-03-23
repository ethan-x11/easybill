package servlets;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import models.Consumer;
import models.Bill;

@WebServlet("/PaymentProcessingServlet")
public class PaymentProcessingServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;

  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession();
    Consumer consumer = (Consumer) session.getAttribute("consumer");
    Bill bill = (Bill) session.getAttribute("currentBill");
    Double totalDue = (Double) session.getAttribute("totalDue");

    if (consumer == null || bill == null || totalDue == null) {
      response.sendRedirect("login.jsp");
      return;
    }

    String paymentMethod = request.getParameter("paymentMethod");

    // Generate transactionId and transactionDateTime
    String transactionId = "TXN" + System.currentTimeMillis();
    String transactionDateTime = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    session.setAttribute("paymentFlag", "true");
    session.setAttribute("transactionId", transactionId);
    session.setAttribute("transactionDateTime", transactionDateTime);
    request.setAttribute("consumerId", consumer.getConsumerId());
    request.setAttribute("billId", bill.getBillId());
    request.setAttribute("paymentMethod", paymentMethod.toUpperCase());
    request.setAttribute("totalAmount", totalDue);

    RequestDispatcher dispatcher = request.getRequestDispatcher("card_details.jsp");
    dispatcher.forward(request, response);
  }
}