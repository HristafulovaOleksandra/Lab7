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
@param String searchQuery

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Список студентів</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;600&display=swap');

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Roboto', sans-serif;
            background: linear-gradient(-45deg, #667eea, #764ba2, #f093fb, #f5576c, #4facfe, #00f2fe);
            background-size: 400% 400%;
            animation: gradientFlow 20s ease infinite;
            min-height: 100vh;
            position: relative;
            overflow-x: auto;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                    radial-gradient(circle at 25% 25%, rgba(255,255,255,0.1) 0%, transparent 50%),
                    radial-gradient(circle at 75% 75%, rgba(255,255,255,0.05) 0%, transparent 50%);
            animation: floatingBubbles 25s ease-in-out infinite;
            pointer-events: none;
            z-index: 0;
        }

        @keyframes gradientFlow {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        @keyframes floatingBubbles {
            0%, 100% { transform: translateY(0px) rotate(0deg); }
            33% { transform: translateY(-15px) rotate(1deg); }
            66% { transform: translateY(-8px) rotate(-0.5deg); }
        }

        @keyframes slideInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.9);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        @keyframes tableRowAppear {
            from {
                opacity: 0;
                transform: translateX(-20px);
            }
            to {
                opacity: 1;
                transform: translateX(0);
            }
        }

        .container {
            max-width: 1200px;
            margin: 20px auto;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            padding: 30px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            box-shadow:
                    0 8px 32px rgba(0, 0, 0, 0.1),
                    inset 0 2px 0 rgba(255, 255, 255, 0.1);
            animation: scaleIn 0.8s ease-out;
            position: relative;
            z-index: 1;
        }

        .container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: linear-gradient(45deg, rgba(255,255,255,0.1), transparent, rgba(255,255,255,0.1));
            border-radius: 20px;
            z-index: -1;
            animation: borderShimmer 3s ease-in-out infinite;
        }

        @keyframes borderShimmer {
            0%, 100% { opacity: 0.3; }
            50% { opacity: 0.8; }
        }

        h1 {
            text-align: center;
            color: rgba(255, 255, 255, 0.95);
            margin-bottom: 35px;
            font-weight: 400;
            font-size: 32px;
            text-shadow: 0 2px 20px rgba(0, 0, 0, 0.2);
            animation: slideInDown 0.8s ease-out;
        }

        .logout-container {
            text-align: right;
            margin-bottom: 20px;
            animation: slideInDown 0.8s ease-out 0.1s both;
        }

        .logout-button {
            background: linear-gradient(135deg, rgba(244, 67, 54, 0.8), rgba(211, 47, 47, 0.9));
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .logout-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .logout-button:hover::before {
            left: 100%;
        }

        .logout-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(244, 67, 54, 0.4);
        }

        .action-buttons {
            margin-bottom: 25px;
            display: flex;
            gap: 15px;
            flex-wrap: wrap;
            justify-content: space-between;
            align-items: center;
            animation: slideInUp 0.8s ease-out 0.2s both;
        }

        .action-buttons .left-side-buttons,
        .action-buttons .right-side-search {
            display: flex;
            gap: 15px;
            align-items: center;
            flex-wrap: wrap;
        }

        .add-button {
            background: linear-gradient(135deg, rgba(76, 175, 80, 0.8), rgba(67, 160, 71, 0.9));
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .add-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s;
        }

        .add-button:hover::before {
            left: 100%;
        }

        .add-button:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(76, 175, 80, 0.4);
        }

        .edit-button, .delete-button {
            padding: 10px 15px;
            border: none;
            border-radius: 10px;
            text-decoration: none;
            font-size: 14px;
            margin-right: 8px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .edit-button {
            background: linear-gradient(135deg, rgba(33, 150, 243, 0.8), rgba(25, 118, 210, 0.9));
            color: white;
            box-shadow: 0 3px 12px rgba(33, 150, 243, 0.3);
        }

        .edit-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 18px rgba(33, 150, 243, 0.4);
        }

        .delete-button {
            background: linear-gradient(135deg, rgba(244, 67, 54, 0.8), rgba(211, 47, 47, 0.9));
            color: white;
            box-shadow: 0 3px 12px rgba(244, 67, 54, 0.3);
        }

        .delete-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 18px rgba(244, 67, 54, 0.4);
        }

        .edit-button::before, .delete-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .edit-button:hover::before, .delete-button:hover::before {
            left: 100%;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-top: 25px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
            animation: scaleIn 0.8s ease-out 0.3s both;
        }

        th, td {
            padding: 15px 20px;
            text-align: left;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        th {
            background: linear-gradient(135deg, rgba(63, 81, 181, 0.6), rgba(48, 63, 159, 0.7));
            color: rgba(255, 255, 255, 0.95);
            font-weight: 500;
            text-transform: uppercase;
            font-size: 14px;
            letter-spacing: 0.5px;
            text-shadow: 0 1px 3px rgba(0, 0, 0, 0.3);
        }

        td {
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            background: rgba(255, 255, 255, 0.02);
            transition: all 0.3s ease;
        }

        tbody tr {
            animation: tableRowAppear 0.6s ease-out both;
            transition: all 0.3s ease;
        }

        tbody tr:nth-child(1) { animation-delay: 0.1s; }
        tbody tr:nth-child(2) { animation-delay: 0.2s; }
        tbody tr:nth-child(3) { animation-delay: 0.3s; }
        tbody tr:nth-child(4) { animation-delay: 0.4s; }
        tbody tr:nth-child(5) { animation-delay: 0.5s; }

        tbody tr:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: scale(1.01);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
        }

        .success-message {
            background: linear-gradient(135deg, rgba(232, 245, 233, 0.9), rgba(200, 230, 201, 0.9));
            color: #2e7d32;
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(76, 175, 80, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(76, 175, 80, 0.3);
            animation: slideInDown 0.6s ease-out;
        }

        .error-message {
            background: linear-gradient(135deg, rgba(255, 235, 238, 0.9), rgba(255, 205, 210, 0.9));
            color: #c62828;
            padding: 15px 20px;
            border-radius: 12px;
            font-weight: 500;
            margin-bottom: 25px;
            box-shadow: 0 4px 15px rgba(244, 67, 54, 0.2);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(244, 67, 54, 0.3);
            animation: slideInDown 0.6s ease-out;
        }

        .grades-section {
            margin-top: 35px;
            padding-top: 25px;
            border-top: 1px solid rgba(255, 255, 255, 0.2);
            animation: slideInUp 0.8s ease-out 0.5s both;
        }

        .grades-section h3 {
            margin-bottom: 20px;
            color: rgba(255, 255, 255, 0.95);
            font-weight: 500;
            font-size: 20px;
        }

        .grade-item {
            margin-bottom: 10px;
            font-size: 16px;
            color: rgba(255, 255, 255, 0.8);
            padding: 8px 0;
            transition: all 0.3s ease;
        }

        .grade-item:hover {
            color: rgba(255, 255, 255, 1);
            transform: translateX(5px);
        }

        .sort-buttons {
            margin-bottom: 25px;
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
        }

        .sort-buttons a {
            background: linear-gradient(135deg, rgba(63, 81, 181, 0.8), rgba(48, 63, 159, 0.9));
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            text-decoration: none;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(63, 81, 181, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .sort-buttons a::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .sort-buttons a:hover::before {
            left: 100%;
        }

        .sort-buttons a:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(63, 81, 181, 0.4);
        }

        .search-form {
            display: flex;
            gap: 12px;
            flex-grow: 1;
        }

        .search-form input[type="text"] {
            padding: 12px 18px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            flex-grow: 1;
            background: rgba(255, 255, 255, 0.1);
            color: rgba(255, 255, 255, 0.9);
            backdrop-filter: blur(10px);
            transition: all 0.4s ease;
            font-size: 14px;
        }

        .search-form input[type="text"]::placeholder {
            color: rgba(255, 255, 255, 0.6);
        }

        .search-form input[type="text"]:focus {
            border-color: rgba(255, 255, 255, 0.4);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.1);
            outline: none;
            background: rgba(255, 255, 255, 0.15);
        }

        .search-form button {
            background: linear-gradient(135deg, rgba(117, 117, 117, 0.8), rgba(97, 97, 97, 0.9));
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 12px;
            cursor: pointer;
            font-size: 14px;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 15px rgba(117, 117, 117, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .search-form button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.5s;
        }

        .search-form button:hover::before {
            left: 100%;
        }

        .search-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(117, 117, 117, 0.4);
        }

        @media (max-width: 768px) {
            .container {
                margin: 10px;
                padding: 20px;
            }

            .action-buttons {
                flex-direction: column;
                align-items: stretch;
            }

            .action-buttons .left-side-buttons,
            .action-buttons .right-side-search {
                justify-content: center;
            }

            table {
                font-size: 12px;
            }

            th, td {
                padding: 10px;
            }
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

    <div class="action-buttons">
        <div class="left-side-buttons">
            @if(isAdmin)
                <a href="/students/create" class="add-button">Додати нового студента</a>
                <a href="/grades/add" class="add-button">Додати оцінку</a>
            @endif
        </div>
        <div class="right-side-search">
            <form action="/students" method="get" class="search-form">
                <input type="text" name="searchQuery" placeholder="Пошук за ім'ям..." value="${searchQuery != null ? searchQuery : ""}">
                <button type="submit">Знайти</button>
                <a href="/students" class="add-button" style="background-color: #f0ad4e;">Скинути</a>
            </form>
        </div>
    </div>

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
