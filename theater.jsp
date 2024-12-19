<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CineFlick Registration</title>
    <link rel="icon" href="C:\Users\vinuk\OneDrive\Desktop\All JAVA\Register - Dihansie\Icon.png" type="image/jpeg">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: Poppins;
    transition: all 0.3s ease; 
}


body {
    background-color: #111;
    color: white;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeIn 1s ease-in-out; 
}


@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}


.header {
    background-color: #f5f5f5;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.logo {
    width: 120px;
    display: flex;
    align-items: center;
    gap: 10px;
    color: #333;
    text-decoration: none;
}

.logo img {
    width: 197px;
    height: 75px;
}

.nav-links {
    display: flex;
    gap: 2rem;
    list-style: none;
}

.nav-links a {
    color: #333;
    text-decoration: none;
    font-weight: bold;
    transition: color 0.3s ease, transform 0.3s ease;
}

.nav-links a:hover {
    color: #4318FF;
    transform: scale(1.1);
}

/* Auth Buttons */
.auth-buttons {
    display: flex;
    gap: 1rem;
}

.auth-buttons button {
    padding: 0.5rem 1rem;
    border-radius: 5px;
    cursor: pointer;
}

.sign-in {
    background-color: #333;
    color: white;
    border: none;
    border-radius: 20px;
    padding: 8px 16px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-weight: bold;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.sign-in .icon {
    font-size: 18px;
}

.sign-in:hover {
    background-color: #5a34ff;
    transform: scale(1.05);
}

.register {
    background-color: transparent;
    border: 1px solid #f5f5f5;
    font-weight: bold;
    transition: background-color 0.3s ease, color 0.3s ease, transform 0.3s ease;
}

.register:hover {
    background-color: #4318FF;
    color: white;
    transform: scale(1.1);
}

h2 {
    text-align: center;
    color: #fff;
    transition: color 0.3s ease; 
}

.theater-section {
    padding: 40px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    color: white;
}

.theater-row {
    display: flex;
    justify-content: space-around;
    width: 100%;
    margin: 20px 0;
}

.theater {
    text-align: center;
    color: white;
    width: 45%;
    transition: transform 0.3s ease, color 0.3s ease;
}

.theater:hover {
    transform: scale(1.05);
    color: #4318FF;
}

.theater-button {
    background-color: transparent;
    border: none;
    cursor: pointer;
    margin-bottom: 15px;
    transition: transform 0.2s ease, box-shadow 0.3s ease;
}

.theater-button img {
    height: 150px;
}

.theater-button:hover {
    transform: scale(1.1);
    box-shadow: 0 4px 15px rgba(255, 255, 255, 0.3);
}

.theater ul {
    list-style: none;
    padding: 0;
}

.theater li {
    margin: 5px 0;
}


        </style>
        </head>

        <body>
            <header class="header">
        <a href="#" class="logo">
            <img src="img/logo.png" alt="CineFlick Logo">
            <span></span>
        </a>
        <nav>
            <ul class="nav-links">
                <li><a href="home.jsp">Home</a></li>
                <li><a href="Movies.jsp">Movies</a></li>
                <li><a href="theater.jsp">Theaters</a></li>
                <li><a href="feedback.jsp">Feedbacks</a></li>
                <li><a href="contact.jsp">Contact Us</a></li>
            </ul>
            </nav>
            <div class="auth-buttons">
                <button class="register" onclick="window.location.href='register.jsp'">Register</button>

                <button class="signin" onclick="window.location.href='signin.jsp'">Sign In</button>
                

            </div>
            </header>
            <main>
                <section class="theater-section">
                    <div class="theater-row">
                        <div class="theater">
                            <button class="theater-button" onclick="window.location.href='https://www.scopecinemas.com/'">
                                <img src="img/scope.jpg" alt="Scope" class="theater-logo">
                            </button>
                            <ul>
                                <li>Colombo City Centre</li>
                                <li>Colpetty</li>
                                <li>Havelock City Mall</li>
                                <li>Kiribathgoda</li>
                            </ul>
                        </div>
                        <div class="theater">
                            <button class="theater-button" onclick="window.location.href='https://www.eapmovies.com/component/eapmovies/?controller=theaters&view=theater&task=displayTheater&cid=3&Itemid=121'">
                                <img src="img/savoy.jpg" alt="Savoy" class="theater-logo">
                            </button>
                            <ul>
                                <li>Maharagama</li>
                                <li>Gampaha</li>
                                <li>Rajagiriya</li>
                                <li>Wellawatte</li>
                                <li>Moratuwa</li>
                            </ul>
                        </div>
                    </div>
                    
                    <div class="theater-row">
                        <div class="theater">
                            <button class="theater-button" onclick="window.location.href='https://www.pvrcinemas.lk/'">
                                <img src="img/pvr.png" alt="pvr" class="theater-logo">
                            </button>
                            <ul>
                                <li>One Galle Face</li>
                            </ul>
                        </div>
                        <div class="theater">
                            <button class="theater-button" onclick="window.location.href='https://kccmultiplex.lk/'">
                                <img src="img/kcc.jpg" alt="Scope" class="theater-logo">
                            </button>
                            <ul>
                                <li>Kandy</li>
                            </ul>
                        </div>
                    </div>
                </section>
            </main>

        </body>