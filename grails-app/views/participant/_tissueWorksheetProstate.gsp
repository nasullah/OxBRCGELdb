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
<table width="100%" >
    <tr>
        <td><rendering:inlineJpeg bytes="${ochre}" height="50px"/></td>
        <td>
            <center><span style="font-size: 9pt">GEL POST SAMPLING TISSUE WORKSHEET</span></center>
            <center><span style="font-size: 8pt">Prostate - V3 (20170911)</span></center>
        </td>
        <td><rendering:inlineJpeg bytes="${orb}" height="50px"/></td>
        <td><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
    </tr>

</table>

<p><span style="font-weight: bold;font-size: 10pt "><u>SECTION 1:</u></span></p>

<p><center><span style="font-size: 8pt" >Histology number………………………	GEL ID………${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}}…………	   Patient initials....${form?.givenName?.toString()?.getAt(0)} ${form?.familyName?.toString()?.getAt(0)}..........     Alternative study ID……………… </span></center></p>

<span style="font-size: 8pt" >Tumour type …………………………………………… Specimen collected from theatres by (initials) ……………………… On (date) ………………………………………………… at (time) …………………</span><br/>

<span style="font-size: 8pt" >Name of surgeon ………………………………………………… Location of theatres    JR / WW / CH	Transported to JR:  on foot / on bicycle / by scooter / other ………………………………………………</span>

<p><span style="font-weight: bold;font-size: 10pt"><u>SECTION 1 (ctd): TISSUE ISCHAEMIA</u></span><span style="font-size: 8pt" >(warm ischemia: organ/tissue isolated in the body; cold ischemia: organ/tissue removed from body):</span></p>

<table border="0.1" style="font-size: 8pt" width="100%">
    <tr>
        <th width="10%"></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt"> Time start</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Time end</span></th>
        <th width="40%"><span style="font-weight: normal;font-size: 8pt">Period in minutes (circle appropriate)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Recorded by</span></th>
        <th width="20%"><span style="font-weight: normal;font-size: 8pt">Was specimen transported on ice? (circle appropriate) &#160; &#160; &#160; &#160; &#160; &#160; &#160; &#160;</span></th>
    </tr>
    <tr>
        <td>Warm ischaemia</td>
        <td></td>
        <td></td>
        <td>&lt;2	&#160; 2-10	&#160; 20-30	&#160; 30-60&#160;&#160; &gt;60	&#160; Unknown</td>
        <td></td>
        <td></td>
    </tr>
    <tr>
        <td>Cold ischaemia</td>
        <td></td>
        <td></td>
        <td>&lt;2	&#160; 2-10	&#160; 20-30	&#160; 30-60    &#160;60-120&#160; &#160; &gt;120	&#160; Unknown</td>
        <td></td>
        <td>Yes &#160; &#160; &#160;No</td>
    </tr>
</table>
<p><span style="font-weight: bold;font-size: 8pt">Date &amp; time specimen sliced/opened ...... </span></p>

<p><span style="font-size: 10pt">Collection Comments:.............................................................................................................................................. </span></p>

<p><span style="font-size: 10pt">Specimen left in fridge:...........Yes / No...............   Time:................................ </span></p>

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

<div class='header'></div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="30%"><span style="font-size: 7pt">Page 1 of 3</span></td>
            <td width="30%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
        </tr>

    </table>
</div>
<div class='content'></div>


<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 2: FROZEN TISSUE</u></span><span style="font-size: 10pt"> (include unique ID for each of the nine cores taken) - REMAINDER OF TISSUE PLACED INTO CASSETTE REF: .............</span></p>

<p></p>

<table width="100%" border="1">

    <tr>
        <th width="30%"><center><span style="font-weight: bold;font-size: 7pt">To be completed by biobanker</span></center></th>
        <th width="70%" bgcolor="#dcdcdc"><center><span style="font-weight: bold;font-size: 7pt">To be completed by ORB / NDS team</span></center></th>

    </tr>

</table>

<table border="1">

    <tr>
        <th width="15%"><span style="font-weight: normal;font-size: 7pt">Full unique ID Sapphire / biobank ID</span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">Inking colour if appl.</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Zone</span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Punch classification &#160; B or T <sup>(1)</sup></span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Ranking &#160; &#160; &#160; &#160; P, R <sup>(2)</sup></span></th>
        <th width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Punch weight mg</span></th>
        <th width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Frozen slide IDs GELxxx last 4/6 digits of unique ID + T, M, B for top, middle, bottom</span></th>
        <th width="9%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide prepared by</span></th>
        <th width="9%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">H&amp;E slide prepared on</span></th>
        <th width="9%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Slide scanned by</span></th>
        <th width="9%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Slide scanned on</span></th>


    </tr>
    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">1. Mid anterior</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>


    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">2. Right lateral</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">3. Right peripheral zone towards lateral</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">4. Right peripheral zone towards mid</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">5. Left peripheral zone towards lateral</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">6. Left Peripheral zone towards mid</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">7. Left Lateral</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">8. LTZ</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">9. RTZ</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

