<?php
require 'config/database.php';
session_start();

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    header("Location: login.html");
}

$email = $_POST['email'];
$password = $_POST['password'];

try {
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = :email");
    $stmt->execute(['email' => $email]);
    $user = $stmt->fetch(PDO::FETCH_ASSOC);
    if ($user && password_verify($password, $user['password_hash'])) {
        // Store user info in session
        $_SESSION['user_id'] = $user['id'];
        $_SESSION['email'] = $user['email'];

        header("Location: dashboard.php");
    } else {
        echo "Invalid credentials. <a href='login.html'>Try again</a> or <a href='register.html'>Register</a>";
    }
} catch (PDOException $e) {
    echo "Error: " . $e->getMessage();
}
