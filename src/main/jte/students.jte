@import com.example.Lab7.data.Student
@import java.util.List
@param List<Student> students

<!DOCTYPE html>
<html>
<head>
    <title>Список студентів</title>
</head>
<body>
<h1>Список студентів</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Ім'я</th>
    </tr>
    @for (Student student : students)
    <tr>
        <td>${student.getId()}</td>
        <td>${student.getName()}</td>
    </tr>
    @endfor
</table>
</body>
</html>
