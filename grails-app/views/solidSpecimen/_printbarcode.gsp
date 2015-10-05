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
    <span style="font-weight: bold">Position and Barcode List</span>
    <table style="width:100%">
        <tr>
            <td width="10%" style="font-weight: bold; font-size: 10pt"><center>Positions</center></td>
            <td width="15%" style="font-weight: bold; font-size: 10pt"><center>Barcode Data</center></td>
            <td width="10%" style="font-weight: bold; font-size: 10pt">GEL ID</td>
            <td width="15%" style="font-weight: bold; font-size: 10pt"><center>Date Collected</center></td>
            <td width="10%" style="font-weight: bold; font-size: 10pt"><center>Location</center></td>
            <td width="40%" style="font-weight: bold; font-size: 10pt"><center>Barcode</center></td>

        </tr>
    </table>
</div>

<table  style="width:100%" border="1">
    <g:each status="i" in="${fileList}" var="file">
        <tr>
            <td width="10%" height="75">${positionList[i]}</td>
            <td width="10%" height="75">${barcodeList[i]}</td>
            <td width="10%" height="75"></td>
            <td width="20%" height="75"></td>
            <td width="10%" height="75"></td>
            <td width="40%" height="75"><center><rendering:inlineJpeg bytes="${file.bytes}" height="30px"/></center></td>

        </tr>
    </g:each>
</table>

<p></p>


</body>
</html>