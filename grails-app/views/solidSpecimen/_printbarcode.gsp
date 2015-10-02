<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <style>
    div.header {
        display: block; text-align: center;
        position: running(header);
    }
    div.footer {
        display: block; text-align: center;
        position: running(footer);
    }
    div.content {page-break-after: always;}
    @page {
        @top-center { content: element(header) }
    }
    @page {
        @bottom-center { content: element(footer) }
    }

    </style>
</head>
<body>
<div class='header'>
    <p style="font-weight: bold">Position and Barcode List</p>
</div>

<table  style="width:100%">
    <tr>
        <td width="20%" style="font-weight: bold; font-size: 10pt">Positions</td>
        <td width="40%" style="font-weight: bold; font-size: 10pt">Barcode Data</td>
        <td width="40%" style="font-weight: bold; font-size: 10pt">Barcode</td>

    </tr>
    <g:each status="i" in="${fileList}" var="file">
        <tr>
            <td width="20%" height="50">${positionList[i]}</td>
            <td width="40%" height="50">${barcodeList[i]}</td>
            <td width="40%" height="50"><rendering:inlineJpeg bytes="${file.bytes}" height="30px"/></td>

        </tr>
    </g:each>
</table>

<p></p>


<div class='footer'>
    <table width="100%">
        <tr>

        </tr>
    </table>
</div>

<div class='content'></div>

</body>
</html>