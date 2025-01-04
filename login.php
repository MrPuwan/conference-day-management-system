<?php
// Include the database connection
include 'db_connect.php'; 

// Process the form data
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get form data
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];

   
    // Prepare SQL query to insert data into the database using prepared statements
    $sql = "INSERT INTO participants (name, email, password) VALUES (?, ?, ?)";

    // Prepare the statement
    if ($stmt = $conn->prepare($sql)) {
        // Bind parameters
        $stmt->bind_param("sss", $username, $email, $password);

        // Execute the statement
        if ($stmt->execute()) {
            // Show a success message and redirect to the homepage
            echo "<script>
                    alert('Login successful!');
                    window.location.href = 'session.html'; // Change to your homepage URL
                  </script>";
        } else {
            echo "Error: " . $stmt->error;
        }

        // Close the statement
        $stmt->close();
    } else {
        echo "<p style='color:red;'>Error: " . $conn->error . "</p>";
    }

    // Close the database connection
    $conn->close();
}
?>
