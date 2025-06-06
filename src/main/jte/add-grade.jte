@param java.util.List<com.example.Lab7.data.Student> students
@param String error

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Додати оцінку</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .add-grade-container { background-color: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 400px; text-align: center; }
        h2 { color: #333; margin-bottom: 20px; }
        label { display: block; text-align: left; margin-bottom: 5px; color: #555; }
        input[type="text"], input[type="number"], select { width: calc(100% - 22px); padding: 10px; margin-bottom: 15px; border: 1px solid #ddd; border-radius: 4px; }
        button { background-color: #007bff; color: white; padding: 10px 15px; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; width: 100%; }
        button:hover { background-color: #0056b3; }
        .back-link { margin-top: 15px; font-size: 14px; }
        .back-link a { color: #007bff; text-decoration: none; }
        .back-link a:hover { text-decoration: underline; }
    </style>
</head>
<body>
<div class="add-grade-container">
    <h2>Додати нову оцінку</h2>

    @if(error != null)
        <p style="color: red;">${error}</p>
    @endif

    <form action="/grades/add" method="post">
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
    <div class="back-link">
        <a href="/students">Повернутися до списку студентів</a>
    </div>
</div>
</body>
</html>