</table>

<p><span style="font-weight: bold; font-size: 8pt">(1)</span><span style="font-size: 8pt"> B = Benign tissue, T = Tumour</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(2)</span><span style="font-size: 8pt"> P = Priority punch for sequencing, R = Reserve punch for sequencing</span></p>

<p></p>

<div class='header'></div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 2 of 3</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>
<div class='content'></div>

<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 2 (ctd): FROZEN TISSUE SECTION MARKING</u></span></p>
<p></p>

<table border="1" width="100%">
    <tr>
        <td bgcolor="#dcdcdc" width="20%"><center><span style="font-size: 7pt; font-weight: bold;">ORB/ NDS tech team</span></center></td>
        <td width="64%"><center><span style="font-size: 7pt; font-weight: bold;">To be completed by pathologist</span></center></td>
        <td width="16%"><center><span style="font-size: 7pt; font-weight: bold;">ORB team</span></center></td>
    </tr>
</table>

<table border="1" width="100%">
    <tr>
        <td bgcolor="#dcdcdc" width="20%"><span style="font-size: 7pt"></span></td>
        <td width="64%"><center><span style="font-size: 7pt; font-weight: bold;">Slide marking</span></center></td>
        <td width="16%"><center><span style="font-size: 7pt; font-weight: bold;">Averages for selected tissue pieces (6)</span></center></td>
    </tr>
</table>

<table border="1" width="100%">

    <tr>
        <th bgcolor="#dcdcdc" width="20%"><span style="font-size: 7pt; font-weight: bold;">Frozen slide ID</span><span style="font-weight: normal;font-size: 7pt"> GELxxx last 4/6 digits of unique ID</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">By initials</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">On date</span></th>
        <th width="7%"><span style="font-weight: normal;font-size: 7pt">% tumour (1)</span></th>
        <th width="7%"><span style="font-weight: normal;font-size: 7pt">% necrosis (2) </span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Cellularity (3)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Non-invasive neoplastic elements (4)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">GeL suitability (circle)(5)</span></th>
        <th width="8%"><span style="font-weight: normal;font-size: 7pt">Average % tumour</span></th>
        <th width="8%"><span style="font-weight: normal;font-size: 7pt">Average % necrosis</span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;D<br/>B&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;E<br/>C&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">All&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>T-M&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>M-B&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;D<br/>B&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;E<br/>C&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">All&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>T-M&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>M-B&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;D<br/>B&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;E<br/>C&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">All&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>T-M&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>M-B&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T .................... M ................... B ....................</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;D<br/>B&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;E<br/>C&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">All&#160;&#160;&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>T-M&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N<br/>M-B&#160;&#160;&#160;&#160;&#160;&#160;Y&#160;&#160;&#160;&#160;&#160;&#160;N</span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>
</table>

<p></p>

<p></p>

<p><span style="font-weight: bold; font-size: 8pt">(1) Tumour content of sample  </span><span style="font-size: 8pt">defined as number of viable invasive tumour cells / total number of viable cells present in marked area, to nearest 5%;</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(2)</span><span style="font-weight: normal; font-size: 8pt"> Percentage </span><span style="font-weight: bold; font-size: 8pt">necrosis </span><span style="font-size: 8pt">present in marked area, by surface area</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(3)</span><span style="font-weight: normal; font-size: 8pt"> Tumour sample </span><span style="font-weight: bold; font-size: 8pt">cellularity </span><span style="font-size: 8pt">A - Very low (&lt;700); B - Low (&lt;4000); C - Medium (4000-10000); D - High (&gt;10000); E - Very High (&gt;50000); F - Unknown</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(4) Non-invasive neoplastic elements </span><span style="font-size: 8pt"> present in the sample (please specify) eg PIN, DCIS, or none;</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(5) Sample suitable for GEL </span><span style="font-size: 8pt">(&gt;40% tumour content) All Yes/No; Top-Middle Yes/No; Middle-Bottom Yes/No (circle appropriate);</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(6) Averages:  </span><span style="font-size: 8pt">calculate average % tumour and % necrosis for the selected pieces of tissue ((T+M+B )/ 3 if all suitable; (T+M)/2 if T-M suitable; (M+B)/2 if M-B suitable)</span></p>

<p>

    <span style="font-size: 10pt">Pathologist comments:.............................................................................................................................................. </span><br/>

    <span style="font-size: 10pt">..................................................................................................................................................................................... </span><br/>

</p>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 3 of 3</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>



</body>
</html>