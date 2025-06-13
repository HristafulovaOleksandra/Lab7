@import com.example.Lab7.data.Student
@import org.springframework.security.web.csrf.CsrfToken
@import java.util.List

@param List<Student> students
@param org.springframework.security.web.csrf.CsrfToken _csrf

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Додати оцінку</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #f093fb 50%, #f5576c 75%, #4facfe 100%);
            background-size: 400% 400%;
            animation: gradient-shift 12s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            overflow: hidden;
            position: relative;
        }

        @keyframes gradient-shift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 20% 80%, rgba(120, 119, 198, 0.3) 0%, transparent 50%),
            radial-gradient(circle at 80% 20%, rgba(255, 177, 153, 0.3) 0%, transparent 50%),
            radial-gradient(circle at 40% 40%, rgba(120, 200, 255, 0.3) 0%, transparent 50%);
            animation: float-bubbles 20s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes float-bubbles {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.7; }
            33% { transform: translateY(-20px) rotate(120deg); opacity: 1; }
            66% { transform: translateY(10px) rotate(240deg); opacity: 0.8; }
        }

        body::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grain" width="100" height="100" patternUnits="userSpaceOnUse"><circle cx="50" cy="50" r="0.5" fill="rgba(255,255,255,0.1)"/><circle cx="20" cy="20" r="0.3" fill="rgba(255,255,255,0.05)"/><circle cx="80" cy="30" r="0.4" fill="rgba(255,255,255,0.08)"/></pattern></defs><rect width="100" height="100" fill="url(%23grain)"/></svg>');
            animation: particle-float 15s linear infinite;
            pointer-events: none;
        }

        @keyframes particle-float {
            0% { transform: translateY(0px); }
            100% { transform: translateY(-100px); }
        }

        .form-container {
            background: linear-gradient(145deg, rgba(255, 255, 255, 0.25), rgba(255, 255, 255, 0.1));
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1), 0 5px 15px rgba(0, 0, 0, 0.08);
            width: 420px;
            box-sizing: border-box;
            transform: translateY(0) scale(1);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: slide-in 0.8s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            overflow: hidden;
        }

        .form-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            transform: rotate(45deg);
            animation: shimmer 3s infinite;
            pointer-events: none;
        }

        @keyframes shimmer {
            0% { transform: translateX(-100%) translateY(-100%) rotate(45deg); }
            100% { transform: translateX(100%) translateY(100%) rotate(45deg); }
        }

        @keyframes slide-in {
            0% {
                opacity: 0;
                transform: translateY(50px) scale(0.9);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .form-container:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15), 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        h2 {
            text-align: center;
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 35px;
            font-weight: 600;
            position: relative;
            padding-bottom: 15px;
            font-size: 28px;
            animation: title-glow 2s ease-in-out infinite alternate;
        }

        @keyframes title-glow {
            0% { filter: drop-shadow(0 0 5px rgba(102, 126, 234, 0.3)); }
            100% { filter: drop-shadow(0 0 15px rgba(102, 126, 234, 0.6)); }
        }

        h2::after {
            content: '';
            position: absolute;
            left: 50%;
            bottom: 0;
            transform: translateX(-50%);
            width: 0;
            height: 4px;
            background: linear-gradient(90deg, #667eea, #764ba2);
            border-radius: 2px;
            animation: underline-expand 1s ease-out 0.5s forwards;
        }

        @keyframes underline-expand {
            to { width: 80px; }
        }

        label {
            display: block;
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.9);
            font-weight: 500;
            font-size: 16px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            transform: translateX(0);
            transition: transform 0.3s ease;
        }

        label:hover {
            transform: translateX(5px);
        }

        input[type="text"], input[type="number"], select {
            width: 100%;
            padding: 15px 20px;
            margin-bottom: 25px;
            border: 2px solid rgba(255, 255, 255, 0.3);
            border-radius: 12px;
            box-sizing: border-box;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            color: #333;
            font-size: 16px;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        input[type="text"]:focus, input[type="number"]:focus, select:focus {
            border-color: rgba(102, 126, 234, 0.8);
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.2), 0 8px 25px rgba(0, 0, 0, 0.1);
            outline: none;
            transform: translateY(-2px) scale(1.02);
        }

        input[type="text"]:hover, input[type="number"]:hover, select:hover {
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-1px);
        }

        button {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.8), rgba(56, 142, 60, 0.8));
            color: white;
            padding: 18px 30px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 18px;
            width: 100%;
            font-weight: 600;
            letter-spacing: 1px;
            text-transform: uppercase;
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            position: relative;
            overflow: hidden;
            animation: button-pulse 3s infinite;
        }

        @keyframes button-pulse {
            0%, 100% { box-shadow: 0 8px 25px rgba(76, 175, 80, 0.3); }
            50% { box-shadow: 0 8px 25px rgba(76, 175, 80, 0.5), 0 0 20px rgba(76, 175, 80, 0.3); }
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        button:hover::before {
            left: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.9), rgba(56, 142, 60, 0.9));
            box-shadow: 0 12px 35px rgba(76, 175, 80, 0.4), 0 0 30px rgba(76, 175, 80, 0.3);
            transform: translateY(-3px) scale(1.02);
        }

        button:active {
            transform: translateY(0) scale(0.98);
            box-shadow: 0 5px 15px rgba(76, 175, 80, 0.3);
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 30px;
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            font-size: 16px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        .back-link::before {
            content: '← ';
            opacity: 0;
            transform: translateX(10px);
            transition: all 0.3s ease;
        }

        .back-link:hover::before {
            opacity: 1;
            transform: translateX(0);
        }

        .back-link:hover {
            color: #ffffff;
            text-decoration: none;
            transform: translateX(-5px);
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
        }
    </style>
</head>
<body>
<div class="form-container">
    <h2>Додати оцінку</h2>
    <form action="/grades" method="post">
        <input type="hidden" name="${_csrf.getParameterName()}" value="${_csrf.getToken()}"/>

        <div>
            <label for="studentId">Виберіть студента:</label>
            <select id="studentId" name="studentId" required>
                @for(com.example.Lab7.data.Student student : students)
                    <option value="${student.getId()}">${student.getName()} (ID: ${student.getId()})</option>
                @endfor
            </select>
        </div>
        <div>
            <label for="subject">Предмет:</label>
            <input type="text" id="subject" name="subject" required>
        </div>
        <div>
            <label for="score">Оцінка:</label>
            <input type="number" id="score" name="score" min="0" max="100" required>
        </div>
        <div>
            <button type="submit">Додати оцінку</button>
        </div>
    </form>
    <a href="/students" class="back-link">Повернутися до списку студентів</a>
</div>
</body>
</html>