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
            <center><span style="font-size: 8pt">Prostate - V2 (20150813)</span></center>
        </td>
        <td><rendering:inlineJpeg bytes="${orb}" height="50px"/></td>
        <td><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
    </tr>

</table>

<p><span style="font-weight: bold;font-size: 10pt "><u>SECTION 1:</u></span></p>

<p><center><span style="font-size: 8pt" >Histology number………………………	GEL ID………${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}}…………	   Patient initials....${form?.givenName?.toString()?.getAt(0)} ${form?.familyName?.toString()?.getAt(0)}..........     Alternative study ID……………… </span></center></p>

<span style="font-size: 8pt" >Tumour type ……………………………  Specimen collected from theatres by (initials) …………………On (date) …………at (time) ………</span><br/>

<span style="font-size: 8pt" >Name of surgeon …………………  Location of theatres    JR / WW / CH	Transported to JR:  on foot / on bicycle / by scooter / other ……………</span>

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

<p><span style="font-weight: bold;font-size: 10pt "><u>SECTION 2: TISSUE FIXATION</u></span></p>

<table border="0.1" style="font-size: 8pt" width="100%">
    <tr>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt"> Sample type (if not main: e.g. punch, slice)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt"> Cassette reference</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Fixation type(1)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Fixation start time </span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Fixation end time </span></th>
        <th width="25%"><span style="font-weight: normal;font-size: 8pt">Period in hours (circle appropriate) (time into formalin to time processing starts. For extra-large blocks add 15.5 hours as blocks sit overnight in formalin; if specimen goes onto processor on a Friday, add 48 hours as processor cycle starts on a Sunday night)</span></th>
        <th width="15%"><span style="font-weight: normal;font-size: 8pt">Processing schedule(2)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 8pt">Recorded by</span></th>
    </tr>
    <tr>
        <td>NBF block</td>
        <td></td>
        <td><center><span style="font-weight: bold;font-size: 8pt ">NBF</span></center></td>
        <td></td>
        <td></td>
        <td>&lt;12 &#160; 12-24	&#160; 24-48 &#160; 48-72 &#160;	&gt;72 &#160;	Unknown</td>
        <td>4H  &#160;  O/N   &#160;  EXT  &#160;    XL</td>
        <td></td>
    </tr>
    <tr>
        <td>Main specimen (small blocks)</td>
        <td bgcolor="#dcdcdc"></td>
        <td><center><span style="font-weight: bold;font-size: 8pt ">F</span></center></td>
        <td></td>
        <td></td>
        <td>&lt;12 &#160; 12-24	&#160; 24-48 &#160; 48-72 &#160;	&gt;72 &#160;	Unknown</td>
        <td>4H  &#160;  O/N   &#160;  EXT  &#160;    XL</td>
        <td></td>
    </tr>
    <tr>
        <td>Main specimen (XL blocks)</td>
        <td bgcolor="#dcdcdc"></td>
        <td><center><span style="font-weight: bold;font-size: 8pt ">F</span></center></td>
        <td></td>
        <td></td>
        <td>&lt;12 &#160; 12-24	&#160; 24-48 &#160; 48-72 &#160;	&gt;72 &#160;	Unknown</td>
        <td>4H  &#160;  O/N   &#160;  EXT  &#160;    XL</td>
        <td></td>
    </tr>
</table>

<p><span style="font-weight: bold;font-size: 8pt">(1) Fixation type: </span><span style="font-size: 8pt" >non-buffered formalin (F); neutral buffered formalin (NBF); PAXgene (P); other:……………………………………………………..</span></p>
<p><span style="font-weight: bold;font-size: 8pt">(2) Processing schedule </span><span style="font-size: 8pt" >(FileMaker “comments” box indication): 4H = same day / rapid processing (4H), O/N = overnight (no comment in FileMaker), EXT = extended (EXT), XL = extra-large programme (XL blocks).</span></p>


<p><span style="font-size: 10pt">Collection Comments:.............................................................................................................................................. </span></p>

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
            <td width="30%"><span style="font-size: 7pt">Page 1 of 5</span></td>
            <td width="30%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
        </tr>

    </table>
