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
        body { font-family: Arial, sans-serif; background-color: #f4f4f4; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .form-container { background-color: #fff; padding: 25px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 400px; }
        h2 { text-align: center; color: #333; margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; color: #555; font-weight: bold; }
        input[type="text"], input[type="email"] {
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