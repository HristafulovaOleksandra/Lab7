@param String error
@param String registrationSuccess
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Реєстрація</title>
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 25%, #fecfef 50%, #ffd6cc 75%, #667eea 100%);
            background-size: 400% 400%;
            animation: aurora-flow 18s ease infinite;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            position: relative;
            overflow: hidden;
        }

        @keyframes aurora-flow {
            0% { background-position: 0% 50%; }
            33% { background-position: 100% 0%; }
            66% { background-position: 0% 100%; }
            100% { background-position: 0% 50%; }
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background:
                    radial-gradient(circle at 25% 25%, rgba(255, 154, 158, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 75% 75%, rgba(254, 207, 239, 0.3) 0%, transparent 50%),
                    radial-gradient(circle at 50% 50%, rgba(255, 214, 204, 0.2) 0%, transparent 50%);
            animation: orb-dance 25s ease-in-out infinite;
            pointer-events: none;
        }

        @keyframes orb-dance {
            0%, 100% {
                transform: translateY(0px) rotate(0deg);
                opacity: 0.7;
            }
            25% {
                transform: translateY(-40px) rotate(90deg);
                opacity: 1;
            }
            50% {
                transform: translateY(20px) rotate(180deg);
                opacity: 0.8;
            }
            75% {
                transform: translateY(-20px) rotate(270deg);
                opacity: 0.9;
            }
        }

        body::after {
            content: '';
            position: absolute;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="hearts" width="25" height="25" patternUnits="userSpaceOnUse"><path d="M12.5 8c-2.5 0-4.5 2-4.5 4.5 0 3 4.5 7.5 4.5 7.5s4.5-4.5 4.5-7.5c0-2.5-2-4.5-4.5-4.5z" fill="rgba(255,255,255,0.1)" opacity="0.6"><animate attributeName="opacity" values="0.1;0.8;0.1" dur="4s" repeatCount="indefinite"/></path></pattern></defs><rect width="100" height="100" fill="url(%23hearts)"/></svg>');
            animation: heart-drift 30s linear infinite;
            pointer-events: none;
            opacity: 0.4;
        }

        @keyframes heart-drift {
            0% { transform: translate(0, 0) scale(1); }
            100% { transform: translate(-25px, -25px) scale(1.1); }
        }

        .registration-container {
            background: linear-gradient(145deg, rgba(255, 255, 255, 0.25), rgba(255, 255, 255, 0.1));
            backdrop-filter: blur(30px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            padding: 45px;
            border-radius: 25px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.1), 0 10px 25px rgba(0, 0, 0, 0.05);
            width: 450px;
            text-align: center;
            box-sizing: border-box;
            position: relative;
            transform: translateY(0) scale(1);
            transition: all 0.6s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            animation: registration-entrance 1.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            overflow: hidden;
        }

        .registration-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, #ff9a9e, #fecfef, #ffd6cc, #667eea);
            border-radius: 25px;
            z-index: -1;
            animation: border-glow 3s linear infinite;
        }

        @keyframes border-glow {
            0% { filter: hue-rotate(0deg) brightness(1); }
            50% { filter: hue-rotate(180deg) brightness(1.2); }
            100% { filter: hue-rotate(360deg) brightness(1); }
        }

        .registration-container::after {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: conic-gradient(from 0deg, transparent, rgba(255, 255, 255, 0.15), transparent);
            animation: cosmic-spin 5s linear infinite;
            pointer-events: none;
        }

        @keyframes cosmic-spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @keyframes registration-entrance {
            0% {
                opacity: 0;
                transform: translateY(80px) scale(0.7) rotateX(20deg);
                filter: blur(15px);
            }
            50% {
                opacity: 0.7;
                transform: translateY(20px) scale(0.9) rotateX(10deg);
                filter: blur(5px);
            }
            100% {
                opacity: 1;
                transform: translateY(0) scale(1) rotateX(0deg);
                filter: blur(0px);
            }
        }

        .registration-container:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 35px 70px rgba(0, 0, 0, 0.15), 0 15px 35px rgba(0, 0, 0, 0.1);
        }

        h2 {
            background: linear-gradient(135deg, #ff9a9e, #667eea);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 35px;
            font-weight: 700;
            font-size: 36px;
            position: relative;
            animation: title-rainbow 4s ease-in-out infinite alternate;
        }

        @keyframes title-rainbow {
            0% {
                filter: drop-shadow(0 0 10px rgba(255, 154, 158, 0.5));
                transform: scale(1) rotate(0deg);
            }
            50% {
                filter: drop-shadow(0 0 25px rgba(102, 126, 234, 0.8));
                transform: scale(1.05) rotate(1deg);
            }
            100% {
                filter: drop-shadow(0 0 15px rgba(255, 214, 204, 0.6));
                transform: scale(1.02) rotate(-1deg);
            }
        }

        .error-message {
            background: linear-gradient(135deg, rgba(211, 47, 47, 0.25), rgba(211, 47, 47, 0.1));
            backdrop-filter: blur(15px);
            border: 1px solid rgba(211, 47, 47, 0.3);
            color: #d32f2f;
            margin-bottom: 25px;
            font-weight: 600;
            padding: 15px;
            border-radius: 15px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
            animation: error-pulse 0.6s ease-out, error-shake 0.5s ease-out 0.1s;
            position: relative;
            overflow: hidden;
        }

        .error-message::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            animation: error-shimmer 1.5s infinite;
        }

        @keyframes error-shimmer {
            0% { left: -100%; }
            100% { left: 100%; }
        }

        @keyframes error-pulse {
            0% { opacity: 0; transform: scale(0.8); }
            100% { opacity: 1; transform: scale(1); }
        }

        @keyframes error-shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        label {
            display: block;
            text-align: left;
            margin-bottom: 12px;
            color: rgba(255, 255, 255, 0.95);
            font-size: 16px;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            transform: translateX(0);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
        }

        label:hover {
            transform: translateX(8px) scale(1.05);
            color: rgba(255, 255, 255, 1);
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.5);
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 18px 25px;
            margin-bottom: 25px;
            border: 2px solid rgba(255, 255, 255, 0.4);
            border-radius: 15px;
            box-sizing: border-box;
            background: rgba(255, 255, 255, 0.2);
            backdrop-filter: blur(15px);
            color: #333;
            font-size: 16px;
            font-weight: 500;
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
        }

        input[type="text"]:focus, input[type="password"]:focus {
            border-color: rgba(255, 154, 158, 0.8);
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 5px rgba(255, 154, 158, 0.3), 0 15px 35px rgba(0, 0, 0, 0.1);
            outline: none;
            transform: translateY(-4px) scale(1.03);
        }

        input[type="text"]:hover, input[type="password"]:hover {
            border-color: rgba(255, 255, 255, 0.6);
            background: rgba(255, 255, 255, 0.25);
            transform: translateY(-2px) scale(1.01);
        }

        button {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.85), rgba(67, 160, 71, 0.85));
            color: white;
            padding: 20px 30px;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            font-size: 18px;
            width: 100%;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.3);
            transition: all 0.5s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            box-shadow: 0 10px 30px rgba(76, 175, 80, 0.4);
            position: relative;
            overflow: hidden;
            animation: button-breath 5s infinite;
        }

        @keyframes button-breath {
            0%, 100% {
                box-shadow: 0 10px 30px rgba(76, 175, 80, 0.4);
                transform: scale(1);
            }
            50% {
                box-shadow: 0 10px 30px rgba(76, 175, 80, 0.7), 0 0 40px rgba(76, 175, 80, 0.5);
                transform: scale(1.01);
            }
        }

        button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.5), transparent);
            transition: left 0.7s;
        }

        button:hover::before {
            left: 100%;
        }

        button:hover {
            background: linear-gradient(135deg, rgba(76, 175, 80, 1), rgba(67, 160, 71, 1));
            box-shadow: 0 15px 45px rgba(76, 175, 80, 0.6), 0 0 50px rgba(76, 175, 80, 0.4);
            transform: translateY(-4px) scale(1.05);
        }

        button:active {
            transform: translateY(-1px) scale(1.02);
            box-shadow: 0 8px 20px rgba(76, 175, 80, 0.4);
        }

        .login-link {
            margin-top: 30px;
            font-size: 16px;
            animation: link-float 1s ease-out 0.8s both;
        }

        @keyframes link-float {
            0% { opacity: 0; transform: translateY(15px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        .login-link a {
            color: rgba(255, 255, 255, 0.95);
            text-decoration: none;
            font-weight: 600;
            text-shadow: 0 2px 4px rgba(0, 0, 0, 0.3);
            transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
            position: relative;
            display: inline-block;
        }

        .login-link a::before {
            content: '';
            position: absolute;
            width: 0;
            height: 3px;
            bottom: -4px;
            left: 50%;
            background: linear-gradient(90deg, #ff9a9e, #667eea);
            transition: all 0.4s ease;
            transform: translateX(-50%);
            border-radius: 2px;
        }

        .login-link a::after {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 0;
            height: 0;
            background: radial-gradient(circle, rgba(255, 255, 255, 0.3), transparent);
            transition: all 0.4s ease;
            transform: translate(-50%, -50%);
            border-radius: 50%;
        }

        .login-link a:hover::before {
            width: 120%;
        }

        .login-link a:hover::after {
            width: 100px;
            height: 100px;
        }

        .login-link a:hover {
            color: #ffffff;
            text-decoration: none;
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.8);
            transform: translateY(-3px) scale(1.05);
        }
    </style>
</head>
<body>

<div class="registration-container">
    <h2>Реєстрація нового користувача</h2>

    @if(error != null)
        <p class="error-message">${error}</p>
    @endif

    <form id="registrationForm" action="/api/register" method="post">
        <div>
            <label for="username">Ім'я користувача:</label>
            <input type="text" id="username" name="username" required>
        </div>
        <div>
            <label for="password">Пароль:</label>
            <input type="password" id="password" name="password" required>
        </div>
        <div>
            <button type="submit">Зареєструватися</button>
        </div>
    </form>
    <div class="login-link">
        Вже маєте обліковий запис? <a href="/login">Увійти</a>
    </div>
</div>
</body>
</html>