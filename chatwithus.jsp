<%-- 
    Document   : chatwithus
    Created on : 11 Jan, 2025, 6:57:01 PM
    Author     : Pradeepti Gaur
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title> Chatbot</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background: linear-gradient(135deg, #f0ffff, #ccffff);
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #e9ecef;
        }
        .chat-container {
            width: 100%;
            max-width: 480px;
            background-color: #c2e5d3;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.4);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            height: 90vh;
        }
        .chat-header {
            background: linear-gradient(135deg,#afeeee, #8b9dc3);
            color: #fff;
            padding: 20px;
            text-align: center;
        }
        .chat-header h1 {
            margin: 0;
            font-size: 1.8rem;
            letter-spacing: 1px;
        }
        .chat-messages {
            flex-grow: 1;
            padding: 20px;
            overflow-y: auto;
            background: #007c80;
        }
        .message {
            display: flex;
            align-items: flex-start;
            margin-bottom: 15px;
        }
        .message-content {
            padding: 12px 15px;
            border-radius: 10px;
            max-width: 75%;
            font-size: 0.95rem;
            word-wrap: break-word;
        }
        .user-message {
            flex-direction: row-reverse;
        }
        .user-message .message-content {
            background: #457b9d;
            margin-right: 10px;
            color: #fff;
        }
        .bot-message .message-content {
            background: #34495e;
            margin-left: 10px;
            color: #ecf0f1;
        }
        .profile-image {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }
        .chat-input-container {
            display: flex;
            padding: 15px;
            background: #1e272e;
            border-top: 1px solid #34495e;
        }
        #user-input {
            flex-grow: 1;
            padding: 12px;
            border: 1px solid #4a4a4a;
            border-radius: 10px;
            font-size: 1rem;
            background: #34495e;
            color: #ecf0f1;
            outline: none;
        }
        #send-button {
            padding: 12px 20px;
            background: linear-gradient(135deg, #457b9d, #1d3557);
            color: #fff;
            border: none;
            border-radius: 10px;
            margin-left: 10px;
            cursor: pointer;
            font-size: 1rem;
            transition: background 0.3s ease;
        }
        #send-button:hover {
            background: linear-gradient(135deg, #1d3557, #457b9d);
        }
        #send-button:disabled {
            background: #34495e;
            cursor: not-allowed;
        }
        @media (max-width: 480px) {
            .chat-container {
                height: 100vh;
                border-radius: 0;
            }
        }
        /* Scrollbar Styles */
        ::-webkit-scrollbar {
            width: 8px;
        }
        ::-webkit-scrollbar-track {
            background: #e6bf83;
        }
        ::-webkit-scrollbar-thumb {
            background: #4a4a4a;
            border-radius: 4px;
        }
        ::-webkit-scrollbar-thumb:hover {
            background: #5a5a5a;
        }
    </style>
</head>
<body>
    <div class="chat-container">
        <div class="chat-header">
            <h1> Chatbot</h1>
        </div>
        <div class="chat-messages" id="chat-messages"></div>
        <div class="chat-input-container">
            <input type="text" id="user-input" placeholder="Type your message...">
            <button id="send-button">Send</button>
        </div>
    </div>
    <script>
        const API_KEY = 'YOUR_API_KEY_HERE';
        const API_URL = 'https://generativelanguage.googleapis.com/v1beta2/models/text-bison-001:generateText&#39;;
        const chatMessages = document.getElementById('chat-messages');
        const userInput = document.getElementById('user-input');
        const sendButton = document.getElementById('send-button');

        async function generateResponse(prompt) {
            const response = await fetch(`${API_URL}?key=${API_KEY}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({
                    prompt: prompt,
                    maxOutputTokens: 256
                })
            });
            if (!response.ok) {
                throw new Error('Failed to generate response');
            }
            const data = await response.json();
            return data.candidates[0].output;
        }

        function addMessage(message, isUser) {
            const messageElement = document.createElement('div');
            messageElement.classList.add('message');
            messageElement.classList.add(isUser ? 'user-message' : 'bot-message');

            const profileImage = document.createElement('img');
            profileImage.classList.add('profile-image');
            profileImage.src = isUser ? 'user.jpg' : 'bot.jpg';
            profileImage.alt = isUser ? 'User' : 'Bot';

            const messageContent = document.createElement('div');
            messageContent.classList.add('message-content');
            messageContent.textContent = message;

            messageElement.appendChild(profileImage);
            messageElement.appendChild(messageContent);
            chatMessages.appendChild(messageElement);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        }

        async function handleUserInput() {
            const userMessage = userInput.value.trim();
            if (userMessage) {
                addMessage(userMessage, true);
                userInput.value = '';
                sendButton.disabled = true;
                userInput.disabled = true;
                try {
                    const botMessage = await generateResponse(userMessage);
                    addMessage(botMessage, false);
                } catch (error) {
                    console.error('Error:', error);
                    addMessage('Sorry, I encountered an error. Please try again.', false);
                } finally {
                    sendButton.disabled = false;
                    userInput.disabled = false;
                    userInput.focus();
                }
            }
        }

        sendButton.addEventListener('click', handleUserInput);
        userInput.addEventListener('keypress', (e) => {
            if (e.key === 'Enter' && !e.shiftKey) {
                e.preventDefault();
                handleUserInput();
            }
        });
    </script>
</body>
</html>