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
		<script type="text/javascript" src="../highslide/highslide.packed.js"></script>
		<script type="text/javascript" src="../highslide/highslide-with-html.packed.js"></script>
		<link rel="stylesheet" type="text/css" href="../highslide/highslide.css" /> 
		<script type="text/javascript"> hs.graphicsDir = '../highslide/graphics/'; hs.showCredits = false; hs.outlineType = 'rounded-white'; hs.outlineWhileAnimating = true; </script>
		<script type="text/javascript" src="../script/WFU-ts-mix.js"></script>
		<script type="text/javascript" src="../script/tongwen-ts.js"></script>
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
			brwCount2 =18;
			aPop = new Array();//['txtSssno', 'lblSss', 'sss', 'noa,namea', 'txtSssno,txtNamea', 'sss_b.aspx']
            				
            $(document).ready(function() {
                bbmKey = ['noa'];
                bbsKey = ['noa','noq'];
                bbtKey = ['noa','noq'];
                q_brwCount();
                q_gt(q_name, q_content, q_sqlCount, 1);
            });
			q_desc=1;
            function main() {
                if (dataErr) {
                    dataErr = false;
                    return;
                }
                mainForm(1);
            }
			
			/*var n_typeb=[],n_typec=[],n_typed=[],n_typeNow=[];
			n_typeNow.push({typea:'',typeb:'',typec:'',typed:''});*/
            function mainPost() {
            	bbmMask = [['txtDatea', '9999/99/99'],['txtTimea', '99:99']];
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
                
                $('.lblLanguage1').text('繁體').css('float','left');
                $('.lblLanguage2').text('簡體').css('float','left');
                $('.lblImgplace').text('位置').css('float','left');
                
                q_cmbParse("cmbRank", "@選擇等級,1,2,3,4,5,6,7,8,9,10");
                q_cmbParse("cmbImgaplace", ",0@右,1@下");
                q_cmbParse("cmbImgbplace", ",0@右,1@下");
                q_cmbParse("cmbImgcplace", ",0@右,1@下");
                q_cmbParse("cmbImgdplace", ",0@右,1@下");
				
				q_gt('sss', '', 0, 0, 0, "sss");
				
				$('#combNamea').change(function() {
					if(q_cur==1 || q_cur==2){
						$('#txtSssno').val($('#combNamea').val());
						$('#txtNamea').val($('#combNamea').find("option:selected").text());	
					}
					$('#combNamea').get(0).selectedIndex=0;
				});
				
                q_gt('newsstype', '', 0, 0, 0, "newsstype");
                //q_gt('newsarea', '', 0, 0, 0, "newsarea");
                q_gt('newscountry', '', 0, 0, 0, "newscountry");
                /*q_gt('newstypea', '', 0, 0, 0, "newstypea");
                q_gt('newstypeb', '', 0, 0, 0, "newstypeb");
                q_gt('newstypec', '', 0, 0, 0, "newstypec");
                q_gt('newstyped', '', 0, 0, 0, "newstyped");*/
                
                /*$('#cmbTypea').change(function() {
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
				
				$('#cmbTyped').change(function() {
					n_typeNow[0].typed=$('#cmbTyped').val()
                	Typeachange(); 
				});*/
				
				$('#cmbRegion').change(function() {
					Regionchange();
				});
				
				$("input[name='typea']").click(function() {
					savetypea();
					var t_values=$(this).val();
					if($(this).prop('checked')){
						//自動勾選上層
						$("input[name='typea']").each(function() {
							if(t_values.substr(0,$(this).val().length)==$(this).val()){
									$(this).prop('checked',true);
							}
						});
					}else{
						//取消下層
						$("input[name='typea']").each(function() {
							if(t_values==$(this).val().substr(0,t_values.length) && t_values.length<$(this).val().length){
									$(this).prop('checked',false);
							}
						});
					}
						savetypea();
						readTypea();
				});
				
				var levels=dec(replaceAll($("input[name='typea']").last().attr('id'),'typea',''));
				for (var i=1;i<=levels;i++){
					$('.typea'+i).hide();
					$('#typea'+i).click(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
				
				$("input[name='typea2']").click(function() {
					savetypea2();
					var t_values=$(this).val();
					if($(this).prop('checked')){
						//自動勾選上層
						$("input[name='typea2']").each(function() {
							if(t_values.substr(0,$(this).val().length)==$(this).val()){
									$(this).prop('checked',true);
							}
						});
					}else{
						//取消下層
						$("input[name='typea2']").each(function() {
							if(t_values==$(this).val().substr(0,t_values.length) && t_values.length<$(this).val().length){
									$(this).prop('checked',false);
							}
						});
					}
						savetypea2();
						readTypea2();
				});
				
				var levels2=dec(replaceAll($("input[name='typea2']").last().attr('id'),'typea',''));
				for (var i=levels+1;i<=levels2;i++){
					$('.typea'+i).hide();
					$('#typea'+i).click(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
                
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
						};
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						};
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
							oReq.open("POST", 'news_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}
					ShowImglbl();
				});
            }
            
            var guid = (function() {
				function s4() {return Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);}
				//return function() {return s4() + s4() + '-' + s4() + '-' + s4() + '-' +s4() + '-' + s4() + s4() + s4();};
				return function() {return s4() + s4() + s4() + s4();};
			})();
            
            /*function Typeachange() {
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
			}*/
			
			function Regionchange() {
				//清除Country資料
				$('#cmbCountry').text('').val('');
				
				if($('#cmbRegion').val()!=''){
					var c_country='@';
					var country_count=0;
					for (i=0;i<t_newscountry.length;i++){
						if(t_newscountry[i].regionno==$('#cmbRegion').val()){
							c_country=c_country+','+t_newscountry[i].noa+"@"+t_newscountry[i].country;
							country_count++;
						}
					}
					
					q_cmbParse("cmbCountry", c_country);
					if(country_count==1){
						$('#cmbCountry').get(0).selectedIndex=1;
					}
				}
			}
			
			function readTypea() {
				var t_typea=$('#txtTypea').val().split(',');
				$("input[name='typea']").prop('checked',false);
				//核取
				$("input[name='typea']").each(function() {
					for(var i=0;i<t_typea.length;i++){
						if(t_typea[i]==$(this).val()){
							$(this).prop('checked',true);
						}	
					}
				});
				
				var levels=dec(replaceAll($("input[name='typea']").last().attr('id'),'typea',''));
				for (var i=1;i<=levels;i++){
					$('.typea'+i).hide();
					$('#typea'+i).each(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
			}
			
			function readTypea2() {
				var t_typea2=$('#txtTypea2').val().split(',');
				$("input[name='typea2']").prop('checked',false);
				//核取
				$("input[name='typea2']").each(function() {
					for(var i=0;i<t_typea2.length;i++){
						if(t_typea2[i]==$(this).val()){
							$(this).prop('checked',true);
						}	
					}
				});
				
				var levels=dec(replaceAll($("input[name='typea']").last().attr('id'),'typea',''));
				var levels2=dec(replaceAll($("input[name='typea2']").last().attr('id'),'typea',''));
				for (var i=levels+1;i<=levels2;i++){
					$('.typea'+i).hide();
					$('#typea'+i).each(function() {
						var className = $(this).attr('id');
						if($(this).prop('checked'))
							$('.'+className).show();
						else
							$('.'+className).hide();
					});	
				}
			}
			
			//檢查階層是否完整
			function checkTypea() {
				//紀錄最高階層 
				var levels=[];
				$("input[name='typea']").each(function() {
					if(levels[dec($(this).val().substr(0,2))]==undefined)
						levels[dec($(this).val().substr(0,2))]={level:0,hcheck:true,lcheck:false,check:false,counts:0,item:'',child:[]}
					if(levels[dec($(this).val().substr(0,2))].level<($(this).val().length/2))
						levels[dec($(this).val().substr(0,2))].level=($(this).val().length/2);
					if(($(this).val().length/2)==1)
						levels[dec($(this).val().substr(0,2))].item=$('#item'+$(this).val()).text();
					if(($(this).val().length/2)==2){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].val=$(this).val();
					}
					if(($(this).val().length/2)==3){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].val=$(this).val();
					}
					if(($(this).val().length/2)==4){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))].child.val=$(this).val();
					}
				});
				
				//目前資料
				var t_typea=$('#txtTypea').val().split(',');
				for (var i=0;i<t_typea.length; i++){
					if((t_typea[i].length/2)==1 ){
						levels[dec(t_typea[i].substr(0,2))].check=true;
					}
					if((t_typea[i].length/2)==2 ){
						levels[dec(t_typea[i].substr(0,2))].child[dec(t_typea[i].substr(2,2))].check=true;
					}
					if((t_typea[i].length/2)==3 ){
						levels[dec(t_typea[i].substr(0,2))].child[dec(t_typea[i].substr(2,2))].child[dec(t_typea[i].substr(4,2))].check=true;
					}
					if((t_typea[i].length/2)==4 ){
						levels[dec(t_typea[i].substr(0,2))].child[dec(t_typea[i].substr(2,2))].child[dec(t_typea[i].substr(4,2))].child[dec(t_typea[i].substr(6,2))].check=true;
					}
					if(levels[dec(t_typea[i].substr(0,2))])
						levels[dec(t_typea[i].substr(0,2))].counts++;
				}
				//寫入底層是否有資料
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						for (var j=0;j<levels[i].child.length; j++){
							if(levels[i].child[j]!=undefined){
								for (var k=0;k<levels[i].child[j].child.length; k++){
									if(levels[i].child[j].child[k]!=undefined){
										for (var l=0;l<levels[i].child[j].child[k].child.length; l++){
											if(levels[i].child[j].child[k].child[l]!=undefined){												
												//l
												if(levels[i].child[j].child[k].child[l].check)
													levels[i].child[j].child[k].lcheck=true;
											}
										}
										//K
										if(levels[i].child[j].child[k].check)
											levels[i].child[j].lcheck=true;
									}
								}
								//j
								if(levels[i].child[j].check)
									levels[i].lcheck=true;
							}
						}
					}
				}
				
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						for (var j=0;j<levels[i].child.length; j++){
							if(levels[i].child[j]!=undefined){
								for (var k=0;k<levels[i].child[j].child.length; k++){
									if(levels[i].child[j].child[k]!=undefined){
										//K
										if(levels[i].child[j].child[k].check!=levels[i].child[j].child[k].lcheck && levels[i].child[j].child[k].child.length!=0)
											levels[i].hcheck=false;
									}
								}
								//j
								if(levels[i].child[j].check!=levels[i].child[j].lcheck && levels[i].child[j].child.length!=0)
									levels[i].hcheck=false;
							}
						}
						//i
						if(levels[i].lcheck != levels[i].check && levels[i].child.length!=0)
							levels[i].hcheck=false;
					}
				}
				
				var t_msg='';
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						if(levels[i].counts!=0 && !levels[i].hcheck)
							t_msg=t_msg+(t_msg.length>0?"\n":"")+levels[i].item+'子階層未選取!!';
					}
				}
				if (t_msg.length>0){
					alert(t_msg);
					return false;
				}else
					return true;
			}
			
			function checkTypea2() {
				//紀錄最高階層 
				var levels=[];
				$("input[name='typea2']").each(function() {
					if(levels[dec($(this).val().substr(0,2))]==undefined)
						levels[dec($(this).val().substr(0,2))]={level:0,hcheck:true,lcheck:false,check:false,counts:0,item:'',child:[]}
					if(levels[dec($(this).val().substr(0,2))].level<($(this).val().length/2))
						levels[dec($(this).val().substr(0,2))].level=($(this).val().length/2);
					if(($(this).val().length/2)==1)
						levels[dec($(this).val().substr(0,2))].item=$('#item'+$(this).val()).text();
					if(($(this).val().length/2)==2){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].val=$(this).val();
					}
					if(($(this).val().length/2)==3){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].val=$(this).val();
					}
					if(($(this).val().length/2)==4){
						if(levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))]==undefined)
							levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))]={lcheck:false,check:false,val:$(this).val(),child:[]};
						levels[dec($(this).val().substr(0,2))].child[dec($(this).val().substr(2,2))].child[dec($(this).val().substr(4,2))].child[dec($(this).val().substr(6,2))].child.val=$(this).val();
					}
				});
				
				//目前資料
				var t_typea2=$('#txtTypea2').val().split(',');
				for (var i=0;i<t_typea2.length; i++){
					if((t_typea2[i].length/2)==1 ){
						levels[dec(t_typea2[i].substr(0,2))].check=true;
					}
					if((t_typea2[i].length/2)==2 ){
						levels[dec(t_typea2[i].substr(0,2))].child[dec(t_typea2[i].substr(2,2))].check=true;
					}
					if((t_typea2[i].length/2)==3 ){
						levels[dec(t_typea2[i].substr(0,2))].child[dec(t_typea2[i].substr(2,2))].child[dec(t_typea2[i].substr(4,2))].check=true;
					}
					if((t_typea2[i].length/2)==4 ){
						levels[dec(t_typea2[i].substr(0,2))].child[dec(t_typea2[i].substr(2,2))].child[dec(t_typea2[i].substr(4,2))].child[dec(t_typea2[i].substr(6,2))].check=true;
					}
					if(levels[dec(t_typea2[i].substr(0,2))])
						levels[dec(t_typea2[i].substr(0,2))].counts++;
				}
				//寫入底層是否有資料
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						for (var j=0;j<levels[i].child.length; j++){
							if(levels[i].child[j]!=undefined){
								for (var k=0;k<levels[i].child[j].child.length; k++){
									if(levels[i].child[j].child[k]!=undefined){
										for (var l=0;l<levels[i].child[j].child[k].child.length; l++){
											if(levels[i].child[j].child[k].child[l]!=undefined){												
												//l
												if(levels[i].child[j].child[k].child[l].check)
													levels[i].child[j].child[k].lcheck=true;
											}
										}
										//K
										if(levels[i].child[j].child[k].check)
											levels[i].child[j].lcheck=true;
									}
								}
								//j
								if(levels[i].child[j].check)
									levels[i].lcheck=true;
							}
						}
					}
				}
				
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						for (var j=0;j<levels[i].child.length; j++){
							if(levels[i].child[j]!=undefined){
								for (var k=0;k<levels[i].child[j].child.length; k++){
									if(levels[i].child[j].child[k]!=undefined){
										//K
										if(levels[i].child[j].child[k].check!=levels[i].child[j].child[k].lcheck && levels[i].child[j].child[k].child.length!=0)
											levels[i].hcheck=false;
									}
								}
								//j
								if(levels[i].child[j].check!=levels[i].child[j].lcheck && levels[i].child[j].child.length!=0)
									levels[i].hcheck=false;
							}
						}
						//i
						if(levels[i].lcheck != levels[i].check && levels[i].child.length!=0)
							levels[i].hcheck=false;
					}
				}
				
				var t_msg='';
				for (var i=0;i<levels.length; i++){
					if(levels[i]!=undefined){
						if(levels[i].counts!=0 && !levels[i].hcheck)
							t_msg=t_msg+(t_msg.length>0?"\n":"")+levels[i].item+'子階層未選取!!';
					}
				}
				if (t_msg.length>0){
					alert(t_msg);
					return false;
				}else
					return true;
			}
			
			function ShowImglbl() {
				$('.lblImgShowDown').each(function(){
					var txtimg=replaceAll($(this).attr('id'),'lbl','txt');
					var lblimg=replaceAll($(this).attr('id'),'lbl','lbl');
					if(!emp($('#'+txtimg).val())){
						$('#'+lblimg).addClass('lbl btn highslide ').attr('href','../doc/news/'+$('#'+txtimg).val())
						.attr('onclick',"return hs.expand(this, { captionId: 'caption1', align: 'center',allowWidthReduction: true } )");
					}else{
						$('#'+lblimg).removeClass('lbl btn highslide ').removeAttr('href').removeAttr('onclick');
					}
						
					$('#'+lblimg).bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
                        if($('#'+txtimg).val().length>0)
                        	$('#xdownload').attr('src','news_download.aspx?FileName='+$('#'+txtimg+'name').val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...');
					});
				});
				
				$('.lblDownload').text('').hide();
				$('.lblDownload').each(function(){
					var txtimg=replaceAll($(this).attr('id'),'lbl','txt');
					var lblimg=replaceAll($(this).attr('id'),'lbl','lbl');
					var txtOrgName = replaceAll($(this).attr('id'),'lbl','txt').split('_');
					
					if(!emp($('#'+txtimg).val()))
						$(this).text('下載').show();
											
					$('#'+lblimg).click(function(e) {
                        if(txtimg.length>0)
                        	$('#xdownload').attr('src','news_download.aspx?FileName='+$('#'+txtOrgName[0]+'name_'+txtOrgName[1]).val()+'&TempName='+$('#'+txtimg).val());
                        else
                        	alert('無資料...'+n);
					});
				});
			}
			
			function ChangeGB() {
				if(q_cur==1 || q_cur==2){
					$('.ChangeGB').attr('title',"點擊滑鼠左鍵，轉簡體。")
					$('.ChangeGB').click(function() {
						var txtGB = replaceAll($(this).attr('id'),'lbl','txt');
						var txtBIG5 = replaceAll($(this).attr('id'),'lbl','txt');
						txtBIG5=txtBIG5.substr(0,txtBIG5.length-1);
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
					});
					
					$('.ChangeGBm').attr('title',"點擊滑鼠左鍵，轉簡體。")
					$('.ChangeGBm').click(function() {
						var txtGB = replaceAll($(this).attr('id'),'lbl','txt');
						var txtBIG5 = replaceAll($(this).attr('id'),'lbl','txt');
						txtBIG5=replaceAll(txtBIG5,'2m','1m')
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
					});
					
					$('.ChangeGBs').attr('title',"點擊滑鼠右鍵，轉簡體。")
					$('.ChangeGBs').bind('contextmenu', function(e) {
						/*滑鼠右鍵*/
						e.preventDefault();
						var txtGB = $(this).attr('id');
						var txtBIG5 = replaceAll($(this).attr('id'),'2_','_');
						$('#'+txtGB).val(toSimp($('#'+txtBIG5).val()));
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
                b_pop='';
            }
            
            var t_newscountry=[];//儲存newscountry資料
            var t_newsregion=[];//儲存newsregion資料
            function q_gtPost(t_name) {
                switch (t_name) {
                	case 'sss':
                		var as = _q_appendData("sss", "", true);
						if (as[0] != undefined) {
							var t_item = "@";
							for (i = 0; i < as.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(as[i].noa) + '@' + $.trim(as[i].namea);
							}
							q_cmbParse("combNamea", t_item);
						}
                		break;
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
                	/*case 'newsarea':
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
                		break;*/
                	case 'newscountry':
                		t_newscountry = _q_appendData("newscountry", "", true);
                		if (t_newscountry[0] != undefined) {
							for (i = 0; i < t_newscountry.length; i++) {
								var regionrepeat=false;
								for (j = 0; j < t_newsregion.length; j++) {
									if(t_newscountry[i].regionno==t_newsregion[j].regionno){
										regionrepeat=true;
										break;
									}
								}
								if(!regionrepeat){
									t_newsregion.push({
										regionno:t_newscountry[i].regionno,
										region:t_newscountry[i].region,
										areano:t_newscountry[i].areano
									})	;
								}
							}
							
							var t_item = "@";
							for (i = 0; i < t_newsregion.length; i++) {
								t_item = t_item + (t_item.length > 0 ? ',' : '') + $.trim(t_newsregion[i].regionno) + '@' + $.trim(t_newsregion[i].region);
							}
							
							q_cmbParse("cmbRegion", t_item);
							if(abbm[q_recno])
								$("#cmbRegion").val(abbm[q_recno].region);
							Regionchange();
							if(abbm[q_recno])
								$("#cmbCountry").val(abbm[q_recno].country);
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
                	/*case 'newstypeb':
                		n_typeb = _q_appendData("newstypeb", "", true);
                		Typeachange();
                		break;
                	case 'newstypec':
                		n_typec = _q_appendData("newstypec", "", true);
                		Typeachange();
                		break;
                	case 'newstyped':
                		n_typed = _q_appendData("newstyped", "", true);
                		Typeachange();
                		break;*/
                    case q_name:
                        if (q_cur == 4)
                            q_Seek_gtPost();
                        break;
                }
            }

            function _btnSeek() {
                if (q_cur > 0 && q_cur < 4)// 1-3
                    return;
                q_box('news_s.aspx', q_name + '_s', "500px", "410px", q_getMsg("popSeek"));
            }

            function btnIns() {
                _btnIns();
                $('#txtTitle').focus();
                $('#txtDatea').val(q_date());
                var timeDate= new Date();
                var tHours = timeDate.getHours();
				var tMinutes = timeDate.getMinutes();
				var tSeconds = timeDate.getSeconds();
				$('#txtTimea').val(padL(tHours, '0', 2)+':'+padL(tMinutes, '0', 2));
                ShowImglbl();
                ChangeGB();
                readTypea();
                readTypea2();
                $('#chkWatermark').prop('checked',true);
                $('#chkOnline').prop('checked',true);
                $('#cmbCountry').text('').val('');
            }

            function btnModi() {
                if (emp($('#txtNoa').val()))
                    return;
                _btnModi();
                $('#txtTitle').focus();
                ShowImglbl();
                ChangeGB();
                readTypea();
                readTypea2();
            }

            function btnPrint() {

            }
            
			function q_stPost() {
                if (!(q_cur == 1 || q_cur == 2))
                    return false;
                Unlock(1);
            }
            
            //儲存文章屬性
            function savetypea() {
                var t_typea=''
            	$("input[name='typea']").each(function(index) {
            		if($(this).prop('checked'))
						t_typea=t_typea+(t_typea.length>0?',':'')+$(this).val();
				});
				$('#txtTypea').val(t_typea);
            } 
            
            function savetypea2() {
                var t_typea2=''
            	$("input[name='typea2']").each(function(index) {
            		if($(this).prop('checked'))
						t_typea2=t_typea2+(t_typea2.length>0?',':'')+$(this).val();
				});
				$('#txtTypea2').val(t_typea2);
            } 
            
            function btnOk() {
            	Lock(1,{opacity:0});
            	var a = $('#txtDatea').val() + ' ' + $('#txtTimea').val();
            	try{
            		var b = new Date(a);
            		if(isNaN(b.valueOf())){
            			alert('日期時間錯誤');
	            		Unlock(1);
	                    return;
            		}
            	}catch(e){
            		alert(e.message);
            		Unlock(1);
                    return;
            	}
            	
            	savetypea();
            	savetypea2();
            	if(!checkTypea()){
            		Unlock(1);
                    return;
            	}
            	if(!checkTypea2()){
            		Unlock(1);
                    return;
            	}
            	
            	var t_err = '';
                t_err = q_chkEmpField([['txtTitle', q_getMsg('lblTitle')],['txtContents', q_getMsg('lblContents')]
                ,['txtSssno', q_getMsg('lblSss')],['txtNamea', q_getMsg('lblSss')],['txtDatea', q_getMsg('lblDatea')],['txtTimea', q_getMsg('lblTimea')]
                ,['cmbStype', q_getMsg('lblStype')],['txtTypea', q_getMsg('lblTypea')],['txtTypea2', q_getMsg('lblTypea2')]
                ,['cmbRegion', q_getMsg('lblRegion')],['cmbCountry', q_getMsg('lblCountry')],['cmbRank', q_getMsg('lblRank')]]);
                //,['cmbArea', q_getMsg('lblArea')]
                
                if (t_err.length > 0) {
                    alert(t_err);
                    Unlock(1);
                    return;
                }
                
                if(!((/^[0-9]{2}\:[0-9]{2}$/g).test($('#txtTimea').val()))){
                	alert('時間格式錯誤!!!');
                    Unlock(1);
                    return;
                }
                
                if($('#chkWatermark').prop('checked') && $('#txtContents').val().indexOf('{ad01}')==-1){
                	var s_contents=$('#txtContents').val().split('。');
                	var t_contents='';
                	for(var i=0;i<s_contents.length;i++){
                		if($.trim(s_contents[i])!=''){
	                		t_contents=t_contents+s_contents[i];
	                		t_contents=t_contents+'。'+(i==1?'{ad01}':'');
                		}
                	}
                	if(t_contents.indexOf('{ad01}')==-1){
                		t_contents=t_contents+'{ad01}';
                	}
                	$('#txtContents').val(t_contents);
                }
                
                if($('#chkWatermark').prop('checked') && $('#txtContents2').val().indexOf('{ad01}')==-1){
                	var s_contents2=$('#txtContents2').val().split('。');
                	var t_contents2='';
                	for(var i=0;i<s_contents2.length;i++){
                		if($.trim(s_contents2[i])!=''){
	                		t_contents2=t_contents2+s_contents2[i];
	                		t_contents2=t_contents2+'。'+(i==1?'{ad01}':'');
                		}
                	}
                	if(t_contents2.indexOf('{ad01}')==-1){
                		t_contents2=t_contents2+'{ad01}';
                	}
                	$('#txtContents2').val(t_contents2);
                }
                
                for(var i=0;i<t_newsregion.length;i++){
                	if($('#cmbRegion').val()==t_newsregion[i].regionno){
                		$('#txtArea').val(t_newsregion[i].areano);
                		break;
                	}
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
                if (q_cur == 2)/// popSave
                    xmlSql = q_preXml();

                $('#txt' + bbmKey[0].substr(0, 1).toUpperCase() + bbmKey[0].substr(1)).val(key_value);
                _btnOk(key_value, bbmKey[0], '', '', 2);
            }
            
            function bbsSave(as) {
				if (!as['title']&&!as['att1']&&!as['att2']) {
					as[bbsKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}
			
			function bbtSave(as) {
				if (!as['title']&&!as['web1']&&!as['web2']) {
					as[bbtKey[1]] = '';
					return;
				}
				q_nowf();
				return true;
			}

            function refresh(recno) {
                _refresh(recno);
                $('#txtContents').val(replaceAll($('#txtContents').val(),'chr(10)','\n'));
            	$('#txtContents2').val(replaceAll($('#txtContents2').val(),'chr(10)','\n')) ;
                /*if(abbm[q_recno]){
	                n_typeNow[0].typea=abbm[q_recno].typea;
	                n_typeNow[0].typeb=abbm[q_recno].typeb;
	                n_typeNow[0].typec=abbm[q_recno].typec;
	                n_typeNow[0].typed=abbm[q_recno].typed;
				}*/
                //Typeachange();  
                Regionchange();
                if(abbm[q_recno])
					$("#cmbCountry").val(abbm[q_recno].country);
                ShowImglbl();
                ChangeGB();
                readTypea();
                readTypea2();
            }

            function readonly(t_para, empty) {
                _readonly(t_para, empty);
                if(t_para){
                	$("input[name='typea']").attr('disabled', 'disabled');
                	$("input[name='typea2']").attr('disabled', 'disabled');
                	$('.btnImg').attr('disabled', 'disabled');
                	$('.btnAtt').attr('disabled', 'disabled');
                	$('#txtDatea').datepicker( 'destroy' );
                }else{
                	$("input[name='typea']").removeAttr('disabled');
                	$("input[name='typea2']").removeAttr('disabled');
                	$('.btnImg').removeAttr('disabled', 'disabled');
                	$('.btnAtt').removeAttr('disabled', 'disabled');
                	$('#txtDatea').removeClass('hasDatepicker');
					$('#txtDatea').datepicker({ dateFormat: 'yy/mm/dd' });
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
				if(q_cur==1 || q_cur==2){
					$('.btnAtt').removeAttr('disabled', 'disabled');
				}else{
					$('.btnAtt').attr('disabled', 'disabled');
				}
				
				$('.lblLanguage1_s').text('繁體');
                $('.lblLanguage2_s').text('簡體');
                
                $('.btnAtt').change(function() {
					event.stopPropagation(); 
					event.preventDefault();
					if(q_cur==1 || q_cur==2){}else{return;}
					var txtOrgName = replaceAll($(this).attr('id'),'btn','txt').split('_');
					var txtName = replaceAll($(this).attr('id'),'btn','txt');
					file = $(this)[0].files[0];
					if(file){
						Lock(1);
						var ext = '';
						var extindex = file.name.lastIndexOf('.');
						if(extindex>=0){
							ext = file.name.substring(extindex,file.name.length);
						}
						$('#'+txtOrgName[0]+'name_'+txtOrgName[1]).val(file.name);
						$('#'+txtName).val(guid()+Date.now()+ext);
						
						fr = new FileReader();
						fr.fileName = $('#'+txtName).val();
					    fr.readAsDataURL(file);
					    fr.onprogress = function(e){
							if ( e.lengthComputable ) { 
								var per = Math.round( (e.loaded * 100) / e.total) ; 
								$('#FileList').children().last().find('progress').eq(0).attr('value',per);
							}
						};
						fr.onloadstart = function(e){
							$('#FileList').append('<div styly="width:100%;"><progress id="progress" max="100" value="0" ></progress><progress id="progress" max="100" value="0" ></progress><a>'+fr.fileName+'</a></div>');
						};
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
								
							oReq.timeout = 360000;
							oReq.ontimeout = function () { alert("Timed out!!!"); }
							oReq.open("POST", 'news_upload.aspx', true);
							oReq.setRequestHeader("Content-type", "text/plain");
							oReq.setRequestHeader("FileName", escape(fr.fileName));
							oReq.send(fr.result);
						};
					}
					ShowImglbl();
				});
				ShowImglbl();
				ChangeGB();
			}

			function bbtAssign() {
				for (var i = 0; i < q_bbtCount; i++) {
					$('#lblNo__' + i).text(q_getMsg("lblWeb")+(i + 1));
				}
				_bbtAssign();
				$('.lblLanguage1_t').text('繁體');
                $('.lblLanguage2_t').text('簡體');
                ChangeGB();
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
                width: 330px; 
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
                width: 870px;
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
                cursor: pointer;
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
            .txt.c3 {
                width: 83%;
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
			.dbbs tr td .lbl.btn {
                color: #4297D7;
                font-weight: bolder;
                cursor: pointer;
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
            .highslide-wrapper .highslide-html-content {
			    width: auto;
			}
		</style>
	</head>
	<body>
		<div style="overflow: auto;display:block;width:1050px;">
			<!--#include file="../inc/toolbar.inc"-->
		</div>
		<div style="overflow: auto;display:block;width:1280px;">
			<div class="dview" id="dview" >
				<table class="tview" id="tview">
					<tr>
						<td align="center" style="width:20px; color:black;"><a id='vewChk'> </a></td>
						<td align="center" style="width:90px; color:black;"><a id='vewDatea'> </a></td>
						<td align="center" style="width:80px; color:black;"><a id='vewSss'> </a></td>
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
						<td style="width: 130px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 110px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 110px"> </td>
						<td style="width: 170px"> </td>
						<td style="width: 10px"> </td>
					</tr>
					<tr>
						<td><span> </span><a id='lblSss' class="lbl"> </a></td>
						<td>
							<!--<input id="txtSssno"  type="text"  class="txt c1" style="width: 49%"/>-->
							<input id="txtSssno"  type="hidden"/>
							<input id="txtNamea"  type="text"  class="txt c1" style="width: 150px;"/>
							<select id="combNamea" class="txt c1" style="width: 20px;"> </select>
						</td>
						<td><span> </span><a id='lblDatea' class="lbl"> </a></td>
						<td><input id="txtDatea"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblTimea' class="lbl"> </a></td>
						<td><input id="txtTimea" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblStype' class="lbl"> </a></td>
						<td><select id="cmbStype" class="txt c1"> </select></td>
						<td><span> </span><a id='lblRank' class="lbl"> </a></td>
						<td><select id="cmbRank" class="txt c1"> </select></td>
						<td><span> </span><a id='lblNoa' class="lbl"> </a></td>
						<td><input id="txtNoa" type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblIllustrate' class="lbl"> </a></td>
						<td><input id="txtIllustrate"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblIllustrate2' class="lbl btn ChangeGB"> </a></td>
						<td><input id="txtIllustrate2"  type="text"  class="txt c1"/></td>
						<td colspan="2">
							<input id="chkOnline" type="checkbox" style="float: left;"/>
							<a id='lblOnline' class="lbl" style="float: left;"> </a>
							<input id="chkNewimg" type="checkbox" style="float: left;"/>
							<a id='lblNewimg' class="lbl" style="float: left;"> </a>
							<input id="chkWatermark" type="checkbox" style="float: left;"/>
							<a id='lblWatermark' class="lbl" style="float: left;"> </a>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTitle' class="lbl"> </a></td>
						<td colspan="5"><input id="txtTitle"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblTitle2' class="lbl btn ChangeGB"> </a></td>
						<td colspan="5"><input id="txtTitle2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr>
						<td><span> </span><a class="lbl">內文關鍵字說明</a></td>
						<td colspan="5"><a style="color: red;">{img01}</a>：為圖片一　<a style="color: red;">{img02}</a>：為圖片二　<a style="color: red;">{ad01}</a>：為浮水印廣告</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContents' class="lbl"> </a></td>
						<td colspan="5"><textarea id="txtContents" cols="10" rows="5" style="width: 99%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblContents2' class="lbl btn ChangeGB"> </a></td>
						<td colspan="5"><textarea id="txtContents2" cols="10" rows="5" style="width: 99%;height: 100px;"> </textarea></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblRegion' class="lbl"> </a></td>
						<td><select id="cmbRegion" class="txt c1"> </select></td>
						<td><span> </span><a id='lblCountry' class="lbl"> </a></td>
						<td><select id="cmbCountry" class="txt c1"> </select></td>
						<td style="display: none;"><span> </span><a id='lblArea' class="lbl"> </a></td>
						<td style="display: none;">
							<input id="txtArea"  type="text"  class="txt c1"/>
							<!--<select id="cmbArea" class="txt c1"> </select>-->
						</td>
					</tr>
					<tr>
						<td>
							<span> </span><a id='lblTypea' class="lbl"> </a>
							<input id="txtTypea" type="hidden"  class="txt c1"/>
						</td>
						<td colspan="5">
							<input id="typea1" name="typea" type="checkbox" value="01"/><a id='item01'>原料</a>
						</td>
					</tr>
					<tr class="typea1">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea" type="checkbox" value="0101"/>鐵礦
										<input name="typea" type="checkbox" value="0102"/>生鐵
										<input name="typea" type="checkbox" value="0103"/>合金鐵
										<input name="typea" type="checkbox" value="0104"/>廢鋼
										<input name="typea" type="checkbox" value="0105"/>煤
										<input name="typea" type="checkbox" value="0106"/>粗鋼
										<input name="typea" type="checkbox" value="0107"/>焦炭
										<input name="typea" type="checkbox" value="0199"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea2" name="typea" type="checkbox" value="02"/><a id='item02'>半成品</a>
						</td>
					</tr>
					<tr class="typea2">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea" type="checkbox" value="0201"/>扁鋼胚(板胚)
										<input name="typea" type="checkbox" value="0202"/>小鋼胚(方胚)
										<input name="typea" type="checkbox" value="0203"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea3" name="typea" type="checkbox" value="03"/><a id='item03'>成品</a>
						</td>
					</tr>
					<tr class="typea3">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td colspan="3">
										<input name="typea" type="checkbox" value="0301"/>碳鋼
									</td>
								</tr>
								<tr>
									<td> </td>
									<td style="width: 60px;"> </td>
									<td colspan="2"><input name="typea" type="checkbox" value="030101"/>板材</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td style="width: 60px;"> </td>
									<td>
										<input name="typea" type="checkbox" value="03010101"/>熱軋
										<input name="typea" type="checkbox" value="03010102"/>冷軋
										<input name="typea" type="checkbox" value="03010103"/>鋼板
										<input name="typea" type="checkbox" value="03010104"/>鍍面
										<input name="typea" type="checkbox" value="03010105"/>其它
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td><input name="typea" type="checkbox" value="030102"/>條鋼</td>
									<td> </td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td> </td>
									<td>
										<input name="typea" type="checkbox" value="03010201"/>鋼筋
										<input name="typea" type="checkbox" value="03010202"/>線材
										<input name="typea" type="checkbox" value="03010203"/>棒鋼
										<input name="typea" type="checkbox" value="03010204"/>型鋼
										<input name="typea" type="checkbox" value="03010205"/>其它
									</td>
								</tr>
								<tr>
									<td style="width: 30px;"> </td>
									<td colspan="3">
										<input name="typea" type="checkbox" value="0302"/>特殊鋼(不鏽鋼)
									</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td colspan="2"><input name="typea" type="checkbox" value="030201"/>板材</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td colspan="2"><input name="typea" type="checkbox" value="030202"/>條鋼</td>
								</tr>
								<tr>
									<td> </td>
									<td> </td>
									<td colspan="2"><input name="typea" type="checkbox" value="030299"/>其他</td>
								</tr>
								<tr>
									<td style="width: 30px;"> </td>
									<td colspan="3">
										<input name="typea" type="checkbox" value="0303"/>鋼材
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea4" name="typea" type="checkbox" value="04"/><a id='item04'>終端成品</a>
						</td>
					</tr>
					<tr class="typea4">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea" type="checkbox" value="0401"/>螺絲(扣件)
										<input name="typea" type="checkbox" value="0402"/>鋼管
										<input name="typea" type="checkbox" value="0403"/>手工具
										<input name="typea" type="checkbox" value="0499"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea5" name="typea" type="checkbox" value="05"/><a id='item05'>非鐵金屬</a>
						</td>
					</tr>
					<tr class="typea5">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea" type="checkbox" value="0501"/>銅
										<input name="typea" type="checkbox" value="0502"/>鋁
										<input name="typea" type="checkbox" value="0503"/>鋅
										<input name="typea" type="checkbox" value="0504"/>鎳
										<input name="typea" type="checkbox" value="0505"/>鉛
										<input name="typea" type="checkbox" value="0506"/>錫
										<input name="typea" type="checkbox" value="0507"/>鉬
										<input name="typea" type="checkbox" value="0508"/>鉻
										<input name="typea" type="checkbox" value="0599"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea6" name="typea" type="checkbox" value="14"/><a id='item14'>碳權</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea7" name="typea" type="checkbox" value="16"/><a id='item16'>金屬期貨</a>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea8" name="typea" type="checkbox" value="13"/><a id='item13'>其它產品</a>
						</td>
					</tr>
					<tr>
						<td>
							<span> </span><a id='lblTypea2' class="lbl"> </a>
							<input id="txtTypea2" type="hidden"  class="txt c1"/>
						</td>
						<td colspan="5">
							<input id="typea9" name="typea2" type="checkbox" value="06"/><a id='item06'>市場脈動</a>
						</td>
					</tr>
					<tr class="typea9">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="0601"/>市場供需
										<input name="typea2" type="checkbox" value="0602"/>行情波動
										<input name="typea2" type="checkbox" value="0603"/>產銷統計
										<input name="typea2" type="checkbox" value="0604"/>公司財報
										<input name="typea2" type="checkbox" value="0605"/>進出口資料
										<input name="typea2" type="checkbox" value="0606"/>建築物建照
										<input name="typea2" type="checkbox" value="0607"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea10" name="typea2" type="checkbox" value="07"/><a id='item07'>政策</a>
						</td>
					</tr>
					<tr class="typea10">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="0701"/>稅率
										<input name="typea2" type="checkbox" value="0702"/>傾銷
										<input name="typea2" type="checkbox" value="0705"/>匯率
										<input name="typea2" type="checkbox" value="0703"/>環保
										<input name="typea2" type="checkbox" value="0704"/>會議
										<input name="typea2" type="checkbox" value="0799"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea11" name="typea2" type="checkbox" value="08"/><a id='item08'>交通運輸</a>
						</td>
					</tr>
					<tr class="typea11">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="0801"/>船運
										<input name="typea2" type="checkbox" value="0802"/>陸運
										<input name="typea2" type="checkbox" value="0803"/>交通政策
										<input name="typea2" type="checkbox" value="0804"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea12" name="typea2" type="checkbox" value="09"/><a id='item09'>企業動態</a>
						</td>
					</tr>
					<tr class="typea12">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="0901"/>盤價
										<input name="typea2" type="checkbox" value="0902"/>盤勢預測
										<input name="typea2" type="checkbox" value="0903"/>營運進展
										<input name="typea2" type="checkbox" value="0904"/>人事異動
										<input name="typea2" type="checkbox" value="0905"/>財務危機
										<input name="typea2" type="checkbox" value="0906"/>突發事故
										<input name="typea2" type="checkbox" value="0907"/>投資
										<input name="typea2" type="checkbox" value="0908"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea13" name="typea2" type="checkbox" value="10"/><a id='item10'>相關產業</a>
						</td>
					</tr>
					<tr class="typea13">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="1001"/>造船
										<input name="typea2" type="checkbox" value="1002"/>汽車
										<input name="typea2" type="checkbox" value="1003"/>機械
										<input name="typea2" type="checkbox" value="1004"/>建築
										<input name="typea2" type="checkbox" value="1005"/>家電
										<input name="typea2" type="checkbox" value="1006"/>加工剪裁
										<input name="typea2" type="checkbox" value="1007"/>單軋業
										<input name="typea2" type="checkbox" value="1008"/>團體組織
										<input name="typea2" type="checkbox" value="1099"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea14" name="typea2" type="checkbox" value="11"/><a id='item11'>應用開發</a>
						</td>
					</tr>
					<tr class="typea14">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="1101"/>新技術
										<input name="typea2" type="checkbox" value="1102"/>新產品
										<input name="typea2" type="checkbox" value="1103"/>新設備
										<input name="typea2" type="checkbox" value="1104"/>其它
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea15" name="typea2" type="checkbox" value="15"/><a id='item15'>碳權專區</a>
						</td>
					</tr>
					<tr class="typea15">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="1501"/>簡介與宣導
										<input name="typea2" type="checkbox" value="1502"/>新聞與動態
										<input name="typea2" type="checkbox" value="1503"/>政令與法規
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea16" name="typea2" type="checkbox" value="17"/><a id='item17'>金屬期貨</a>
						</td>
					</tr>
					<tr class="typea16">
						<td> </td>
						<td colspan="5">
							<table style="width: 100%;">
								<tr>
									<td style="width: 30px;"> </td>
									<td>
										<input name="typea2" type="checkbox" value="1701"/>價格波動綜述
										<input name="typea2" type="checkbox" value="1702"/>現貨交易建議
										<input name="typea2" type="checkbox" value="1703"/>深度分析
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td> </td>
						<td colspan="5">
							<input id="typea17" name="typea2" type="checkbox" value="12"/><a id='item12'>其它</a>
						</td>
					</tr>
					<!--<tr class="typea">
						<td><span> </span><a id='lblTypea' class="lbl"> </a></td>
						<td><select id="cmbTypea" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypeb' class="lbl"> </a></td>
						<td><select id="cmbTypeb" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTypec' class="lbl"> </a></td>
						<td><select id="cmbTypec" class="txt c1"> </select></td>
						<td><span> </span><a id='lblTyped' class="lbl"> </a></td>
						<td><select id="cmbTyped" class="txt c1"> </select></td>
					</tr>-->
					<tr>
						<td><span> </span><a id='lblImga' class="lbl"> </a></td>
						<td colspan="2">
							<a id="lblImga1" class='lblLanguage1 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImga1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImga1"  type="hidden"/><input id="txtImga1name"  type="hidden"/>
						</td>
						<td colspan="2">
							<a id="lblImga2" class='lblLanguage2 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImga2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImga2"  type="hidden"/><input id="txtImga2name"  type="hidden"/>
						</td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgaplace" class="txt c2"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgamemo' class="lbl"> </a></td>
						<td colspan="2">
							<a class='lblLanguage1'> </a><span style="float: left;"> </span>
							<input id="txtImga1memo"  type="text"  class="txt c3"/>
						</td>
						<td colspan="2">
							<a id="lblImga2memo" class='lblLanguage2 lbl btn ChangeGBm'> </a><span style="float: left;"> </span>
							<input id="txtImga2memo"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgb' class="lbl"> </a></td>
						<td colspan="2">
							<a id="lblImgb1" class='lblLanguage1 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgb1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgb1"  type="hidden"/><input id="txtImgb1name"  type="hidden"/>
						</td>
						<td colspan="2">
							<a id="lblImgb2" class='lblLanguage2 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgb2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgb2"  type="hidden"/><input id="txtImgb2name"  type="hidden"/>
						</td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgbplace" class="txt c2"> </select></td>
					</tr>
					<tr>
						<td><span> </span><a id='lblImgbmemo' class="lbl"> </a></td>
						<td colspan="2">
							<a class='lblLanguage1'> </a><span style="float: left;"> </span>
							<input id="txtImgb1memo"  type="text"  class="txt c3"/>
						</td>
						<td colspan="2">
							<a id="lblImgb2memo" class='lblLanguage2 lbl btn ChangeGBm'> </a><span style="float: left;"> </span>
							<input id="txtImgb2memo"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblImgc' class="lbl"> </a></td>
						<td colspan="2">
							<a id="lblImgc1" class='lblLanguage1 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgc1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgc1"  type="hidden"/><input id="txtImgc1name"  type="hidden"/>
						</td>
						<td colspan="2">
							<a id="lblImgc2" class='lblLanguage2 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgc2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgc2"  type="hidden"/><input id="txtImgc2name"  type="hidden"/>
						</td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgcplace" class="txt c2"> </select></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblImgcmemo' class="lbl"> </a></td>
						<td colspan="2">
							<a class='lblLanguage1'> </a><span style="float: left;"> </span>
							<input id="txtImgc1memo"  type="text"  class="txt c3"/>
						</td>
						<td colspan="2">
							<a id="lblImgc2memo" class='lblLanguage2 lbl btn ChangeGBm'> </a><span style="float: left;"> </span>
							<input id="txtImgc2memo"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblImgd' class="lbl"> </a></td>
						<td colspan="2">
							<a id="lblImgd1" class='lblLanguage1 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgd1" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgd1"  type="hidden"/><input id="txtImgd1name"  type="hidden"/>
						</td>
						<td colspan="2">
							<a id="lblImgd2" class='lblLanguage2 lblImgShowDown'> </a><span style="float: left;"> </span>
							<input type="file" id="btnImgd2" class="btnImg" value="選擇檔案" accept="image/*"/>
							<input id="txtImgd2"  type="hidden"/><input id="txtImgd2name"  type="hidden"/>
						</td>
						<td><a class="lblImgplace"> </a><span style="float: left;"> </span><select id="cmbImgdplace" class="txt c2"> </select></td>
					</tr>
					<tr style="display: none;">
						<td><span> </span><a id='lblImgdmemo' class="lbl"> </a></td>
						<td colspan="2">
							<a class='lblLanguage1'> </a><span style="float: left;"> </span>
							<input id="txtImgd1memo"  type="text"  class="txt c3"/>
						</td>
						<td colspan="2">
							<a id="lblImgd2memo" class='lblLanguage2 lbl btn ChangeGBm'> </a><span style="float: left;"> </span>
							<input id="txtImgd2memo"  type="text"  class="txt c3"/>
						</td>
					</tr>
					<tr>
						<td><span> </span><a id='lblWorker' class="lbl"> </a></td>
						<td><input id="txtWorker"  type="text"  class="txt c1"/></td>
						<td><span> </span><a id='lblWorker2' class="lbl"> </a></td>
						<td><input id="txtWorker2"  type="text"  class="txt c1"/></td>
					</tr>
					<tr style="display: none;">
						<td colspan="7"><div style="width:100%;" id="FileList"> </div></td>
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
						<td><a id='lblTitle2_s'> </a></td>
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
						<td><input type="text" id="txtTitle2.*" class="txt c1 ChangeGBs" /></td>
						<td style="text-align: left;">
							<span style="float: left;"> </span>
							<input type="file" id="btnAtt1.*" class="btnAtt" value="選擇檔案"/>
							<input id="txtAtt1.*"  type="hidden"/>
							<input id="txtAtt1name.*"  type="hidden"/>
							<a id="lblAtt1.*" class='lblDownload lbl btn'> </a>
						</td>
						<td style="text-align: left;">
							<span style="float: left;"> </span>
							<input type="file" id="btnAtt2.*" class="btnAtt" value="選擇檔案"/>
							<input id="txtAtt2.*"  type="hidden"/>
							<input id="txtAtt2name.*"  type="hidden"/>
							<a id="lblAtt2.*" class='lblDownload lbl btn'> </a>
						</td>
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
						<td><a id='lblTitle2_t'> </a></td>
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
						<td><input id="txtTitle2..*" type="text" class="txt  c1 ChangeGBs"/></td>
						<td><input id="txtWeb1..*" type="text" class="txt  c1"/></td>
						<td><input id="txtWeb2..*" type="text" class="txt  c1"/></td>
					</tr>
				</tbody>
			</table>
		</div>
		<iframe id="xdownload" style="display:none;"> </iframe>
		<input id="q_sys" type="hidden" />
	</body>
</html>
