<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr">
	<head>
		<title> </title>
		<script src="../script/jquery.min.js" type="text/javascript"> </script>
		<script src='../script/qj2.js' type="text/javascript"> </script>
		<script src='qset.js' type="text/javascript"> </script>
		<script src='../script/qj_mess.js' type="text/javascript"> </script>
		<script src="../script/qbox.js" type="text/javascript"> </script>
		<script src='../script/mask.js' type="text/javascript"> </script>
		<link href="../qbox.css" rel="stylesheet" type="text/css" />
		<link href="css/jquery/themes/redmond/jquery.ui.all.css" rel="stylesheet" type="text/css" />
		<script src="css/jquery/ui/jquery.ui.core.js"></script>
		<script src="css/jquery/ui/jquery.ui.widget.js"></script>
		<script src="css/jquery/ui/jquery.ui.datepicker.js"></script>
		<script type="text/javascript" src="../highslide/highslide.packed.js"></script>
		<script type="text/javascript" src="../highslide/highslide-with-html.packed.js"></script>
		<link rel="stylesheet" type="text/css" href="../highslide/highslide.css" /> 
		<script type="text/javascript"> hs.graphicsDir = '../highslide/graphics/'; hs.showCredits = false; hs.outlineType = 'rounded-white'; hs.outlineWhileAnimating = true; </script>
		<script type="text/javascript">
			this.errorHandler = null;
			function onPageError(error) {
				alert("An error occurred:\r\n" + error.Message);
			}
			q_tables = 't';
			var q_name = "cust";
			var q_readonly = [];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = [['txtCapital', 15, 0,1]];
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
			brwCount2 = 48;
			aPop = new Array();
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1)
                $('#txtNoa').focus
			});

			//////////////////end Ready
			function main() {
				if (dataErr) {
					dataErr = false;
					return;
				}
				mainForm(0);
				
			}

			function mainPost() {
				bbmMask = [['txtStartdate', '9999/99/99'],['txtKdate', '9999/99/99']];
				bbtMask = [['txtBdate', '9999/99/99'],['txtEdate', '9999/99/99']];
				q_mask(bbmMask);
				
				q_gt('custtype', '', 0, 0, 0, "custtype");
				q_gt('country', '', 0, 0, 0, "country");
				q_cmbParse("cmbStatus", ','+q_getPara('cust.status'));
				q_cmbParse("cmbCoin", '@無,NTD@台幣,RMB@人民幣,USD@美金');
				q_cmbParse("cmbBizscope", '@無,A000@鋼鐵生產廠商,B000@產品製造業,C000@裁剪 / 加工業,D000@買賣業,E000@原料 / 設備 / 耗材供應商,F000@買賣業,G000@鋼鐵工業副產品,H000@鋼鐵應用相關產業,I000@鋼鐵相關組織,J000@其 它');
				//q_cmbParse("cmbTypea", '@選擇,'+q_getPara('custs.typea'),'s');
				//q_cmbParse("cmbTypea", '@選擇,'+q_getPara('custs.typea'),'t');
				q_cmbParse("cmbCobtype", ',二聯,三聯');
				
				$('#btnCusts').click(function() {
					$('.dbbs').css('top', $(this).offset().top+25);
					$('.dbbs').css('left', 0);
				 	$('.dbbs').show()
				});
				
				$('#btnClosesCusts').click(function() {
					$('.dbbs').hide();
					$('.dbbt').hide();
					t_bbt_id='';
				});
				
				$('#btnClosesCustt').click(function() {
					$('.dbbt').hide();
					t_bbt_id='';
				});
				
				$('#btnShip').click(function() {
				 	if(q_cur==1){
				 		return;
				 	}else{
				 		q_box("ship.aspx?;;;noa='" + $('#txtNoa').val() + "'", 'ship', "60%", "95%", q_getMsg("btnShip"));
					}
				});
				
				$('#txtNoa').change(function(e){
					$(this).val($.trim($(this).val()).toUpperCase());		
					if($(this).val().length>0){
						if((/^(\w+|\w+\u002D\w+)$/g).test($(this).val())){
							//t_where="where=^^ noa='"+$(this).val()+"'^^";
							//q_gt('cust', t_where, 0, 0, 0, "checkCustno_change", r_accy);
							$('#cmbTypea').val($('#txtNoa').val().substring(0,1));
						}else{
							Lock();
							alert('編號只允許 英文(A-Z)、數字(0-9)及dash(-)。'+String.fromCharCode(13)+'EX: A01、A01-001');
							Unlock();
						}
					}
				});
				
				$('#txtComp').change(function(e){
					if(emp($('#txtComp').val()))
						$('#txtInvotitle').val($('#txtComp').val());
				});
				
				$('#btnCustu').click(function(e){
					if(!emp($('#txtNoa').val()))
						q_box("custu.aspx?;;;serial='" + $('#txtNoa').val() + "'",'custu', "95%", "95%", '繳款');
				});
				
				$('.btnImg').change(function() {
					event.stopPropagation(); 
					event.preventDefault();
					if(q_cur==1 || q_cur==2){}else{return;}
					var txtName = replaceAll($(this).attr('id'),'btn','txt');
					var btnName = $(this).attr('id');
					file = $(this)[0].files[0];
					
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#'+txtName+'name').val(file.name);
						$('#'+txtName).val(guid()+Date.now()+ext);
						
						fr = new FileReader();
						fr.fileName = $('#'+txtName).val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}; 
						}
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						}
						fr.onloadend = function(e){
							$('#FileList').children().last().find('progress').eq(0).attr('value',100);
							console.log(fr.fileName+':'+fr.result.length);
							var oReq = new XMLHttpRequest();
							oReq.upload.addEventListener("progress",function(e) {
								if (e.lengthComputable) {
									percentComplete = Math.round((e.loaded / e.total) * 100,0);
									$('#FileList').children().last().find('progress').eq(1).attr('value',percentComplete);
								}
							}, false);
							oReq.upload.addEventListener("load",function(e) {
								Unlock(1);
							}, false);
							oReq.upload.addEventListener("error",function(e) {
								alert("資料上傳發生錯誤!");
							}, false);
							oReq.addEventListener("loadend", function(e) {
								$('#'+btnName).val('');
							}, false);
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'cust_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}
					ShowImglbl();
				});
				
				for (var i=1;i<10;i++){
					$('.bizscopes'+i).hide();
					$('#bizscopes'+i).click(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
			}
			
			var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				//return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
				return function() {return s4() + s4() + s4() + s4();};
			})();
			
			function ShowImglbl() {
				$('.lblImgShowDown').each(function(){
					var txtimg=replaceAll($(this).attr('id'),'lbl','txt');
					var lblimg=replaceAll($(this).attr('id'),'lbl','lbl');
					if(!emp($('#'+txtimg).val())){
						$('#'+lblimg).addClass('btn highslide ').attr('href','../doc/cust/'+$('#'+txtimg).val())
						.attr('onclick',"return hs.expand(this, { captionId: 'caption1', align: 'center',allowWidthReduction: true } )");
					}else{
						$('#'+lblimg).removeClass('btn highslide ').removeAttr('href').removeAttr('onclick');
					}
						
					$('#'+lblimg).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
                        if(txtimg.length>0)
                        	$('#xdownload').attr('src','cust_download.aspx?FileName='+$('#'+txtimg+'name').val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...'+n);
					});
				});
			}
			
			function readBizscope() {
				var t_bizscopes=$('#txtBizscopes').val().split('##')[0],txttmp_bizscopes=$('#txtBizscopes').val().split('##')[1];
				var txt_bizscopes=txttmp_bizscopes==undefined?[]:txttmp_bizscopes.split(',');
				$("input[name='bizscopes']").prop('checked',false);
				//核取
				$("input[name='bizscopes']").each(function() {
					if(t_bizscopes.indexOf($(this).val())>-1){
						$(this).prop('checked',true);
					}	
				});
				//其他
				for(var i=0;i<txt_bizscopes.length;i++){
					$('#textBizscopesother'+(i+1)).val(txt_bizscopes[i]);	
				}
				
				for (var i=1;i<10;i++){
					$('.bizscopes'+i).hide();
					$('#bizscopes'+i).each(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
			}
			
			function q_boxClose(s2) {
				var ret;
				switch (b_pop) {
					 case q_name + '_s':
						q_boxClose2(s2);
						break;
				}
				b_pop = '';
			}

			function q_gtPost(t_name) {
				switch (t_name) {
					case 'custtype':
						var as = _q_appendData("custtype", "", true);
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
					case 'country':
						var as = _q_appendData("country", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].cname);
							}
							q_cmbParse("cmbCountry", t_item);
							if(abbm[q_recno])
								$("#cmbCountry").val(abbm[q_recno].country);
						}
						break;	
					case 'btnOkCustsId':
						var as = _q_appendData("custs", "", true);
						if (as[0] != undefined) {
							alert(q_getMsg('lblId_s')+'重覆!!!');
							Unlock(1);
						}else{
							wrServer($('#txtNoa').val());
						}
						break;
					case q_name:
						if (q_cur == 4)
							q_Seek_gtPost();
				 		break;
				} /// end switch
				
				if(t_name.split('_')[0]=="checkCustsId"){
					var n=t_name.split('_')[1];
					var as = _q_appendData("custs", "", true);
					if (as[0] != undefined) {
						alert(q_getMsg('lblId_s')+'重覆!!!');
						$('#txtId_'+n).val('');
					}
				}
			}

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "330px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtNoa').focus();
				ShowImglbl();
				readBizscope();
				bbtchange();
				refreshclear();
			}

			function btnModi() {
				if (emp($('#txtNoa').val()))
					return;
				_btnModi();
				refreshBbm();
				$('#txtComp').focus();
				ShowImglbl();
				readBizscope();
				bbtchange();
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
            	
            	$('#txtNoa').val($.trim($('#txtNoa').val())); 	
            	$('#txtSerial').val($('#txtNoa').val());
            	
            	if($('#txtNoa').val().length==0){
            		alert('請輸入'+q_getMsg("lblNoa"));
            		Unlock(1);
            		return;
            	}
            	
            	//儲存營業項目 選項##其他文字
            	var t_bizscopes='',txt_bizscopes='';
            	$("input[name='bizscopes']").each(function(index) {
            		if($(this).prop('checked'))
						t_bizscopes=t_bizscopes+(t_bizscopes.length>0?',':'')+$(this).val();
				});
				
            	$(".textBizscopes").each(function(index) {
					txt_bizscopes=txt_bizscopes+$(this).val()+',';
				});
				txt_bizscopes=txt_bizscopes.substr(0,txt_bizscopes.length-1);//去逗號
				$('#txtBizscopes').val(t_bizscopes+'##'+txt_bizscopes);
				
				//檢查會員帳號是否重複
				var t_id='';
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtId_'+i).val())){
						t_id=t_id+(t_id.length>0?',':'')+("'"+$('#txtId_'+i).val()+"'");
					}
				}
				t_where="where=^^ id in ("+t_id+") and noa!='"+$('#txtNoa').val()+"' ^^";
				q_gt('custs', t_where, 0, 0, 0, "btnOkCustsId", r_accy);
				//wrServer($('#txtNoa').val());
			}

			function wrServer(key_value) {
				var i;

				xmlSql = '';
				if (q_cur == 2)/// popSave
					xmlSql = q_preXml();

				$('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
				_btnOk(key_value, bbmKey[0], bbsKey[1], '', 2);
			}
			
			function bbsSave(as) {
		        if (!as['id']) {
		            as[bbsKey[1]] = '';
		            return;
		        }
		        q_nowf();
		        
		        return true;
		    }
		    
		    function bbtSave(as) {
				if (!as['id'] && !as['bdate']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			var tmp_noa=$('#txtNoa').val();
			function refresh(recno) {
				_refresh(recno);
				refreshBbm();
				ShowImglbl();
				readBizscope();
				if(tmp_noa!=$('#txtNoa').val()){
					refreshclear();
					tmp_noa=$('#txtNoa').val();
				}
			}
			
			function refreshclear(){
				$('.dbbs').hide();
				$('.dbbt').hide();
				t_bbt_id='';
			}
			
			function refreshBbm(){
				if(q_cur==1){
					$('#txtNoa').css('color','black').css('background','white').removeAttr('readonly');
				}else{
					$('#txtNoa').css('color','green').css('background','RGB(237,237,237)').attr('readonly','readonly');
				}
			}
			
			function readonly(t_para, empty) {
				_readonly(t_para, empty);
				if(t_para){
					$("input[name='bizscopes']").attr('disabled', 'disabled');
					$(".textBizscopes").attr('disabled', 'disabled');
					$('.btnImg').attr('disabled', 'disabled');
					$('#btnShip').removeAttr('disabled', 'disabled');
					$('#btnCustu').removeAttr('disabled', 'disabled');
					$('#txtStartdate').datepicker( 'destroy' );
                	$('#txtKdate').datepicker( 'destroy' );
				}else{
					$("input[name='bizscopes']").removeAttr('disabled');
					$(".textBizscopes").removeAttr('disabled');
					$('.btnImg').removeAttr('disabled', 'disabled');
					$('#btnShip').attr('disabled', 'disabled');
					$('#btnCustu').attr('disabled', 'disabled');
					$('#txtStartdate').removeClass('hasDatepicker')
					$('#txtStartdate').datepicker({ dateFormat: 'yy/mm/dd' });
					$('#txtKdate').removeClass('hasDatepicker')
					$('#txtKdate').datepicker({ dateFormat: 'yy/mm/dd' });
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
			
			var t_bbt_id='';
			function bbsAssign() {
		        for (var i = 0; i < q_bbsCount; i++) {
		            $('#lblNo_' + i).text(i + 1);
		            if (!$('#btnMinus_' + i).hasClass('isAssign')) {
		            	$('#btnCustt_'+i).click(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('.dbbt').css('top', $('.dbbs').offset().top+$('.dbbs').height()+5);
							$('.dbbt').css('left', $('.dbbs').width()-$('.dbbt').width());
							t_bbt_id=$('#txtId_'+b_seq).val();
							bbtchange();
						 	$('.dbbt').show()
						});
						
						$('#txtId_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($(this).val())){
								t_where="where=^^ id='"+$(this).val()+"'^^";
								q_gt('custs', t_where, 0, 0, 0, "checkCustsId_"+b_seq, r_accy);
							}
						});
		            }
		        }
		        _bbsAssign();
		        bbtchange();
		    }
		    
		    function bbtchange() {
		    	if(t_bbt_id==''){
		    		$('.dbbt').hide();
		    		return;
		    	}
		    	
		    	var datea_last=0;
		    	for(var k=0;k<q_bbtCount;k++){
					if($('#txtId__'+k).val()==t_bbt_id && !emp(t_bbt_id) && !emp($('#txtId__'+k).val()))
						$(".bbtid__"+k).show();
					else
						$(".bbtid__"+k).hide();
					if(!emp($('#txtId__'+k).val()))
						datea_last=k;
				}
				for(var k=datea_last+1;k<q_bbtCount;k++){
					$(".bbtid__"+k).show();
				}
		    }
		    
		    function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(i + 1);
					if (!$('#btnMinut__' + i).hasClass('isAssign')) {
						$('#txtBdate__'+i).blur(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtId__'+b_seq).val(t_bbt_id);
						});
						$('#txtEdate__'+i).blur(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtId__'+b_seq).val(t_bbt_id);
						});
						
						$('#cmbTypea__'+i).blur(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							$('#txtId__'+b_seq).val(t_bbt_id);
						});
					}
				}
				_bbtAssign();
				var t_typea='@選擇,'+q_getPara('custs.typea');
				for (var i = 0; i < q_bbtCount; i++) {
					q_cmbParse("cmbTypea__"+i, t_typea);
					if(abbtNow[i])
						$("#cmbTypea__"+i).val(abbtNow[i].typea);
				}
				
				bbtchange();
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
			}
			.tview {
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
			.tbbm .conn{
				  background: lightpink;
			}
			.tbbm .sconn{
				  background: aquamarine;
			}
			.tbbm .bizscopes{
				  /*background: lavender;*/
				  background: antiquewhite;
			}
			.tbbm .bizscopeshead{
				  background: antiquewhite;
			}
			.tbbm table{
				  background: lightblue;
			}
			.tbbm table .head1{
				    font-weight: bold;
				    font-size: 20px;
				    color: purple;
			}
			.tbbm table .head2{
				    font-weight: bold;
			}
			.tbbm table .head3{
				    font-weight: bold;
				    color: brown;
			}
			.tbbm tr td {
				/*width: 9%;*/
			}
			.tbbm .tdZ {
				/*width: 2%;*/
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
			.tbbm select {
				font-size: medium;
			}
			.txt.c1 {
				width: 98%;
				float: left;
			}
			.txt.c2 {
				width: 32%;
				float: left;
			}
			.txt.c3 {
				width: 66%;
				float: left;
			}
			.txt.c4 {
				width: 25%;
				float: left;
			}
			.txt.c5 {
				width: 70%;
				float: left;
			}
			.txt.c9 {
				width: 20%;
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
            .tbbs{
            	width: 100%;
                background: aliceblue;
            }
            .tbbs a {
                font-size: medium;
            }
            .dbbs .tbbs {
				color: blue;
			}
			#dbbt {
				width: 380px;
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
			input[type="text"], input[type="button"] {
				font-size: medium;
			}
		</style>
	</head>
	<body ondragstart="return false" draggable="false"
	ondragenter="event.dataTransfer.dropEffect='none'; event.stopPropagation(); event.preventDefault();"
	ondragover="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	ondrop="event.dataTransfer.dropEffect='none';event.stopPropagation(); event.preventDefault();"
	>
		<!--#include file="../inc/toolbar.inc"-->
		<div id='dmain' style="overflow:hidden;width:1250px;">
			<div class="dview" id="dview" style="float: left; width:300px;" >
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:25%"><a id='vewSerial'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='noa'>~noa</td>
						<td align="center" id='nick'>~nick</td>
					</tr>
				</table>
			</div>
			<div class='dbbm' style="width: 850px;float: left;">
				<table class="tbbm" id="tbbm" border="0" cellpadding='2' cellspacing='5'>
					<tr style="height:1px;">
						<td style="width: 130px;"> </td>
						<td style="width: 280px;"> </td>
						<td style="width: 130px;"> </td>
						<td style="width: 280px;"> </td>
						<td style="width: 10px;"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1"/>
							<input id="txtSerial" type="hidden"/>
						</td>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblEcomp' class="lbl"> </a></td>
						<td><input id="txtEcomp" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblNick' class="lbl"> </a></td>
						<td><input id="txtNick" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtBoss" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIsshipcomp' class="lbl"> </a></td>
						<td>
							<input id="chkIsshipcomp" type="checkbox"/>
							<input id="btnShip" type="button" value="公司船名"/>
						</td>
						<td> 	</td>
						<td>
							<input id="btnCusts" type="button" value="使用者帳號維護"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStartdate' class="lbl"> </a></td>
						<td><input id="txtStartdate" type="text" class="txt c2"/></td>
						<td><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td>
							<input id="txtKdate" type="text" class="txt c2"/>
							<span style="float:left;"> </span>
							<a id='lblIscheck' class="lbl" style="float:left;"> </a>
							<input id="chkIscheck" type="checkbox"/>
							<span style="float:left;"> </span>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a><a style="float: right;">-</a><a id='lblCountry' class="lbl"> </a></td>
						<td colspan='3'>
							<select id="cmbCountry" class="txt c2"> </select><a style="float: left">-</a>
							<input id="txtAddr" type="text" class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCoin' class="lbl"> </a><a style="float: right;">-</a><a id='lblCapital' class="lbl"> </a></td>
						<td>
							<input id="txtCapital" type="text" class="txt num c3"/><a style="float: left">-</a>
							<select id="cmbCoin" class="txt c2"> </select>
						</td>
						<td><span> </span><a id='lblWeb' class="lbl"> </a></td>
						<td><input id="txtWeb" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td><input id="txtTel" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td><input id="txtFax" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td>
							<select id="cmbStatus" class="txt c3"> </select>
							<input id="btnCustu" type="button" value="繳款"/>
						</td>
						<td><span> </span><a id='lblUmmstatus' class="lbl"> </a></td>
						<td><input id="txtUmmstatus" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblInvoserial' class="lbl"> </a></td>
						<td><input id="txtInvoserial" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvotitle' class="lbl"> </a></td>
						<td><input id="txtInvotitle" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCobtype' class="lbl"> </a></td>
						<td><select id="cmbCobtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblInvoaddr' class="lbl"> </a></td>
						<td>
							<input id="txtInvopost" type="text" class="txt c4"/><a style="float: left;">-</a>
							<input id="txtInvoaddr" type="text" class="txt c5"/>
						</td>
					</tr>
					<tr class="conn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">主帳號(型錄聯絡人)</a></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblExt' class="lbl"> </a></td>
						<td><input id="txtExt" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td><input id="txtJob" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td><input id="txtMobile" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td><input id="txtEmail" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">業務聯絡人</a></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSconn' class="lbl"> </a></td>
						<td><input id="txtSconn" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSext' class="lbl"> </a></td>
						<td><input id="txtSext" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSjob' class="lbl"> </a></td>
						<td><input id="txtSjob" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblSmobile' class="lbl"> </a></td>
						<td><input id="txtSmobile" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblSemail' class="lbl"> </a></td>
						<td><input id="txtSemail" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblCmemo' class="lbl"> </a></td>
						<td colspan='3'>
							<textarea id="txtCmemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBmemo' class="lbl"> </a></td>
						<td colspan='3'>
							<textarea id="txtBmemo" rows='5' cols='10' style="width:99%; height: 50px;"> </textarea>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBizscope' class="lbl"> </a></td>
						<td><select id="cmbBizscope" class="txt c1"> </select></td>
						<td><span> </span><a id='lblMemo' class="lbl"> </a></td>
						<td><input id="txtMemo" type="text" class="txt c1"/></td>
					</tr>
					<tr class="bizscopes">
						<td colspan="4" style="text-align: center;">
							<span> </span><a id='lblBizscopes' class="lbl" style="float: none;"> </a>
							<input id="txtBizscopes" type="hidden"/><!--存放下面選項-->
						</td>
						<td> </td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes1" name="bizscopes" type="checkbox" value="A000"/>鋼鐵生產廠商
						</td>
					</tr>
					<tr class="bizscopes bizscopes1">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td colspan="3" class="head1">碳鋼</td>								</tr>
								<tr>
									<td colspan="2" style="width: 165px;"  class="head2">[半成品]</td>
									<td>
										<input name="bizscopes" type="checkbox" value="A001"/>扁 鋼 胚
										<input name="bizscopes" type="checkbox" value="A002"/>大 鋼 胚
										<input name="bizscopes" type="checkbox" value="A003"/>小 鋼 胚
										<input name="bizscopes" type="checkbox" value="A004"/>圓 胚
									</td>
								</tr>
								<tr>
									<td class="head2">[成 品]</td>
									<td class="head3">熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A005"/>鋼 筋
										<input name="bizscopes" type="checkbox" value="A006"/>角 鋼
										<input name="bizscopes" type="checkbox" value="A007"/>槽 鋼
										<input name="bizscopes" type="checkbox" value="A008"/>直 棒 鋼
										<input name="bizscopes" type="checkbox" value="A009"/>線材盤元
										<input name="bizscopes" type="checkbox" value="A010"/>條鋼盤元
										<input name="bizscopes" type="checkbox" value="A011"/>無縫鋼管
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A012"/>扁 鋼
										<input name="bizscopes" type="checkbox" value="A013"/>鋼 軌
										<input name="bizscopes" type="checkbox" value="A014"/>異 形 鋼
										<input name="bizscopes" type="checkbox" value="A015"/>鋼 板 樁
										<input name="bizscopes" type="checkbox" value="A016"/>H 型 鋼
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A017"/>寬 厚 板
										<input name="bizscopes" type="checkbox" value="A018"/>鋼捲(厚度2.0mm 以上)
										<input name="bizscopes" type="checkbox" value="A019"/>鋼捲(厚度2.0mm 以下)
										<input name="bizscopes" type="checkbox" value="A020"/>花紋鋼板
										<input name="bizscopes" type="checkbox" value="A021"/>酸洗塗油板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A022"/>酸洗塗油板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A023"/>霧面鋼捲SD
										<input name="bizscopes" type="checkbox" value="A024"/>亮面鋼捲SB
										<input name="bizscopes" type="checkbox" value="A025"/>全硬未退火鋼捲
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">鍍 面 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A026"/>熱浸鍍鋅
										<input name="bizscopes" type="checkbox" value="A027"/>熱浸鍍鋁鋅
										<input name="bizscopes" type="checkbox" value="A028"/>彩色(彩塗)
										<input name="bizscopes" type="checkbox" value="A029"/>電鍍鋅
										<input name="bizscopes" type="checkbox" value="A030"/>馬口鐵(鍍錫)
										<input name="bizscopes" type="checkbox" value="A031"/>電磁鋼(矽鋼片)
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3" class="head1">不 鏽 鋼</td>
								</tr>
								<tr>
									<td colspan="2" style="width: 165px;"  class="head2">[半成品]</td>
									<td>
										<input name="bizscopes" type="checkbox" value="A032"/>扁 鋼 胚
										<input name="bizscopes" type="checkbox" value="A033"/>大 鋼 胚
										<input name="bizscopes" type="checkbox" value="A034"/>小 鋼 胚
										<input name="bizscopes" type="checkbox" value="A035"/>圓 胚
									</td>
								</tr>
								<tr>
									<td class="head2">[成 品]</td>
									<td class="head3">熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A036"/>角 鋼
										<input name="bizscopes" type="checkbox" value="A037"/>扁 鋼
										<input name="bizscopes" type="checkbox" value="A038"/>異 形 鋼
										<input name="bizscopes" type="checkbox" value="A039"/>直 棒 鋼
										<input name="bizscopes" type="checkbox" value="A040"/>無縫鋼管
										<input name="bizscopes" type="checkbox" value="A041"/>線材盤元
										<input name="bizscopes" type="checkbox" value="A042"/>條鋼盤元
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A043"/>寬 厚 板
										<input name="bizscopes" type="checkbox" value="A044"/>黑皮鋼捲
										<input name="bizscopes" type="checkbox" value="A045"/>酸洗退火板(原面)
										<input name="bizscopes" type="checkbox" value="A046"/>花紋鋼板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A047"/>鈍面鋼捲(2D)
										<input name="bizscopes" type="checkbox" value="A048"/>霧面鋼捲(2B)
										<input name="bizscopes" type="checkbox" value="A049"/>金面鋼捲(BA)
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3" class="head1">合 金 鋼</td>
								</tr>
								<tr>
									<td colspan="2" style="width: 165px;"  class="head2">[半成品]</td>
									<td>
										<input name="bizscopes" type="checkbox" value="A050"/>扁 鋼 胚
										<input name="bizscopes" type="checkbox" value="A051"/>大 鋼 胚
										<input name="bizscopes" type="checkbox" value="A052"/>小 鋼 胚
										<input name="bizscopes" type="checkbox" value="A053"/>圓 胚
									</td>
								</tr>
								<tr>
									<td class="head2">[成 品]</td>
									<td class="head3">熱 軋 － 長條類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A054"/>角 鋼
										<input name="bizscopes" type="checkbox" value="A055"/>扁 鋼
										<input name="bizscopes" type="checkbox" value="A056"/>異 形 鋼
										<input name="bizscopes" type="checkbox" value="A057"/>直 棒 鋼
										<input name="bizscopes" type="checkbox" value="A058"/>線材盤元
										<input name="bizscopes" type="checkbox" value="A059"/>條鋼盤元
										<input name="bizscopes" type="checkbox" value="A060"/>無縫鋼管
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">熱 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A061"/>鋼捲
										<input name="bizscopes" type="checkbox" value="A062"/>寬厚板
										<input name="bizscopes" type="checkbox" value="A063"/>酸洗退火板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td class="head3">冷 軋 － 平板類</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="A064"/>鋼捲
										<input name="bizscopes" type="checkbox" value="A065"/>複合板
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
								<tr>
									<td colspan="3">
										<input name="bizscopes" type="checkbox" value="A999" style="float: left;"/>
										<a style="float: left;">其 他</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother1" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="3"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes2" name="bizscopes" type="checkbox" value="B000"/> 產品製造業
						</td>
					</tr>
					<tr class="bizscopes bizscopes2">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td colspan="2" class="head1">以長條類鋼品為原料所製造的產品</td>
								</tr>
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B001"/>鎖
										<input name="bizscopes" type="checkbox" value="B002"/>鍛造零件
										<input name="bizscopes" type="checkbox" value="B003"/>焊接鋼網
										<input name="bizscopes" type="checkbox" value="B004"/>鍍鋅鐵線
										<input name="bizscopes" type="checkbox" value="B005"/>預力鋼線
										<input name="bizscopes" type="checkbox" value="B006"/>鋼線/鋼纜
										<input name="bizscopes" type="checkbox" value="B007"/>螺絲/螺帽
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B008"/>揚聲器
										<input name="bizscopes" type="checkbox" value="B009"/>手工具
										<input name="bizscopes" type="checkbox" value="B010"/>千金頂
										<input name="bizscopes" type="checkbox" value="B011"/>緊固件
										<input name="bizscopes" type="checkbox" value="B012"/>五金線
										<input name="bizscopes" type="checkbox" value="B013"/>焊材
										<input name="bizscopes" type="checkbox" value="B014"/>捲釘
										<input name="bizscopes" type="checkbox" value="B015"/>鐵條
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B016"/>齒輪
										<input name="bizscopes" type="checkbox" value="B017"/>鏈條
										<input name="bizscopes" type="checkbox" value="B018"/>彈簧
										<input name="bizscopes" type="checkbox" value="B019"/>軸承
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td colspan="2" class="head1">以平板類鋼品為原料所製造的產品</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B020"/>鋼管
										<input name="bizscopes" type="checkbox" value="B021"/>貨櫃(集裝箱)
										<input name="bizscopes" type="checkbox" value="B022"/>桶槽(容器)
										<input name="bizscopes" type="checkbox" value="B023"/>船體/零件
										<input name="bizscopes" type="checkbox" value="B024"/>車體/零件
										<input name="bizscopes" type="checkbox" value="B025"/>三明治浪板
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B026"/>廠房浪板
										<input name="bizscopes" type="checkbox" value="B027"/>運動器材
										<input name="bizscopes" type="checkbox" value="B028"/>鋼製家俱
										<input name="bizscopes" type="checkbox" value="B029"/>照明器材
										<input name="bizscopes" type="checkbox" value="B030"/>電腦機殼
										<input name="bizscopes" type="checkbox" value="B031"/>塘瓷鋼片
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B032"/>貼皮鋼片
										<input name="bizscopes" type="checkbox" value="B033"/>API 油管
										<input name="bizscopes" type="checkbox" value="B034"/>擴張網
										<input name="bizscopes" type="checkbox" value="B035"/>T 型鋼
										<input name="bizscopes" type="checkbox" value="B036"/>鋼結構
										<input name="bizscopes" type="checkbox" value="B037"/>C 型鋼
										<input name="bizscopes" type="checkbox" value="B038"/>隔屏
										<input name="bizscopes" type="checkbox" value="B039"/>廚具
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B040"/>洋傘
										<input name="bizscopes" type="checkbox" value="B041"/>模座
										<input name="bizscopes" type="checkbox" value="B042"/>捲門
										<input name="bizscopes" type="checkbox" value="B043"/>風管
										<input name="bizscopes" type="checkbox" value="B044"/>家電
										<input name="bizscopes" type="checkbox" value="B045"/>馬達
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td colspan="2" class="head1">其他金屬製品</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="B046"/>鋼管
										<input name="bizscopes" type="checkbox" value="B047"/>輪圈
										<input name="bizscopes" type="checkbox" value="B048"/>引擎
										<input name="bizscopes" type="checkbox" value="B049"/>帷幕牆
										<input name="bizscopes" type="checkbox" value="B050"/>鋁門窗
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes3" name="bizscopes" type="checkbox" value="C000"/> 裁剪 / 加工業
						</td>
					</tr>
					<tr class="bizscopes bizscopes3">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="C001"/>酸洗
										<input name="bizscopes" type="checkbox" value="C002"/>成型
										<input name="bizscopes" type="checkbox" value="C003"/>粉末治金
										<input name="bizscopes" type="checkbox" value="C004"/>鋼板切割
										<input name="bizscopes" type="checkbox" value="C005"/>結構鍍鋅
										<input name="bizscopes" type="checkbox" value="C006"/>鋼捲裁剪
										<input name="bizscopes" type="checkbox" value="C007"/>表面處理
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="C008"/>熱處理
										<input name="bizscopes" type="checkbox" value="C009"/>鍛造
										<input name="bizscopes" type="checkbox" value="C010"/>球化
										<input name="bizscopes" type="checkbox" value="C011"/>沖壓
										<input name="bizscopes" type="checkbox" value="C012"/>鑄造
										<input name="bizscopes" type="checkbox" value="C013"/>冷抽
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="C999" style="float: left;"/>
										<a style="float: left;">其 他</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother2" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes4" name="bizscopes" type="checkbox" value="D000"/> 買賣業
						</td>
					</tr>
					<tr class="bizscopes bizscopes4">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="D001" style="float: left;"/><a style="float: left;">碳鋼</a>
										<input name="bizscopes" type="checkbox" value="D002" style="float: left;"/><a style="float: left;">不鏽鋼</a>
										<input name="bizscopes" type="checkbox" value="D003" style="float: left;"/><a style="float: left;">合金鋼</a>
										<input name="bizscopes" type="checkbox" value="D999" style="float: left;"/><a style="float: left;">其 它</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother3" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes5" name="bizscopes" type="checkbox" value="E000"/> 原料 / 設備 / 耗材供應商(例：軋輥、耐火材、鐵合金、石料等)
						</td>
					</tr>
					<tr class="bizscopes bizscopes5">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;" class="head1">原料</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E001"/>鈮
										<input name="bizscopes" type="checkbox" value="E002"/>鈦
										<input name="bizscopes" type="checkbox" value="E003"/>鋁
										<input name="bizscopes" type="checkbox" value="E004"/>銅
										<input name="bizscopes" type="checkbox" value="E005"/>鉛
										<input name="bizscopes" type="checkbox" value="E006"/>鉬
										<input name="bizscopes" type="checkbox" value="E007"/>鋯
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E008"/>球結礦
										<input name="bizscopes" type="checkbox" value="E009"/>石料
										<input name="bizscopes" type="checkbox" value="E010"/>生鐵
										<input name="bizscopes" type="checkbox" value="E011"/>廢鋼
										<input name="bizscopes" type="checkbox" value="E012"/>鉻鐵
										<input name="bizscopes" type="checkbox" value="E013"/>釩鐵
										<input name="bizscopes" type="checkbox" value="E014"/>錳鐵
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E015"/>矽鐵(硅)
										<input name="bizscopes" type="checkbox" value="E016"/>硼
										<input name="bizscopes" type="checkbox" value="E017"/>鎳
										<input name="bizscopes" type="checkbox" value="E018"/>熱鐵磚HBI
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
								<tr>
									<td class="head1">設備 / 耗材</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E019"/>高爐
										<input name="bizscopes" type="checkbox" value="E020"/>直接還原設備
										<input name="bizscopes" type="checkbox" value="E021"/>連 鑄
										<input name="bizscopes" type="checkbox" value="E022"/>精煉爐
										<input name="bizscopes" type="checkbox" value="E023"/>電爐
										<input name="bizscopes" type="checkbox" value="E024"/>轉爐
										<input name="bizscopes" type="checkbox" value="E025"/>軋 輥 修 補
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E026"/>軋 輥
										<input name="bizscopes" type="checkbox" value="E027"/>耐 火 材
										<input name="bizscopes" type="checkbox" value="E028"/>油封
										<input name="bizscopes" type="checkbox" value="E029"/>軸承
										<input name="bizscopes" type="checkbox" value="E030"/>冷卻床
										<input name="bizscopes" type="checkbox" value="E031"/>酸液回收設備
										<input name="bizscopes" type="checkbox" value="E032"/> 冷軋機
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E033"/>熱軋機
										<input name="bizscopes" type="checkbox" value="E034"/>澆鑄粉
										<input name="bizscopes" type="checkbox" value="E035"/>發 電
										<input name="bizscopes" type="checkbox" value="E036"/>閥類
										<input name="bizscopes" type="checkbox" value="E037"/>泵浦
										<input name="bizscopes" type="checkbox" value="E038"/>起重機
										<input name="bizscopes" type="checkbox" value="E039"/>空調設備
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E040"/>機 械
										<input name="bizscopes" type="checkbox" value="E041"/>環 保
										<input name="bizscopes" type="checkbox" value="E042"/>檢 驗
										<input name="bizscopes" type="checkbox" value="E043"/>冷卻油
										<input name="bizscopes" type="checkbox" value="E044"/>溶劑
										<input name="bizscopes" type="checkbox" value="E045"/>防鏽油
										<input name="bizscopes" type="checkbox" value="E046"/>軋延油
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E047"/>儀 表
										<input name="bizscopes" type="checkbox" value="E048"/>鍛 造
										<input name="bizscopes" type="checkbox" value="E049"/>成 形
										<input name="bizscopes" type="checkbox" value="E050"/>裁 剪
										<input name="bizscopes" type="checkbox" value="E051"/>退火
										<input name="bizscopes" type="checkbox" value="E052"/>酸洗
										<input name="bizscopes" type="checkbox" value="E053"/>張力重捲線
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E054"/>調質機
										<input name="bizscopes" type="checkbox" value="E055"/>加 熱 爐
										<input name="bizscopes" type="checkbox" value="E056"/>研磨機
										<input name="bizscopes" type="checkbox" value="E057"/>真空精練爐
										<input name="bizscopes" type="checkbox" value="E058"/>集塵粉再回收設備
										<input name="bizscopes" type="checkbox" value="E059"/>噴碳機
									</td>
								</tr>
								<tr>
									<td> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="E060"/>氧氣場
										<input name="bizscopes" type="checkbox" value="E061"/>燒結工場
										<input name="bizscopes" type="checkbox" value="E062"/>煉焦工場
										<input name="bizscopes" type="checkbox" value="E063"/>電擊棒
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes6" name="bizscopes" type="checkbox" value="F000"/> 買賣業
						</td>
					</tr>
					<tr class="bizscopes bizscopes6">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="F001" style="float: left;"/><a style="float: left;">運輸</a>
										<input name="bizscopes" type="checkbox" value="F002" style="float: left;"/><a style="float: left;">公証檢驗</a>
										<input name="bizscopes" type="checkbox" value="F003" style="float: left;"/><a style="float: left;">報關/理貨</a>
										<input name="bizscopes" type="checkbox" value="F004" style="float: left;"/><a style="float: left;">保險</a>
										<input name="bizscopes" type="checkbox" value="F005" style="float: left;"/><a style="float: left;">電子商務</a>
										<input name="bizscopes" type="checkbox" value="F006" style="float: left;"/><a style="float: left;">自動化</a>
										<input name="bizscopes" type="checkbox" value="F007" style="float: left;"/><a style="float: left;">塗料</a>
									</td>
								</tr>
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="F008" style="float: left;"/><a style="float: left;">金融機構</a>
										<input name="bizscopes" type="checkbox" value="F009" style="float: left;"/><a style="float: left;">施工/設計</a>
										<input name="bizscopes" type="checkbox" value="F010" style="float: left;"/><a style="float: left;">顧問</a>
										<input name="bizscopes" type="checkbox" value="F011" style="float: left;"/><a style="float: left;">包裝</a>
										<input name="bizscopes" type="checkbox" value="F999" style="float: left;"/><a style="float: left;">其 它</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother4" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes7" name="bizscopes" type="checkbox" value="G000"/> 鋼鐵工業副產品（例：水淬爐石、氧化鐵、焦油等）
						</td>
					</tr>
					<tr class="bizscopes bizscopes7">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="G001" style="float: left;"/><a style="float: left;">水淬爐石</a>
										<input name="bizscopes" type="checkbox" value="G002" style="float: left;"/><a style="float: left;">氧化鐵</a>
										<input name="bizscopes" type="checkbox" value="G003" style="float: left;"/><a style="float: left;">焦油</a>
										<input name="bizscopes" type="checkbox" value="G004" style="float: left;"/><a style="float: left;">高爐水泥</a>
										<input name="bizscopes" type="checkbox" value="G999" style="float: left;"/><a style="float: left;">其 它</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother5" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes8" name="bizscopes" type="checkbox" value="H000"/>鋼鐵應用相關產業(例：建築、 造船、 汽車等)
						</td>
					</tr>
					<tr class="bizscopes bizscopes8">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="H001" style="float: left;"/><a style="float: left;">建築</a>
										<input name="bizscopes" type="checkbox" value="H002" style="float: left;"/><a style="float: left;">機械</a>
										<input name="bizscopes" type="checkbox" value="H003" style="float: left;"/><a style="float: left;">造船</a>
										<input name="bizscopes" type="checkbox" value="H004" style="float: left;"/><a style="float: left;">家電</a>
										<input name="bizscopes" type="checkbox" value="H005" style="float: left;"/><a style="float: left;">汽車</a>
										<input name="bizscopes" type="checkbox" value="H999" style="float: left;"/><a style="float: left;">其 它</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother6" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input id="bizscopes9" name="bizscopes" type="checkbox" value="I000"/> 鋼鐵相關組織(例：公會、協會)
						</td>
					</tr>
					<tr class="bizscopes bizscopes9">
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 165px;"> </td>
									<td>
										<input name="bizscopes" type="checkbox" value="I001" style="float: left;"/><a style="float: left;">公會</a>
										<input name="bizscopes" type="checkbox" value="I002" style="float: left;"/><a style="float: left;">協會</a>
										<input name="bizscopes" type="checkbox" value="I003" style="float: left;"/><a style="float: left;">研究中心</a>
										<input name="bizscopes" type="checkbox" value="I999" style="float: left;"/><a style="float: left;">其 它</a>
										<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother7" type="text" class="txt c9"/>
										<span style="float: left;"> </span>(請填寫名稱)
									</td>
								</tr>
								<tr>
									<td colspan="2"><hr></td>
								</tr>
							</table>
						</td>
					</tr>
					<tr class="bizscopeshead">
						<td colspan="5">
							<input style="float: left;" id="bizscopes10" name="bizscopes" type="checkbox" value="J000"/><a style="float: left;">其 它</a>
							<span style="float: left;"> </span><input class="textBizscopes" id="textBizscopesother8" type="text" class="txt c9"/>
							<span style="float: left;"> </span>(請填寫名稱)
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImagea' class="lbl lblImgShowDown"> </a></td>
						<td>
							<input type="file" id="btnImagea" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImagea"  type="hidden"/><input id="txtImageaname"  type="hidden"/>
						</td>
						<td><span> </span><a id='lblImageb' class="lbl lblImgShowDown"> </a></td>
						<td>
							<input type="file" id="btnImageb" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImageb"  type="hidden"/><input id="txtImagebname"  type="hidden"/>
						</td>
					</tr>
					<tr style="display: none;">
						<td colspan="5"><div style="width:100%;" id="FileList"> </div></td>
					</tr>
				</table>
			</div>
		</div>
		<div class='dbbs' style="position:absolute;display:none;">
			<input id="btnClosesCusts" type="button" value="關閉" style=" float: right;"/>
			<BR>
			<table id="tbbs" class='tbbs' border="1" cellpadding='2' cellspacing='1'>
				<tr style='color:white; background:#003366;' >
					<td  align="center" style="width:30px;"><input class="btn"  id="btnPlus" type="button" value='+' style="font-weight: bold;"  /></td>
					<td align="center" style="width:20px;"> </td>
					<td align="center" style="width:130px;"><a id='lblId_s'> </a></td>
					<td align="center" style="width:130px;"><a id='lblPw_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblGroupa_s'> </a></td>
					<td align="center" style="width:40px;"><a id='lblGroupb_s'> </a></td>
					<td align="center" style="width:100px;"><a id='lblConn_s'> </a></td>
					<td align="center" style="width:150px;"><a id='lblEmail_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblMaster_s'> </a></td>
					<!--<td align="center" style="width:80px;"><a id='lblTypea_s'> </a></td>-->
					<td align="center" style="width:50px;"><a id='lblSconn_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCredit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTimes_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:35px;"><a id='lblCustt_s'> </a></td>
				</tr>
				<tr  style='background:#cad3ff;'>
					<td align="center">
						<input class="btn"  id="btnMinus.*" type="button" value='-' style=" font-weight: bold;" />
						<input id="txtNoq.*" type="text" style="display: none;" />
					</td>
					<td><a id="lblNo.*" style="font-weight: bold;text-align: center;display: block;"> </a></td>
					<td ><input type="text" id="txtId.*" class="txt c1" /></td>
					<td><input type="text" id="txtPw.*" class="txt c1" /></td>
					<td align="center"><input id="chkGroupa.*" type="checkbox"/></td>
					<td align="center"><input id="chkGroupb.*" type="checkbox"/></td>
					<td><input type="text" id="txtConn.*" class="txt c1" /></td>
					<td><input type="text" id="txtEmail.*" class="txt c1" /></td>
					<td align="center"><input id="chkMaster.*" type="checkbox"/></td>
					<!--<td><select id="cmbTypea.*" class="txt c1"> </select></td>-->
					<td align="center"><input id="chkSconn.*" type="checkbox"/></td>
					<td><input type="text" id="txtCredit.*" class="txt num c1" /></td>
					<td><input type="text" id="txtTimes.*" class="txt num c1" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td align="center"><input class="btn"  id="btnCustt.*" type="button" value='.'/></td>
				</tr>
			</table>
		</div>
		<div id="dbbt" class="dbbt" style="position:absolute;display:none;">
			<input id="btnClosesCustt" type="button" value="關閉" style=" float: right;"/>
			<BR>
			<table id="tbbt">
				<tr class="head" style="color:white; background:#003366;">
					<td style="width:20px;"><input id="btnPlut" type="button" style="font-size: medium; font-weight: bold;" value="＋"/></td>
					<td style="width:120px; text-align: center;"><a id='lblBdate_t'> </a></td>
					<td style="width:120px; text-align: center;"><a id='lblEdate_t'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTypea_t'> </a></td>
				</tr>
				<tr class="bbtid..*">
					<td>
						<input id="btnMinut..*" type="button" style="font-size: medium; font-weight: bold;" value="－"/>
						<input class="txt" id="txtNoq..*" type="text" style="display: none;"/>
						<input class="txt" id="txtId..*" type="text" style="display: none;"/>
						<!--<input class="txt" id="txtBtime..*" type="text" style="display: none;"/>
						<input class="txt" id="txtEtime..*" type="text" style="display: none;"/>-->
					</td>
					<td><input id="txtBdate..*" type="text" class="txt c1"/></td>
					<td><input id="txtEdate..*" type="text" class="txt c1"/></td>
					<td><select id="cmbTypea..*" class="txt c1"> </select></td>
				</tr>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>