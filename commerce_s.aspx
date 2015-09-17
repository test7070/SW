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
			var q_name = "cust_s";
			aPop = new Array();
			$(document).ready(function() {
				main();
			});
			/// end ready

			function main() {
				mainSeek();
				q_gf('', q_name);
			}

			function q_gfPost() {
				q_getFormat();
				q_langShow();

				bbmMask = [['txtBdatea', '9999/99/99'], ['txtEdatea', '9999/99/99'],['txtBedate', '9999/99/99'], ['txtEedate', '9999/99/99']];
				q_mask(bbmMask);
				
				q_cmbParse("cmbTypea", '@全部,A@原料,B@半成品,C@碳鋼成品,D@不鏽鋼成品,E@特殊鋼成品,F@終端成品,G@非鐵金屬,H@機械設備,I@其他產品');
				q_cmbParse("cmbOnline", '@全部,Y@上線,N@未上線');
				
				$('#txtNoa').focus();
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    default:
						break;
                }
            }

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_bdatea = $('#txtBdatea').val();
				t_edatea = $('#txtEdatea').val();
				t_bedate = $('#txtBedate').val();
				t_eedate = $('#txtEedate').val();
				t_typea = $('#cmbTypea').val();
				t_product = $('#txtProduct').val();
				t_conn = $('#txtConn').val();
				t_comp = $('#txtComp').val();
				t_online = $('#txtOnline').val();
			
				var t_where = " 1=1 " 
					+ q_sqlPara2("noa", t_noa)
					+ q_sqlPara2("datea", t_bdatea, t_edatea) 
					+ q_sqlPara2("edate", t_bedate, t_eedate);
					
				if(t_product.length>0)
					t_where=t_where+" and (charindex(N'"+t_product+"',product)>0 or charindex(N'"+t_product+"',product2)>0) ";
					
				if(t_conn.length>0)	
					t_where=t_where+" and charindex(N'"+t_conn+"',namea)>0 ";
				if(t_comp.length>0)	
					t_where=t_where+" and charindex(N'"+t_comp+"',comp)>0 ";
				if(t_typea.length>0)
					t_where=t_where+q_sqlPara2("typea", t_typea);
				if(t_online=='Y')
					t_where=t_where+" and [online]=1";
				if(t_online=='N')
					t_where=t_where+" and isnull([online],0)=1";
				t_where = ' where=^^' + t_where + '^^ ';
				return t_where;
			}
		</script>
		<style type="text/css">
			.seek_tr {
				color: white;
				text-align: center;
				font-weight: bold;
				BACKGROUND-COLOR: #76a2fe
			}
		</style>
	</head>
	<body>
		<div style='width:400px; text-align:center;padding:15px;' >
			<table id="seek"  border="1"   cellpadding='3' cellspacing='2' style='width:100%;' >
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>電腦編號</a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a>登錄日期</a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdatea" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdatea" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a>有效日期</a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBedate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEedate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>產品類別</a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a>產品名稱</a></td>
					<td><input class="txt" id="txtProduct" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a>聯絡人</a></td>
					<td><input class="txt" id="txtConn" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a>公司名稱</a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a>上線</a></td>
					<td><select id="cmbOnline" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
