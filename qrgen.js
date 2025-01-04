document.addEventListener('DOMContentLoaded', function () {
    // Get parameters from URL
    const params = new URLSearchParams(window.location.search);
    const name = params.get('name');
    const email = params.get('email');
    const session_name = params.get('session_name');
    let qrUrl = params.get('qrUrl'); // Fetch QR URL directly from parameters

    // Log parameters for debugging
    console.log(`Name: ${name}`);
    console.log(`Email: ${email}`);
    console.log(`Session Name: ${session_name}`);
    console.log(`QR URL: ${qrUrl}`);

    // Validate required fields
    if (!name || !email || !session_name || !qrUrl) {
        alert("Some required parameters are missing or invalid!");
        console.error("Validation failed. Missing parameters:", { name, email, session_name, qrUrl });
        return; // Stop execution if validation fails
    }

    // Validate the qrUrl starts with 'https://'
    if (!qrUrl.startsWith('https://')) {
        console.error("Invalid QR URL:", qrUrl);
        alert("The QR code URL is invalid.");
        return; // Stop execution if QR URL is invalid
    }

    // Now, update qrUrl to include the data to be encoded (name, email, session_name)
    // We will encode the parameters to ensure they are safely included in the QR code
    const qrData = `Name: ${name}, Email: ${email}, Session Name: ${session_name}`;
    qrUrl = `https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=${encodeURIComponent(qrData)}`;

    // Set the QR image source
    const qrImage = document.getElementById('qrimage');
    if (qrImage) {
        qrImage.src = qrUrl; // Set the generated QR code URL as the image source
    } else {
        console.error("QR image element with ID 'qrimage' not found!");
        alert("QR code image container is missing in the HTML.");
    }

    // Add download functionality
    const downloadBtn = document.getElementById('download-btn');
    if (downloadBtn) {
        downloadBtn.addEventListener('click', function () {
            const qrContainer = document.getElementById('qr-code');
            if (qrContainer) {
                html2canvas(qrContainer).then((canvas) => {
                    const link = document.createElement('a');
                    link.href = canvas.toDataURL('image/png'); // Convert the canvas to a PNG image
                    link.download = 'qr-code.png'; // Set download file name
                    link.click(); // Trigger download
                }).catch((error) => {
                    console.error("Error capturing QR code for download:", error);
                    alert("Failed to generate a downloadable QR code. Please try again.");
                });
            } else {
                console.error("QR container element with ID 'qr-code' not found!");
                alert("QR code container is missing in the HTML.");
            }
        });
    } else {
        console.error("Download button with ID 'download-btn' not found!");
        alert("Download button is missing in the HTML.");
    }
});
