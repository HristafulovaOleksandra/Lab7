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
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .form-container { background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 400px; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: bold; }
        input[type="text"], input[type="number"], select {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        button { background-color: #28a745; color: white; padding: 12px 20px; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; width: 100%; transition: background-color 0.3s ease; }
        button:hover { background-color: #218838; }
        .back-link { display: block; text-align: center; margin-top: 20px; color: #007bff; text-decoration: none; }
        .back-link:hover { text-decoration: underline; }
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