</div>
<div class='content'></div>


<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 2 (ctd): FIXED TISSUE CASSETTES</u> </span><span style="font-size: 8pt">(A 5mm area adjacent to the frozen tissue sample which is going forward for DNA extraction is to be marked by the pathologist).</span></p>


<table border="1" width="100%">

    <tr>
        <th width="18%"><span style="font-weight: bold;font-size: 7pt"></span></th>
        <th width="49%"><span style="font-weight: bold;font-size: 7pt">To be completed by pathologist</span></th>
        <th width="33%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 6pt">To be completed by ORB/NDS team</span></th>


    </tr>

</table>
<table border="1" width="100%">

    <tr>
        <th width="18%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 7pt">Block details</span></th>
        <th width="49%"><span style="font-weight: bold;font-size: 7pt">Slide marking</span></th>
        <th width="14%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 6pt">H&amp;E slide scanned</span></th>
        <th width="19%" bgcolor="#dcdcdc"><span style="font-weight: bold;font-size: 6pt">Block punched</span></th>

    </tr>

</table>
<table border="1" width="100%">

    <tr>
        <th width="3%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Ranking</span></th>
        <th width="15%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Block no &amp; size (small/XL)</span></th>
        <th width="7%"><span style="font-weight: normal;font-size: 7pt">By initials</span></th>
        <th width="7%"><span style="font-weight: normal;font-size: 7pt">On date</span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">% tumour (3)</span></th>
        <th width="5%"><span style="font-weight: normal;font-size: 7pt">% necrosis (4)</span></th>
        <th width="8%"><span style="font-weight: normal;font-size: 7pt">Cellularity (circle one) (5)</span></th>
        <th width="10%"><span style="font-weight: normal;font-size: 7pt">Non-invasive neoplastic elements (6)</span></th>
        <th width="7%"><span style="font-weight: normal;font-size: 7pt">GeL suitability  (circle one) (7)</span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">By initials</span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">On date</span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">By initials</span></th>
        <th width="7%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">On date</span></th>
        <th width="5%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">No of punches (8)</span></th>

    </tr>
    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Priority</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;F<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>


    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Reserve</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;F<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">&#160;</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;F<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

    <tr>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">&#160;</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><span style="font-weight: normal;font-size: 7pt">T ........<br/> M .......<br/> B ........</span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">A&#160;&#160;&#160;&#160;&#160;&#160;D <br/>B &#160;&#160;&#160;&#160;&#160;&#160;F<br/> C &#160;&#160;&#160;&#160;&#160;&#160;F</span></center></th>
        <th><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th><center><span style="font-weight: normal;font-size: 7pt">Y &#160;&#160;&#160;&#160;&#160;&#160;N</span></center></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>
</table>

<p><span style="font-weight: bold; font-size: 8pt">(3) Tumour content of sample </span><span style="font-size: 8pt">defined as number of viable invasive tumour cells / total number of viable cells present in marked area, to nearest 5%;</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(4) Percentage necrosis </span><span style="font-size: 8pt">present in marked area, by surface area;</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(5) Tumour sample cellularity: </span><span style="font-size: 8pt">A - Very low (&lt;700); B - Low (&lt;4000); C - Medium (4000-10000); D - High (&gt;10000); E - Very High (&gt;50000); F – Unknown.</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(6) Non-invasive neoplastic elements </span><span style="font-size: 8pt">present in the sample (please specify) eg PIN, DCIS, or none.</span></p>

<p><span style="font-weight: bold; font-size: 8pt">(7) GeL suitability: </span><span style="font-size: 8pt">at least 40% tumour and no more than 50% necrosis in marked area </span></p>

<p><span style="font-size: 8pt">(8) If punches are not 1mm, </span><span style="font-weight: bold; font-size: 8pt">ndicate size </span><span style="font-size: 8pt">here as well as number of punches.</span></p>

<p>

<span style="font-size: 10pt">Pathologist comments:.............................................................................................................................................. </span><br/>

