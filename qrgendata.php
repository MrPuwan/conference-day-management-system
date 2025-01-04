<?php
// Capture and sanitize form data
$name = htmlspecialchars(trim($_POST["name"]));
$email = htmlspecialchars(trim($_POST["email"]));
$session_name = htmlspecialchars(trim($_POST["session_name"]));

// Validate email
if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
    die("Invalid email format.");
}

// Check if all fields are provided
if (empty($name) || empty($email) || empty($session_name)) {
    die("All fields are required.");
}

// Connect to the database
$connect = new mysqli('localhost', 'root', '', 'conference_db');

// Check connection
if ($connect->connect_error) {
    die("Connection failed: " . $connect->connect_error);
}

// Prepare and bind statement to insert data into the database
$stmt = $connect->prepare("INSERT INTO registration (name, email, session_name) VALUES (?, ?, ?)");
if ($stmt) {
    $stmt->bind_param("sss", $name, $email, $session_name);

    // Execute the statement
    if ($stmt->execute()) {
        // Create the data string and URL encode it
        $data = urlencode("$name|$email|$session_name");

        // Generate the QR code URL
        $qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=" . $data;

        // Generate the query string
        $queryString = http_build_query([
            'name' => $name,
            'email' => $email,
            'session_name' => $session_name,
            'qrUrl' => $qrUrl
        ]);

        // Redirect to qrgen.html with query parameters
        header("Location: qrgen.html?" . $queryString);
        exit();
    } else {
        // Handle execution error
        echo "<script>alert('Error registering user: " . htmlspecialchars($stmt->error) . "');</script>";
    }

    // Close the statement
    $stmt->close();
} else {
    // Handle preparation error
    echo "<script>alert('Error preparing statement: " . htmlspecialchars($connect->error) . "');</script>";
}

// Close the database connection
$connect->close();
?>
