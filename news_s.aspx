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
			var q_name = "news_s";
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

				$('#txtBdate').focus();
				
				q_gt('newsstype', '', 0, 0, 0, "");
				q_gt('newsarea', '', 0, 0, 0, "");
				q_gt('newstypea', "where=^^groupa='A'^^", 0, 0, 0, "newstypea_A");
				q_gt('newstypea', "where=^^groupa='B'^^", 0, 0, 0, "newstypea_B");
			}
			
			function q_gtPost(t_name) {
                switch (t_name) {
                    case 'newsstype':
                        var as = _q_appendData("newsstype", "", true);
                        if (as[0] != undefined) {
                            t_item = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].stype;
                            }
                            q_cmbParse("cmbStype", t_item);
                        }
                        break;
                     case 'newsarea':
                        var as = _q_appendData("newsarea", "", true);
                        if (as[0] != undefined) {
                            t_item = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].area;
                            }
                            q_cmbParse("cmbArea", t_item);
                        }
                        break;
					case 'newstypea_A':
                        var as = _q_appendData("newstypea", "", true);
                        if (as[0] != undefined) {
                            t_item = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].typea;
                            }
                            q_cmbParse("cmbTypea_a", t_item);
                        }
                        break;
                    case 'newstypea_B':
                        var as = _q_appendData("newstypea", "", true);
                        if (as[0] != undefined) {
                            t_item = '@全部';
                            for ( i = 0; i < as.length; i++) {
                                t_item = t_item + (t_item.length > 0 ? ',' : '') + as[i].noa + '@' + as[i].typea;
                            }
                            q_cmbParse("cmbTypea_b", t_item);
                        }
                        break;
                }
            }

			function q_seekStr() {
				t_noa = $('#txtNoa').val();
				t_bdate = $('#txtBdate').val();
				t_edate = $('#txtEdate').val();
				t_sssno = $('#txtSssno').val();
				t_namea = $('#txtNamea').val();
				t_stype = $('#cmbStype').val();
				t_typea_a = $('#cmbTypea_a').val();
				t_typea_b = $('#cmbTypea_b').val();
				t_area = $('#cmbArea').val();
				t_title = $('#txtTitle').val();

				t_bdate = t_bdate.length > 0 && t_bdate.indexOf("_") > -1 ? t_bdate.substr(0, t_bdate.indexOf("_")) : t_bdate;
				t_edate = t_edate.length > 0 && t_edate.indexOf("_") > -1 ? t_edate.substr(0, t_edate.indexOf("_")) : t_edate;

				var t_where = " 1=1 " + q_sqlPara2("noa", t_noa) + q_sqlPara2("datea", t_bdate, t_edate) 
				+ q_sqlPara2("sssno", t_sssno) + q_sqlPara2("namea", t_namea) 
				+ q_sqlPara2("stype", t_stype) + q_sqlPara2("area", t_area);
				
				if (t_title.length>0){
					t_where=t_where+" and (charindex('"+t_title+"',title)>0 or charindex('"+t_title+"',title2)>0 ) ";
				}
				if (t_typea_a.length>0){
					t_where+=" and ( charindex(',"+t_typea_a+",',','+typea+',')>0 ) ";
				}
				if (t_typea_b.length>0){
					t_where+=" and ( charindex(',"+t_typea_b+",',','+typea2+',')>0 ) ";
				}

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
					<td   style="width:35%;" ><a id='lblDatea'></a></td>
					<td style="width:65%;  ">
					<input class="txt" id="txtBdate" type="text" style="width:90px; font-size:medium;" />
					<span style="display:inline-block; vertical-align:middle">&sim;</span>
					<input class="txt" id="txtEdate" type="text" style="width:93px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblNoa'> </a></td>
					<td><input class="txt" id="txtNoa" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblSss'> </a></td>
					<td>
					<input class="txt" id="txtSssno" type="text" style="width:90px; font-size:medium;" />
					&nbsp;
					<input class="txt" id="txtNamea" type="text" style="width:115px; font-size:medium;" />
					</td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek'  style="width:20%;"><a id='lblTitle'> </a></td>
					<td><input class="txt" id="txtTitle" type="text" style="width:215px; font-size:medium;" /></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblStype'> </a></td>
					<td><select id="cmbStype" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblTypea_a'>文章屬性一</a></td>
					<td><select id="cmbTypea_a" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblTypea_b'>文章屬性二</a></td>
					<td><select id="cmbTypea_b" style="width:215px; font-size:medium;"> </select></td>
				</tr>
				<tr class='seek_tr'>
					<td class='seek' style="width:30%;"><a id='lblArea'> </a></td>
					<td><select id="cmbArea" style="width:215px; font-size:medium;"> </select></td>
				</tr>
			</table>
			<!--#include file="../inc/seek_ctrl.inc"-->
		</div>
	</body>
</html>
