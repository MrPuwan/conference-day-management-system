<?php
// Include the database connection file
include('db_connect.php');

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Get the form data
    $name = $_POST['name'];
    $email = $_POST['email'];
    $institution = $_POST['Institution'];
    $session_name = $_POST['session_name'];  // New session name field from hidden input

    // Validate the data
    if (empty($name) || empty($email) || empty($session_name)) {
        echo "Name, Email, and Session Name are required!";
        exit;
    }

    // Optional: Default `institution` to NULL if empty
    if (empty($institution)) {
        $institution = NULL;
    }

    // Sanitize email address to prevent malicious content
    $email = filter_var($email, FILTER_SANITIZE_EMAIL);

    // Validate email address format
    if (!filter_var($email, FILTER_VALIDATE_EMAIL)) {
        echo "Invalid email format!";
        exit;
    }

    // Prepare the SQL query to insert registration data into the registration table
    $query = "INSERT INTO registration (name, email, institution, session_name) VALUES (?, ?, ?, ?)";

    // Prepare the statement
    if ($stmt = $conn->prepare($query)) {
        // Bind parameters (name, email, institution, session_name)
        $stmt->bind_param("ssss", $name, $email, $institution, $session_name);
    
        // Execute the statement
        if ($stmt->execute()) {
            // Get the generated session_id
            $generated_session_id = $stmt->insert_id;  // This will give you the auto-generated session_id
    
            // Generate QR Code URL with user details
            $qrData = urlencode($name . ' ' . $email . ' ' . $session_name);
            $qrUrl = "https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=$qrData"; // External API to generate QR code
    
            // Use PHP header() to redirect the user to the QR generation page
            header("Location: qrgen.html?name=$name&email=$email&session_name=$session_name&qrUrl=$qrUrl");
            exit();  // Ensure script stops after redirection
        } else {
            echo "Error: " . $stmt->error;
        }
    
        // Close the statement
        $stmt->close();
    } else {
        echo "Error preparing the query: " . $conn->error;
    }

    // Close the database connection
    $conn->close();
}
?>
