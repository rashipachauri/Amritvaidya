<%@ page import="java.util.Properties, javax.mail.*, javax.mail.internet.*" %>
<%
    String name = request.getParameter("name");
    String userEmail = request.getParameter("email"); // User's email
    String message = request.getParameter("message");

    String adminEmail = "amritavaidya1@gmail.com"; // Replace with admin's email
    String subject = "New Contact Form Message from " + name;
    String body = "You have received a new message:\n\n" +
                  "Name: " + name + "\n" +
                  "Email: " + userEmail + "\n" +
                  "Message: " + message + "\n\n" +
                  "Please reply directly to this email.";

    final String senderEmail = "amritavaidya73@gmail.com";  // Your email (for sending)
    final String senderPassword = "njvq lmyy vchu fbnt";  // Your email password (enable SMTP)

    Properties props = new Properties();
    props.put("mail.smtp.host", "smtp.gmail.com");  
    props.put("mail.smtp.port", "465");  // ? Try changing to 465 (SSL) if 587 (TLS) doesn?t work
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");  
    props.put("mail.smtp.ssl.enable", "true");  // ? Add this for SSL

    Session mailSession = Session.getInstance(props, new Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(senderEmail, senderPassword);
        }
    });

    try {
        Message emailMessage = new MimeMessage(mailSession);
        emailMessage.setFrom(new InternetAddress(senderEmail)); // Your email sends the mail
        emailMessage.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));
        emailMessage.setSubject(subject);
        emailMessage.setText(body);

        // ? Set "Reply-To" as the user's email
        emailMessage.setReplyTo(new Address[]{new InternetAddress(userEmail)});

        Transport.send(emailMessage);
        out.println("<script>alert('Message sent successfully!'); window.location.href='contact.html';</script>");
    }catch (Exception e) {
        e.printStackTrace(); // This prints the error in server logs
        out.println("<script>alert('Error: " + e.getMessage() + "'); window.location.href='contact.html';</script>");
    }

%>