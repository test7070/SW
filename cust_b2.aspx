<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta http-equiv="Content-Language" content="en-us" />
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src="../script/qj2.js" type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src="../script/qj_mess.js" type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'cust', t_content = ' field=noa,comp,nick,tel,fax,conn,email', bbsKey = ['noa'], as;
            var isBott = false;
            /// 是否已按過 最後一頁
            var txtfield = [], afield, t_data, t_htm, t_bbsTag = 'tbbs';
            var i, s1;
            
            $(document).ready(function() {
                main();
            });
            /// end ready
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(0, t_content);
                brwCount2 = 0;
            	brwCount = -1;
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
            }
		</script>
		<style type="text/css">
		</style>
	</head>

	<body>
		<div  id="dbbs"  >
			<table id="tbbs"  border="2"  cellpadding='0' cellspacing='0' style='width:98%' >
				<tr>
					<td align="center" ><input type="checkbox" id="checkAllCheckbox"/> </td>
					<td align="center" style='color:Blue;' ><a id='lblSerial'> </a></td>
					<td align="center" style='color:Blue;' ><a id='lblComp'> </a></td>
				</tr>
				<tr>
					<td style="width:2%;"><input name="chk"  id="chkSel.*" type="checkbox" /></td>
					<td style="width:20%;"><input class="txt" id="txtNoa.*" type="text" style="width:98%;"  readonly="readonly" /></td>
					<td style="width:75%;"><input class="txt" id="txtComp.*" type="text" style="width:98%;"  readonly="readonly" /></td>
				</tr>
			</table>
			<!--#include file="../inc/brow_ctrl.inc"-->
		</div>

	</body>
</html>
