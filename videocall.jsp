<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>AmritaVaidya - Video Call</title>
  <style>
     
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        font-family: 'Arial', sans-serif;
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        height: 100vh;
        background: linear-gradient(135deg, #B2FFFF, #0CAFFF);
        color: #fff;
        overflow: hidden;
      }

      .header {
        background-color: #ffffff;
        padding: 20px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        position: absolute;
        top: 0;
      }

      .header img {
        height: 100px;
        width: 80px;
      }

      .menu {
        display: flex;
        gap: 20px;
      }

      .menu a {
        text-decoration: none;
        color: blue;
        font-weight: bold;
      }

      .video-container {
        display: flex;
        justify-content: space-between;
        width: 85%;
        max-width: 1200px;
        height: 70vh;
        border-radius: 15px;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        background-color: #222;
        padding: 10px;
        position: relative;
      }

      video {
        width: 48%;
        height: 100%;
        border-radius: 10px;
        object-fit: cover;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.4);
      }

      .controls {
        position: absolute;
        bottom: 10px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        gap: 20px;
      }

      button {
        padding: 15px 30px;
        font-size: 18px;
        font-weight: bold;
        color: #fff;
        background-color: #28a745;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        transition: all 0.3s ease;
      }

      button:hover {
        background-color: #218838;
        transform: scale(1.1);
      }

      button:active {
        background-color: #1e7e34;
      }

      @media (max-width: 768px) {
        .video-container {
          flex-direction: column;
          height: auto;
          padding: 15px;
        }

        video {
          width: 100%;
          margin-bottom: 10px;
        }
      }

      .controls button {
        font-size: 14px;
        padding: 12px 24px;
      }
  </style>
</head>
<body>
 
  <div class="header">
    <img src="images/LOGO.png" alt="AmritaVaidya Logo">
    <div class="menu">
      <a href="home1.jsp">Login</a>
      <a href="about.jsp">About Us</a>
    </div>
  </div>

 
  <div class="video-container">
    <video id="localVideo" autoplay muted></video>
    <video id="remoteVideo" autoplay></video>
  </div>

  <div class="controls">
    <button id="startCall">Start Call</button>
    <button id="endCall">End Call</button>
  </div>

  <script>
    let localStream;
    let remoteStream;
    let peerConnection;
    const serverConfig = {
      iceServers: [
        {
          urls: "stun:stun.l.google.com:19302"
        }
      ]
    };

    const startCallButton = document.getElementById('startCall');
    const endCallButton = document.getElementById('endCall');
    const localVideo = document.getElementById('localVideo');
    const remoteVideo = document.getElementById('remoteVideo');

    startCallButton.onclick = startCall;
    endCallButton.onclick = endCall;

    async function startCall() {
      try {
        localStream = await navigator.mediaDevices.getUserMedia({ video: true, audio: true });
        localVideo.srcObject = localStream;

        peerConnection = new RTCPeerConnection(serverConfig);
        peerConnection.addEventListener('icecandidate', handleIceCandidate);
        peerConnection.addEventListener('track', handleTrackEvent);

        localStream.getTracks().forEach(track => {
          peerConnection.addTrack(track, localStream);
        });

        const offer = await peerConnection.createOffer();
        await peerConnection.setLocalDescription(offer);

        sendOfferToRemotePeer(offer);
      } catch (err) {
        console.error("Error accessing media devices.", err);
      }
    }

    async function handleIceCandidate(event) {
      if (event.candidate) {
        sendIceCandidateToRemotePeer(event.candidate);
      }
    }

    function handleTrackEvent(event) {
      remoteStream = event.streams[0];
      remoteVideo.srcObject = remoteStream;
    }

    function endCall() {
      if (peerConnection) {
        peerConnection.close();
        peerConnection = null;
      }
      if (localStream) {
        localStream.getTracks().forEach(track => track.stop());
        localStream = null;
      }
      remoteVideo.srcObject = null;

     
      window.location.href = "web.jsp";
    }

    function sendOfferToRemotePeer(offer) {
     
    }

    function sendIceCandidateToRemotePeer(candidate) {
      // Implement your signaling server to send the ICE candidate
    }
  </script>
</body>
</html>