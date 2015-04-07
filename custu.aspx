<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
        <script type="text/javascript" src="../highslide/highslide.packed.js"></script>
		<script type="text/javascript" src="../highslide/highslide-with-html.packed.js"></script>
		<link rel="stylesheet" type="text/css" href="../highslide/highslide.css" /> 
		<script type="text/javascript"> hs.graphicsDir = '../highslide/graphics/'; hs.showCredits = false; hs.outlineType = 'rounded-white'; hs.outlineWhileAnimating = true; </script>
        <script type="text/javascript">    
            var q_name = "custu";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [['txtMoney', 15, 0,1],['txtInvomoney', 15, 0,1]];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array();
			
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
                // 1=Last  0=Top
            }
			
            function mainPost() {
            	bbmMask = [['txtDatea', '9999/99/99'],['txtInvodate', '9999/99/99']];
                q_mask(bbmMask);
                q_cmbParse("cmbCobtype", ',二聯,三聯');
                q_cmbParse("cmbTypea", ','+q_getPara('custu.typea'));
                q_cmbParse("cmbAcc", ','+q_getPara('custu.acc'));
                q_cmbParse("cmbKind", ','+q_getPara('custu.kind'));
                
            }
            
            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }
			
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                //q_box('custu_s.aspx', q_name + '_s', "500px", "300px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtInvotitle').focus();
                if (window.parent.q_name == 'cust') {
                    var wParent = window.parent.document;
                    $('#txtComp').val(wParent.getElementById("txtComp").value);
                    $('#txtSerial').val(wParent.getElementById("txtNoa").value);
                    $('#txtInvoserial').val(wParent.getElementById("txtInvoserial").value);
                    $('#txtInvotitle').val(wParent.getElementById("txtInvotitle").value);
                    $('#cmbCobtype').val(wParent.getElementById("cmbCobtype").value);
                    $('#txtPost').val(wParent.getElementById("txtInvopost").value);
                    $('#txtAddr').val(wParent.getElementById("txtInvoaddr").value);
                }
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtInvotitle').focus();
            }

            function btnPrint() {

            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock();
            }

            function btnOk() {
                Lock(1,{opacity:0});
            	var t_err = '';
                t_err = q_chkEmpField([['txtComp', q_getMsg('lblComp')],['txtSerial', q_getMsg('lblSerial')]
                ,['txtDatea', q_getMsg('lblDatea')],['txtInvodate', q_getMsg('lblInvodate')]
                ,['txtMoney', q_getMsg('lblMoney')],['txtInvomoney', q_getMsg('lblInvomoney')]
                ,['cmbCobtype', q_getMsg('lblCobtype')],['cmbTypea', q_getMsg('lblTypea')]
                ,['cmbAcc', q_getMsg('lblAcc')],['cmbKind', q_getMsg('lblKind')]
                ]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                            	
				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
				else
					wrServer(s1);

            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                 	$('#txtDatea').datepicker( 'destroy' );
                 	$('#txtInvodate').datepicker( 'destroy' );
                }else{
                	$('#txtDatea').removeClass('hasDatepicker')
					$('#txtDatea').datepicker({ dateFormat: 'yy/mm/dd' });
					$('#txtInvodate').removeClass('hasDatepicker')
					$('#txtInvodate').datepicker({ dateFormat: 'yy/mm/dd' });
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }

            function q_appendData(t_Table) {
                return _q_appendData(t_Table);
            }

            function btnSeek() {
                _btnSeek();
            }

            function btnTop() {
                _btnTop();
            }

            function btnPrev() {
                _btnPrev();
            }

            function btnPrevPage() {
                _btnPrevPage();
            }

            function btnNext() {
                _btnNext();
            }

            function btnNextPage() {
                _btnNextPage();
            }

            function btnBott() {
                _btnBott();
            }

            function q_brwAssign(s1) {
                _q_brwAssign(s1);
            }

            function btnDele() {
                _btnDele();
            }

            function btnCancel() {
                _btnCancel();
            }
		</script>
		<style type="text/css">
            #dmain {
                overflow: hidden;
            }
            .dview {
                float: left;
                width: 350px;
            }
            .tview {
            	width:100%;
                margin: 0;
                padding: 2px;
                border: 1px black double;
                border-spacing: 0;
                font-size: medium;
                background-color: #FFFF66;
                color: blue;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border: 1px black solid;
            }
            .dbbm {
                float: left;
                width: 750px;
                margin: -1px;
                border: 1px black solid;
                border-radius: 5px;
            }
            .tbbm {
                padding: 0px;
                border: 1px white double;
                border-spacing: 0;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: #cad3ff;
                width: 100%;
            }
            .tbbm tr {
                height: 35px;
            }
            .tbbm tr td {
                
            }
            .tbbm .tdZ {
                width: 2%;
            }
            .tbbm tr td span {
                float: right;
                display: block;
                width: 5px;
                height: 10px;
            }
            .tbbm tr td .lbl {
                float: right;
                color: blue;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                font-size: medium;
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 15%;
                float: left;
            }
            .txt.c3 {
                width: 83%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
                float: left;
            }
            .txt.num {
                text-align: right;
            }
            .tbbm td {
                margin: 0 -1px;
                padding: 0;
            }
            .tbbm td input[type="text"] {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                float: left;
            }
            .tbbm select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; "  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:47%"><a id='vewComp'> </a></td>
						<td align="center" style="width:25%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:25%"><a id='vewMoney'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id="comp">~comp</td>
						<td align="center" id="datea">~datea</td>
						<td align="center" id='money,0,1'>~money,0,1</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 190px"> </td>
						<td style="width: 200px"> </td>
						<td style="width: 150px"> </td>
						<td style="width: 200px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td>
							<input id="txtComp" type="text" class="txt c1"/>
							<input id="txtCustno" type="hidden"/>
						</td>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td>
							<input id="txtSerial" type="text" class="txt c1"/>
							<input id="txtNoa" type="hidden"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvotitle' class="lbl"> </a></td>
						<td><input id="txtInvotitle" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvoserial' class="lbl"> </a></td>
						<td><input id="txtInvoserial" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvodate' class="lbl"> </a></td>
						<td><input id="txtInvodate" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMoney' class="lbl"> </a></td>
						<td><input id="txtMoney" type="text" class="txt num c1"/></td>
						<td><span> </span><a id='lblInvomoney' class="lbl"> </a></td>
						<td><input id="txtInvomoney" type="text" class="txt num c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a><a class="lbl">-</a><a id='lblPost' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtPost" type="text" class="txt c2"/><a style="float: left;">-</a>
							<input id="txtAddr" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCobtype' class="lbl"> </a></td>
						<td><select id="cmbCobtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAcc' class="lbl"> </a></td>
						<td><select id="cmbAcc" class="txt c1"> </select></td>
						<td><span> </span><a id='lblKind' class="lbl"> </a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><input id="txtMemo"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
