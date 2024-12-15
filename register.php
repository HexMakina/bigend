<?php
require 'config/database.php';


if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $email = $_POST['email'];
    $password = $_POST['password'];

    // Hash the password for security
    $passwordHash = password_hash($password, PASSWORD_DEFAULT);

    try {
        $stmt = $pdo->prepare("INSERT INTO users (email, password_hash) VALUES (:email, :password_hash)");
        $stmt->execute(['email' => $email, 'password_hash' => $passwordHash]);

        echo "Registration successful. <a href='login.html'>Login here</a>";
    } catch (PDOException $e) {
        echo "Error: " . $e->getMessage();
    }
}
