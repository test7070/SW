<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
    <head>
        <title> </title>
        <script src="../script/jquery.min.js" type="text/javascript"></script>
        <script src='../script/qj2.js' type="text/javascript"></script>
        <script src='qset.js' type="text/javascript"></script>
        <script src='../script/qj_mess.js' type="text/javascript"></script>
        <script src="../script/qbox.js" type="text/javascript"></script>
        <script src='../script/mask.js' type="text/javascript"></script>
        <link href="../qbox.css" rel="stylesheet" type="text/css" />
        <link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
        <script type="text/javascript">    
            var q_name = "shipping";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var bbmNum = [];
            var bbmMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array();
			
			q_desc=1;
            $(document).ready(function() {
                bbmKey = ['noa'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus();
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
                // 1=Last  0=Top
            }
			
			var n_dockNow=[];
			n_dockNow.push({custno:'',bdock:'',mdock:'',edock:''});
            function mainPost() {
            	bbmMask = [['txtCldate', '9999/99/99']];
                q_mask(bbmMask);
                
                $.datepicker.regional['zh-TW']={
				   dayNames:["星期日","星期一","星期二","星期三","星期四","星期五","星期六"],
				   dayNamesMin:["日","一","二","三","四","五","六"],
				   monthNames:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   monthNamesShort:["一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"],
				   prevText:"上月",
				   nextText:"次月",
				   weekHeader:"週"
				};
				//將預設語系設定為中文
				$.datepicker.setDefaults($.datepicker.regional["zh-TW"]);
                
                q_cmbParse("cmbShipline", '@全部,'+q_getPara('shipping.shipline'));
                q_cmbParse("cmbBdock",'@無');
                q_cmbParse("cmbMdock",'@無');
                q_gt('cust', "where=^^ isnull(isshipcomp,0) =1 ^^", 0, 0, 0, "cust");
                q_gt('dock', '', 0, 0, 0, "dock");
                
                $('#cmbCustno').change(function() {
                	$('#txtComp').val($('#cmbCustno').find("option:selected").text());
                	q_gt('ship', "where=^^ noa='"+$('#cmbCustno').val()+"' ^^", 0, 0, 0, "ship");
				});
                $('#cmbBarea').change(function() {
                	dockChange('B');
				});
				$('#cmbMarea').change(function() {
                	dockChange('M');
				});
            }
            
            function dockChange(dock) {
            	if(dock!='' && docks!=undefined){
	            	$("#cmb"+dock+"dock").text('');
	            	var t_dock='@無';
					for (i=0;i<docks.length;i++){
						if(docks[i].area==$("#cmb"+dock+"area").val())
							t_dock=t_dock+','+docks[i].dock+"@"+docks[i].dock;
					}
					q_cmbParse("cmb"+dock+"dock", t_dock);
				}
				if(n_dockNow[0] && dock=='B')
					$("#cmb"+dock+"dock").val(n_dockNow[0].bdock);
				if(n_dockNow[0] && dock=='M')
					$("#cmb"+dock+"dock").val(n_dockNow[0].mdock);
			}

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }
			var area,docks;
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'cust':
                		var as = _q_appendData("cust", "", true);
                		if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].nick!=''?as[i].nick:as[i].comp);
							}
							q_cmbParse("cmbCustno", t_item);
							if(abbm[q_recno])
								$("#cmbCustno").val(abbm[q_recno].custno);
						}
                		break;
                	case 'ship':
                			var as = _q_appendData("ship", "", true);
                			if (as[0] != undefined) {
                				$('#cmbShipname').text('');
                				var t_item = "@";
								for (i = 0; i < as.length; i++) {
									t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].shipname) + '@' + $.trim(as[i].shipname);
								}
								q_cmbParse("cmbShipname", t_item);
								if(abbm[q_recno])
									$("#cmbShipname").val(abbm[q_recno].shipname);
                			}
                		break;
                	case 'dock':
                		area = _q_appendData("dock", "", true);
                		if(area[0] != undefined){
                			docks = _q_appendData("docks", "", true);
							var t_item = "@";
							for (i = 0; i < area.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(area[i].area) + '@' + $.trim(area[i].area);
							}
							q_cmbParse("cmbBarea", t_item);
							q_cmbParse("cmbMarea", t_item);
							if(abbm[q_recno]){
								$("#cmbBarea").val(abbm[q_recno].barea);
								$("#cmbMarea").val(abbm[q_recno].marea);
								dockChange('B');
	                			dockChange('M');
							}
						}
                		
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }  /// end switch
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('shipping_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtCustno').focus();
                $('#cmbBdock').text('');
                $('#cmbMdock').text('');
                $('#cmbShipname').text('');
                n_dockNow[0].bdock='';
	            n_dockNow[0].mdock='';
                q_cmbParse("cmbBdock",'@無');
                q_cmbParse("cmbMdock",'@無');
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtCustno').focus();
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
            	var t_err = '';
                t_err = q_chkEmpField([['txtCustno', q_getMsg('lblCust')],['txtComp', q_getMsg('lblCust')]
                ,['txtBdate', q_getMsg('lblBdate')],['txtEdate', q_getMsg('lblBdate')],['cmbTypea', q_getMsg('lblTypea')]
                ,['txtImage1', q_getMsg('lblImage1')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                            	
				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
				}

				var s1 = $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val();
				if (s1.length == 0 || s1 == "AUTO")
					q_gtnoa(q_name, replaceAll(q_date(), '/', ''));
				else
					wrServer(s1);

            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }

            function refresh(recno) {
                _refresh(recno);
                if(abbm[q_recno]){
	                n_dockNow[0].bdock=abbm[q_recno].bdock;
	                n_dockNow[0].mdock=abbm[q_recno].mdock;
	                n_dockNow[0].custno=abbm[q_recno].custno;
	                dockChange('B');
	                dockChange('M');
	                q_gt('ship', "where=^^ noa='"+abbm[q_recno].custno+"' ^^", 0, 0, 0, "ship");
				}
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                	$('#txtCldate').datepicker( 'destroy' );
                }else{
					$('#txtCldate').removeClass('hasDatepicker')
					$('#txtCldate').datepicker({ dateFormat: 'yy/mm/dd' });
                }
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
                width: 1250px;
            }
            .tview {
            	width:100%;
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
                width: 1250px;
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
            .tbbm tr td {
                
            }
            .tbbm .tdZ {
                width: 2%;
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
            .txt.c1 {
                width: 99%;
                float: left;
            }
            .txt.c2 {
                width: 38%;
                float: left;
            }
            .txt.c3 {
                width: 60%;
                float: left;
            }
            .txt.c4 {
                width: 18%;
                float: left;
            }
            .txt.c5 {
                width: 80%;
                float: left;
            }
            .txt.c6 {
                width: 50%;
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
                font-size: medium;
            }
            .tbbm textarea {
                font-size: medium;
            }

            input[type="text"], input[type="button"] {
                font-size: medium;
            }
		</style>
	</head>
	<body>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;">
			<div class="dview" id="dview" style="float: left; "  >
				<table class="tview" id="tview"   border="1" cellpadding='2'  cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:3%"><a id='vewChk'> </a></td>
						<td align="center" style="width:15%"><a id='vewShipline'> </a></td>
						<td align="center" style="width:10%"><a id='vewCldate'> </a></td>
						<td align="center" style="width:35%"><a id='vewComp'> </a></td>
						<td align="center" style="width:35%"><a id='vewShipname'> </a></td>
					</tr>
					<tr>
						<td >
						<input id="chkBrow.*" type="checkbox" style=''/>
						</td>
						<td align="center" id='shipline'>~shipline</td>
						<td align="center" id="cldate">~cldate</td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='shipname'>~shipname</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 130px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 130px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblShipline' class="lbl"> </a></td>
						<td><select id="cmbShipline" class="txt c1"> </select></td>
						<td><span> </span><a id='lblVoyage' class="lbl"> </a></td>
						<td><input id="txtVoyage"  type="text"  class="txt c1"/></td>
						<td><input id="txtNoa"  type="text" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl"> </a></td>
						<td>
							<select id="cmbCustno" class="txt c1"> </select>
							<input id="txtComp"  type="text"  style="display: none;"/>
						</td>
						<td><span> </span><a id='lblCldate' class="lbl"> </a></td>
						<td><input id="txtCldate"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblShipname' class="lbl"> </a></td>
						<td><select id="cmbShipname" class="txt c1"> </select></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBarea' class="lbl"> </a></td>
						<td><select id="cmbBarea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblBdock' class="lbl"> </a></td>
						<td><select id="cmbBdock" class="txt c1"> </select></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMarea' class="lbl"> </a></td>
						<td><select id="cmbMarea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblMdock' class="lbl"> </a></td>
						<td><select id="cmbMdock" class="txt c1"> </select></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEdock' class="lbl"> </a></td>
						<td colspan="3"><input id="txtEdock"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
				</table>
			</div>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
