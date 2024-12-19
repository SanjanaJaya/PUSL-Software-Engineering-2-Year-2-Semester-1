<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="c:\Users\vinuk\OneDrive\Desktop\All JAVA\Contact Us - Nethsara\Contact Us\Icon.png" type="image/jpeg">
    <title>Contact Us</title>
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
    position: relative;
    background-color: #111;
    color: white;
    background-image: url('img/bg.jpg');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    animation: fadeIn 1s ease-in-out; 
}

body::after {
    content: '';
    position: absolute;
    top: 0;
    left: 0;
    right: 0;
    bottom: 0;
    background-color: rgba(0, 0, 0, 0.5);
    z-index: -1;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}


header {
    background-color: #333;
    padding: 20px;
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


.auth-buttons {
    display: flex;
    gap: 1rem;
}

.auth-buttons button {
    padding: 0.5rem 1rem;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
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
}

.sign-in:hover {
    background-color: #4318FF;
    transform: scale(1.05);
}

.sign-in .icon {
    font-size: 18px;
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


.contact-container {
    text-align: center;
    padding: 50px 0;
    background-color: rgba(17, 17, 17, 0); 
    display: flex;
    justify-content: center;
}

.contact-info {
    background-color: rgba(0, 0, 0, 0);
    padding: 20px;
    border-radius: 10px;
    width: 50%;
    margin-left: auto;
    position: relative;
    text-align: right;
    transition: box-shadow 0.3s ease;
}

.contact-info:hover {
    box-shadow: 0 0 15px rgba(255, 255, 255, 0.8);
}


.popcorn-image {
    position: absolute;
    top: 0;
    left: -380px;
    transform: translateX(-50%);
    width: 949px;
    height: 596px;
    transition: transform 0.3s ease;
}

.popcorn-image:hover {
    transform: translateX(-50%) scale(1.05);
}


.contact-info h2 {
    font-size: 45px;
    margin-top: 0px;
    margin-bottom: 5px;
    text-align: center;
}

.contact-info p {
    font-size: 18px;
    margin-bottom: 20px;
    text-align: center;
}


.social-media {
    display: flex;
    justify-content: center;
    gap: 40px;
    margin-top: 20px;
}

.social-media a {
    color: white;
    font-size: 24px;
    text-decoration: none;
    display: flex;
    align-items: center;
    gap: 8px;
    transition: color 0.3s ease, transform 0.3s ease;
}

.social-media a:hover {
    color: #4318FF;
    transform: scale(1.2);
}

.social-media img {
    width: 24px;
    height: 24px;
}

    </style>
</head>
<body>
    
    <header class="header">
        <a href="#" class="logo">
            <img src="img/logo.png" alt="CineFlick Logo"> 
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

   
    <div class="contact-container">
        <div class="contact-info">
            <img src="img/popcorn.png" alt="Popcorn" class="popcorn-image"draggable="false"> 
            <h2>Contact Us</h2>
            <p>CineFlick Ltd. is the largest and the most premium film exhibition company in India. Since its inception in 1997, the brand has redefined the cinema industry and the way people watch movies in the country. The company acquired Cinemas in 2012 and had taken over DT Cinemas in 2016, serving 100 million patrons annually. Currently, CineFlick operates a cinema circuit of 845 Screens at 176 Properties in 71 Cities (India and Sri Lanka).</p>

            <p>CineFlick offers a grand collection of cinema formats. From its Mainstream to Gold Class Cinemas, Director's Cut to the latest sub-brands - CineFlick ICON and CineFlick Superplex, the company has made exceptional technology like the IMAX, 4DX and ECX (Enhanced Cinema Experience) accessible to its audience. VR's recent addition has been FX1 - India's first premium extra-large homegrown big screen format for a truly enigmatic movie-watching experience.</p>

            <p>CineFlick Ltd., the integrated film and retail brand has CineFlick Cinemas as its major subsidiary. Its other two subsidiaries are CineFlick Leisure and CineFlick Pictures. CineFlick Pictures has been a prolific distributor of non-studio/independent international films in India since 2002. With over 350+ Hollywood, 175+ Hindi, and 75+ regional films across genres being released under this banner, CineFlick Pictures has gained significant recognition in the film industry.</p>
            <div class="social-media">
                <a href="https://www.facebook.com/CineFlickCinema" target="_blank"draggable="false"> 
                    <img src="img/fb.png" alt="Facebook" width="24" height="24">
                    CineFlick
                </a>
                <a href="tel:+94112246751">
                    <img src="img/mobile.png" alt="Phone" width="24" height="24"> 
                    +94112246751
                </a>
                <a href="mailto:cineflickcinema@gmail.com">
                    <img src="img/mail.png" alt="Email" width="24" height="24"> 
                    cineflickcinema@gmail.com
                </a>
            </div>
        </div>
    </div>
</body>
</html>
