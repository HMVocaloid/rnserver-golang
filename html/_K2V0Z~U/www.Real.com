<html>
<body>
<script language="JavaScript">
<!--
var sessionCookieName = "_afs";
var sessionCookieDomain = "real.com";
var sessionCookiePath = "/";
var refarmingParamName = "_refarm-request-"
var flashVersion = null;
var playerVersion = null;
var dropCookieValue = "";
var queryStringValue = "";
function isObject(type){
return ( "undefined" != typeof(type) );
}
function refresh() {
setCookie(sessionCookieName, dropCookieValue);
var cookieDropped = getCookie(sessionCookieName) != null;
var sURL = unescape(window.location);
var requestPath = getRequestPath( sURL );
var queryString;
if ( (!cookieDropped)
|| document.cookie == null
|| document.cookie == "" ) { // no cookie detected.
queryString = removeElementByPrefix(queryStringValue, refarmingParamName , "&");
}
else {
queryString = getQueryString(sURL);
queryString = removeElementByPrefix(queryString, refarmingParamName , "&");
}
if ( queryString != null && queryString != "" )
sURL = requestPath + "?" + queryString;
window.location.replace( sURL );
}
function setCookie(name, value) {
var cookieStr;
cookieStr = name + "=" + value;
if ( sessionCookiePath != null && sessionCookiePath != "" ) {
cookieStr += "; path=" + sessionCookiePath;
}
if ( sessionCookieDomain != null && sessionCookieDomain != "" ) {
cookieStr += "; domain=" + sessionCookieDomain;
}
document.cookie = cookieStr;
}
function getElement(str, name, sep1, sep2)
{
var prefix = name + "=";
var begin = str.indexOf(sep1 + prefix);
if (begin == -1) {
begin = str.indexOf(prefix);
if (begin != 0) return null;
}
else {
begin += 2;
}
var end = str.indexOf(sep2, begin);
if (end == -1) {
end = str.length;
}
return unescape(str.substring(begin + prefix.length, end));
}
// remove all elements with name as prefix.
function removeElementByPrefix(str, name, sep) {
if ( str == null )
return str;
// var prefix = name + "=";
var prefix = name; // prefix check only.
var prefix1 = sep + prefix;
var begin = str.indexOf(prefix1);
if (begin < 0) {
begin = str.indexOf(prefix);
if (begin != 0) {
return str;
}
}
if ( begin < 0 ) // not found
return str;
var end = str.indexOf(sep, begin + 1);
if (end == -1) {
return str.substring(0,begin);
}
else {
return str.substring(0,begin) + str.substring(end, str.length);
}
}
function replaceElement(str, name, value, sep) {
if ( str == null || str == "" ) {
return name + "=" + value;
}
var prefix = name + "=";
var prefix1 = sep + prefix;
var begin = str.indexOf(prefix1);
if (begin < 0) {
begin = str.indexOf(prefix);
if (begin != 0) {
return str + sep + name + "=" + value;
}
begin += prefix.length;
}
else {
begin += prefix1.length;
}
var end = str.indexOf(sep, begin);
if (end == -1) {
return str.substring(0,begin) + value;
}
else {
return str.substring(0,begin) + value + str.substring(end, str.length);
}
}
function getCookie(name)
{
var dc = document.cookie;
return getElement(dc, name, "; ", ";");
}
function getQueryString(url) {
var pos = url.indexOf("?");
if ( pos >= 0 )
return url.substring(pos+1, url.length);
else
return "";
}
function getRequestPath(url) {
var pos = url.indexOf("?");
if ( pos > 0 )
return url.substring(0,pos);
else
return url;
}
function setChip(chipName, value)
{
value = value == null ? "" : value;
queryStringValue = replaceElement(queryStringValue, chipName, value, "&");
dropCookieValue = replaceElement(dropCookieValue, chipName, value, "&");
}
function winIE5upPlyrDetect(){
var player;
var iectl;
try {
iectl = new ActiveXObject("Shell.Explorer");
}
catch(e){
}
try{
player = new ActiveXObject("rmocx.RealPlayer G2 Control.1");
playerVersion = (player.GetVersionInfo());
}
catch(e){
}
if(!isObject(iectl)){
return false; //ActiveX disabled
}
return new String(isObject(player));
}
function checkPlugin(name){
plugin = navigator.plugins[name];
if(isObject(plugin)){
playerVersion = plugin.description;
return true;
}
return false;
}
function checkFuzzyPluginVersion() {
if ( arguments == null || arguments.length <= 0 )
return false;
var plugins = navigator.plugins;
if ( plugins != null && plugins.length > 0 ) {
for(i=0; i<plugins.length; i++) {
var name = " " + plugins[i].name;
var desc = " " + plugins[i].description;
var allFound = true;;
for(j=0; j<arguments.length; j++) {
if ( name.indexOf(" " + arguments[i]) < 0
&& desc.indexOf(" " + arguments[i]) < 0 ) { // not found
allFound = false;
break;
}
}
if ( allFound ) {
var versRX = /[0-9]+[\.][0-9]+[\.][0-9]+[\.][0-9]+/;
playerVersion = desc.match(versRX);
return true;
}
}
}
return false;
}
function pluginDetect(){
var result = (checkPlugin("RealPlayer Version Plugin"))
||
(checkPlugin("RealOne Player Version Plugin"));
if ( result ) {
return result;
}
return checkFuzzyPluginVersion("RealPlayer","G2", "Plug-In");
}
function mimeTypeDetect(){
return (
isObject(navigator.mimeTypes)
&&
isObject(navigator.mimeTypes["audio/x-pn-realaudio-plugin"])
);
}
function isWinIE5plus(){
var result = false;
var uaLower = navigator.userAgent.toLowerCase();
if(uaLower.indexOf("windows") >=0 && uaLower.indexOf("msie")>=0){
var versRX = /msie\s+[5-9]/;
result = versRX.test(uaLower);
}
return result;
}
function hasRealPlayer(){
if( isWinIE5plus() ){
return winIE5upPlyrDetect();
}else{
return ((pluginDetect() || mimeTypeDetect() )?"true":"false");
}
}
function getFlashVersion() {
var plugin = (navigator.mimeTypes && navigator.mimeTypes["application/x-shockwave-flash"]) ? navigator.mimeTypes["application/x-shockwave-flash"].enabledPlugin : 0;
if ( plugin ) {
var words = navigator.plugins["Shockwave Flash"].description.split(" ");
for (var i = 0; i < words.length; ++i)
{
if (isNaN(parseInt(words[i])))
continue;
return words[i];
}
}
else if (navigator.userAgent && navigator.userAgent.indexOf("MSIE")>=0 && (navigator.appVersion.indexOf("Win") != -1)) {
for( ver=9 ; ver>=2 ; ver-- ) {
try{
var flashPlugin = new ActiveXObject("ShockwaveFlash.ShockwaveFlash."+ver);
if( flashPlugin ) {
return ver;
}
}catch(e){
}
}
}
return null;
}
queryStringValue = getQueryString(unescape(window.location));
dropCookieValue = getCookie(sessionCookieName);
// -->
</script>
<script LANGUAGE="javascript">
<!--
setChip("has-player", hasRealPlayer());
// -->
</script>
<script LANGUAGE="javascript">
<!--
if ( playerVersion == null ) {
// has-player attribute is not enabled.
// browser version is too low.
if ( isWinIE5plus() ) {
winIE5upPlyrDetect()
}
}
setChip("player-version", playerVersion);
// -->
</script>
<OBJECT ID="IERJCtl" WIDTH=0 HEIGHT=0
CLASSID="CLSID:A5DC33CE-214B-4c26-8596-8A45456C9EB8"></OBJECT>
<script language = "JavaScript">
<!--
if(navigator.appName == "Netscape"){
var nArcadeInstalled=0;
var szArcadeVersion="";
var arcadeInstalled = 0;
if ((navigator.userAgent.charAt(8)) >= ('3'))
{
var i=0;
while (navigator.plugins[i])
{
if ((navigator.plugins[i].name) == 'RealArcade NS Plugin' ||
(navigator.plugins[i].name) == 'RealOne Arcade NS Plugin')
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
} else {
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
if (arcadeInstalled == 1)
{
setChip("has-arcade", "true");
} else {
setChip("has-arcade", "false");
}
//-->
</script>
<script language="javascript">
<!--
var delta = (new Date()).getTime();
// -->
</script>
<link href="/includes/bindata.html" rel="stylesheet"
type="text/css">
<script language="javascript">
<!--
delta = (new Date()).getTime() -delta +1;
bw= parseInt(32*8*1000/delta); setChip("bw", bw);
// -->
</script>
<script LANGUAGE="javascript">
<!--
refresh();
// -->
</script>
</body>
</html>