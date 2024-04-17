
if(navigator.appName == "Netscape"){

	var nArcadeInstalled=0;
	var szArcadeVersion="";
	var arcadeInstalled = 0;
	
	if ((navigator.userAgent.charAt(8)) >= ('3'))
	{ 
	  var i=0;
	  while (navigator.plugins[i])
	  {
	    if ((navigator.plugins[i].name) == 'RealArcade NS Plugin' || (navigator.plugins[i].name) == 'RealOne Arcade NS Plugin')
	    {
	      nArcadeInstalled=1;
	      szArcadeVersion=navigator.plugins[i].description;
	      break;
	    }
	    else 
	    {
	      nArcadeInstalled=2;
	    }
	    i++;
	  }
	}
	
	if (nArcadeInstalled == 1)
	{
		arcadeInstalled = 1;
	  
	} 



}else{

	var arcadeInstalled = 0;
	
	var undefined;
	
	if ((navigator.userAgent.charAt(8)) >= ('3'))
	{
	  var nRNGCVersion = IERJCtl.RealArcadeVersion;
	  if ( undefined != nRNGCVersion )
	  {
	  	arcadeInstalled = 1;
	    
	  }
	}



}
