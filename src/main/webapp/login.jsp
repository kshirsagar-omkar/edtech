<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Student Portal</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Custom CSS -->
  <style>
    /* General Styling */
    body {
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      display: flex;
      justify-content: center;
      align-items: center;
      height: 100vh;
      margin: 0;
      font-family: 'Arial', sans-serif;
    }

    /* Login Container */
    .login-container {
      background-color: rgba(255, 255, 255, 0.9);
      padding: 2.5rem;
      border-radius: 15px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      width: 100%;
      max-width: 400px;
      animation: float 3s ease-in-out infinite;
    }

    /* Floating Animation */
    @keyframes float {
      0%, 100% {
        transform: translateY(0);
      }
      50% {
        transform: translateY(-10px);
      }
    }

    /* Header */
    .login-container h2 {
      text-align: center;
      margin-bottom: 1.5rem;
      color: #333;
      font-weight: bold;
      font-size: 2rem;
    }

    /* Form Group */
    .form-group {
      margin-bottom: 1.5rem;
    }

    .form-group label {
      font-weight: bold;
      color: #555;
      margin-bottom: 0.5rem;
      display: block;
    }

    /* Input Fields */
    .form-control {
      width: 100%;
      padding: 0.75rem;
      border: 1px solid #ddd;
      border-radius: 8px;
      font-size: 1rem;
      transition: border-color 0.3s ease, box-shadow 0.3s ease;
    }

    .form-control:focus {
      border-color: #2575fc;
      outline: none;
      box-shadow: 0 0 10px rgba(37, 117, 252, 0.5);
    }

    /* Login Button */
    .btn-login {
      width: 100%;
      padding: 0.75rem;
      background-color: #2575fc;
      color: white;
      border: none;
      border-radius: 8px;
      font-size: 1rem;
      font-weight: bold;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }

    .btn-login:hover {
      background-color: #1a5bbf;
      transform: translateY(-2px);
    }

    /* Error Message */
    .alert {
      margin-top: 1.5rem;
      border-radius: 8px;
      text-align: center;
      padding: 0.75rem;
      font-size: 0.9rem;
    }

    /* Link to Register (Optional) */
    .register-link {
      text-align: center;
      margin-top: 1rem;
      color: #555;
    }

    .register-link a {
      color: #2575fc;
      text-decoration: none;
      font-weight: bold;
    }

    .register-link a:hover {
      text-decoration: underline;
    }
  </style>
</head>
<body>
<div class="login-container">
  <h2>Login</h2>
  <form action="login" method="post">
    <div class="form-group">
      <label for="username">Username</label>
      <input type="text" id="username" name="username" class="form-control" placeholder="Enter your username" required>
    </div>
    <div class="form-group">
      <label for="password">Password</label>
      <input type="password" id="password" name="password" class="form-control" placeholder="Enter your password" required>
    </div>
    <button type="submit" class="btn-login">Login</button>
  </form>




  <!-- Display error message if login fails -->
  <% if (request.getAttribute("error") != null) { %>
  <div class="alert alert-danger">
    <%= request.getAttribute("error") %>
  </div>
  <% } %>




  <!-- Optional: Register Link -->
  <div class="register-link">
    Don't have an account? <a href="register.jsp">Register here</a>
  </div>

  <!-- Link to go home page -->
  <div class="register-link">
    Navigate to home <a href="index.jsp">Home</a>
  </div>

</div>

<!-- Bootstrap 5 JS and dependencies -->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>
</body>
</html>