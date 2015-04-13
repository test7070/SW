<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
			var q_name = "ad_s";
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

				bbmMask = [['txtBdate', '9999/99/99'], ['txtEdate', '9999/99/99']];
				q_mask(bbmMask);
				q_cmbParse("cmbTypea", '@全部,'+q_getPara('ad.typea'));

				$('#txtBdate').focus();
				
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    
                }
            }

			function q_seekStr() {
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_custno = $('#txtCustno').val();
				t_comp = $('#txtComp').val();
				t_typea = $('#cmbTypea').val();

				t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
				t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;

				var t_where = " 1=1 " + q_sqlPara2("edate", t_bdate, t_edate) 
				+ q_sqlPara2("custno", t_custno) + q_sqlPara2("comp", t_comp) 
				+ q_sqlPara2("typea", t_typea);

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
					<td class='seek'  style="width:20%;"><a id='lblCust'> </a></td>
					<td>
						<input class="txt" id="txtCustno" type="text" style="width:90px; font-size:medium;" />&nbsp;
						<input class="txt" id="txtComp" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblEdate'> </a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblTypea'> </a></td>
					<td><select id="cmbTypea" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>