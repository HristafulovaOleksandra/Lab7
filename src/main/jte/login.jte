@param String error
@param String logout
@param String registrationSuccess

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Увійти</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-container { background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 300px; text-align: center; }
        h2 { color: #333; margin-bottom: 20px; }
        .message-container { margin-bottom: 15px; padding: 10px; border-radius: 5px; font-weight: bold; }
        .error-message { background-color: #ffebee; color: red; }
        .logout-message { background-color: #e8f5e9; color: green; }
        .success-message { background-color: #e6ffed; color: #28a745; } /* Новий стиль для успішного повідомлення */
        label { display: block; text-align: left; margin-bottom: 5px; color: #555; }
        input[type="text"], input[type="password"] { width: calc(100% - 22px); padding: 10px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; width: 100%; }
        button:hover { background-color: #0056b3; }
        .register-link { margin-top: 15px; font-size: 14px; }
        .register-link a { color: #007bff; text-decoration: none; }
        .register-link a:hover { text-decoration: underline; }
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