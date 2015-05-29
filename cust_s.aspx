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

				bbmMask = [['txtBdate', '9999/99/99'], ['txtEdate', '9999/99/99']];
				q_mask(bbmMask);
				
				q_cmbParse("cmbStatus", '@全部,'+q_getPara('cust.status'));
				q_cmbParse("cmbUnprocess", '@全部,1@未處理,2@已處理');
				q_cmbParse("cmbIssms", '@全部,1@是,2@否');
				
				$('#txtNoa').focus();
				q_gt('bizscope', "where=^^right(noa,3)='000'^^", 0, 0, 0, "bizscope");
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'bizscope':
						var as = _q_appendData("bizscope", "", true);
						if (as[0] != undefined) {
							var t_item = "@---------《 專 業 項 目 》---------";
							var t_item2 = "@---------《 兼 業 項 目 》---------";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].scope);
								t_item2 = t_item2 + (t_item2.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].scope);
							}
							q_cmbParse("cmbBizscope", t_item);
							q_cmbParse("cmbBizscope2", t_item2);
							if(abbm[q_recno]){
								$("#cmbBizscope").val(abbm[q_recno].bizscope);
								$("#cmbBizscope2").val(abbm[q_recno].bizscope2);
							}
						}
						break;
                }
            }

			function q_seekStr() {
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_noa = $('#txtNoa').val();
				t_comp = $('#txtComp').val();
				t_status = $('#cmbStatus').val();
				t_bizscope = $('#cmbBizscope').val();
				t_bizscope2 = $('#cmbBizscope2').val();
				t_unprocess = $('#cmbUnprocess').val();
				t_id = $('#txtId').val();
				t_issms = $('#cmbIssms').val();

				t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
				t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;

				var t_where = " 1=1 " + q_sqlPara2("kdate", t_bdate, t_edate) 
				+ q_sqlPara2("noa", t_noa) + q_sqlPara2("status", t_status) 
				+ q_sqlPara2("bizscope", t_bizscope)+ q_sqlPara2("bizscope2", t_bizscope2)+ q_sqlPara2("unprocess", t_unprocess);
				
				if(t_comp.length>0)
					t_where=t_where+" and charindex(N'"+t_comp+"',comp)>0 ";
					
				if(t_id.length>0)	
					t_where=t_where+" and noa=(select noa from custs where id='"+t_id+"' ) ";
				
				if(t_issms=='1')
					t_where=t_where+" and isnull(issms,0)=1 ";
				if(t_issms=='2')
					t_where=t_where+" and isnull(issms,0)=0 ";
				
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
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblComp'> </a></td>
					<td><input class="txt" id="txtComp" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td   style="width:35%;" ><a id='lblKdate'> </a></td>
					<td style="width:65%;  ">
						<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
						<span style="display:inline-block; vertical-align:middle">&sim;</span>
						<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblStatus'> </a></td>
					<td><select id="cmbStatus" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblBizscope'> </a></td>
					<td><select id="cmbBizscope" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblBizscope2'> </a></td>
					<td><select id="cmbBizscope2" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblUnprocess'> </a></td>
					<td><select id="cmbUnprocess" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblId'> </a></td>
					<td><input class="txt" id="txtId" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblIssms'> </a></td>
					<td><select id="cmbIssms" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
