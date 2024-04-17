

function getCookieValue( cookieName )
{
        var cookieArray = new Array();
        var cRE = new RegExp("(\;|^)[^;]*("+cookieName+")\=([^;]*)(;|$)");
        cookieArray = cRE.exec(document.cookie);
        if( cookieArray != null )
        {
                return cookieArray[3];
        }
        return "";
}


function setCookie( name, value, life_in_days )
{
	var exp = new Date();
        var oneDay = exp.getTime() + (24 * 60 * 60 * 1000 * life_in_days );
        var newWin;
        if( parseInt( navigator.appVersion) >=4 )
        {
		exp.setTime(oneDay);
		if( document.location.href.indexOf(".real.com") >=0 )
			var domname=".real.com";
		else
			var domname=".prognet.com";
		document.cookie = name + "=" + escape(value) +"; expires=" + exp.toGMTString() + "; domain=" + domname;
                
        }

}


function rotatePopUp()
{
	var c_val = getCookieValue("keebler3");
	if( c_val.length == 0 )
	{
		c_val = 0;
	}
	var cookieVal = new Number( c_val );
	if( cookieVal == 0 )
	{


		
window.open('../inserts/arcpop031122.html','pop','scrollbars=no,left=20,top=20,width=250,height=330,noresize');
		




	}
	cookieVal = (++cookieVal) % 3;
	setCookie( "keebler3", cookieVal, 1 );
}





if (arcadeInstalled == 1){
		
	}
	else
	{
rotatePopUp();
}

