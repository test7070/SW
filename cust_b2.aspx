<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'cust', t_content = ' field=noa,comp,nick,tel,fax,conn,email,status', bbsKey = ['noa'], as;
            var t_sqlname = 'cust_load';
            t_postname = q_name;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            brwCount = -1;
            brwCount2 = 0;
            $(document).ready(function() {
                main();
            });
            /// end ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                
                mainBrow(6, t_content, t_sqlname, t_postname, r_accy);
                
                $('#btnTop').hide();
                $('#btnPrev').hide();
                $('#btnNext').hide();
                $('#btnBott').hide();
            	
				$('#btnSearch').click(function() {
					var t_where="1=1";
					if(!emp($('#textId').val())){
						t_where+=" and noa in (select noa from where id='"+$('#textId').val()+"') ";
					}
					if(!emp($('#textComp').val())){
						t_where+=" and charindex('"+$('#textComp').val()+"',comp)>0";
					}
					if(!emp($('#combStatus').val())){
						t_where+=" and status='"+$('#combStatus').val()+"' ";
					}
					//t_where="where=^^"+t_where+"^^"
					location.href = location.origin+location.pathname+"?" + r_userno + ";" + r_name + ";" + q_id + ";"+t_where+";"+r_accy;
				});
            }

            function q_gtPost() {
            }

            function refresh() {
                _refresh();
                $('#checkAllCheckbox').click(function() {
                    $('input[type=checkbox][id^=chkSel]').each(function() {
                        $(this).attr('checked', $('#checkAllCheckbox').is(':checked'));
                    });
                });
                q_cmbParse("combStatus", ','+q_getPara('cust.status'));
            }
            
            function bbsAssign() {
                _bbsAssign();
            }
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dbbs"  >
			<div>
				<a>會員ID</a>
				<input class="txt" id="textId" type="text" style="width:130px;" />
				<a>會員狀態</a>
				<select id="combStatus" style="width:130px;" > </select>
				<BR>
				<a>公司名 </a>
				<input class="txt" id="textComp" type="text" style="width:260px;" />
				<input type="button" id="btnSearch" style="border-style: none; width: 36px; height: 36px; cursor: pointer; background: url(../image/search_32.png) 0px 0px no-repeat;">
			 </div>
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<td align="center" ><input type="checkbox" id="checkAllCheckbox"/> </td>
					<td align="center" style='color:Blue;display: none;'><a id='lblSerial'> </a></td>
					<td align="center" style='color:Blue;' ><a id='lblMid'> </a></td>
					<td align="center" style='color:Blue;' ><a id='lblComp'> </a></td>
					<td align="center" style='color:Blue;' ><a id='lblStatus'> </a></td>
				</tr>
				<tr>
					<td style="width:2%;"><input name="chk"  id="chkSel.*" type="checkbox" /></td>
					<td style="width:20%;display: none;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:20%;"><input class="txt" id="txtMid.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:55%;"><input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:25%;"><input class="txt" id="txtStatus.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>

