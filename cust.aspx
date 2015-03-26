<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			var q_name = "cust";
			var q_readonly = [];
			var bbmNum = [];
			var bbmMask = [];
			q_sqlCount = 6;
			brwCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			brwCount2 = 20;
			aPop = new Array();
			
			$(document).ready(function() {
				bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
			});

			//////////////////end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				
			}

			function mainPost() {
				bbmMask = [['txtStartdate', '9999/99/99'],['txtKdate', '9999/99/99']];
				q_mask(bbmMask);
				
				q_gt('custtype', '', 0, 0, 0, "custtype");
				q_gt('country', '', 0, 0, 0, "country");
				q_cmbParse("cmbCoin", '@無,NTD@台幣,RMB@人民幣,USD,美金');
				
				$('#btnCusts').click(function() {
				 	if(q_cur==1){
				 		return;
				 	}else{
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("custs.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'custs', "95%", "650px", q_getMsg('btnCusts'));
					}
				});
				
				$('#btnShip').click(function() {
				 	if(q_cur==1){
				 		return;
				 	}else{
						t_where = "noa='" + $('#txtNoa').val() + "'";
						q_box("ship.aspx?" + r_userno + ";" + r_name + ";" + q_time + ";" + t_where, 'ship', "95%", "650px", q_getMsg('btnShip'));
					}
				});
				
				$('#txtNoa').change(function(e){
					$(this).val($.trim($(this).val()).toUpperCase());		
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							//t_where="where=^^ noa='"+$(this).val()+"'^^";
							//q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
							$('#cmbTypea').val($('#txtNoa').val().substring(0,1));
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				
				$('#txtComp').change(function(e){
					if(emp($('#txtComp').val()))
						$('#txtInvotitle').val($('#txtComp').val());
				});
				
				for (var i=1;i<10;i++){
					$('.btypes'+i).hide();
					$('#btypes'+i).click(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
			}
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					 case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
						}
						break;
					case 'country':
						var as = _q_appendData("country", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].cname);
							}
							q_cmbParse("cmbCountry", t_item);
							if(abbm[q_recno])
								$("#cmbCountry").val(abbm[q_recno].country);
						}
						break;	
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
				 		break;
				} /// end switch
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtNoa').focus();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
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
            	
            	$('#txtNoa').val($.trim($('#txtNoa').val())); 	
            	
            	if($('#txtNoa').val().length==0){
            		alert('請輸入'+q_getMsg("lblNoa"));
            		Unlock(1);
            		return;
            	}
				
				wrServer($('#txtNoa').val());
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], '', '', 2);
			}

			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
			}
			
			function refreshBbm(){
				if(q_cur==1){
					$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
				}else{
					$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
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
			}
			.tview {
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
			.tbbm .conn{
				  background: aliceblue;
			}
			.tbbm .sconn{
				  background: beige;
			}
			.tbbm .btypes{
				  background: lavender;
			}
			.tbbm tr td {
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				/*width: 2%;*/
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
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 32%;
				float: left;
			}
			.txt.c3 {
				width: 65%;
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
			}
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width:1250px;">
			<div class="dview" id="dview" style="float: left; width:300px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewSerial'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 130px;"> </td>
						<td style="width: 280px;"> </td>
						<td style="width: 130px;"> </td>
						<td style="width: 280px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtSerial" type="hidden"/>
						</td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEcomp' class="lbl"> </a></td>
						<td><input id="txtEcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtBoss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIsshipcomp' class="lbl"> </a></td>
						<td>
							<input id="chkIsshipcomp" type="checkbox"/>
							<input id="btnShip" type="button" value="公司船名"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c2"/></td>
						<td><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td>
							<input id="txtKdate" type="text" class="txt c2"/>
							<span style="float:left;"> </span>
							<a id='lblIscheck' class="lbl" style="float:left;"> </a>
							<input id="chkIscheck" type="checkbox"/>
							<span style="float:left;"> </span>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a><a style="float: right;">-</a><a id='lblCountry' class="lbl"> </a></td>
						<td colspan='3'>
							<select id="cmbCountry" class="txt c2"> </select><a style="float: left">-</a>
							<input id="txtAddr" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCoin' class="lbl"> </a><a style="float: right;">-</a><a id='lblCapital' class="lbl"> </a></td>
						<td>
							<input id="txtCapital" type="text" class="txt num c3"/><a style="float: left">-</a>
							<select id="cmbCoin" class="txt c2"> </select>
						</td>
						<td><span> </span><a id='lblWeb' class="lbl"> </a></td>
						<td><input id="txtWeb" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td><input id="txtStatus" type="text" class="txt c1" disabled="disabled"/></td>
						<td><span> </span><a id='lblUmmstatus' class="lbl"> </a></td>
						<td><input id="txtUmmstatus" type="text" class="txt c1" disabled="disabled"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvoserial' class="lbl"> </a></td>
						<td><input id="txtInvoserial" type="text" class="txt c1" disabled="disabled"/></td>
						<td><span> </span><a id='lblInvotitle' class="lbl"> </a></td>
						<td><input id="txtInvotitle" type="text" class="txt c1" disabled="disabled"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCobtype' class="lbl"> </a></td>
						<td><input id="txtCobtype" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvoaddr' class="lbl"> </a></td>
						<td><input id="txtInvoaddr" type="text" class="txt c1"/></td>
					</tr>
					<tr class="conn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">主帳號(型錄聯絡人)</a></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblExt' class="lbl"> </a></td>
						<td><input id="txtExt" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td><input id="txtJob" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td><input id="txtEmail" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">業務聯絡人</a></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSconn' class="lbl"> </a></td>
						<td><input id="txtSconn" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSext' class="lbl"> </a></td>
						<td><input id="txtSext" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSjob' class="lbl"> </a></td>
						<td><input id="txtSjob" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSmobile' class="lbl"> </a></td>
						<td><input id="txtSmobile" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSemail' class="lbl"> </a></td>
						<td><input id="txtSemail" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCmemo' class="lbl"> </a></td>
						<td colspan='3'>
							<textarea id="txtCmemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBmemo' class="lbl"> </a></td>
						<td colspan='3'>
							<textarea id="txtBmemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBtype' class="lbl"> </a></td>
						<td><select id="cmbBtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr class="btypes">
						<td colspan="4" style="text-align: center;">
							<span> </span><a id='lblBtypes' class="lbl" style="float: none;"> </a>
							<input id="txtBtypes" type="hidden"/>
						</td>
						<td> </td>
					</tr>
					<tr class="btypes">
						<td colspan="5">
							<input id="btypes1" name="btypes" type="checkbox" value="A000"/> 鋼鐵生產廠商
						</td>
					</tr>
					<tr class="btypes btypes1">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td colspan="3">碳鋼</td>								</tr>
								<tr>
									<td> </td>
									<td>[半成品]</td>
									<td>
										<input name="btypes" type="checkbox" value="A001"/> 扁 鋼 胚
										<input name="btypes" type="checkbox" value="A002"/> 大 鋼 胚
										<input name="btypes" type="checkbox" value="A003"/> 小 鋼 胚
										<input name="btypes" type="checkbox" value="A004"/> 圓 胚
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>[成 品]熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A005"/> 鋼 筋
										<input name="btypes" type="checkbox" value="A006"/> 角 鋼
										<input name="btypes" type="checkbox" value="A007"/> 槽 鋼
										<input name="btypes" type="checkbox" value="A008"/>直 棒 鋼
										<input name="btypes" type="checkbox" value="A009"/>線材盤元
										<input name="btypes" type="checkbox" value="A010"/>條鋼盤元
										<input name="btypes" type="checkbox" value="A011"/>無縫鋼管
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A012"/>扁 鋼
										<input name="btypes" type="checkbox" value="A013"/>鋼 軌
										<input name="btypes" type="checkbox" value="A014"/>異 形 鋼
										<input name="btypes" type="checkbox" value="A015"/>鋼 板 樁
										<input name="btypes" type="checkbox" value="A016"/>H 型 鋼
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A017"/>寬 厚 板
										<input name="btypes" type="checkbox" value="A018"/>鋼捲(厚度2.0mm 以上)
										<input name="btypes" type="checkbox" value="A019"/>鋼捲(厚度2.0mm 以下)
										<input name="btypes" type="checkbox" value="A020"/>花紋鋼板
										<input name="btypes" type="checkbox" value="A021"/>酸洗塗油板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A022"/>酸洗塗油板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A023"/>霧面鋼捲SD
										<input name="btypes" type="checkbox" value="A024"/>亮面鋼捲SB
										<input name="btypes" type="checkbox" value="A025"/>全硬未退火鋼捲
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>鍍 面 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A026"/>熱浸鍍鋅
										<input name="btypes" type="checkbox" value="A026"/>熱浸鍍鋁鋅
										<input name="btypes" type="checkbox" value="A027"/>彩色(彩塗)
										<input name="btypes" type="checkbox" value="A028"/>電鍍鋅
										<input name="btypes" type="checkbox" value="A029"/>馬口鐵(鍍錫)
										<input name="btypes" type="checkbox" value="A030"/>電磁鋼(矽鋼片)
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3">不 鏽 鋼</td>
								</tr>
								<tr>
									<td> </td>
									<td>[半成品]</td>
									<td>
										<input name="btypes" type="checkbox" value="A031"/> 扁 鋼 胚
										<input name="btypes" type="checkbox" value="A032"/> 大 鋼 胚
										<input name="btypes" type="checkbox" value="A033"/> 小 鋼 胚
										<input name="btypes" type="checkbox" value="A034"/> 圓 胚
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>[成 品]熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A035"/> 角 鋼
										<input name="btypes" type="checkbox" value="A036"/>扁 鋼
										<input name="btypes" type="checkbox" value="A037"/>異 形 鋼
										<input name="btypes" type="checkbox" value="A038"/>直 棒 鋼
										<input name="btypes" type="checkbox" value="A039"/>無縫鋼管
										<input name="btypes" type="checkbox" value="A040"/>線材盤元
										<input name="btypes" type="checkbox" value="A041"/>條鋼盤元
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A042"/>寬 厚 板
										<input name="btypes" type="checkbox" value="A043"/>黑皮鋼捲
										<input name="btypes" type="checkbox" value="A044"/>酸洗退火板(原面)
										<input name="btypes" type="checkbox" value="A045"/>花紋鋼板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A046"/>鈍面鋼捲(2D)
										<input name="btypes" type="checkbox" value="A047"/>霧面鋼捲(2B)
										<input name="btypes" type="checkbox" value="A048"/>金面鋼捲(BA)
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3">合 金 鋼</td>
								</tr>
								<tr>
									<td> </td>
									<td>[半成品]</td>
									<td>
										<input name="btypes" type="checkbox" value="A049"/> 扁 鋼 胚
										<input name="btypes" type="checkbox" value="A050"/> 大 鋼 胚
										<input name="btypes" type="checkbox" value="A051"/> 小 鋼 胚
										<input name="btypes" type="checkbox" value="A052"/> 圓 胚
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>[成 品]熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A053"/> 角 鋼
										<input name="btypes" type="checkbox" value="A054"/>扁 鋼
										<input name="btypes" type="checkbox" value="A055"/>異 形 鋼
										<input name="btypes" type="checkbox" value="A056"/>直 棒 鋼
										<input name="btypes" type="checkbox" value="A057"/>線材盤元
										<input name="btypes" type="checkbox" value="A058"/>條鋼盤元
										<input name="btypes" type="checkbox" value="A059"/>無縫鋼管
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A060"/>鋼捲
										<input name="btypes" type="checkbox" value="A061"/>寬厚板
										<input name="btypes" type="checkbox" value="A062"/>酸洗退火板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="A063"/>鋼捲
										<input name="btypes" type="checkbox" value="A064"/>複合板
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3">
										<input name="btypes" type="checkbox" value="A999" style="float: left;"/>
										<a style="float: left;">其 他</a>
										<span style="float: left;"> </span><input id="textBtypesother1" type="text" class="txt c2"/>
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="btypes">
						<td colspan="5">
							<input id="btypes2" name="btypes" type="checkbox" value="B000"/> 產品製造業
						</td>
					</tr>
					<tr class="btypes btypes2">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td colspan="2">以長條類鋼品為原料所製造的產品</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B001"/> 鎖
										<input name="btypes" type="checkbox" value="B002"/>鍛造零件
										<input name="btypes" type="checkbox" value="B003"/>焊接鋼網
										<input name="btypes" type="checkbox" value="B004"/>鍍鋅鐵線
										<input name="btypes" type="checkbox" value="B005"/>預力鋼線
										<input name="btypes" type="checkbox" value="B006"/>鋼線/鋼纜
										<input name="btypes" type="checkbox" value="B007"/>螺絲/螺帽
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B008"/> 揚聲器
										<input name="btypes" type="checkbox" value="B009"/>手工具
										<input name="btypes" type="checkbox" value="B010"/>千金頂
										<input name="btypes" type="checkbox" value="B011"/>緊固件
										<input name="btypes" type="checkbox" value="B012"/>五金線
										<input name="btypes" type="checkbox" value="B013"/>焊材
										<input name="btypes" type="checkbox" value="B014"/>捲釘
										<input name="btypes" type="checkbox" value="B015"/>鐵條
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B016"/>齒輪
										<input name="btypes" type="checkbox" value="B017"/>鏈條
										<input name="btypes" type="checkbox" value="B018"/>彈簧
										<input name="btypes" type="checkbox" value="B019"/>軸承
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td colspan="2">以平板類鋼品為原料所製造的產品</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B020"/> 鋼管
										<input name="btypes" type="checkbox" value="B021"/>貨櫃(集裝箱)
										<input name="btypes" type="checkbox" value="B022"/>桶槽(容器)
										<input name="btypes" type="checkbox" value="B023"/>船體/零件
										<input name="btypes" type="checkbox" value="B024"/>車體/零件
										<input name="btypes" type="checkbox" value="B025"/>三明治浪板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B026"/> 廠房浪板
										<input name="btypes" type="checkbox" value="B027"/>運動器材
										<input name="btypes" type="checkbox" value="B028"/>鋼製家俱
										<input name="btypes" type="checkbox" value="B029"/>照明器材
										<input name="btypes" type="checkbox" value="B030"/>電腦機殼
										<input name="btypes" type="checkbox" value="B031"/>塘瓷鋼片
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B032"/> 貼皮鋼片
										<input name="btypes" type="checkbox" value="B033"/>API 油管
										<input name="btypes" type="checkbox" value="B034"/>擴張網
										<input name="btypes" type="checkbox" value="B035"/>T 型鋼
										<input name="btypes" type="checkbox" value="B036"/>鋼結構
										<input name="btypes" type="checkbox" value="B037"/>C 型鋼
										<input name="btypes" type="checkbox" value="B038"/>隔屏
										<input name="btypes" type="checkbox" value="B039"/>廚具
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B040"/> 洋傘
										<input name="btypes" type="checkbox" value="B041"/>模座
										<input name="btypes" type="checkbox" value="B042"/>捲門
										<input name="btypes" type="checkbox" value="B043"/>風管
										<input name="btypes" type="checkbox" value="B044"/>家電
										<input name="btypes" type="checkbox" value="B045"/>馬達
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td colspan="2">其他金屬製品</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="B046"/> 鋼管
										<input name="btypes" type="checkbox" value="B047"/>輪圈
										<input name="btypes" type="checkbox" value="B048"/>引擎
										<input name="btypes" type="checkbox" value="B049"/>帷幕牆
										<input name="btypes" type="checkbox" value="B050"/>鋁門窗
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="btypes">
						<td colspan="5">
							<input id="btypes3" name="btypes" type="checkbox" value="C000"/> 裁剪 / 加工業
						</td>
					</tr>
					<tr class="btypes btypes3">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td>
										<input name="btypes" type="checkbox" value="C001"/>酸洗
										<input name="btypes" type="checkbox" value="C002"/>成型
										<input name="btypes" type="checkbox" value="C003"/>粉末治金
										<input name="btypes" type="checkbox" value="C004"/>鋼板切割
										<input name="btypes" type="checkbox" value="C005"/>結構鍍鋅
										<input name="btypes" type="checkbox" value="C006"/>鋼捲裁剪
										<input name="btypes" type="checkbox" value="C007"/>表面處理
									</td>
								</tr>
								<tr>
									<td>
										<input name="btypes" type="checkbox" value="C008"/> 熱處理
										<input name="btypes" type="checkbox" value="C009"/>鍛造
										<input name="btypes" type="checkbox" value="C010"/>球化
										<input name="btypes" type="checkbox" value="C011"/>沖壓
										<input name="btypes" type="checkbox" value="C012"/>鑄造
										<input name="btypes" type="checkbox" value="C013"/>冷抽
									</td>
								</tr>
								<tr>
									<td>
										<input name="btypes" type="checkbox" value="C999" style="float: left;"/>
										<a style="float: left;">其 他</a>
										<span style="float: left;"> </span><input id="textBtypesother2" type="text" class="txt c2"/>
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="btypes">
						<td colspan="5">
							<input id="btypes4" name="btypes" type="checkbox" value="D000"/> 買賣業
						</td>
					</tr>
					<tr class="btypes btypes4">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td>
										<input name="btypes" type="checkbox" value="D001" style="float: left;"/>碳鋼
										<input name="btypes" type="checkbox" value="D002" style="float: left;"/>不鏽鋼
										<input name="btypes" type="checkbox" value="D003" style="float: left;"/>合金鋼
										<input name="btypes" type="checkbox" value="D999" style="float: left;"/>其 它
										<a style="float: left;">其 他</a>
										<span style="float: left;"> </span><input id="textBtypesother3" type="text" class="txt c2"/>
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="btypes">
						<td colspan="5">
							<input id="btypes5" name="btypes" type="checkbox" value="E000"/> 原料 / 設備 / 耗材供應商(例：軋輥、耐火材、鐵合金、石料等)
						</td>
					</tr>
					<tr class="btypes btypes5">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td colspan="2">原料</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E001"/>鈮
										<input name="btypes" type="checkbox" value="E002"/>鈦
										<input name="btypes" type="checkbox" value="E003"/>鋁
										<input name="btypes" type="checkbox" value="E004"/>銅
										<input name="btypes" type="checkbox" value="E005"/>鉛
										<input name="btypes" type="checkbox" value="E006"/>鉬
										<input name="btypes" type="checkbox" value="E007"/>鋯
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E008"/>球結礦
										<input name="btypes" type="checkbox" value="E009"/>石料
										<input name="btypes" type="checkbox" value="E010"/>生鐵
										<input name="btypes" type="checkbox" value="E011"/>廢鋼
										<input name="btypes" type="checkbox" value="E012"/>鉻鐵
										<input name="btypes" type="checkbox" value="E013"/>釩鐵
										<input name="btypes" type="checkbox" value="E014"/>錳鐵
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E015"/>矽鐵(硅)
										<input name="btypes" type="checkbox" value="E016"/>硼
										<input name="btypes" type="checkbox" value="E017"/>鎳
										<input name="btypes" type="checkbox" value="E018"/>熱鐵磚HBI
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td colspan="2">設備 / 耗材</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E019"/>高爐
										<input name="btypes" type="checkbox" value="E020"/>直接還原設備
										<input name="btypes" type="checkbox" value="E021"/>連 鑄
										<input name="btypes" type="checkbox" value="E022"/>精煉爐
										<input name="btypes" type="checkbox" value="E023"/>電爐
										<input name="btypes" type="checkbox" value="E024"/>轉爐
										<input name="btypes" type="checkbox" value="E025"/>軋 輥 修 補
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E026"/>軋 輥
										<input name="btypes" type="checkbox" value="E027"/>耐 火 材
										<input name="btypes" type="checkbox" value="E028"/>油封
										<input name="btypes" type="checkbox" value="E029"/>軸承
										<input name="btypes" type="checkbox" value="E030"/>冷卻床
										<input name="btypes" type="checkbox" value="E031"/>酸液回收設備
										<input name="btypes" type="checkbox" value="E032"/> 冷軋機
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E033"/>熱軋機
										<input name="btypes" type="checkbox" value="E034"/>澆鑄粉
										<input name="btypes" type="checkbox" value="E035"/>發 電
										<input name="btypes" type="checkbox" value="E036"/>閥類
										<input name="btypes" type="checkbox" value="E037"/>泵浦
										<input name="btypes" type="checkbox" value="E038"/>起重機
										<input name="btypes" type="checkbox" value="E039"/>空調設備
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E040"/>機 械
										<input name="btypes" type="checkbox" value="E041"/>環 保
										<input name="btypes" type="checkbox" value="E042"/>檢 驗
										<input name="btypes" type="checkbox" value="E043"/>冷卻油
										<input name="btypes" type="checkbox" value="E044"/>溶劑
										<input name="btypes" type="checkbox" value="E045"/>防鏽油
										<input name="btypes" type="checkbox" value="E046"/>軋延油
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E047"/>儀 表
										<input name="btypes" type="checkbox" value="E048"/>鍛 造
										<input name="btypes" type="checkbox" value="E049"/>成 形
										<input name="btypes" type="checkbox" value="E050"/>裁 剪
										<input name="btypes" type="checkbox" value="E051"/>退火
										<input name="btypes" type="checkbox" value="E052"/>酸洗
										<input name="btypes" type="checkbox" value="E053"/>張力重捲線
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E054"/>調質機
										<input name="btypes" type="checkbox" value="E055"/>加 熱 爐
										<input name="btypes" type="checkbox" value="E056"/>研磨機
										<input name="btypes" type="checkbox" value="E057"/>真空精練爐
										<input name="btypes" type="checkbox" value="E058"/>集塵粉再回收設備
										<input name="btypes" type="checkbox" value="E059"/>噴碳機
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="btypes" type="checkbox" value="E060"/>氧氣場
										<input name="btypes" type="checkbox" value="E061"/>燒結工場
										<input name="btypes" type="checkbox" value="E062"/>煉焦工場
										<input name="btypes" type="checkbox" value="E063"/>電擊棒
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>