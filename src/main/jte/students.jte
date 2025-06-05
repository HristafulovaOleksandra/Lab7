@import com.example.Lab7.data.Student
@param java.util.List<Student> students

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

    @if(students.isEmpty())
        <p>Немає зареєстрованих студентів.</p>
    @else
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Ім'я</th>
                <th>Імейл</th>
            </tr>
            </thead>
            <tbody>
            @for(Student student : students)
                <tr>
                    <td>${student.getId()}</td>
                    <td>${student.getName()}</td>
                    <td>${student.getEmail()}</td>
                </tr>
            @endfor
            </tbody>
        </table>
    @endif
</div>
</body>
</html>