<?php
require 'auth.php';
?>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description"
        content="Bigend: Create dynamic, customizable QR codes with analytics and intelligent redirection.">
    <meta name="keywords" content="Bigend, QR Codes, Dynamic QR Codes, Customizable QR, QR Analytics">
    <meta name="author" content="Bigend">
    <title>Bigend - Smarter Connections with Dynamic QR Codes</title>
    <link rel="stylesheet" href="public/css/bigend.css">
</head>

<body>
    <!-- Header Section -->
    <header>
        <div class="container">
            <nav class="navbar">
                <div class="logo">
                    <a href="/">Bigend</a>
                </div>
                <ul class="nav-links">
                    <li><a href="#features">Features</a></li>
                    <li><a href="#how-it-works">How It Works</a></li>
                    <li><a href="#pricing">Pricing</a></li>
                    <li><a href="#contact">Contact</a></li>
                </ul>
                <a href="register.html" class="btn-primary">Sign Up</a>
            </nav>
        </div>
    </header>

    <section>
        <div class="container">
            <h1>Welcome, <?php echo htmlspecialchars($_SESSION['username']); ?>!</h1>
            <p><a href="logout.php">Logout</a></p>
        </div>
    </section>
</body>
</html>