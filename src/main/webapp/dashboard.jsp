<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
  if (session == null || session.getAttribute("username") == null) {
    response.sendRedirect("login.jsp");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Student Dashboard</title>
  <!-- Bootstrap 5 CSS -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
  <!-- Custom CSS -->
  <style>
    :root {
      --primary: #6C5CE7;
      --secondary: #A8A4FF;
      --accent: #FF7675;
      --bg: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
    }

    body {
      background: var(--bg);
      min-height: 100vh;
      font-family: 'Segoe UI', sans-serif;
    }

    /* Floating Header */
    .floating-header {
      background: rgba(255, 255, 255, 0.95);
      backdrop-filter: blur(10px);
      box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
      border-radius: 0 0 20px 20px;
      padding: 1rem 2rem;
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      z-index: 1000;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }

    /* Main Content */
    .main-content {
      margin-top: 80px;
      padding: 2rem;
    }

    /* Stats Cards */
    .stat-card {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 20px;
      padding: 1.5rem;
      margin-bottom: 1.5rem;
      backdrop-filter: blur(10px);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .stat-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 12px 24px rgba(0, 0, 0, 0.1);
    }

    .stat-icon {
      width: 50px;
      height: 50px;
      border-radius: 12px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.5rem;
      margin-bottom: 1rem;
    }

    /* Progress Ring */
    .progress-ring {
      width: 100px;
      height: 100px;
      transform: rotate(-90deg);
    }

    .progress-ring circle {
      fill: none;
      stroke-width: 8;
      stroke-linecap: round;
    }

    .progress-ring-bg {
      stroke: #eee;
    }

    .progress-ring-fill {
      stroke: var(--primary);
      stroke-dasharray: 283;
      transition: stroke-dashoffset 0.5s ease;
    }

    /* Quick Actions */
    .quick-action {
      background: rgba(255, 255, 255, 0.9);
      border-radius: 15px;
      padding: 1.5rem;
      text-align: center;
      transition: all 0.3s ease;
      border: 1px solid rgba(255, 255, 255, 0.3);
    }

    .quick-action:hover {
      background: white;
      transform: translateY(-3px);
    }

    /* Floating Menu */
    .floating-menu {
      position: fixed;
      bottom: 2rem;
      right: 2rem;
      background: white;
      border-radius: 50px;
      padding: 0.5rem;
      box-shadow: 0 8px 24px rgba(0, 0, 0, 0.1);
      display: flex;
      gap: 0.5rem;
    }

    .menu-btn {
      width: 50px;
      height: 50px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      background: var(--primary);
      color: white;
      transition: all 0.3s ease;
    }

    .menu-btn:hover {
      transform: scale(1.1);
      background: var(--accent);
    }
  </style>
</head>
<body>
<!-- Floating Header -->
<div class="floating-header">
  <h2 class="mb-0 text-primary">StudyHub |  Hello, <%=(String)session.getAttribute("username")%></h2>
  <div class="d-flex gap-3">
    <button class="btn btn-sm btn-outline-primary">
      <i class="fas fa-bell"></i>
    </button>
    
    <form method="post" action="logout" class="d-inline">
	    <button type="submit" class="btn btn-sm btn-danger">
	        <i class="fas fa-sign-out-alt"></i> Logout
	    </button>
	</form>
    
  </div>
</div>

<!-- Main Content -->
<div class="main-content">
  <div class="container">
    <!-- Stats Row -->
    <div class="row g-4">
      <div class="col-md-3">
        <div class="stat-card">
          <div class="stat-icon bg-primary text-white">
            <i class="fas fa-book-open"></i>
          </div>
          <h4 class="text-primary">Active Courses</h4>
          <h2>5</h2>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="stat-icon bg-success text-white">
            <i class="fas fa-check"></i>
          </div>
          <h4 class="text-success">Completed</h4>
          <h2>12</h2>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="stat-icon bg-warning text-white">
            <i class="fas fa-clock"></i>
          </div>
          <h4 class="text-warning">Pending</h4>
          <h2>3</h2>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="stat-icon bg-info text-white">
            <i class="fas fa-chart-line"></i>
          </div>
          <h4 class="text-info">Performance</h4>
          <h2>87%</h2>
        </div>
      </div>
    </div>

    <!-- Progress Section -->
    <div class="row mt-4">
      <div class="col-md-8">
        <div class="stat-card">
          <h3 class="text-primary">Course Progress</h3>
          <div class="d-flex align-items-center">
            <div class="position-relative">
              <svg class="progress-ring" viewBox="0 0 100 100">
                <circle class="progress-ring-bg" cx="50" cy="50" r="45"/>
                <circle class="progress-ring-fill" cx="50" cy="50" r="45"
                        stroke-dashoffset="calc(283 - (283 * 0.65))"/>
              </svg>
              <div class="position-absolute top-50 start-50 translate-middle">
                <h2 class="mb-0">65%</h2>
              </div>
            </div>
            <div class="ms-4">
              <h5>Current Course: Web Development</h5>
              <div class="progress mt-2" style="height: 8px;">
                <div class="progress-bar bg-primary" style="width: 65%"></div>
              </div>
              <p class="text-muted mt-2">Next milestone: Module 4</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Quick Actions -->
      <div class="col-md-4">
        <div class="d-flex flex-column gap-3">
          <div class="quick-action">
            <i class="fas fa-video text-primary fs-3"></i>
            <h5 class="mt-2">Join Live Class</h5>
            <p class="text-muted">Next session in 15m</p>
          </div>
          <div class="quick-action">
            <i class="fas fa-file-upload text-success fs-3"></i>
            <h5 class="mt-2">Submit Assignment</h5>
            <p class="text-muted">Due tomorrow</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<!-- Floating Menu -->
<div class="floating-menu">
  <button class="menu-btn">
    <i class="fas fa-plus"></i>
  </button>
  <button class="menu-btn">
    <i class="fas fa-calendar"></i>
  </button>
  <button class="menu-btn">
    <i class="fas fa-comments"></i>
  </button>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>