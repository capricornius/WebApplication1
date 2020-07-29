Public Class WebForm1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

    End Sub

    <System.Web.Services.WebMethod()>
    Public Shared Function ParseStr(ByVal numberStr As String) As Int32
        Dim number As Int32

        If Not String.IsNullOrEmpty(numberStr) Then
            Try
                number = Convert.ToInt32(numberStr)

            Catch ex As FormatException
                Throw New Exception("Need pass only numbers")
            Catch ex As Exception
                Return Nothing

            End Try
         End If

        Return number

    End Function

End Class