<span style="font-size: 10pt">..................................................................................................................................................................................... </span><br/>

<span style="font-size: 10pt">..................................................................................................................................................................................... </span><br/>

<span style="font-size: 10pt">..................................................................................................................................................................................... </span><br/>

</p>

<div class='header'></div>

<div class='footer'>

    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 2 of 5</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>
<div class='content'></div>

<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 3: FROZEN TISSUE</u></span><span style="font-size: 10pt"> (include unique ID for each of the nine cores taken) - REMAINDER OF TISSUE PLACED INTO CASSETTE REF: .............</span></p>

<p></p>

<table width="100%" border="1">

    <tr>
        <th width="44%"><center><span style="font-weight: bold;font-size: 7pt">To be completed by biobanker</span></center></th>
        <th width="56%" bgcolor="#dcdcdc"><center><span style="font-weight: bold;font-size: 7pt">To be completed by ORB / NDS team</span></center></th>

    </tr>

</table>

<table border="1">

    <tr>
        <th width="20%"><span style="font-weight: normal;font-size: 7pt">Full unique ID Sapphire / biobank ID</span></th>
        <th width="9%"><span style="font-weight: normal;font-size: 7pt">Inking colour if appl.</span></th>
        <th width="15%"><span style="font-weight: normal;font-size: 7pt">Zone</span></th>
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
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">T-M ........................ M-B ........................</span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt"></span></th>
    </tr>

</table>

<p></p>

<div class='header'></div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 3 of 5</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>
<div class='content'></div>

<p><span style="font-weight: bold; font-size: 10pt"><u>SECTION 3 (ctd): FROZEN TISSUE SECTION MARKING</u></span></p>
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

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 4 of 5</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>

<div class='header'></div>

<div class='footer'>
    <table width="100%">
        <tr>
            <td width="40%"><span style="font-size: 7pt">GEL Post sampling Worksheet (Prostate only)</span></td>
            <td width="20%"><span style="font-size: 7pt">Page 5 of 5</span></td>
            <td width="20%"><span style="font-size: 7pt">GEL ID:  ${form?.studySubject?.studySubjectIdentifier?.findResult{it?.size() ? it : null}} </span></td>
            <td width="20%"><rendering:inlineJpeg bytes="${barcode}" height="50px"/></td>
        </tr>
    </table>
</div>

<div class='content'></div>

<center><span style="font-weight: bold; font-size: 10pt">Data entry into NGS-LIMS</span></center>

<p></p>

<p></p>

<table border="1" style="width:100%">

    <tr>

        <td width="40%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt" >Data entry step</span></td>
        <td width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Initials</span></td>
        <td width="15%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Date (dd/mm/yr)</span></td>
        <th bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">&#160;</span></th>
        <td width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Audited by</span></td>
        <td width="15%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">on (dd/mm/yy)</span></td>
        <td width="10%" bgcolor="#dcdcdc"><span style="font-weight: normal;font-size: 7pt">Audit outcome</span></td>

    </tr>

</table>

<span style="font-weight: bold; font-size: 8pt">Section 1</span>

<table border="1" style="width:100%">

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >Main specimen registration, participant registration if not done yet, Ischemia and Specimen sliced and opened for optimal fixation (if applicable)</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

</table>

<span style="font-weight: bold; font-size: 8pt">Section 2</span>

<table border="1" style="width:100%">

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >FFPE punch aliquots registration, block fixation and processing, slide marking outcome</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >Slide scanning</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >Punching of block</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

</table>

<span style="font-weight: bold; font-size: 8pt">Section 3</span>

<table border="1" style="width:100%">

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >Frozen tissue registration, punch weight, frozen section preparation, slide marking outcome</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

    <tr>

        <td width="40%" ><span style="font-weight: normal;font-size: 7pt" >Slide scanning</span></td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td bgcolor="#dcdcdc">&#160;</td>
        <td width="10%"></td>
        <td width="15%"></td>
        <td width="10%"></td>

    </tr>

</table>

</body>
</html>