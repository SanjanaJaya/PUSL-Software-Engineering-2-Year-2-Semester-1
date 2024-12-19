<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment</title>
    <link rel="icon" href="C:\Users\vinuk\OneDrive\Desktop\All JAVA\Register - Dihansie\Icon.png" type="image/jpeg">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;700&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: Poppins;
        }

        body {
            background-color: #111;
            color: white;
            background-image: url('img/bg.jpg');
            background-size: cover;
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
        }

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
        }

        .sign-in .icon {
            font-size: 18px;
        }

        .register {
            border: 1px solid #000000;
            font-weight: bold;
        }

       
        .payment-tab{
            
            aspect-ratio: 1/1;
            position: fixed;
            display:block ;
            margin-left: 1000px;
            margin-top: 310px;
        }

       .cc{
        width: 800px;
        height: 800px;
        position: fixed;
       }

       .pay-now-text {
        font-size: 60px;
        font-family: Arial, Helvetica, sans-serif;
        color: #ffffff;
        position: fixed;
        display: block;
        margin-left: 1000px;
        margin-top: 180px;
  }

    </style>
</head>
<body>
    <span class="pay-now-text"><b>PAY HERE</b></span>
    <script src="https://www.paypal.com/sdk/js?client-id=BAApxzwPrxmx0E049EnG6aBHBFKkEarT-lRUwReD3ZDRGIh5xosUx1uIcOdaa0uQXj8ON1KYrK7Iggs8ks&components=hosted-buttons&disable-funding=venmo&currency=USD"></script>
<div id="paypal-container-FVZYDPYHLD24E" class="payment-tab"></div>
<script>
  paypal.HostedButtons({
    hostedButtonId: "FVZYDPYHLD24E",
  }).render("#paypal-container-FVZYDPYHLD24E")
</script>

      <img src="img/creditcard.png" alt="Credit Card" class="cc"> 
        
     
</body>
</html>