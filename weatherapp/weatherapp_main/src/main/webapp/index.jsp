<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Weather App</title>
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
        .btn-primary {
            width: 100%;
        }
    </style>
</head>
<body>
    <div class="container weather-container">
        <h1>Weather App</h1>
        <form action="weather" method="post">
            <div class="form-group">
                <label for="city">Select City:</label>
                <select class="form-control" id="city" name="city" required>
                    <option value="" disabled selected>Select a city</option>
                    <option value="Florida">Florida</option>
                    <option value="London">London</option>
                    <option value="Tokyo">Tokyo</option>
                    <option value="Paris">Paris</option>
                    <option value="Berlin">Berlin</option>
                    <option value="Moscow">Moscow</option>
                    <option value="Delhi">Delhi</option>
                    <option value="Sydney">Sydney</option>
                    <option value="Toronto">Toronto</option>
                    <option value="Dubai">Dubai</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Get Weather</button>
        </form>
    </div>

    <!-- Include Bootstrap JS and dependencies -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
