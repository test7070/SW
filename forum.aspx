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
        	this.errorHandler = null;
		    function onPageError(error) {
		        alert("An error occurred:\r\n" + error.Message);
		    }
		    
			q_tables = 's';
            var q_name = "forum";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2','txtUdate'];
            var bbmNum = [];
            var bbsNum = [];
            var bbmMask = [];
            var bbsMask = [];
            q_sqlCount = 6;
            brwCount = 6;
            brwCount2 = 8;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
            //ajaxPath = ""; //  execute in Root
            aPop = new Array(
            	['txtCustno', 'lblCust', 'cust', 'noa,comp', 'txtCustno,txtComp', 'cust_b.aspx']
            );
			
			q_desc=1;
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa', 'noq'];
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
            	bbmMask = [['txtDatea', '9999/99/99'],['txtUdate', '9999/99/99']];
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
                q_gt('forumtype', '', 0, 0, 0, "forumtype");
            }

            function q_boxClose(s2) {
                var ret;
                switch (b_pop) {
                    case q_name + '_s':
                        q_boxClose2(s2);
                        break;

                }
            }
            
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'forumtype':
                		var as = _q_appendData("forumtype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].typea);
							}
							q_cmbParse("cmbTypea", t_item);
							if(abbm[q_recno])
								$("#cmbTypea").val(abbm[q_recno].typea);
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
                q_box('forum_s.aspx', q_name + '_s', "500px", "350px", q_getMsg("popSeek"));
            }
            
            function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            }
		        }
		        _bbsAssign();
		        if(q_cur==1){
		        	$('.dbbs').hide();
		        }else{
		        	$('.dbbs').show();
		        }
		        showbbslbl();
		    }
		    
		    function showbbslbl() {
                for (var i = 0; i < q_bbsCount; i++) {
                	$('#lblRdate_'+i).text($('#txtRdate_'+i).val());
                	$('#lblNamea_'+i).text($('#txtNamea_'+i).val()+"("+$('#txtId_'+i).val()+")");
                	$('#lblEmail_'+i).text($('#txtEmail_'+i).val());
                	$('#lblReply_'+i).text($('#txtReply_'+i).val());
                }
            }

            function btnIns() {
                _btnIns();
                $('#txtTitle').focus();
                $('#txtDatea').val(q_date());
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtReply').focus();
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
                t_err = q_chkEmpField([['txtTitle', q_getMsg('lblTitle')],['cmbTypea', q_getMsg('lblTypea')]
                ,['txtDatea', q_getMsg('lblDatea')],['txtEmail', q_getMsg('lblEmail')],['txtNamea', q_getMsg('lblNamea')]
                ,['txtId', q_getMsg('lblNamea')]]);
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                
                if(!emp($('#txtCustno').val()) || !emp($('#txtReply').val()))
                	$('#txtIsreply').val('已回覆');
                else
                	$('#txtIsreply').val('未回覆');
                            	
				if(q_cur==1){
					$('#txtWorker').val(r_name);
				}else{
					$('#txtWorker2').val(r_name);
					$('#txtUdate').val(q_date());
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
                   _btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
		    }

		    function bbsSave(as) {
		        if (!as['id']&&!as['namea']&&!as['rdate']&&!as['reply']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        return true;
		    }
		    
            function refresh(recno) {
                _refresh(recno);
                if(!emp($('#txtId').val()))
                	$('#lblId').text("(會員帳號:"+$('#txtId').val()+")");
                showbbslbl();
            }
            
            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                 if(t_para){
                	$('#txtDatea').datepicker( 'destroy' );
                	//$('#txtUdate').datepicker( 'destroy' );
                }else{
					$('#txtDatea').removeClass('hasDatepicker')
					$('#txtDatea').datepicker({ dateFormat: 'yy/mm/dd' });
					//$('#txtUdate').removeClass('hasDatepicker')
					//$('#txtUdate').datepicker({ dateFormat: 'yy/mm/dd' });
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
			 .dbbs {
				width: 1250px;
			}
			.dbbs .tbbs {
				margin: 0;
				padding: 2px;
				border: 2px lightgrey double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				/*background: #cad3ff;*/
				background: lightgrey;
				width: 100%;
			}
			.dbbs .tbbs tr {
				height: 35px;
			}
			.dbbs .tbbs tr td {
				text-align: center;
				border: 2px lightgrey double;
			}
			.dbbs tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                cursor: pointer;
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
						<td align="center" style="width:30%"><a id='vewTitle'> </a></td>
						<td align="center" style="width:10%"><a id='vewDatea'> </a></td>
						<td align="center" style="width:10%"><a id='vewUdate'> </a></td>
						<td align="center" style="width:10%"><a id='vewRcount'> </a></td>
						<td align="center" style="width:20%"><a id='vewIsreply'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='title'>~title</td>
						<td align="center" id="datea">~datea</td>
						<td align="center" id='udate'>~udate</td>
						<td align="center" id='rcount'>~rcount</td>
						<td align="center" id='isreply comp'>~isreply ~comp</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="float: left;">
				<table class="tbbm"  id="tbbm"   border="0" cellpadding='2'  cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 150px"> </td>
						<td style="width: 470px"> </td>
						<td style="width: 150px"> </td>
						<td style="width: 470px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTitle' class="lbl"> </a></td>
						<td><input id="txtTitle"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><input id="txtNoa"  type="text" style="display: none;"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblUdate' class="lbl"> </a></td>
						<td><input id="txtUdate"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblNamea' class="lbl"> </a></td>
						<td>
							<input id="txtId"  type="hidden"/>
							<input id="txtNamea"  type="text"  class="txt c2"/>
							<span style="float: left;"> </span><a id='lblId' class="lbl" style="float: left;"> </a>
						</td>
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td><input id="txtEmail"  type="text"  class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtMemo" cols="10" rows="6" style="width: 99%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblReply' class="lbl"> </a></td>
						<td colspan="3"><textarea id="txtReply" cols="10" rows="6" style="width: 99%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCust' class="lbl btn"> </a></td>
						<td>
							<input id="txtCustno"  type="text"  class="txt c2"/>
							<input id="txtComp"  type="text"  class="txt c3"/>
						</td>
						<td>
							<input id="txtIsreply"  type="text" style="display: none;"/>
							<input id="txtRcount"  type="text" style="display: none;"/>
						</td>
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
		<div class='dbbs'>
			<table id="tbbs" class='tbbs'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:100px;"><a id='lblRdate_s'> </a></td>
					<td align="center" style="width:200px;"><a id='lblNamea_s'> </a>(<a id='lblId_s'> </a>)</td>
					<td align="center" style="width:200px;"><a id='lblEmail_s'> </a></td>
					<td align="center"><a id='lblReply_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td >
						<a id="lblRdate.*"> </a>
						<input type="hidden" id="txtRdate.*" class="txt c1" />
					</td>
					<td >
						<a id="lblNamea.*"> </a>
						<input type="hidden" id="txtNamea.*"/><input type="hidden" id="txtId.*" />
					</td>
					<td >
						<a id="lblEmail.*"> </a>
						<input type="hidden" id="txtEmail.*" class="txt c1" />
					</td>
					<td >
						<a id="lblReply.*"> </a>
						<input type="hidden" id="txtReply.*" class="txt c1" />
					</td>
				</tr>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
