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
			var q_name = "import_s";
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

				bbmMask = [['txtBmon', '9999/99'], ['txtEmon', '9999/99']];
				q_mask(bbmMask);

				$('#txtBmon').focus();
				
				q_cmbParse("cmbCountry", '@全部,'+q_getPara('import.country'));
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    
                }
            }

			function q_seekStr() {
				t_bmon = $('#txtBmon').val();
				t_emon = $('#txtEmon').val();
				t_country = $('#cmbCountry').val();

				t_bmon = t_bmon.length > 0 && t_bmon.indexOf("_") > -1 ? t_bmon.substr(0, t_bmon.indexOf("_")) : t_bmon;
				t_emon = t_emon.length > 0 && t_emon.indexOf("_") > -1 ? t_emon.substr(0, t_emon.indexOf("_")) : t_emon;

				var t_where = " 1=1 " + q_sqlPara2("mon", t_bmon, t_emon) + q_sqlPara2("country", t_country);

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
					<td   style="width:35%;" ><a id='lblMon'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBmon" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEmon" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblCountry'> </a></td>
					<td><select id="cmbCountry" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
