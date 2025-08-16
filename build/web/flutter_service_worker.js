'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "a97ef493d2aeb65c6e6bdbb2afc7d616",
"version.json": "5dae36f32df2e0ac9bc7a09aa73b8a84",
"index.html": "9b511bd0d04eef62236ec031d5e04074",
"/": "9b511bd0d04eef62236ec031d5e04074",
"main.dart.js": "1bea845e92454af7ede1739fbdb07770",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "bf66ead3fdd6aea563566b48f80b0a08",
"assets/AssetManifest.json": "4fdcb476fff2e49278f8f87c64fe9a44",
"assets/NOTICES": "aaa413f4d76f93207b4ce5063bc623f9",
"assets/FontManifest.json": "75eefa752069e9b388f0547e8f3341cd",
"assets/AssetManifest.bin.json": "5bfe316f35b4cbdbd1d5aae34a403192",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6afc5a95d7c2ea785c5a318851f77714",
"assets/fonts/QuicksandlightRegular.otf": "555cd799d40b72622c36b330714d4026",
"assets/fonts/MaterialIcons-Regular.otf": "9c16a75e619e8270ac29027a419760b2",
"assets/assets/iHousemap2.png": "590e68cd47b0bd440756fb7d09220f22",
"assets/assets/generalLighting.png": "1d7dd9c67d3ad4a2e87258ff9f3283d8",
"assets/assets/iHousemap3.png": "872292479c1acd7aa2fd412dd1683942",
"assets/assets/iHousemap.png": "5406743592bc93a5a4288a992ad13770",
"assets/assets/iHousemap1.png": "bb35184a873e70b2599bfc03ed91124c",
"assets/assets/electricCurtaintrue.png": "3151549f22c2ac913332ec6d77caefd8",
"assets/assets/iHousemap0.png": "bd8feb690cf3935d88dc53a7fbf182d4",
"assets/assets/iHousemap4.png": "640c26e72c1aa385393e8125d8b06c7a",
"assets/assets/powerDistributionBoardMetering.png": "839a2d954e66c863b0292b1f31936764",
"assets/assets/Bedroom.PNG": "4c34511a70180d60e3ab476e2d0c81f0",
"assets/assets/Spare%2520Room.PNG": "f7915799a37006db38bcb758224b9b5b",
"assets/assets/iHousemap5.png": "22cf621b427d46740f3793deadc72e50",
"assets/assets/iHousemap7.png": "2cb74383a079ae97e6ed6619ef3ed141",
"assets/assets/generalLightingtrue.png": "fc8928735c42a0eb56d5734cbc3ee294",
"assets/assets/iHousemap6.png": "0e3e78a986cd245f1ab4116caa7e876f",
"assets/assets/humanDetectionSensor.png": "eb7f8e19afe3e2fbcba1f6e8894767bb",
"assets/assets/electricLock.png": "2ff8664163260dee65dd436088fd3e8c",
"assets/assets/Living%2520Room.PNG": "f2438050599dd4f3e39bb410d316ebf2",
"assets/assets/Western%25202%2520Room.PNG": "9af27f7dd2e4771ae88081beacd01908",
"assets/assets/humiditySensor.png": "cf2b9588eb8663e533d637ac5522f5c2",
"assets/assets/Japanese%2520Room.PNG": "fcf15c060665b5cadf716145b0ba1bed",
"assets/assets/electricCurtain.png": "deac1f8a914d988fd87f546ca5a63685",
"assets/assets/1F%2520Hallway.png": "a805866d41699cc78257949a8fd08a76",
"assets/assets/electricCurtainfalse.png": "2806b591f70d062c1cbaf7fdac246a6d",
"assets/assets/Western%25201%2520Room.PNG": "0e6ebc755cc1f011ed15b179a6e98194",
"assets/assets/electricWindowtrue.png": "2f095baf0b93e3e5741ba5c64bec594c",
"assets/assets/Utility%2520Room.PNG": "105dc23cb102daf0ca7c5aa278526ad7",
"assets/assets/electricWindow.png": "31e754db74afd3dce50a431d18e0a7c1",
"assets/assets/electricSwitch.png": "965d8bd6056a72af256258a18a221d83",
"assets/assets/generalLightingfalse.png": "343a9986a6b90b5831c33b5e908b19e0",
"assets/assets/lvSmartElectricEnergyMeter.png": "1e3494d3c96151fa107aa03e830dbe97",
"assets/assets/homeAirConditioner.png": "2634b33ef3d916b7ae700b2cde9495a3",
"assets/assets/electricEnergySensor.png": "d119b3774cb51125514975ff4ddb4d2a",
"assets/assets/electricShade.png": "2a5180dc7e01cc720b8ea6192c8c9918",
"assets/assets/iHousemap2f.png": "dad88c4ccd189547b9eaed4e341c095d",
"assets/assets/2F%2520Hallway.png": "254ea351e883a00f45a96dc58fd144c3",
"assets/assets/Kitchen.PNG": "69302afb9a325b5f48bd8be6d0043396",
"assets/assets/iHousemap8.png": "5c7eaf0abd17d0bee404a5ce105c8cef",
"assets/assets/iHousemap9.png": "16b8efd384c154d613ce1d358b35a7fe",
"assets/assets/electricWindowfalse.png": "ff48e25ed8ea64cc042c6822aa1e06bd",
"assets/assets/storageBattery.png": "af1e02eff74d7101760deeea685b9746",
"assets/assets/temperatureSensor.png": "c7e849f89d7e448c2f71cc566fae50d0",
"assets/assets/bg.PNG": "4219daef36d7cbabbde39411c67f9751",
"assets/assets/electricWaterHeater.png": "a09df900aaec3836edb6ae2c94268fb8",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm_st.js.symbols": "c7e7aac7cd8b612defd62b43e3050bdd",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/skwasm_st.wasm": "56c3973560dfcbf28ce47cebe40f3206"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
