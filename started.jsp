<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>AmritaVaidya - Online Consultancy</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap');
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(45deg, #a8e6cf, #dcedc1, #90caf9); /* Updated background colors */
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            animation: backgroundAnimation 10s infinite alternate;
        }
        .container {
            max-width: 850px;
            padding: 40px;
            background: #fff9f3;
            border-radius: 20px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.2);
            text-align: center;
            animation: fadeIn 1.5s ease-in-out;
        }
        h1 {
            color: #6a5d7b;
            font-size: 36px;
            font-weight: 600;
            margin-bottom: 15px;
        }
        p {
            font-size: 20px;
            color: #7b6d8d;
            line-height: 1.8;
        }
        .btn {
            display: inline-block;
            margin-top: 25px;
            padding: 14px 28px;
            font-size: 20px;
            font-weight: 600;
            color: black;
            background: linear-gradient(45deg, #a8e6cf, #dcedc1, #90caf9); /* Updated background colors */
            text-decoration: none;
            border-radius: 30px;
            transition: all 0.4s ease;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }
        .btn:hover {
            background: linear-gradient(45deg, #a8e6cf, #dcedc1, #90caf9); /* Updated background colors */
            transform: scale(1.1);
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        @keyframes backgroundAnimation {
            from { background: linear-gradient(to right, #a8e6cf, #90caf9); } /* Updated animation colors */
            to { background: linear-gradient(to right, #dcedc1, #64b5f6); } /* Updated animation colors */
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Welcome to AmritaVaidya</h1>
        <p>Your trusted online platform for doctor and patient consultations.</p>
        <p>Connect with healthcare professionals and receive expert medical advice from the comfort of your home.</p>
        <a href="website.jsp" class="btn">Get Started</a>
    </div>
</body>
</html>