<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
			
            var q_name = "commerce";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys = ['txtDatea','txtTimea'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [['txtDatea','9999/99/99'],['txtEdate','9999/99/99']];
            var bbsMask = [];
			x_bbsSave = 1;// bbs不存資料
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            q_desc = 1;
			q_bbsLen = 10;
            aPop = new Array();
			brwCount2 = 23;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
			
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(0);
            }

            function mainPost() {
                q_mask(bbmMask);
				q_cmbParse("cmbKind", 'A@供貨,B@求購,C@徵才,D@招商,E@其他');
				q_cmbParse("cmbTypea", ' @,A@原料,B@半成品,C@碳鋼成品,D@不鏽鋼成品,E@特殊鋼成品,F@終端成品,G@非鐵金屬,H@機械設備,I@其他產品');
            	q_cmbParse("cmbAppellation", ' @,M@先生,F@小姐');
            	q_cmbParse("cmbAppellation", ' @,M@先生,F@小姐','s');
            	
            	q_cmbParse("cmbUnit", ' @,KG@公斤,MT@公噸');
            	q_cmbParse("cmbCoin", ' @,NTD@新台幣,USD@美金,RMB@人民幣');
            	
            	$('#btnSuccess').click(function(e){
            		t_noa = $('#txtNoa').val();
            		if(confirm("將寄送【申請成功信件】,是否繼續?")){
            			javascript:window.open('../commerce/commerce_send_mail.aspx?noa='+t_noa+'&success=true',  t_noa ,config='width=400px,height=200px,toolbar=no,location=no,menubar=no,status=no,scrollbars=yes, resizable=yes');
            		}
            	});
            	$('#btnFail').click(function(e){
            		t_noa = $('#txtNoa').val();
            		if(confirm("將寄送【申請失敗信件】,是否繼續?")){
            			javascript:window.open('../commerce/commerce_send_mail.aspx?noa='+t_noa+'&success=false',  t_noa ,config='width=400px,height=200px,toolbar=no,location=no,menubar=no,status=no,scrollbars=yes, resizable=yes');
            		}
            	});
            }

            function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
			function q_popPost(id) {
                switch (id) {
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                    default:
                        break;
                }
            }

            function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)
                    return;
                q_box('commerce_s.aspx', q_name + '_s', "550px", "440px", q_getMsg("popSeek"));
            }

            function btnIns() {
                //_btnIns(); 
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
            	_btnModi();
            	$('#txtDatea').focus();
            }

            function btnPrint() {
                q_box("z_commercep.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + JSON.stringify({noa:trim($('#txtNoa').val())}) + ";" + r_accy + "_" + r_cno, 'commerce', "95%", "95%", m_print);
            }

            function btnOk() {
                if (q_cur == 1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
		
				var t_noa = trim($('#txtNoa').val());
				/*var t_date = trim($('#txtDatea').val());
				if (t_noa.length == 0 || t_noa == "AUTO")
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_cng') + (t_date.length == 0 ? q_date() : t_date), '/', ''));
				else*/
					wrServer(t_noa);
            }

            function wrServer(key_value) {
                var i;
                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
            }

            function bbsSave(as) {
                if (!as['namea']) {
                    as[bbsKey[1]] = '';
                    return;
                }
                q_nowf();
                return true;
            }

            function refresh(recno) {
                _refresh(recno);	
                var t_noa = $('#txtNoa').val();
                $('#img').attr("src","../commerce/commerce_img.aspx?noa="+t_noa);
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#btnSuccess').removeAttr('disabled');
                	$('#btnFail').removeAttr('disabled');
                }else{
                	$('#btnSuccess').attr('disabled','disabled');
                	$('#btnFail').attr('disabled','disabled');
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }
            function bbsAssign() {
                for (var i = 0; i < q_bbsCount; i++) {
                    $('#lblNo_' + i).text(i + 1);
                    if (!$('#btnMinus_' + i).hasClass('isAssign')) {
                    }
                }
                _bbsAssign();
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

            function onPageError(error) {
                alert("An error occurred:\r\n" + error.Message);
            }
            
		</script>
		<style type="text/css">
            #dmain {
                overflow: visible;
            }
            .dview {
                float: left;
                width: 300px;
                border-width: 0px;
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30%;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 70%;
                /*margin: -1px;
                 border: 1px black solid;*/
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
                width: 9%;
            }
            .tbbm .tdZ {
                width: 1%;
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
                width: 100%;
                float: left;
            }
            .txt.c2 {
                width: 130%;
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
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            .dbbs {
                width: 1700px;
            }
            .dbbs .tbbs {
                margin: 0;
                padding: 2px;
                border: 2px lightgrey double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                /*background: #cad3ff;*/
                background: lightgrey;
                width: 1700px;
            }
            .dbbs .tbbs tr {
                height: 35px;
            }
            .dbbs .tbbs tr td {
                text-align: center;
                border: 2px lightgrey double;
            }
            .dbbs .tbbs select {
                border-width: 1px;
                padding: 0px;
                margin: -1px;
                font-size: medium;
            }
            #dbbt {
                width: 1500px;
            }
            #tbbt {
                margin: 0;
                padding: 2px;
                border: 2px pink double;
                border-spacing: 1;
                border-collapse: collapse;
                font-size: medium;
                color: blue;
                background: pink;
                width: 100%;
            }
            #tbbt tr {
                height: 35px;
            }
            #tbbt tr td {
                text-align: center;
                border: 2px pink double;
            }
            #InterestWindows {
                display: none;
                width: 20%;
                background-color: #cad3ff;
                border: 5px solid gray;
                position: absolute;
                z-index: 50;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:visible;width: 1200px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview" >
					<tr>
						<td style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td style="width:100px; color:black;"><a id='vewDatea'>登錄日期</a></td>
						<td style="width:100px; color:black;"><a id='vewOnline'>上線</a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='online' style="text-align: center;">~online</td>
					</tr>
				</table>
			</div>
			<div class='dbbm'>
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td></td>
						<td class="tdZ"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNoa" class="lbl">電腦編號</a></td>
						<td colspan="2"> <input id="txtNoa"  type="text" class="txt c1"/> </td>
						<td><span> </span><a id="lblDatea" class="lbl">登錄日期</a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblTimea" class="lbl">登錄時間</a></td>
						<td><input id="txtTimea"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblEdate" class="lbl">有效日期</a></td>
						<td><input id="txtEdate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblKind" class="lbl">需求類型</a></td>
						<td><select id="cmbKind" class="txt c1"> </select></td>
						<td><span> </span><a id="lblTypea" class="lbl">產品類別</a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><input id="txtTypeitem"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblProduct" class="lbl">產品名稱</a></td>
						<td><input id="txtProduct"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblMaterial" class="lbl">材質</a></td>
						<td><input id="txtMaterial"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblSpec" class="lbl">規格</a></td>
						<td><input id="txtSpec"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblPlace" class="lbl">產地/廠家</a></td>
						<td><input id="txtPlace"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblLocation" class="lbl">所在地</a></td>
						<td><input id="txtLocation"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblMount" class="lbl">數量</a></td>
						<td><input id="txtMount"  type="text"  class="txt c1 num"/></td>
						<td><select id="cmbUnit" class="txt c1"> </select></td>
						<td><span> </span><a id="lblPrice" class="lbl">價格</a></td>
						<td><input id="txtPrice"  type="text"  class="txt c1 num"/></td>
						<td><select id="cmbCoin" class="txt c1"> </select></td>
						
						<td>
							<span> </span>
							<input id="chkBargain"  type="checkbox"  class="txt"/>議價
						</td>
					</tr>
					
					<tr>
						<td><span> </span><a id="lblMemo" class="lbl">其他說明</a></td>
						<td colspan="6"><textarea id="txtMemo" class="txt c1" rows="5"></textarea></td>
					</tr>
					<tr style="background:pink;">
						<td><span> </span><a id="lblProduct2" class="lbl">名稱</a></td>
						<td colspan="6"><input id="txtProduct2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr style="background:pink;">
						<td><span> </span><a id="lblLocation2" class="lbl">地點</a></td>
						<td colspan="6"><input id="txtLocation2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr style="background:pink;">
						<td><span> </span><a id="lblMemo2" class="lbl">詳細說明</a></td>
						<td colspan="6"><textarea id="txtMemo2" class="txt c1" rows="5"> </textarea></td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="6"><img id="img" width="430"></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblNamea" class="lbl">聯絡人姓名</a></td>
						<td colspan="5"><input id="txtNamea"  type="text"  class="txt c1"/></td>
						<td><select id="cmbAppellation" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblComp" class="lbl">公司名稱</a></td>
						<td colspan="2"><input id="txtComp"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblHref" class="lbl">公司網址</a></td>
						<td colspan="2"><input id="txtHref"  type="text"  class="txt c1"/></td>
						<td><input id="btnSuccess"  type="button" value="申請通過E-MAIL"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel1" class="lbl">連絡電話(1)</a></td>
						<td colspan="2"><input id="txtTel1"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblEmail" class="lbl">E-MAIL</a></td>
						<td colspan="2"><input id="txtEmail"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblTel2" class="lbl">連絡電話(2)</a></td>
						<td colspan="2"><input id="txtTel2"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id="lblFax" class="lbl">傳真</a></td>
						<td colspan="2"><input id="txtFax"  type="text"  class="txt c1"/></td>
						<td><input id="btnFail"  type="button" style="color:red;" value="申請不通過E-MAIL"/></td>
					</tr>
					<tr>
						<td><span> </span><a id="lblWorker" class="lbl">製單人員</a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblWorker2" class="lbl">修改人員</a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td><span> </span><a id="lblOnline" class="lbl">上線</a></td>
						<td><input id="chkOnline" type="checkbox" class="txt c1"/></td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5" style="color:red;">↓↓↓↓↓明細無法修改，請注意↓↓↓↓↓</td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td style="width:20px;">
						<input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/>
					</td>
					<td style="width:20px;"> </td>
					<td style="width:180px;"><a id='lbl_cont'>標題</a></td>
					<td style="width:100px;"><a id='lbl_cont'>姓名</a></td>
					<td style="width:50px;"><a id='lbl_cont'>稱謂</a></td>
					<td style="width:180px;"><a id='lbl_cont'>公司名稱</a></td>
					<td style="width:180px;"><a id='lbl_cont'>公司網站</a></td>
					<td style="width:180px;"><a id='lbl_cont'>聯絡方式(1)</a></td>
					<td style="width:180px;"><a id='lbl_cont'>聯絡方式(2)</a></td>
					<td style="width:200px;"><a id='lbl_cont'>留言內容</a></td>
					<td style="width:100px;"><a id='lbl_cont'>日期</a></td>
					<td style="width:100px;"><a id='lbl_cont'>時間</a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input id="btnMinus.*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input id="txtNoq.*" type="text" style="display: none;"/>
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td><input class="txt" id="txtTitle.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtNamea.*" type="text" style="width:95%;"/></td>
					<td><select id="cmbAppellation.*" class="txt c1"> </select></td>
					<td><input class="txt" id="txtComp.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtHref.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtTel1.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtTel2.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtMemo.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtDatea.*" type="text" style="width:95%;"/></td>
					<td><input class="txt" id="txtTimea.*" type="text" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
