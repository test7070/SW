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
			var q_readonly = ['textMid','txtWorker','txtWorker2'];
			var q_readonlys = [];
			var q_readonlyt = [];
			var bbmNum = [];
			var bbsNum = [];
			var bbtNum = [];
			var bbmMask = [];
			var bbsMask = [];
			var bbtMask = [];
			q_sqlCount = 6;
			brwList = [];
			brwNowPage = 0;
			brwKey = 'noa';
			//brwCount = 6;
			//brwCount2 = 33;
            brwCount = 0;
            brwCount2 = 9999;
			
			aPop = new Array();
			
			$(document).ready(function() {
				bbmKey = ['noa'];
				bbsKey = ['noa', 'noq'];
				bbtKey = ['noa', 'noq'];
                q_brwCount();
                
                q_content="where=^^1=1^^";
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
			
			var t_area=[],t_areas=[],t_areat=[];
			function mainPost() {
				bbmMask = [['txtStartdate', '9999/99/99'],['txtKdate', '9999/99/99']];
				bbtMask = [['txtBdate', '9999/99/99'],['txtEdate', '9999/99/99']];
				q_mask(bbmMask);
				
				$('#btnPrevPage').hide();
				$('#btnNextPage').hide();
				
				//q_gt('custtype', '', 0, 0, 0, "custtype");
				q_gt('bizscope', "where=^^right(noa,3)='000'^^", 0, 0, 0, "bizscope");
				q_gt('country', '', 0, 0, 0, "country");
				q_gt('area', '', 0, 0, 0, "area");
				q_cmbParse("cmbAreasno",'@----------');
				q_cmbParse("cmbIareasno",'@----------');
				q_cmbParse("cmbAreatno",'@----------');
				q_cmbParse("cmbIareatno",'@----------');
				
				q_cmbParse("cmbStatus", ','+q_getPara('cust.status'));
				//q_cmbParse("cmbCoin", '@無,NTD@台幣,RMB@人民幣,USD@美金');
				//q_cmbParse("cmbBizscope", '@無,A000@鋼鐵生產廠商,B000@產品製造業,C000@裁剪 / 加工業,D000@買賣業,E000@原料 / 設備 / 耗材供應商,F000@買賣業,G000@鋼鐵工業副產品,H000@鋼鐵應用相關產業,I000@鋼鐵相關組織,J000@其 它');
				//q_cmbParse("cmbBizscope2", '@無,A000@鋼鐵生產廠商,B000@產品製造業,C000@裁剪 / 加工業,D000@買賣業,E000@原料 / 設備 / 耗材供應商,F000@買賣業,G000@鋼鐵工業副產品,H000@鋼鐵應用相關產業,I000@鋼鐵相關組織,J000@其 它');
				//q_cmbParse("cmbTypea", '@選擇,'+q_getPara('custs.typea'),'s');
				//q_cmbParse("cmbTypea", '@選擇,'+q_getPara('custs.typea'),'t');
				q_cmbParse("cmbCobtype", ',二聯式,三聯式');
				q_cmbParse("cmbForeigns", ',0@台灣地區,1@台灣以外地區');
				
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
					$(this).val($.trim($(this).val()));		
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
				
				$('#cmbAreano').change(function() {
					change_areas('A');
				});
				$('#cmbAreasno').change(function() {
					change_areat('A');
				});
				$('#cmbIareano').change(function() {
					change_areas('I');
				});
				$('#cmbIareasno').change(function() {
					change_areat('I');
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
			
			/*function readBizscope() {
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
			}*/
			
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
					case 'area':
						t_area = _q_appendData("area", "", true);
						 var t_item = "@請選擇地區";
						for ( i = 0; i < t_area.length; i++) {
							t_item = t_item + (t_item.length > 0 ? ',' : '') + t_area[i].noa + '@' + t_area[i].area;
						}
						q_cmbParse("cmbAreano", t_item);
						q_cmbParse("cmbIareano", t_item);
						if(abbm[q_recno]){
							$("#cmbAreano").val(abbm[q_recno].areano);
							$("#cmbIareano").val(abbm[q_recno].iareano);
						}
						
						q_gt('areas', '', 0, 0, 0, "areas");
						break;
					case 'areas':
						t_areas = _q_appendData("areas", "", true);
						q_gt('areat', '', 0, 0, 0, "areat");
						break;
					case 'areat':
						t_areat = _q_appendData("areat", "", true);
						refresh(q_recno);
						break;
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
					case 'bizscope':
						var as = _q_appendData("bizscope", "", true);
						if (as[0] != undefined) {
							var t_item = "@---------------------《 專 業 項 目 》---------------------";
							var t_item2 = "@---------------------《 兼 業 項 目 》---------------------";
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
						$('#txtId_'+n).val(bbs_id_new);
					}else{
						$('.dbbt').hide();
						if(bbs_id_new==''){
							//新的ID
							//找主帳號的日期
							var v_bdate='',v_edate='';
							for(var j=0;j<q_bbtCount;j++){
								if($('#textMid').val()==$('#txtId__'+j).val()){
									if(v_bdate<$('#txtBdate__'+j).val()){
										v_bdate=$('#txtBdate__'+j).val()
										v_edate=$('#txtEdate__'+j).val()
									}
								}
							}
							$('#btnPlut').click();
							var m=q_bbtCount-1;
							$('#txtId__'+m).val($('#txtId_'+n).val());
							$('#txtBdate__'+m).val(v_bdate);
							$('#txtEdate__'+m).val(v_edate);
						}else{
							//取代原先使用期限的id
							for(var j=0;j<q_bbtCount;j++){
								if(bbs_id_new==$('#txtId__'+j).val()){
									$('#txtId__'+j).val($('#txtId_'+n).val());
								}
							}
						}
					}
				}
			}
			
			function change_areas(typea) {
				if(typea=='A'){//地址
					if($('#cmbAreano').val()!=''){
						//處理內容
						$('#cmbAreasno').text('');
						$('#cmbAreatno').text('');
						q_cmbParse("cmbAreatno",'@----------');
						var c_areas='@----------';
						for (i=0;i<t_areas.length;i++){
							if(t_areas[i].noa==$('#cmbAreano').val())
								c_areas=c_areas+','+t_areas[i].noq+"@"+t_areas[i].city;
						}
						q_cmbParse("cmbAreasno", c_areas);
					}else{
						$('#cmbAreasno').text('');
						$('#cmbAreatno').text('');
						q_cmbParse("cmbAreasno",'@----------');
						q_cmbParse("cmbAreatno",'@----------');
					}
				}else{//發票
					if($('#cmbIareano').val()!=''){
						//處理內容
						$('#cmbIareasno').text('');
						$('#cmbIareatno').text('');
						q_cmbParse("cmbIareatno",'@----------');
						var c_areas='@----------';
						for (i=0;i<t_areas.length;i++){
							if(t_areas[i].noa==$('#cmbIareano').val())
								c_areas=c_areas+','+t_areas[i].noq+"@"+t_areas[i].city;
						}
						q_cmbParse("cmbIareasno", c_areas);
					}else{
						$('#cmbIareasno').text('');
						$('#cmbIareatno').text('');
						q_cmbParse("cmbIareasno",'@----------');
						q_cmbParse("cmbIareatno",'@----------');
					}
				}
			}
			
			function change_areat(typea) {
				if(typea=='A'){//地址
					if($('#cmbAreano').val()!='' && $('#cmbAreasno').val()!=''){
						//處理內容
						$('#cmbAreatno').text('');
						var c_areat='@----------';
						for (i=0;i<t_areat.length;i++){
							if(t_areat[i].noa==$('#cmbAreano').val() && t_areat[i].noq==$('#cmbAreasno').val())
								c_areat=c_areat+','+t_areat[i].nor+"@"+t_areat[i].district;
						}
						q_cmbParse("cmbAreatno", c_areat);
					}else{
						$('#cmbAreatno').text('');
						q_cmbParse("cmbAreatno",'@----------');
					}
				}else{//發票
					if($('#cmbIareano').val()!='' && $('#cmbIareasno').val()!=''){
						//處理內容
						$('#cmbIareatno').text('');
						var c_areat='@----------';
						for (i=0;i<t_areat.length;i++){
							if(t_areat[i].noa==$('#cmbAreano').val() && t_areat[i].noq==$('#cmbAreasno').val())
								c_areat=c_areat+','+t_areat[i].nor+"@"+t_areat[i].district;
						}
						q_cmbParse("cmbIareatno", c_areat);
					}else{
						$('#cmbIareatno').text('');
						q_cmbParse("cmbIareatno",'@----------');
					}
				}
			}
			

			function _btnSeek() {
				if (q_cur > 0 && q_cur < 4)// 1-3
					return;
				q_box('cust_s.aspx', q_name + '_s', "500px", "450px", q_getMsg("popSeek"));
			}

			function btnIns() {
				_btnIns();
				refreshBbm();
				$('#txtNoa').focus();
				ShowImglbl();
				//readBizscope();
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
				//readBizscope();
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
				
				//檢查會員密碼是否空白
				var t_err='';
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtId_'+i).val()) && emp($('#txtPw_'+i).val())){
						t_err=t_err+(t_err.length>0?"、":"")+"【"+$('#txtId_'+i).val()+"】";
					}
				}
				
				if(t_err.length>0){
					alert(t_err+"密碼空白!!");
					Unlock(1);
					return;	
				}
				
				if(q_cur==1)
					$('#txtWorker').val(r_name);
				else
					$('#txtWorker2').val(r_name);
				
				//檢查會員帳號是否重複
				var t_id='';
				for (var i = 0; i < q_bbsCount; i++) {
					if(!emp($('#txtId_'+i).val())){
						t_id=t_id+(t_id.length>0?' and':'')+(" id='"+$('#txtId_'+i).val()+"' collate Chinese_Taiwan_Stroke_CS_AS ");
					}
				}
				t_where="where=^^  ("+t_id+") and noa!='"+$('#txtNoa').val()+"' collate Chinese_Taiwan_Stroke_CS_AS^^";
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
				//readBizscope();
				if(tmp_noa!=$('#txtNoa').val()){
					refreshclear();
					tmp_noa=$('#txtNoa').val();
				}
				
				change_areas('A');
				change_areas('I');
				if(abbm[q_recno]){
					$("#cmbAreasno").val(abbm[q_recno].areasno);
					$("#cmbIareasno").val(abbm[q_recno].iareasno);
				}
				change_areat('A');
				change_areat('I');
				if(abbm[q_recno]){
					$("#cmbAreatno").val(abbm[q_recno].areatno);
					$("#cmbIareatno").val(abbm[q_recno].iareatno);
				}
				
				for (var i = 0; i < brwCount; i++) {
                	if($('#vtunprocess_'+i).text()=="V" || dec($('#vtunprocess_'+i).text())>0)
                		$('#vtunprocess_'+i).text("V");
                	else
                		$('#vtunprocess_'+i).text("");
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
				if(q_cur==1)
					$('#btnCustu').attr('disabled', 'disabled');
				else
					$('#btnCustu').removeAttr('disabled', 'disabled');
					
				if(t_para){
					$("input[name='bizscopes']").attr('disabled', 'disabled');
					$(".textBizscopes").attr('disabled', 'disabled');
					$('.btnImg').attr('disabled', 'disabled');
					$('#btnShip').removeAttr('disabled', 'disabled');
					//$('#btnCustu').removeAttr('disabled', 'disabled');
					$('#txtStartdate').datepicker( 'destroy' );
                	$('#txtKdate').datepicker( 'destroy' );
				}else{
					$("input[name='bizscopes']").removeAttr('disabled');
					$(".textBizscopes").removeAttr('disabled');
					$('.btnImg').removeAttr('disabled', 'disabled');
					$('#btnShip').attr('disabled', 'disabled');
					//$('#btnCustu').attr('disabled', 'disabled');
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
			var bbs_id_new='';
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
							if(t_bbt_id!=''){
								bbtchange();
							 	$('.dbbt').show();
						 	}else{
						 		$('.dbbt').hide();
						 	}
						});
						
						$('#txtId_'+i).focusin(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							bbs_id_new=$(this).val();
						})
						
						$('#txtId_'+i).change(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							//$(this).val($(this).val());
							//if((/^[A-Za-z0-9]{4,12}$/g).test($(this).val())){
								if(!emp($(this).val())){
									t_where="where=^^ id='"+$(this).val()+"' collate Chinese_Taiwan_Stroke_CS_AS ^^";
									q_gt('custs', t_where, 0, 0, 0, "checkCustsId_"+b_seq, r_accy);
								}
							/*/}else{
								alert(q_getMsg('lblId_s')+'請輸入4~12個英文或數字!!');
								$(this).val('');
							}*/
							
							$('#chkGroupa_'+b_seq).prop('checked',true);
							$('#txtCredit_'+b_seq).val(100);
							$('#txtTimes_'+b_seq).val(100);
							
						});
						
						$('#chkMaster_'+i).click(function() {
							t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							
							if($('#chkMaster_'+b_seq).prop('checked')){
								$('#textMid').val($('#txtId_'+b_seq).val());
								for (var j = 0; j < q_bbsCount; j++) {
					        		if(b_seq!=j){
					        			$('#chkMaster_'+j).prop('checked',false);
					        			$('#btnPassid_'+j).hide();
					        		}else{
					        			$('#btnPassid_'+j).show();
					        		}
					        	}
							}
						});
						
						$('#btnPassid_'+i).click(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtId_'+b_seq).val())){
								if(emp($('#txtEmail').val())){
									alert(q_getMsg('lblEmail')+"空白!!");
									return;
								}
								
								if(emp($('#txtConn_'+b_seq).val())){
									alert("【"+$('#txtId_'+b_seq).val()+"】"+q_getMsg('lblConn_s')+"空白!!");
									return;
								}
								
								if(emp($('#txtPw_'+b_seq).val())){
									alert("【"+$('#txtId_'+b_seq).val()+"】密碼空白!!");
									return;
								}
								
								if(confirm('確定要'+q_getMsg('lblPassid_s')+'【'+$('#txtId_'+b_seq).val()+'】?')){
									var valid_id=[];
									for (var j = 0; j < q_bbtCount; j++) {
										if(q_date()>=$('#txtBdate__'+j).val() && q_date()<=$('#txtEdate__'+j).val()){
											var t_pw='';
											for (var i = 0; i < q_bbsCount; i++) {
												if($('#txtId__'+j).val()==$('#txtId_'+i).val()){
													t_pw=$('#txtPw_'+i).val();
												}
											}
											//密碼不空白
											if(t_pw!=''){
												//檢查id是否存在
												var x_id=false;
												for (var i = 0; i < valid_id.length; i++) {
													if(valid_id[i].id==$('#txtId__'+j).val()){
														x_id=true;
														break;
													}
												}
												if(!x_id){
													valid_id.push({
														id:$('#txtId__'+j).val(),
														pw:t_pw
													})
												}
											}
										}
									}
									
									if(valid_id.length>0){
										var t_id='',t_pw='';
										for (var i = 0; i < valid_id.length; i++) {
											t_id=t_id+(t_id.length>0?';':'')+valid_id[i].id;
											t_pw=t_pw+(t_pw.length>0?';':'')+valid_id[i].pw;
										}
										q_func( "daysw.email", "1,"+$('#txtEmail').val()+","+$('#txtConn_'+b_seq).val()+","+t_id+","+t_pw);   //會員帳號開通信函
										//q_func( "daysw.email", "1,"+$('#txtEmail').val()+","+$('#txtConn_'+b_seq).val()+","+$('#txtId_'+b_seq).val()+","+$('#txtPw_'+b_seq).val());   //會員帳號開通信函
									}else{
										alert("無有效帳號!!");
									}
								}
							}
						});
						
						$('#btnSendpass_'+i).click(function() {
		            		t_IdSeq = -1;
							q_bodyId($(this).attr('id'));
							b_seq = t_IdSeq;
							if(!emp($('#txtId_'+b_seq).val())){
								if(emp($('#txtEmail').val())){
									alert(q_getMsg('lblEmail')+"空白!!");
									return;
								}
								
								if(emp($('#txtConn_'+b_seq).val())){
									alert("【"+$('#txtId_'+b_seq).val()+"】"+q_getMsg('lblConn_s')+"空白!!");
									return;
								}
								
								if(emp($('#txtPw_'+b_seq).val())){
									alert("【"+$('#txtId_'+b_seq).val()+"】密碼空白!!");
									return;
								}
							
								if(confirm('確定要'+q_getMsg('lblSendpass_s')+'【'+$('#txtId_'+b_seq).val()+'】?')){
									q_func( "daysw.email", "3,"+$('#txtEmail').val()+","+$('#txtConn_'+b_seq).val()+","+$('#txtId_'+b_seq).val()+","+$('#txtPw_'+b_seq).val());   //會員密碼查詢回覆 
								}
							}
						});
		            }
		        }
		        _bbsAssign();
		        bbtchange();
		        var mid='';
		        for (var i = 0; i < q_bbsCount; i++) {
		        	if($('#chkMaster_'+i).prop('checked')){
		        		if(mid=='')
		        			mid=$('#txtId_'+i).val();
		        		$('#btnPassid_'+i).show();
		        	}else{
		        		$('#btnPassid_'+i).hide();
		        	}
		        }
		        $('#textMid').val(mid);
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
				
				for (var i = 0; i < q_bbtCount; i++) {
					if (q_cur<1 && q_cur>2) {
						$('#txtBdate__'+i).datepicker( 'destroy' );
						$('#txtEdate__'+i).datepicker( 'destroy' );
					}else{
						$('#txtBdate__'+i).removeClass('hasDatepicker');
						$('#txtBdate__'+i).datepicker({ dateFormat: 'yy/mm/dd' });
						$('#txtEdate__'+i).removeClass('hasDatepicker');
						$('#txtEdate__'+i).datepicker({ dateFormat: 'yy/mm/dd' });
					}
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
			<div class="dview" id="dview" style="float: left; width:400px; display: none;">
				<table class="tview" id="tview" border="1" cellpadding='2' cellspacing='0' style="background-color: #FFFF66;">
					<tr>
						<td align="center" style="width:5%"><a id='vewChk'> </a></td>
						<td align="center" style="width:35%"><a id='vewStatus'> </a></td>
						<td align="center" style="width:40%"><a id='vewComp'> </a></td>
						<td align="center" style="width:40%"><a id='vewUnprocess'> </a></td>
					</tr>
					<tr>
						<td><input id="chkBrow.*" type="checkbox" style=''/></td>
						<td align="center" id='status'>~status</td>
						<td align="center" id='comp'>~comp</td>
						<td align="center" id='unprocess'>~unprocess</td>
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
					<tr class="conn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">(1)帳號使用資料▼</a></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblMid' class="lbl"> </a></td>
						<td><input id="textMid" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblConn' class="lbl"> </a></td>
						<td><input id="txtConn" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblJob' class="lbl"> </a></td>
						<td><input id="txtJob" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblExt' class="lbl"> </a></td>
						<td><input id="txtExt" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="conn">
						<td><span> </span><a id='lblMobile' class="lbl"> </a></td>
						<td>
							<input id="txtMcode" type="text" class="txt c4"/><a style="float:left;">-</a>
							<input id="txtMobile" type="text" class="txt c5"/>
						</td>
						<td><span> </span><a id='lblEmail' class="lbl"> </a></td>
						<td><input id="txtEmail" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">(2)公司基本資料▼</a></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSerial' class="lbl"> </a></td>
						<td>
							<input id="txtNoa" type="text" class="txt c1" style="width: 50%;"/>
							<select id="cmbForeigns" class="txt c1" style="width: 50%;"> </select>
							<input id="txtSerial" type="hidden"/>
						</td>
						<td><input id="btnCusts" type="button" value="使用者帳號維護"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBizscope' class="lbl"> </a></td>
						<td colspan="2"><select id="cmbBizscope" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="2"><select id="cmbBizscope2" class="txt c1"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblComp' class="lbl"> </a></td>
						<td><input id="txtComp" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblBoss' class="lbl"> </a></td>
						<td><input id="txtBoss" type="text" class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTel' class="lbl"> </a></td>
						<td>
							<input id="txtTcode" type="text" class="txt c1" style="width: 15%;"/>
							<a style="float:left;">-</a>
							<input id="txtTareacode" type="text" class="txt c1" style="width: 15%;"/>
							<a style="float:left;">-</a>
							<input id="txtTel" type="text" class="txt c1" style="width: 65%;"/>
						</td>
						<td><span> </span><a id='lblFax' class="lbl"> </a></td>
						<td>
							<input id="txtFcode" type="text" class="txt c1" style="width: 15%;"/>
							<a style="float:left;">-</a>
							<input id="txtFareacode" type="text" class="txt c1" style="width: 15%;"/>
							<a style="float:left;">-</a>
							<input id="txtFax" type="text" class="txt c1" style="width: 65%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblAddr' class="lbl"> </a>
							<a style="float: right;display: none;">-</a><a id='lblCountry' class="lbl" style="display: none;"> </a>
						</td>
						<td colspan='3'>
							<select id="cmbCountry" class="txt c2" style="display: none;"> </select>
							<a style="float: left;display: none;">-</a>
							<select id="cmbAreano" class="txt c2" style="width: 15%;"> </select>
							<select id="cmbAreasno" class="txt c2" style="width: 13%;"> </select>
							<select id="cmbAreatno" class="txt c2" style="width: 13%;"> </select>
							<input id="txtAddr" type="text" class="txt c1" style="width: 58%;"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWeb' class="lbl"> </a></td>
						<td colspan='2'><input id="txtWeb" type="text" class="txt c1"/></td>
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
						<td><span> </span><a id='lblKdate' class="lbl"> </a></td>
						<td><input id="txtKdate" type="text" class="txt c2"/></td>
						<td><span> </span><a id='lblIscheck' class="lbl"> </a></td>
						<td><input id="chkIscheck" type="checkbox"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStatus' class="lbl"> </a></td>
						<td>
							<select id="cmbStatus" class="txt c3"> </select>
							<input id="btnCustu" type="button" value="繳款"/>
						</td>
					</tr>
					<tr class="sconn">
						<td colspan="4" style="text-align: center;"><a class="lbl" style="float: none;">(3)發票寄送資料▼</a></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblInvoname' class="lbl"> </a></td>
						<td><input id="txtInvoname" type="text" class="txt c1"/></td>
						<td> </td>
						<td> </td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblInvoaddr' class="lbl"> </a></td>
						<td colspan="3">
							<input id="txtInvopost" type="text" class="txt c4" style="display: none;"/>
							<a style="float: left;display: none;">-</a>
							<select id="cmbIareano" class="txt c2" style="width: 15%;"> </select>
							<select id="cmbIareasno" class="txt c2" style="width: 13%;"> </select>
							<select id="cmbIareatno" class="txt c2" style="width: 13%;"> </select>
							<input id="txtInvoaddr" type="text" class="txt c5" style="width: 58%;"/>
						</td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblCobtype' class="lbl"> </a></td>
						<td><select id="cmbCobtype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblInvotitle' class="lbl"> </a></td>
						<td><input id="txtInvotitle" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr class="sconn">
						<td><span> </span><a id='lblInvoserial' class="lbl"> </a></td>
						<td><input id="txtInvoserial" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblInvomemo' class="lbl"> </a></td>
						<td><input id="txtInvomemo" type="text" class="txt c1"/></td>
						<td> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker" type="text" class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2" type="text" class="txt c1"/></td>
						<td> </td>
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
					<td align="center" style="width:150px;display: none;"><a id='lblEmail_s'> </a></td>
					<td align="center" style="width:50px;"><a id='lblMaster_s'> </a></td>
					<!--<td align="center" style="width:80px;"><a id='lblTypea_s'> </a></td>-->
					<td align="center" style="width:50px;"><a id='lblSconn_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblCredit_s'> </a></td>
					<td align="center" style="width:80px;"><a id='lblTimes_s'> </a></td>
					<td align="center"><a id='lblMemo_s'> </a></td>
					<td align="center" style="width:35px;"><a id='lblCustt_s'> </a></td>
					<td align="center" style="width:35px;"><a id='lblSendpass_s'> </a></td>
					<td align="center" style="width:35px;"><a id='lblPassid_s'> </a></td>
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
					<td style="display: none;"><input type="text" id="txtEmail.*" class="txt c1" /></td>
					<td align="center"><input id="chkMaster.*" type="checkbox"/></td>
					<!--<td><select id="cmbTypea.*" class="txt c1"> </select></td>-->
					<td align="center"><input id="chkSconn.*" type="checkbox"/></td>
					<td><input type="text" id="txtCredit.*" class="txt num c1" /></td>
					<td><input type="text" id="txtTimes.*" class="txt num c1" /></td>
					<td><input type="text" id="txtMemo.*" class="txt c1" /></td>
					<td align="center"><input class="btn"  id="btnCustt.*" type="button" value='.'/></td>
					<td align="center"><input class="btn"  id="btnSendpass.*" type="button" value='.'/></td>
					<td align="center"><input class="btn"  id="btnPassid.*" type="button" value='.'/></td>
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