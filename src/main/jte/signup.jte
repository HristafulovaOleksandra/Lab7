@param String error

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Реєстрація</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .registration-container { background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        h2 { color: #333; margin-bottom: 20px; }
        .error-message { color: red; margin-bottom: 15px; }
        label { display: block; text-align: left; margin-bottom: 5px; color: #555; }
        input[type="text"], input[type="password"] { width: calc(100% - 22px); padding: 10px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #28a745; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; width: 100%; }
        button:hover { background-color: #218838; }
        .login-link { margin-top: 15px; font-size: 14px; }
        .login-link a { color: #007bff; text-decoration: none; }
        .login-link a:hover { text-decoration: underline; }
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