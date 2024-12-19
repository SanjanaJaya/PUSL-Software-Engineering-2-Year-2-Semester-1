<%@ page import="java.sql.*" %>

<%
    String email = (String) session.getAttribute("email");
    if (email == null) {
        response.sendRedirect("signin.jsp");
        return;
    }
%>


<div class="email-display">
    <p>Logged in as: <strong><%= email %></strong></p>
</div>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <title>Cinema Ticket Booking</title>
    <style>
        body {
    background-color: #111;
    color: white;
    font-family: 'Poppins', sans-serif;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    transition: background-color 0.5s, color 0.5s;
}

.container {
    background-color: rgba(0, 0, 0, 0.8);
    padding: 2rem;
    border-radius: 10px;
    margin: 2rem auto;
    max-width: 600px;
    text-align: center;
    transition: background-color 0.3s, transform 0.3s;
}

.container:hover {
    background-color: rgba(0, 0, 0, 0.9);
    transform: scale(1.02);
}

select, .proceed-btn, input[type="date"] {
    padding: 12px;
    width: 100%;
    margin: 10px 0;
    font-size: 16px;
    border-radius: 5px;
    border: none;
    transition: background-color 0.3s, box-shadow 0.3s;
}

select:hover, input[type="date"]:hover {
    box-shadow: 0 0 10px rgba(111, 66, 193, 0.6);
}

.proceed-btn {
    background-color: #800080;
    color: white;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

.proceed-btn:hover {
    background-color: #660066;
    transform: scale(1.05);
}

.seat-grid {
    display: grid;
    grid-template-columns: repeat(10, 1fr);
    gap: 10px;
    margin: 20px auto; 
    justify-content: center; 
    align-content: center; 
    transition: gap 0.3s;
}

.seat {
    padding: 10px;
    background-color: #6f42c1;
    color: white;
    text-align: center;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s, transform 0.3s;
}

.seat:hover:not(.disabled):not(.selected) {
    background-color: #800080;
    transform: scale(1.1);
}

.seat.selected {
    background-color: #ff6347;
    transition: background-color 0.3s;
}

.seat.disabled {
    background-color: #555;
    cursor: not-allowed;
}

.email-display p {
    margin: 0; 
    font-size: 16px; 
    transition: color 0.3s;
}

.email-display strong {
    color: #6f42c1; 
    transition: color 0.3s;
}

.email-display strong:hover {
    color: #800080;
}

    </style>
    <script>
        let selectedSeat = null;

        function validateSelections() {
            const theater = document.getElementById("hall-dropdown").value;
            const showtime = document.getElementById("time-dropdown").value;
            const date = document.getElementById("date").value;

            if (!theater || !showtime || !date) {
                alert("Please select Theater, Show Time, and Date first.");
                return false;
            }
            return true;
        }

        function selectSeat(seatId) {
            const seatElements = document.querySelectorAll(".seat");
            seatElements.forEach(seat => seat.classList.remove("selected"));

            const selectedSeatElement = document.getElementById(seatId);
            selectedSeatElement.classList.add("selected");
            selectedSeat = seatId;

            document.getElementById("selected-seat").value = seatId;
        }

        function validateForm() {
            if (!selectedSeat) {
                alert("Please select a seat!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>Cinema Ticket Booking</h1>
        <form action="processBooking.jsp" method="POST" onsubmit="return validateForm();">
            <h2>Select Your Seat</h2>
            <div class="seat-grid">
                <% for (int row = 1; row <= 5; row++) { 
                     for (int col = 1; col <= 14; col++) { 
                         String seatId = "A" + row + "B" + col; 
                %>
                <div class="seat" id="<%= seatId %>" onclick="selectSeat('<%= seatId %>')">
                    <%= seatId %>
                </div>
                <% } } %>
            </div>

            <select id="movie-dropdown" name="movie">
                <option value="">Select Your Movie</option>
                <option value="Amaran - Tamil">Amaran - Tamil</option>
                <option value="Bhool Bhulaiya 3 - Hindi">Bhool Bhulaiya 3 - Hindi</option>
                <option value="Moana 2 - English">Moana 2 - English</option>
                <option value="Deadpool & Wolverine - English">Deadpool & Wolverine - English</option>
                <option value="Lucky Baskhar - Telugu">Lucky Baskhar - Telugu</option>
                <option value="Singham Again - Hindi">Singham Again - Hindi</option>
                <option value="Sihina Nelum Mal - Sinhala">Sihina Nelum Mal - Sinhala</option>
                <option value="Viduthalai Part 2 - Tamil">Viduthalai Part 2 - Tamil</option>
                <option value="Kanguva - Tamil">Kanguva - Tamil</option>
                <option value="Mandara - Sinhala">Mandara - Sinhala</option>
                <option value="Red One - English">Red One - English</option>
                <option value="Pushpa 2: The Rule - Telugu">Pushpa 2: The Rule - Telugu</option>
                <option value="Vettaiyan - Tamil">Vettaiyan - Tamil</option>
                <option value="The Wild Robot - English">The Wild Robot - English</option>
                <option value="Venom: The Last Dance - English">Venom: The Last Dance - English</option>
            </select>
            <select id="hall-dropdown" name="hall">
                <option value="">Select Your Theater</option>
                <option value="Scope Cinema - Colombo">Scope Cinema - Colombo</option>
                <option value="Scope Cinema - Colpetty">Scope Cinema - Colpetty</option>
                <option value="Scope Cinema - Havelock City Mall">Scope Cinema - Havelock City Mall</option>
                <option value="Scope Cinema - Kiribathgoda">Scope Cinema - Kiribathgoda</option>
                <option value="Savoy Cinema - Maharagama">Savoy Cinema - Maharagama</option>
                <option value="Savoy Cinema - Gampaha">Savoy Cinema - Gampaha</option>
                <option value="Savoy Cinema - Rajagiriya">Savoy Cinema - Rajagiriya</option>
                <option value="Savoy Cinema - Wellawatte">Savoy Cinema - Wellawatte</option>
                <option value="Savoy Cinema - Moratuwa">Savoy Cinema - Moratuwa</option>
                <option value="PVR Cinema - One Galle Face">PVR Cinema - One Galle Face</option>
                <option value="KCC Multiplex - Kandy">KCC Multiplex - Kandy</option>
            </select>
            <select id="time-dropdown" name="showtime">
                <option value="">Select Show Time</option>
                <option value="10:30 AM">10:30 AM</option>
                <option value="1:30 PM">1:30 PM</option>
                <option value="6:00 PM">6:00 PM</option>
            </select>
            <div>
                <label for="date">Select Date:</label>
                <input type="date" id="date" name="date">
            </div>

            <input type="hidden" id="selected-seat" name="seatno">
            <button type="submit" class="proceed-btn">Proceed to Book</button>
        </form>
    </div>
</body>
</html>
