<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<script src="../script/jquery.min.js" type="text/javascript"></script>
		<script src='../script/qj2.js' type="text/javascript"></script>
		<script src='qset.js' type="text/javascript"></script>
		<script src='../script/qj_mess.js' type="text/javascript"></script>
		<script src='../script/mask.js' type="text/javascript"></script>
		<script src="../script/qbox.js" type="text/javascript"></script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript">
            var q_name = 'ship', t_bbsTag = 'tbbs', t_content = "", afilter = [] , bbmKey = [], bbsKey = ['noa,noq'], as, brwCount2 = 0;
            var t_sqlname = 'ship_load';
            t_postname = q_name;
            var isBott = false;
			brwCount=-1;
            var afield, t_htm;
            var i, s1;
            var q_readonly = [];
            var q_readonlys = [];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];

            aPop = new Array();

            $(document).ready(function() {
                bbmKey = [];
                bbsKey = ['noa', 'noq'];
                if(location.href.indexOf('?') < 0)// debug
                {
                    location.href = location.href + "?;;;noa='0015'";
                    return;
                }
                if(!q_paraChk())
                    return;

                main();
            });
            
            function main() {
                if(dataErr) {
                    dataErr = false;
                    return;
                }
                mainBrow(6, t_content, t_sqlname, t_postname);
                q_mask(bbmMask);
                bbsMask = [];
            }

            function q_gtPost(t_name) {
                switch (t_name) {
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch

            }
            function bbsAssign() {
            	for(var j = 0; j < q_bbsCount; j++) {
            	}
                _bbsAssign();
            }

            function btnOk() {
            	if(q_getHref()[0] == 'noa' && q_getHref()[1] != '' ){
	            	
            	}else{
            		alert("read error!");
            		return;
            	}
                t_key = q_getHref();
                _btnOk(t_key[1], bbsKey[0], bbsKey[1], '', 2);
                
            }

            function bbsSave(as) {
                if(!as['shipname']) {// Dont Save Condition
                    as[bbsKey[0]] = '';
                    return;
                }
                q_getId2('', as);
                return true;
            }
            function refresh() {
                _refresh();
            }
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
            }

            function btnMinus(id) {
                _btnMinus(id);
                sum();
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
                if(q_tables == 's')
                    bbsAssign();
            }

		</script>
		<style type="text/css">
            td a {
                font-size: medium;
            }
            input[type="text"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<div  id="dbbs"  >
			<!--#include file="../inc/pop_modi.inc"-->
			<table id="tbbs" class='tbbs'  border="2"  cellpadding='2' cellspacing='1' style='width:100%'  >
				<tr style='color:white; background:#003366;' >
					<td align="center" style="width:1%; max-width:20px;">
						<input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  />
					</td>
					<td align="center" style="width:18%;"><a id='lblShipname'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style="font-weight: bold; "  />
						<input class="txt c1"  id="txtNoa.*" type="hidden"  />
                    	<input id="txtNoq.*" type="hidden" />
					</td>
					<td><input id="txtShipname.*" type="text" class="txt c1" style="width:95%;"/></td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
