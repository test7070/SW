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
			var q_name = 'custw', t_bbsTag = 'tbbs', t_content = " ", afilter = [], bbsKey = ['noa'], t_count = 0, as, brwCount = -1;
			brwCount2 = 0;
			var t_sqlname = q_name;
			t_postname = q_name;
			var isBott = false;
			var afield, t_htm;
			var i, s1;
			var decbbs = [];
			var decbbm = [];
			var q_readonly = [];
			var q_readonlys = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var Parent = window.parent;
			
			var currentNoa = '';

			/*aPop = new Array(
				['txtProductno_', 'btnProductno_', 'ucaucc', 'noa,product', 'txtProductno_,txtProduct_', 'ucaucc_b.aspx']
				,['txtUcolor_', 'btnUcolor_', 'view_uccc2', 'uno,productno,product,eweight', '0txtUcolor_,txtProductno_,txtProduct_,txtWeight_', 'uccc_seek_b2.aspx?;;;1=0', '95%', '95%']
			);*/
			
			$(document).ready(function() {
				bbmKey = [];
				bbsKey = ['noa', 'noq'];
				if (!q_paraChk())
					return;
				main();
			});
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
			}

			function mainPost() {
				q_mask(bbmMask);
				parent.$.fn.colorbox.resize({
					height : "750px"
				});
			}


			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(i + 1);
					if (!$('#btnMinus_' + i).hasClass('isAssign')) {
						/*$('#txtUcolor_' + i).bind('contextmenu', function(e) {
							e.preventDefault();
							if(!(q_cur==1 || q_cur==2))
								return;
                            var n = $(this).attr('id').replace(/^(.*)_(\d+)$/,'$2');
                            $('#btnUcolor_'+n).click();
                        });*/
					}
				}
				_bbsAssign();
				for (var i = 0; i < q_bbsCount; i++) {
					if(!$('#txtBdate_'+i).hasClass('hasDatepicker')){
						$('#txtBdate_'+i).datepicker();
					}
					if(!$('#txtEdate_'+i).hasClass('hasDatepicker')){
						$('#txtEdate_'+i).datepicker();
					}		
				}
			}

			function btnOk() {
				console.log('btnOk');
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
			}
			function q_funcPost(t_func, result) {
                switch(t_func) {
                    default:
                        break;
                }
            }
            function q_gtPost(t_name) {
				switch (t_name) {
					case q_name:
						break;
					default:
                    	break;
				}
			}
			
			function bbsSave(as) {
				if (!as['bdate']) {
					as[bbsKey[0]] = '';
					return;
				}
				q_getId2('', as);
				return true;
			}

			function btnModi() {
				var t_key = q_getHref();
				if (!t_key)
					return;
				_btnModi(1);
			}
			function q_stPost() {
				if (!(q_cur == 1 || q_cur == 2))
					return false;
			}
			
			function refresh() {
				_refresh();
			}


			function q_popPost(s1) {
				switch (s1) {
					default:
						break;
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
				if (q_tables == 's')
					bbsAssign();
			}
		</script>
		<style type="text/css">
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
			.txt {
				float: left;
			}
			.c1 {
				width: 95%;
			}
			.num {
				text-align: right;
			}
			.btn {
				font-weight: bold;
			}
			#lblNo {
				font-size: medium;
			}
		</style>
	</head>
	<body>
		<div id="dbbs" style="width:700px;">
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%;font-size: medium;'>
				<tr style='color:white; background:#003366;' >
					<td align="center">
					<input class="btn"  id="btnPlus" type="button" value='＋' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:150px;">頁面</td>
					<td align="center" style="width:150px;">起始日</td>
					<td align="center" style="width:150px;">終止日</td>
					<td align="center" style="width:200px;">備註</td>
					
				</tr>
				<tr style="background:#cad3ff;font-size: 14px;">
					<td><input class="btn"  id="btnMinus.*" type="button" value="－" style="font-weight: bold;"/></td>
					<td style="text-align:center;">
						<a id="lblNo.*"> </a>
						<input type="text" id="txtNoq.*" style="display:none;"/>
					</td>
					<td><select id="cmbPagename" class="txt c1"> </select></td>
					<td><input type="text" id="txtBdate.*" class="txt c1"/></td>
					<td><input type="text" id="txtEdate.*" class="txt c1"/></td>
					<td><input type="text" id="txtMemo.*" class="txt c1"/></td>					
				</tr>
			</table>
			<!--#include file="../inc/pop_modi.inc"-->
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>