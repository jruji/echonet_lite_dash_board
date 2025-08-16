// const apikey = "5980d48994fa7911d6717787ecce15b7";
const apikey = String.fromEnvironment("apikey");

// const temperatureSensorId = 'temperatureSensor1653899075894947';
// const humiditySensorId = 'humiditySensor165389907565791';
// const illuminanceSensorId = 'illuminanceSensor165389907584867';

// JAIST token
// const accessToken = '4ecdf33ff128e03f2be5341388f60a8f16f9e071d2014bae8b9567417c601494';
const accessToken = String.fromEnvironment("accessToken");
// KAIT token
//const accessToken =
//    '.rbl329.4_-4x.i76q3iozzdzvvo6-0e9lx4n7dfsh3v6.2s9pgvcfpmv26f3fgtlqigyw9cnjmnuje5k2ljg13';

//const serverUrl = 'http://150.65.230.146:5000/elapi/v1/';
//JAIST server
String serverUrl = const String.fromEnvironment("serverUrl");

// const serverUrl ="http://150.65.179.132:7000/elapi/v1/"; 
//const accessToken =    'tMU95c0YcQbIEssB2iurkikFiMziRcdsVlHIJ6_mN_fImS69C_ZT5CvNMGLbDy2HExbQzqK-AXbjg4r9zbj7NXs';
//KAIT Server
//const serverUrl = 'https://www.smarthouse-center.org/elapi/v1/';


const bool mapImplemented = bool.fromEnvironment("mapImplemented");
// const List<List<List<dynamic>>> map =
const String parseMap=String.fromEnvironment("map");
const int roomNum = int.fromEnvironment("roomNum");

List<List<List<dynamic>>> newMap=[];

List<List<String>> tempId = [];
List<List<String>> humidId = [];
List<List<String>> lightId = [];
List<List<String>> airId = [];




