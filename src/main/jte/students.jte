@import com.example.Lab7.data.Student
@param java.util.List<Student> students
@param String successMessage

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Список студентів</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 800px; margin: 0 auto; }
        h1 { text-align: center; color: #333; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .logout-container { text-align: right; margin-bottom: 10px; }
        .logout-button {
            background-color: #dc3545;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }
        .logout-button:hover {
            background-color: #c82333;
        }
        .add-grade-button {
            background-color: #28a745;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            margin-top: 10px;
            display: inline-block;
            margin-bottom: 20px;
        }
        .add-grade-button:hover {
            background-color: #218838;
        }
        .success-message {
            background-color: #e6ffed;
            color: #28a745;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .grades-section { margin-top: 30px; }
        .grades-section h3 { margin-bottom: 10px; }
        .grade-item { margin-bottom: 5px; font-size: 0.9em; color: #555; }
    </style>
</head>
<body>
<div class="container">
    <div class="logout-container">
        <form action="/logout" method="post">
            <button type="submit" class="logout-button">Вийти</button>
        </form>
    </div>
    <h1>Список Студентів</h1>

    @if(successMessage != null)
        <div class="success-message">${successMessage}</div>
    @endif

    <a href="/grades/add" class="add-grade-button">Додати оцінку</a>

    @if(students.isEmpty())
        <p>Немає зареєстрованих студентів.</p>
    @else
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Ім'я</th>
                <th>Імейл</th>
                <th>Оцінки</th> </tr>
            </thead>
            <tbody>
            @for(Student student : students)
                <tr>
                    <td>${student.getId()}</td>
                    <td>${student.getName()}</td>
                    <td>${student.getEmail()}</td>
                    <td>
                        @if(student.getGrades() != null && !student.getGrades().isEmpty())
                            <ul>
                                @for(com.example.Lab7.data.Grade grade : student.getGrades())
                                    <li>${grade.getSubject()}: ${grade.getScore()}</li>
                                @endfor
                            </ul>
                        @else
                            <p>Немає оцінок</p>
                        @endif
                    </td>
                </tr>
            @endfor
            </tbody>
        </table>
    @endif
</div>
</body>
</html>