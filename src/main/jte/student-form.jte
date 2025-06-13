@param com.example.Lab7.data.Student student
@param org.springframework.security.web.csrf.CsrfToken _csrf

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>
        @if(student.getId() == null)
            Додати нового студента
        @else
            Редагувати студента: ${student.getName()}
        @endif
    </title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c);
            background-size: 400% 400%;
            animation: gradientShift 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            overflow: hidden;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><radialGradient id="g"><stop offset="20%" stop-opacity=".1"/><stop offset="50%" stop-opacity=".05"/><stop offset="100%" stop-opacity="0"/></radialGradient></defs><circle fill="url(%23g)" cx="20" cy="50" r="50"/><circle fill="url(%23g)" cx="80" cy="20" r="50"/><circle fill="url(%23g)" cx="40" cy="80" r="50"/></svg>');
            opacity: 0.3;
            animation: float 20s ease-in-out infinite;
        }

        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-20px) rotate(2deg); }
            66% { transform: translateY(-10px) rotate(-1deg); }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        @keyframes inputFocus {
            0% { transform: scale(1); }
            50% { transform: scale(1.02); }
            100% { transform: scale(1); }
        }

        @keyframes buttonPulse {
            0% { box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4); }
            50% { box-shadow: 0 6px 20px rgba(76, 175, 80, 0.6); }
            100% { box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4); }
        }

        .form-container {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(15px);
            -webkit-backdrop-filter: blur(15px);
            padding: 40px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow:
                    0 8px 32px rgba(0, 0, 0, 0.1),
                    inset 0 1px 0 rgba(255, 255, 255, 0.2);
            width: 420px;
            animation: slideInUp 0.8s ease-out;
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            border-radius: 20px;
            z-index: -1;
            animation: borderGlow 3s ease-in-out infinite alternate;
        }

        @keyframes borderGlow {
            0% { opacity: 0.5; }
            100% { opacity: 1; }
        }

        h2 {
            text-align: center;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 35px;
            font-weight: 300;
            font-size: 28px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            opacity: 0;
            animation: slideInUp 0.8s ease-out 0.2s forwards;
        }

        .input-group {
            position: relative;
            margin-bottom: 25px;
            opacity: 0;
            animation: slideInUp 0.8s ease-out forwards;
        }

        .input-group:nth-child(2) { animation-delay: 0.3s; }
        .input-group:nth-child(3) { animation-delay: 0.4s; }
        .input-group:nth-child(4) { animation-delay: 0.5s; }

        label {
            display: block;
            margin-bottom: 8px;
            color: rgba(255, 255, 255, 0.8);
            font-weight: 400;
            font-size: 14px;
            transition: all 0.3s ease;
        }

        input[type="text"], input[type="email"] {
            width: 100%;
            padding: 15px 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            color: rgba(255, 255, 255, 0.9);
            font-size: 16px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            outline: none;
        }

        input[type="text"]::placeholder, input[type="email"]::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        input[type="text"]:focus, input[type="email"]:focus {
            border-color: rgba(255, 255, 255, 0.4);
            background: rgba(255, 255, 255, 0.15);
            box-shadow:
                    0 0 0 3px rgba(255, 255, 255, 0.1),
                    0 8px 25px rgba(0, 0, 0, 0.1);
            transform: translateY(-2px);
            animation: inputFocus 0.6s ease;
        }

        input[type="text"]:focus + label, input[type="email"]:focus + label {
            color: rgba(255, 255, 255, 1);
            transform: translateY(-2px);
        }

        .button-container {
            opacity: 0;
            animation: slideInUp 0.8s ease-out 0.6s forwards;
        }

        button {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.8), rgba(67, 160, 71, 0.9));
            color: white;
            padding: 16px 24px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.4);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        button:hover::before {
            left: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.9), rgba(67, 160, 71, 1));
            transform: translateY(-3px);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.5);
            animation: buttonPulse 2s ease-in-out infinite;
        }

        button:active {
            transform: translateY(-1px);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.6);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 400;
            transition: all 0.3s ease;
            opacity: 0;
            animation: slideInUp 0.8s ease-out 0.7s forwards;
        }

        .back-link:hover {
            color: rgba(255, 255, 255, 1);
            text-decoration: underline;
            text-shadow: 0 2px 10px rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        @media (max-width: 480px) {
            .form-container {
                width: 90%;
                padding: 30px 25px;
                margin: 20px;
            }
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>
        @if(student.getId() == null)
            Додати нового студента
        @else
            Редагувати студента
        @endif
    </h2>

    <form action="/students" method="post">
        <input type="hidden" name="${_csrf.getParameterName()}" value="${_csrf.getToken()}"/>

        @if(student.getId() != null)
            <input type="hidden" name="id" value="${student.getId()}"/>
        @endif

        <div>
            <label for="name">Ім'я:</label>
            <input type="text" id="name" name="name" value="${student.getName() != null ? student.getName() : ""}" required>
        </div>
        <div>
            <label for="email">Електронна пошта:</label>
            <input type="email" id="email" name="email" value="${student.getEmail() != null ? student.getEmail() : ""}" required>
        </div>
        @if(student.getGrades() != null && !student.getGrades().isEmpty())
            <h3>Існуючі оцінки:</h3>
            @for(com.example.Lab7.data.Grade grade : student.getGrades())
                <p>${grade.getSubject()}: ${grade.getScore()}</p>
            @endfor
        @else
            <p>Немає оцінок.</p>
        @endif

        <div>
            <button type="submit">
                @if(student.getId() == null)
                    Додати студента
                @else
                    Зберегти зміни
                @endif
            </button>
        </div>
    </form>
    <a href="/students" class="back-link">Повернутися до списку студентів</a>
</div>
</body>
</html>