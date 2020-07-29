<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Calculator.aspx.vb" Inherits="WebApplication1.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk" crossorigin="anonymous"/>
    <title>Calculator Test</title>
    <style type="text/css">
        .myheight {
           height: 28px;
        }
    </style>
</head>
<body>
    <table>
        <tr>
            <td id="sum" colspan="3" class="myheight"></td>
             <td class="auto-style1" ></td>
             <td class="auto-style1"></td>
        </tr>
         <tr>
            <td colspan="3"><input id="textBox" /></td>
             <td class="" id="result"></td>
             <td></td>
        </tr>
        <tr>
            <td><button type="button" id="btnNumber">1</button></td>
            <td><button type="button" id="btnNumber">2</button></td>
            <td><button type="button" id="btnNumber">3</button></td>
            <td><button type="button" id="btnOperator">+</button></td>
        </tr>                               
         <tr>                               
            <td><button type="button" id="btnNumber">4</button></td>
            <td><button type="button" id="btnNumber">5</button></td>
            <td><button type="button" id="btnNumber">6</button></td>
            <td><button type="button" id="btnOperator">-</button></td>
        </tr>                               
         <tr>                               
            <td><button type="button" id="btnNumber">7</button></td>
            <td><button type="button" id="btnNumber">8</button></td>
            <td><button type="button" id="btnNumber">9</button></td>
            <td><button type="button" id="btnOperator">x</button></td>                                          
        </tr>                             
         <tr>                             
            <td><button type="button" id="btn">.</button></td>
            <td><button type="button" id="btnNumber">0</button></td>
            <td><button type="button" id="btnCalc">=</button></td>
            <td><button type="button" id="btnOperator">/</button></td>
        </tr>
    </table>
    <p>
</body>
</html>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>
        //globals variables
    var value1;
    var value2;
    var operator;
    $(document).ready(function () {
        //$("#btnCalc").prop('disabled', true); 
        $('button[id^="btnNumber"]').click(function () {    //the same fuctions for all numbers. Get value from text onClick event
            var strBtn = $(this).text();
            populateTextBox(strBtn);
        });
        $('button[id^="btnOperator"]').click(function () {
            //if there is 2 digit is necesary parse convert in the
            operator = $(this).text();
            ParseStr(getTextBox());
            cleanTextBox();
            //populateTextBox(strBtn);
        });
        $('#btnCalc').click(function () {
           // debugger;
            var str = getTextBox();
            if ($.trim(str) != "") {
                $("#result").addClass('spinner-border');
                $.when(ParseStr(str)).done(function () {
                    $("#result").removeClass('spinner-border');
                    $("#result").text(calc());
                    reset();
                });
                //reset();
            } else {
                alert("Set Number");
            }
            
        });
    });

    function getTextBox() {                 //functions tu management textBox
        return $("#textBox").val();
    }
    function populateTextBox(text) {
        $("#textBox").val(getTextBox() + text);
    }
    function cleanTextBox() {
        $("#textBox").val("");
    }
    function reset() {
        $("#sum").text("");
        cleanTextBox();
        value1 = null;
        value2 = null;
        operator = null;
    }
    function calc() {
        var result;
        //debugger;
        switch (operator) {
            case "+":
                result = value1 + value2;
                break;
            case "-":
                result = value1 - value2;
                break;
            case "x":
                result = value1 * value2;
                break;
            case "/":
                result = value1 / value2;
                break;
        }
        return result;
    }
</script>

 <script type = "text/javascript">
     function ParseStr(numberStr) {
         return $.ajax({
             type: "POST",
             url: "Calculator.aspx/ParseStr",
             data: '{numberStr: "'+numberStr+'" }',
             contentType: "application/json; charset=utf-8",
             dataType: "json",
             success: OnSuccess,
             error: function (response) {
                 //debugger;
                 alert(response.responseText);
             }
         });
     }

     function OnSuccess(response) {
         //debugger;                        //to see values on run Time
         if (value1 == null) {
             value1 = response.d;
             $("#sum").text(value1 + operator);
         } else {
             value2 = response.d;
         }
     }
 </script>