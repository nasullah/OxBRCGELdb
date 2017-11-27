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
    @page {
        size: 11in 8.8in;  /* width height */
        margin-bottom: 60px;
    }

    </style>
</head>

<body>

<table width="100%">
    <tr>
        <td><rendering:inlineJpeg bytes="${ochre}" height="50px"/></td>
        <td>
            <center><span style="font-size: 9pt">GEL POST SAMPLING TISSUE WORKSHEET</span></center>
            <center><span style="font-size: 8pt">All tissues except Prostate - V9</span></center>
        </td>
        <td><rendering:inlineJpeg bytes="${orb}" height="50px"/></td>
        <td><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
    </tr>
</table>

<p><u><span style="font-weight: bold;font-size: 10pt">SECTION 1</span></u></p>

<center><span style="font-size: 8pt" >Histology number………………………	GEL ID………${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}}…………	   Patient initials....${form?.givenName?.toString()?.getAt(0)} ${form?.familyName?.toString()?.getAt(0)}..........     Alternative study ID……………… </span></center>

<p>

    <span style="font-size: 8pt" >Tumour type …………………………………………… Specimen collected from theatres by (initials) ……………………… On (date) ………………………………………………… at (time) …………………</span><br/>

    <span style="font-size: 8pt" >Name of surgeon ………………………………………………… Location of theatres    JR / WW / CH / NOC	Transported to JR:  on foot / on bicycle / by scooter / other ……………………………………………</span>

</p>

<p><span style="font-weight: bold;font-size: 10pt"><u>SECTION 1 (ctd): TISSUE ISCHAEMIA</u></span><span style="font-size: 8pt" >(warm ischemia: organ/tissue isolated in the body; cold ischemia: organ/tissue removed from body):</span></p>

<table border="0.1" style="font-size: 8pt" width="100%">
    <tr>
        <th width="10%"></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt"> Time start</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Time end</span></th>
        <th width="20%"><span style="font-weight: normal;font-size: 8pt">Period in minutes (circle appropriate)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Recorded by</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Was specimen transported on ice? (circle appropriate)</span></th>
    </tr>
    <tr>
        <td>Warm ischaemia</td>
        <td></td>
        <td></td>
        <td>&lt;2	&#160; 2-10	&#160; 20-30	&#160; 30-60	&#160;&#160; &gt;60	&#160; Unknown</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>Cold ischaemia</td>
        <td></td>
        <td></td>
        <td>&lt;2	&#160; 2-10	&#160; 20-30	&#160; 30-60	&#160;&#160;  60-120	&#160;&#160; &gt;120 &#160;&#160; Unknown</td>
        <td></td>
        <td>Yes &#160; &#160; &#160;No</td>
    </tr>
</table>

<br/>

<span style="font-weight: bold;font-size: 8pt">Date &amp; time specimen sliced/opened </span><br/>

<span style="font-size: 10pt">Collection Comments:.............................................................................................................................................. </span><br/>

<span style="font-size: 10pt">Specimen left in fridge:...........Yes / No...............   Time:................................ </span><br/>

<table>
    <tr>
        <td><span style="font-size: 10pt; color: rgba(0, 0, 0, 0.11)">&#160; &#160;  &#160;  &#160; &#160; &#160;  &#160; &#160; &#160; &#160; &#160; &#160;&#160; &#160;  &#160;  &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160; &#160;  &#160;  &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160; &#160;  &#160;  &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160; &#160;  &#160;  &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;&#160; &#160;  &#160;  &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;</span></td>
        <td>
            <table style="font-size: 10pt">
                <tr>
                    <th> <span style="font-weight: normal;font-size: 8pt">Worksheet scanned:</span></th>
                </tr>

                <tr>
                    <td><span style="font-weight: normal;font-size: 8pt">By:</span></td>
                    <td><span style="font-weight: normal;font-size: 8pt">Date:</span></td>

                </tr>
            </table>
        </td>
    </tr>

</table>


<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 2: FROZEN TISSUE</u> </span></p>

<p></p>

<table border="1" width="100%">

    <tr>
        <th width="65%"><span style="font-weight: bold;font-size: 7pt">To be completed by biobanker at time of sampling</span></th>
        <th width="35%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 7pt">To be completed by ORB / NDS team</span></th>

    </tr>

</table>

<table border="1" width="100%">

    <tr>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th width="20%"><span style="font-weight: normal;font-size: 7pt">Full unique ID Sapphire / biobank ID/ barcode</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Inking colour if appl.</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Co-location FFPE block ref</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Assessment not possible – FS required</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Storage Location Freezer, tower, box, position</span></th>
        <th width="5%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Punch weight mg</span></th>
        <th width="5%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide prepared by</span></th>
        <th width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide prepared on</span></th>
        <th width="5%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide scanned by</span></th>
        <th width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide scanned on</span></th>


    </tr>
    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">1</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>


    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">2</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">3</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">4</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">5</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt">6</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>
</table>


<div class='header'></div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (all tissues except Prostate)</span></td>
            <td width="30%"><span style="font-size: 7pt">Page 1 of 2</span></td>
            <td width="30%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
        </tr>
    </table>
</div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (all tissues except Prostate)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 2 of 2</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>
<div class='content'></div>

<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 3 : TUMOUR CONTENT ASSESSMENT</u> &#160;&#160;&#160;&#160;&#160;&#160;</span><span style="font-size: 10pt"> Frozen section:................................</span></p>

<p><span style="font-size: 10pt">&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160; Mirror block:................................ </span></p>


<table border="1" width="100%">

    <tr>
        <th width="25%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 7pt">ORB/ NDS tech team</span></th>
        <th width="75%"><span style="font-weight: bold;font-size: 7pt">Slide marking (To be completed by pathologist)</span></th>

    </tr>

</table>

<table border="1" width="100%">

    <tr>
        <th width="5%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">&#160;</span></th>
        <th width="20%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Frozen tissue slide ID (1)</span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">By initials</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">On date</span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">With frozen section</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">% tumour (2)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">% necrosis (3) </span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">Cellularity (4)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Non-invasive neoplastic elements (5)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">GeL suitability (circle)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Ranking (Tick priority punch )</span></th>


    </tr>
    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">1</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A &#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;E<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>


    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">2</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A &#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;E<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">3</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A &#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;E<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">4</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A &#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;E<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>
</table>


<p></p>


<span style="font-weight: bold; font-size: 8pt">(1) Frozen slide ID: </span><span style="font-size: 8pt">GELxxx last 4/6 digits of unique ID </span><br/>

<span style="font-weight: bold; font-size: 8pt">(2) Tumour content </span><span style="font-size: 8pt">of sample defined as number of viable invasive tumour cells / total number of viable cells present in marked area, to nearest 5%;</span><br/>

<span style="font-weight: bold; font-size: 8pt">(3) Percentage necrosis </span><span style="font-size: 8pt">present in marked area, by surface area</span><br/>

<span style="font-weight: bold; font-size: 8pt">(4) Tumour sample cellularity: </span><span style="font-size: 8pt">A - Very low (&lt;700); B - Low (&lt;4000); C - Medium (4000-10000); D - High (&gt;10000); E - Very High (&gt;50000); F – Unknown.</span><br/>

<span style="font-weight: bold; font-size: 8pt">(5) Non-invasive neoplastic elements </span><span style="font-size: 8pt">present in the sample (please specify) eg PIN, DCIS, or none. </span>


<p>

<span style="font-size: 10pt">Pathologist comments:.............................................................................................................................................. </span><br/>

<span style="font-size: 10pt">..................................................................................................................................................................................... </span><br/>

</p>

</body>
</html>