<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f4f6f9; /* Un gri foarte deschis, odihnitor */
    }

    /* Sidebar Styling */
    .sidebar {
        min-height: 100vh;
        background: #212529; /* Dark Bootstrap Color */
        color: white;
        box-shadow: 2px 0 5px rgba(0,0,0,0.1);
    }

    .sidebar .nav-link {
        color: #cfd2d6;
        margin-bottom: 5px;
        border-radius: 5px;
        padding: 10px 15px;
        transition: all 0.3s;
    }

    .sidebar .nav-link:hover, .sidebar .nav-link.active {
        background-color: #0d6efd; /* Albastru Bootstrap */
        color: white;
        transform: translateX(5px); /* Mica miscare la dreapta */
    }

    .sidebar .nav-link i {
        width: 25px; /* Spatiu fix pt iconite ca sa se alinieze textul */
        text-align: center;
    }

    .main-content {
        padding: 20px;
    }

    .card-dashboard {
        border: none;
        border-radius: 10px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.07);
        transition: transform 0.3s;
    }

    .card-dashboard:hover {
        transform: translateY(-5px); /* Se ridica putin cand pui mouse-ul */
    }
</style>