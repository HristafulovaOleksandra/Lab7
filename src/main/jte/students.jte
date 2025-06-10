@import com.example.Lab7.data.Student
@import org.springframework.security.core.context.SecurityContextHolder
@import org.springframework.security.core.Authentication
@import org.springframework.security.core.authority.SimpleGrantedAuthority
@import org.springframework.security.web.csrf.CsrfToken

@param java.util.List<Student> students
@param String successMessage
@param String errorMessage
@param boolean isAdmin
@param org.springframework.security.web.csrf.CsrfToken _csrf

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Список студентів</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .container { max-width: 1000px; margin: 0 auto; }
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
        .add-button {
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
        .add-button:hover {
            background-color: #218838;
        }
        .edit-button, .delete-button {
            padding: 5px 10px;
            border: none;
            border-radius: 3px;
            text-decoration: none;
            font-size: 14px;
            margin-right: 5px;
        }
        .edit-button {
            background-color: #007bff;
            color: white;
        }
        .edit-button:hover {
            background-color: #0056b3;
        }
        .delete-button {
            background-color: #dc3545;
            color: white;
        }
        .delete-button:hover {
            background-color: #c82333;
        }
        .success-message {
            background-color: #e6ffed;
            color: #28a745;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .error-message {
            background-color: #ffebee;
            color: red;
            padding: 10px;
            border-radius: 5px;
            font-weight: bold;
            margin-bottom: 15px;
        }
        .grades-section { margin-top: 30px; }
        .grades-section h3 { margin-bottom: 10px; }
        .grade-item { margin-bottom: 5px; font-size: 0.9em; color: #555; }
        .sort-buttons {
            margin-bottom: 15px;
            display: flex;
            gap: 10px;
        }
        .sort-buttons a {
            background-color: #007bff;
            color: white;
            padding: 8px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
        }
        .sort-buttons a:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="logout-container">
        <form action="/logout" method="post">
            <input type="hidden" name="${_csrf.getParameterName()}" value="${_csrf.getToken()}"/>
            <button type="submit" class="logout-button">Вийти</button>
        </form>
    </div>
    <h1>Список Студентів</h1>

    @if(successMessage != null)
        <div class="success-message">${successMessage}</div>
    @endif
    @if(errorMessage != null)
        <div class="error-message">${errorMessage}</div>
    @endif

    @if(isAdmin)
        <a href="/students/create" class="add-button">Додати нового студента</a>
        <a href="/grades/add" class="add-button">Додати оцінку</a>
    @endif

    <div class="sort-buttons">
        <a href="/students?sortBy=asc">Сортувати за ім'ям (А-Я)</a>
        <a href="/students?sortBy=desc">Сортувати за ім'ям (Я-А)</a>
    </div>

    @if(students.isEmpty())
        <p>Немає зареєстрованих студентів.</p>
    @else
        <table>
            <thead>
            <tr>
                <th>ID</th>
                <th>Ім'я</th>
                <th>Імейл</th>
                <th>Оцінки</th>
                @if(isAdmin)
                    <th>Дії</th>
                @endif
            </tr>
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
                    @if(isAdmin)
                        <td>
                            <a href="/students/${student.getId()}/edit" class="edit-button">Редагувати</a>
                            <form action="/students/${student.getId()}/delete" method="post" style="display:inline;">
                                <input type="hidden" name="${_csrf.getParameterName()}" value="${_csrf.getToken()}"/>
                                <input type="hidden" name="_method" value="DELETE"/>
                                <button type="submit" class="delete-button"
                                        onclick="return confirm('Ви впевнені, що хочете видалити цього студента?');">
                                    Видалити
                                </button>
                            </form>
                        </td>
                    @endif
                </tr>
            @endfor
            </tbody>
        </table>
    @endif
</div>
</body>
</html>