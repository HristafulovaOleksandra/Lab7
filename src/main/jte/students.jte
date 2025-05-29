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
<ul>
    @for (Student student : students){
        <tr>
            <td>@student.getName()</td>
            <td>@student.getId()</td>
        </tr>}
    @endfor
    }</ul>
</body>
</html>