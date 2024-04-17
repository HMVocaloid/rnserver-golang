// This code parses parses referrer
function referrerString(key){
var value = null;

for (var i=0;i<referrerString.keys.length;i++){
if (referrerString.keys[i]==key){
value = referrerString.values[i];
break;
}
}
return value;
}

referrerString.keys = new Array();
referrerString.values = new Array();

function referrerString_Parse(){
var referrer_string = document.referrer.split('?');

if (referrer_string[1]){ 
var pairs = referrer_string[1].split('&');
	
for (var i=0;i<pairs.length;i++){
var pos = pairs[i].indexOf('=');

if (pos >= 0){
var argname = pairs[i].substring(0,pos);
var value = pairs[i].substring(pos+1);
referrerString.keys[referrerString.keys.length] = argname;
referrerString.values[referrerString.values.length] = value;
}
}

}
}

referrerString_Parse();
