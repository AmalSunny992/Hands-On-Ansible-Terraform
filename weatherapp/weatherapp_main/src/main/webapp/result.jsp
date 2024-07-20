<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Weather Report</title>
    <!-- Include Bootstrap CSS for styling -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #f7f9fc;
            font-family: Arial, sans-serif;
        }
        .weather-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
        }
        .weather-container h1 {
            text-align: center;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="container weather-container">
        <h1>Weather Information for ${city}</h1>
        <p><strong>Weather:</strong> ${weather}</p>
        <p><strong>Temperature:</strong> ${temperature} °C</p>
        <p><strong>Humidity:</strong> ${humidity} %</p>
        <p><strong>Pressure:</strong> ${pressure} hPa</p>
        <p><strong>Wind Speed:</strong> ${wind} m/s</p>
        <p><strong>Visibility:</strong> ${visibility} meters</p>
        <a href="index.jsp" class="btn btn-primary mt-3">Back</a>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
