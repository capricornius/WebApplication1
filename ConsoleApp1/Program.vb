Imports System
Imports System.Data.SqlClient

Module Program
    Sub Main(args As String())

        Console.WriteLine("Hello World!")

        Dim builder As New System.Text.StringBuilder
        Dim str = "I am  a man"
        Dim strNew = ""
        Dim cant = str.Length()

        For index = 1 To cant
            strNew &= str.Substring(cant - index, 1)
            'The StringBuilder class is more efficient than the &= operator for concatenating many strings.
            'Reference: https://docs.microsoft.com/en-us/dotnet/visual-basic/programming-guide/language-features/strings/how-to-create-strings-using-a-stringbuilder
            builder.Append(str.Substring(cant - index, 1))
        Next

        Console.WriteLine(builder.ToString)
        Console.WriteLine(strNew)

        Using cnn As New SqlConnection("Server=myServerName\myInstanceName;Database=myDataBase;User Id=myUsername;Password=myPassword;")
            Dim query As String = "Select * from Table"
            Dim cmd As New SqlCommand(query, cnn)

            Try
                cmd.Connection.Open()
                cmd.ExecuteNonQuery()

            Catch exSql As SqlException
                Dim errorMsj As String
                errorMsj = "SQL Error: " + exSql.Message

                If exSql.InnerException IsNot Nothing Then
                    errorMsj &= "Inner: " + exSql.InnerException.Message
                End If
                Console.WriteLine(errorMsj)

            Catch ex As Exception
                Dim errorMsj As String
                errorMsj = "Error: " + ex.Message

                If ex.InnerException IsNot Nothing Then
                    errorMsj &= "Inner: " + ex.InnerException.Message
                End If
                Console.WriteLine(errorMsj)
            End Try
        End Using
    End Sub
End Module
