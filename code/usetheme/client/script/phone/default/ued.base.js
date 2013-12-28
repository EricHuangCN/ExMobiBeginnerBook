/*
*	ExMobi4.0 JS 框架之 控件对象类ued.base.js
*	Version	:	1.0.0
*	Author	:	WangMingzhu @ Nandy Wong
*	Email	:	wangmingzhu@nj.fiberhome.com.cn
*   Copyright 2012 (c) 南京烽火星空通信发展有限公司
*/
var header=document.getElementsByTagName("header")[0];
var footer=document.getElementsByTagName("footer")[0];
var body=document.getElementsByTagName("body")[0];
var screen={"objName":"screen"};
function $ui(x){
	var obj = null;
	//获取对象
	if(x==null){
		return x;
	}else if((typeof x)=="string"){
		obj = document.getElementById(x);
		obj = obj==null&&document.getElementsByName(x.toString()).length>0?document.getElementsByName(x.toString())[0]:obj;
	}else{
		obj = x;
	}
	//给不为空的对象添加函数
	if(!obj) return null;
	//设置对象隐藏
	obj.hide = function(){
		obj.style.display = "none";
		return obj;
	};

	//设置对象显示
	obj.show = function(){			
		obj.tagName()=="page"?document.getElementById(x).show():obj.style.display = "block";
		return obj;
	};

	//设置对象显隐反转
	obj.toggle = function(){	
		obj.style.display = obj.style.display=="none"?"block":"none";
		return obj;
	};
	
	//获得对象高度
	obj.height = function(){
		if(arguments.length>0 && typeof arguments[0]=="number"){
			obj.style["height"]=arguments[0];
			return obj;
		}
		if(obj.tagName()=="header"){
			return Util.getHeaderHeight();
		}
		if(obj.tagName()=="body"){
			return Util.getBodyHeight();
		}
		if(obj.tagName()=="footer"){
			return Util.getFooterHeight();
		}
		if(obj.tagName()=="window"){
			return Util.getWindowHeight();
		}
		if(obj.tagName()=="screen"){
			return Util.getScreenHeight();
		}
		return obj.style["height"];
	}
	//获得对象宽度度
	obj.width=function(){
		if(obj.tagName()=="body"){
			return Util.getBodyWidth();
		}
		if(obj.tagName()=="screen"){
			return Util.getScreenWidth();
		}
		return obj.style["width"];
	}
		
	//获取或者设置的value
	obj.val = function(){//0:设置value值,无:返回值
		if(arguments.length>0){
			obj.value = arguments[0];
			return obj;
		}else{				
			return obj.value;
		}
	};
		
	//追加控件的value
	obj.addVal = function(){
		obj.value += arguments[0];
		return obj;
	};
		
	//获取或者设置对象的innerHTML
	obj.html = function(){//0:设置HTML值,无:返回值
		if(arguments.length>0){
			obj.innerHTML = arguments[0];
			return obj;
		}else{
			return obj.innerHTML;
		}	
	};
		
	//追加对象的innerHTML
	obj.addHtml = function(){			
		obj.innerHTML += arguments[0];
		return obj;
	};
	
	//获取设置属性
	obj.attr = function(){			
		if(arguments.length>1){
			obj[arguments[0]] = arguments[1];
			return obj;
		}else{
			return obj[arguments[0]];
		}
	};

	//设置获取对象的样式
	obj.css = function(){ //0:样式名,1:样式值
		if(arguments.length>1){
			obj.style[arguments[0]] = arguments[1];
			return obj;
		}else{
			return obj.style[arguments[0]];
		}
	};
	//获取对象的标签名
	obj.tagName = function(){
		return obj.objName?obj.objName:"";
	};
	return obj;
}


//String类原生扩展
//去掉string两边的空格
String.prototype.trim = function(){
	return this.replace(/(^\s*)|(\s*$)/g,"");
}

//将String中符合s1要求的字符串替换成s2
String.prototype.replaceAll = function(s1,s2){
	s1 = (typeof s1) == "string"?new RegExp(s1, "gm"):s1;
	return this.replace(s1, s2);
}

//转换为数字格式
String.prototype.toInt = function(){
	return Number(this);
}

//设置session
String.prototype.session = function(){
	if(arguments.length==0){	
		return window.getStringSession(this)||window.getArraySession(this)[0];		
	}
	if((typeof arguments[0])=="string"){
		window.setStringSession(this,arguments[0]);
	}else{
		window.setArraySession(this,arguments[0]);
	}
}

//返回截取给定字符串之前的数值
String.prototype.substrBefore = function(){
	return arguments.length > 0 && arguments[0]?this.substring(0,this.indexOf(arguments[0],arguments[1])):"";
}

//返回截取给定字符串之后的数值
String.prototype.substrAfter = function(){
	return arguments.length > 0 && arguments[0]?this.substring(this.indexOf(arguments[0],arguments[1]) + arguments[0].length,this.length):"";
}

//Number类原生扩展
//加
Number.prototype.add=function(){
	return typeof arguments[0]=="number"?this+arguments[0]:"isNan";
}
//减
Number.prototype.minus=function(){
	return typeof arguments[0]=="number"?this-arguments[0]:"isNan";
}
var $phone = {
		//通过toast提示信息
		toast:function(t, d, s){
			if(!t) return;
			var toast= new Toast();
			toast.setText(t); /*设置Toast显示信息*/
			toast.setDuration(d?d:1000);/* 设置Toast显示时间*/
			if(s) toast.setStyle(s);/*设置弹出toast弹出位置*/		
			toast.show(true);/*展现Toast框*/
		},
		//拨打电话t为号码，n为名称
		tel:function(t,n){
			if(arguments.length==0 && $phone["$telcache"]){
				Util.tel($phone["$telcache"]);
			}else if(!t){
				alert("您所拨打的号码不存在！");
			}else{
				var str = n?"您确认拨打"+n+"的电话吗？":"您确认拨打电话"+t+"吗？";
				$phone["$telcache"] = t;
				confirm(str,$phone.tel,null);
			}
		},
		message:function(t,m){
			if(Util.sendSms(t,m)){
				$phone.toast("发送短信成功！");
				window.close();
				return;
			}
			$phone.toast("发送短信失败！");
		},
		sysmessage:function(){
			Util.openSystemSms();
		},
		systel:function(){
			Util.openSystemDial();
		},
		syscontact:function(){
			Util.openSystemContact();
		},
		close:function(){
			if(arguments.length>0){
				for(var i=0;i<arguments.length;i++){
					var objWin=util.getWindowById(arguments[i]);
					objWin.close();
				}
			}
			window.close();
		},
		os:function(){
			return Util.getOs();
		}
};
