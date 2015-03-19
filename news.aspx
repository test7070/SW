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
		<script src="css/jquery/ui/jquery.ui.datepicker_tw.js"></script>
		<script type="text/javascript">
		
			q_tables = 't';
            var q_name = "news";
            var q_readonly = ['txtNoa','txtWorker','txtWorker2'];
            var q_readonlys =[];
            var q_readonlyt =[];
            var bbmNum = [];
            var bbsNum = [];
            var bbtNum = [];
            var bbmMask = [];
            var bbsMask = [];
            var bbtMask = [];
     
            q_sqlCount = 6;
            brwCount = 6;
            brwList = [];
            brwNowPage = 0;
            brwKey = 'noa';
			brwCount2 =13;
			aPop = new Array(['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']);
            				
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa','noq'];
                bbtKey = ['noa','noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });

            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
			
			var n_typeb=[],n_typec=[],n_typed=[],n_typeNow=[];
			n_typeNow.push({typea:'',typeb:'',typec:'',typed:''});
            function mainPost() {
            	bbmMask = [['txtDatea', '9999/99/99']];
                q_mask(bbmMask);
                
                $('.lblLanguage1').text('繁體').css('float','left');
                $('.lblLanguage2').text('簡體').css('float','left');
                $('.lblImgplace').text('位置').css('float','left');
                
                q_cmbParse("cmbRank", "0@選擇等級,1,2,3,4,5,6,7,8,9,10");
                q_cmbParse("cmbImgaplace", ",0@右,1@下");
                q_cmbParse("cmbImgbplace", ",0@右,1@下");
                q_cmbParse("cmbImgcplace", ",0@右,1@下");
                q_cmbParse("cmbImgdplace", ",0@右,1@下");
				
                q_gt('newsstype', '', 0, 0, 0, "newsstype");
                q_gt('newsarea', '', 0, 0, 0, "newsarea");
                q_gt('newstypea', '', 0, 0, 0, "newstypea");
                q_gt('newstypeb', '', 0, 0, 0, "newstypeb");
                q_gt('newstypec', '', 0, 0, 0, "newstypec");
                q_gt('newstyped', '', 0, 0, 0, "newstyped");
                
                $('#cmbTypea').change(function() {
                	n_typeNow[0].typea=$('#cmbTypea').val()
                	Typeachange(); 
				});
				$('#cmbTypeb').change(function() {
					n_typeNow[0].typeb=$('#cmbTypeb').val()
                	Typeachange(); 
				});
				$('#cmbTypec').change(function() {
					n_typeNow[0].typec=$('#cmbTypec').val()
                	Typeachange(); 
				});
				$('#cmbTypec').change(function() {
					n_typeNow[0].typed=$('#cmbTyped').val()
                	Typeachange(); 
				});
                
            }
            
            function Typeachange() {
				if($('#cmbTypea').val()!=''){
					//處理內容
					$('#cmbTypeb').text('');
					$('#cmbTypec').text('');
					$('#cmbTyped').text('');
					
					var c_typeb='@';
					for (i=0;i<n_typeb.length;i++){
						if(n_typeb[i].typeano==$('#cmbTypea').val())
							c_typeb=c_typeb+','+n_typeb[i].noa+"@"+n_typeb[i].typeb;
					}
					q_cmbParse("cmbTypeb", c_typeb);
					if(n_typeNow[0])
						$('#cmbTypeb').val(n_typeNow[0].typeb);
					
					var c_typec='@';
					for (i=0;i<n_typec.length;i++){
						if(n_typec[i].typebno==$('#cmbTypeb').val())
							c_typec=c_typec+','+n_typec[i].noa+"@"+n_typec[i].typec;
					}					
					q_cmbParse("cmbTypec", c_typec);
					if(abbm[q_recno])
						$('#cmbTypec').val(n_typeNow[0].typec);
						
					var c_typed='@';
					for (i=0;i<n_typed.length;i++){
						if(n_typed[i].typecno==$('#cmbTypec').val())
							c_typed=c_typed+','+n_typed[i].noa+"@"+n_typed[i].typed;
					}					
					q_cmbParse("cmbTyped", c_typed);
					if(abbm[q_recno])
						$('#cmbTyped').val(n_typeNow[0].typed);
				}
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
                	case 'newsstype':
                		var as = _q_appendData("newsstype", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].stype);
							}
							q_cmbParse("cmbStype", t_item);
							if(abbm[q_recno])
								$("#cmbStype").val(abbm[q_recno].stype);
						}
                		break;
                	case 'newsarea':
                		var as = _q_appendData("newsarea", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].area);
							}
							q_cmbParse("cmbArea", t_item);
							if(abbm[q_recno])
								$("#cmbArea").val(abbm[q_recno].area);
						}
                		break;
                	case 'newstypea':
                		var as = _q_appendData("newstypea", "", true);
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
                	case 'newstypeb':
                		n_typeb = _q_appendData("newstypeb", "", true);
                		break;
                	case 'newstypec':
                		n_typec = _q_appendData("newstypec", "", true);
                		break;
                	case 'newstyped':
                		n_typed = _q_appendData("newstyped", "", true);
                		break;
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('news_s.aspx', q_name + '_s', "500px", "310px", q_getMsg("popSeek"));
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
                $('#txtTitle').focus();
            }

            function btnPrint() {

            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            
            function btnOk() {
            	Lock(1,{opacity:0});
            	if($('#txtTitle').val().length==0){
            		alert('請輸入'+q_getMsg("lblTitle"));
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
					q_gtnoa(q_name, replaceAll(q_getPara('sys.key_news') + q_date(), '/', ''));
				else
					wrServer(s1);
            }

            function wrServer(key_value) {
                var i;

                xmlSql = '';
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
            
            function bbsSave(as) {
				if (!as['title']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			function bbtSave(as) {
				if (!as['title']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

            function refresh(recno) {
                _refresh(recno);   
                Typeachange();  
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$('#txtDatea').datepicker( 'destroy' );
                }else{
                	$('#txtDatea').removeClass('hasDatepicker')
					$('#txtDatea').datepicker();
                }
            }

            function btnMinus(id) {
                _btnMinus(id);
            }

            function btnPlus(org_htm, dest_tag, afield) {
                _btnPlus(org_htm, dest_tag, afield);
            }
            
            function btnPlut(org_htm, dest_tag, afield) {
				_btnPlut(org_htm, dest_tag, afield);
			}
			
			function bbsAssign() {
				for (var i = 0; i < q_bbsCount; i++) {
					$('#lblNo_' + i).text(q_getMsg("lblAtt")+(i + 1));
				}
				_bbsAssign();
				$('.lblLanguage1_s').text('繁體');
                $('.lblLanguage2_s').text('簡體');
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(q_getMsg("lblWeb")+(i + 1));
				}
				_bbtAssign();
				$('.lblLanguage1_t').text('繁體');
                $('.lblLanguage2_t').text('簡體');
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
                width: 400px; 
                border-width: 0px; 
            }
            .tview {
                border: 5px solid gray;
                font-size: medium;
                background-color: black;
            }
            .tview tr {
                height: 30px;
            }
            .tview td {
                padding: 2px;
                text-align: center;
                border-width: 0px;
                background-color: #FFFF66;
                color: blue;
            }
            .dbbm {
                float: left;
                width: 850px;
                /*margin: -1px;        
                border: 1px black solid;*/
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
            }
            .tbbm tr td .lbl.btn:hover {
                color: #FF8F19;
            }
            .txt.c1 {
                width: 100%;
                float: left;
            }
            .txt.c2 {
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
			select {
				border-width: 1px;
				padding: 0px;
				margin: -1px;
				font-size: medium;
			}
			#dbbt {
				width: 1250px;
			}
			#tbbt {
				margin: 0;
				padding: 2px;
				border: 2px pink double;
				border-spacing: 1;
				border-collapse: collapse;
				font-size: medium;
				color: blue;
				background: pink;
				width: 100%;
			}
			#tbbt tr {
				height: 35px;
			}
			#tbbt tr td {
				text-align: center;
				border: 2px pink double;
			}
            .num {
                text-align: right;
            }
            input[type="text"], input[type="button"] {
                font-size: medium;
            }
            select {
                font-size: medium;
            }
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:100px; color:black;"><a id='vewSss'> </a></td>
						<td align="center" style="width:170px; color:black;"><a id='vewTitle'> </a></td>
					</tr>
					<tr>
						<td ><input id="chkBrow.*" type="checkbox" style=' '/></td>
						<td id='datea' style="text-align: center;">~datea</td>
						<td id='namea' style="text-align: center;">~namea</td>
						<td id='title,8' style="text-align: center;">~title,8</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' >
				<table class="tbbm"  id="tbbm">
					<tr style="height:1px;">
						<td style="width: 100px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 100px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 100px"> </td>
						<td style="width: 180px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSss' class="lbl btn"> </a></td>
						<td>
							<input id="txtSssno"  type="text"  class="txt c1" style="width: 49%"/>
							<input id="txtNamea"  type="text"  class="txt c1" style="width: 49%"/>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblIllustrate' class="lbl"> </a></td>
						<td><input id="txtIllustrate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblRank' class="lbl"> </a></td>
						<td><select id="cmbRank" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblArea' class="lbl"> </a></td>
						<td><select id="cmbArea" class="txt c1"> </select></td>
						<td colspan="2">
							<input id="chkOnline" type="checkbox" style="float: center;"/>
							<a id='lblOnline' class="lbl" style="float: center;"> </a>
							<input id="chkNewimg" type="checkbox" style="float: center;"/>
							<a id='lblNewimg' class="lbl" style="float: center;"> </a>
							<input id="chkWatermark" type="checkbox" style="float: center;"/>
							<a id='lblWatermark' class="lbl" style="float: center;"> </a>
						</td>
					</tr>
					<tr class="typea">
						<td><span> </span><a id='lblTypeb' class="lbl"> </a></td>
						<td><select id="cmbTypeb" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypec' class="lbl"> </a></td>
						<td><select id="cmbTypec" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTyped' class="lbl"> </a></td>
						<td><select id="cmbTyped" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTitle' class="lbl"> </a></td>
						<td colspan="5"><input id="txtITitle"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContents' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtContents" cols="10" rows="5" style="width: 99%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImga' class="lbl"> </a></td>
						<td colspan="2"><a class='lblLanguage1'> </a><span style="float: left;"> </span><input type="file" id="btnImga1" value="選擇檔案"/></td>
						<td colspan="2"><a class='lblLanguage2'> </a><span style="float: left;"> </span><input type="file" id="btnImga2" value="選擇檔案"/></td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgaplace" class="txt c2"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgb' class="lbl"> </a></td>
						<td colspan="2"><a class='lblLanguage1'> </a><span style="float: left;"> </span><input type="file" id="btnImgb1" value="選擇檔案"/></td>
						<td colspan="2"><a class='lblLanguage2'> </a><span style="float: left;"> </span><input type="file" id="btnImgb2" value="選擇檔案"/></td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgbplace" class="txt c2"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgc' class="lbl"> </a></td>
						<td colspan="2"><a class='lblLanguage1'> </a><span style="float: left;"> </span><input type="file" id="btnImgc1" value="選擇檔案"/></td>
						<td colspan="2"><a class='lblLanguage2'> </a><span style="float: left;"> </span><input type="file" id="btnImgc2" value="選擇檔案"/></td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgcplace" class="txt c2"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgd' class="lbl"> </a></td>
						<td colspan="2"><a class='lblLanguage1'> </a><span style="float: left;"> </span><input type="file" id="btnImgd1" value="選擇檔案"/></td>
						<td colspan="2"><a class='lblLanguage2'> </a><span style="float: left;"> </span><input type="file" id="btnImgd2" value="選擇檔案"/></td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgdplace" class="txt c2"> </select></td>
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
						<td style="width:20px;"><input id="btnPlus" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:80px;"><a id='lblNo_s'> </a></td>
						<td><a id='lblTitle_s'> </a></td>
						<td style="width:300px;"><a class='lblLanguage1_s'> </a></td>
						<td style="width:300px;"><a class='lblLanguage2_s'> </a></td>
						
					</tr>
					<tr style='background:#cad3ff;'>
						<td align="center">
							<input type="button" id="btnMinus.*" style="font-size: medium; font-weight: bold;" value="－"/>
							<input type="text" id="txtNoq.*" style="display: none;"/>
						</td>
						<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input type="text" id="txtTitle.*" class="txt c1" /></td>
						<td><input type="file" id="btnAtt1.*" value="選擇檔案"/></td>
						<td><input type="file" id="btnAtt2.*" value="選擇檔案"/></td>
					</tr>
				</table>
			</div>
			<div id="dbbt" >
			<table id="tbbt">
				<tbody>
					<tr class="head" style="color:white; background:#003366;">
						<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
						<td style="width:80px;"><a id='lblNo_t'> </a></td>
						<td><a id='lblTitle_t'> </a></td>
						<td style="width:300px; text-align: center;"><a class='lblLanguage1_t'> </a></td>
						<td style="width:300px; text-align: center;"><a class='lblLanguage2_t'> </a></td>
					</tr>
					<tr>
						<td>
							<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
							<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						</td>
						<td><a id="lblNo..*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
						<td><input id="txtTitle..*" type="text" class="txt  c1"/></td>
						<td><input id="txtWeb1..*" type="text" class="txt  c1"/></td>
						<td><input id="txtWeb2..*" type="text" class="txt  c1"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<input id="q_sys" type="hidden" />
	</body>
</html>
