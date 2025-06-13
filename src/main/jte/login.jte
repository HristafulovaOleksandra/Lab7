@param String error
@param String logout
@param String registrationSuccess
@param org.springframework.security.web.csrf.CsrfToken _csrf

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Увійти</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 25%, #a8e6cf 50%, #ffd3a5 75%, #ff8a80 100%);
            background-size: 400% 400%;
            animation: gradient-flow 15s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            overflow: hidden;
        }

        @keyframes gradient-flow {
            0% { background-position: 0% 50%; }
            25% { background-position: 100% 50%; }
            50% { background-position: 100% 100%; }
            75% { background-position: 0% 100%; }
            100% { background-position: 0% 50%; }
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle at 30% 40%, rgba(255, 255, 255, 0.2) 0%, transparent 50%),
            radial-gradient(circle at 70% 70%, rgba(255, 255, 255, 0.15) 0%, transparent 50%),
            radial-gradient(circle at 20% 80%, rgba(255, 255, 255, 0.1) 0%, transparent 50%);
            animation: floating-orbs 20s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes floating-orbs {
            0%, 100% { transform: translateY(0px) rotate(0deg); opacity: 0.8; }
            33% { transform: translateY(-30px) rotate(120deg); opacity: 1; }
            66% { transform: translateY(15px) rotate(240deg); opacity: 0.6; }
        }

        body::after {
            content: '';
            position: absolute;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="sparkles" width="20" height="20" patternUnits="userSpaceOnUse"><circle cx="2" cy="2" r="1" fill="rgba(255,255,255,0.1)" opacity="0.5"><animate attributeName="opacity" values="0.1;0.8;0.1" dur="3s" repeatCount="indefinite"/></circle><circle cx="18" cy="18" r="0.5" fill="rgba(255,255,255,0.2)" opacity="0.3"><animate attributeName="opacity" values="0.2;1;0.2" dur="2s" repeatCount="indefinite"/></circle></pattern></defs><rect width="100" height="100" fill="url(%23sparkles)"/></svg>');
            animation: sparkle-drift 25s linear infinite;
            pointer-events: none;
            opacity: 0.6;
        }

        @keyframes sparkle-drift {
            0% { transform: translate(0, 0) rotate(0deg); }
            100% { transform: translate(-50px, -50px) rotate(360deg); }
        }

        .login-container {
            background: linear-gradient(145deg, rgba(255, 255, 255, 0.2), rgba(255, 255, 255, 0.05));
            backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.25);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1), 0 10px 20px rgba(0, 0, 0, 0.05);
            width: 380px;
            text-align: center;
            box-sizing: border-box;
            position: relative;
            transform: translateY(0) scale(1);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: container-entrance 1s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
        }

        .login-container::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(255, 255, 255, 0.1), transparent);
            animation: rotate-shine 4s linear infinite;
            pointer-events: none;
        }

        @keyframes rotate-shine {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes container-entrance {
            0% {
                opacity: 0;
                transform: translateY(60px) scale(0.8);
                filter: blur(10px);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1);
                filter: blur(0px);
            }
        }

        .login-container:hover {
            transform: translateY(-5px) scale(1.02);
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.15), 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        h2 {
            background: linear-gradient(135deg, #667eea, #764ba2);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 30px;
            font-weight: 600;
            font-size: 32px;
            position: relative;
            animation: title-pulse 3s ease-in-out infinite alternate;
        }

        @keyframes title-pulse {
            0% {
                filter: drop-shadow(0 0 5px rgba(102, 126, 234, 0.3));
                transform: scale(1);
            }
            100% {
                filter: drop-shadow(0 0 20px rgba(102, 126, 234, 0.8));
                transform: scale(1.02);
            }
        }

        .message-container {
            margin-bottom: 25px;
            padding: 15px;
            border-radius: 12px;
            font-weight: 500;
            text-align: left;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            animation: message-slide 0.5s ease-out;
            position: relative;
            overflow: hidden;
        }

        .message-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            animation: message-shimmer 2s infinite;
        }

        @keyframes message-shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes message-slide {
            0% {
                opacity: 0;
                transform: translateX(-20px);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .error-message {
            background: linear-gradient(135deg, rgba(244, 67, 54, 0.2), rgba(244, 67, 54, 0.1));
            color: #d32f2f;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .logout-message {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.2), rgba(76, 175, 80, 0.1));
            color: #388e3c;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        .success-message {
            background: linear-gradient(135deg, rgba(40, 167, 69, 0.2), rgba(40, 167, 69, 0.1));
            color: #28a745;
            text-shadow: 0 1px 2px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 10px;
            color: rgba(255, 255, 255, 0.9);
            font-size: 15px;
            font-weight: 500;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            transform: translateX(0);
            transition: all 0.3s ease;
        }

        label:hover {
            transform: translateX(5px);
            color: rgba(255, 255, 255, 1);
        }

        input[type="text"], input[type="password"] {
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

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: rgba(102, 126, 234, 0.8);
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.2), 0 10px 30px rgba(0, 0, 0, 0.1);
            outline: none;
            transform: translateY(-3px) scale(1.02);
        }

        input[type="text"]:hover, input[type="password"]:hover {
            border-color: rgba(255, 255, 255, 0.5);
            transform: translateY(-1px);
        }

        button {
            background: linear-gradient(135deg, rgba(63, 81, 181, 0.8), rgba(48, 63, 159, 0.8));
            color: white;
            padding: 16px 25px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            width: 100%;
            font-weight: 600;
            letter-spacing: 0.5px;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 8px 25px rgba(63, 81, 181, 0.3);
            position: relative;
            overflow: hidden;
            animation: button-glow 4s infinite;
        }

        @keyframes button-glow {
            0%, 100% { box-shadow: 0 8px 25px rgba(63, 81, 181, 0.3); }
            50% { box-shadow: 0 8px 25px rgba(63, 81, 181, 0.6), 0 0 30px rgba(63, 81, 181, 0.4); }
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.6s;
        }

        button:hover::before {
            left: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, rgba(63, 81, 181, 0.9), rgba(48, 63, 159, 0.9));
            box-shadow: 0 12px 35px rgba(63, 81, 181, 0.4), 0 0 40px rgba(63, 81, 181, 0.3);
            transform: translateY(-3px) scale(1.02);
        }

        button:active {
            transform: translateY(0) scale(0.98);
            box-shadow: 0 5px 15px rgba(63, 81, 181, 0.3);
        }

        .register-link {
            margin-top: 25px;
            font-size: 15px;
            animation: link-fade 0.8s ease-out 0.5s both;
        }

        @keyframes link-fade {
            0% { opacity: 0; transform: translateY(10px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .register-link a {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
            transition: all 0.3s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        .register-link a::before {
            content: '';
            position: absolute;
            width: 0;
            height: 2px;
            bottom: -2px;
            left: 50%;
            background: linear-gradient(90deg, #667eea, #764ba2);
            transition: all 0.3s ease;
            transform: translateX(-50%);
        }

        .register-link a:hover::before {
            width: 100%;
        }

        .register-link a:hover {
            color: #ffffff;
            text-decoration: none;
            text-shadow: 0 0 10px rgba(255, 255, 255, 0.5);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2>Вхід</h2>

    @if(error != null)
        <div class="message-container error-message">${error}</div>
    @endif
    @if(logout != null)
        <div class="message-container logout-message">${logout}</div>
    @endif
    @if(registrationSuccess != null)
        <div class="message-container success-message">${registrationSuccess}</div>
    @endif

    <form action="/login" method="post">
        <input type="hidden" name="${_csrf.getParameterName()}" value="${_csrf.getToken()}"/>

        <div>
            <label for="username">Ім'я користувача:</label>
            <input type="text" id="username" name="username" autofocus="autofocus">
        </div>
        <div>
            <label for="password">Пароль:</label>
            <input type="password" id="password" name="password">
        </div>
        <div>
            <button type="submit">Увійти</button>
        </div>
    </form>
    <div class="register-link">
        Не маєте облікового запису? <a href="/register">Зареєструватися</a>
    </div>
</div>
</body>
</html>