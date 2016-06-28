//TODO: FIND HOW TO DISPLAY VALUES THAT ARE WITHIN A SPECIFIC RADIUS
//TODO: USE PLACE SEARCH PAGINATION FOR SURVEY PART

var mapDiv = document.getElementById('map');
var geocoder;
var map;
var marker;
var latitude;
var longitude;

/////////////////// CREATING MAP //////////////////////////
function initialize() {
    geocoder = new google.maps.Geocoder();
    var address = $('#initial_location').val();
    geocoder.geocode({'address': address}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            ///////// SETTING THE INITAL POSITION /////////////
            latitude = results[0].geometry.location.lat();
            longitude = results[0].geometry.location.lng();
            var LatLng = new google.maps.LatLng(latitude, longitude);
            console.log(LatLng);

            ///////// CREATING MAP RELATIVE TO INITIAL LOCATION ////////////
            map = new google.maps.Map(mapDiv, {
                center: LatLng,
                zoom: 13,
                mapTypeId: google.maps.MapTypeId.ROADMAP
                //TODO: FIGURE OUT WHY CONTROLS WON'T ADJUST POSITIONS
                // mapTypeControlOptions: {
                //   style: google.maps.MapTypeControlStyle.DROPDOWN_MENU,
                //   position: TOP_RIGHT,
                //   mapTypeIds: [
                //     google.maps.MapTypeId.ROADMAP,
                //     google.maps.MapTypeId.TERRAIN
                //   ]
                // }
            });

            ///////// CREATING MARKER RELATIVE TO INITIAL LOCATION////////////
            marker = new google.maps.Marker({
                position: LatLng,
                animation: google.maps.Animation.DROP,
                map: map
            });

            var input = document.getElementById('pac-input');
            var search_bar = new google.maps.places.Autocomplete(input);
            var infowindow = new google.maps.InfoWindow({


            });

            search_bar.bindTo('bounds', map);
            map.controls[google.maps.ControlPosition.TOP_RIGHT].push(input);

            //TODO: ADD A LISTENER TO MARKER TO OPEN SIDE PANEL
            //TODO: USE SEARCH PAGINATION TO DO SO
            // marker.addListener('click', function() {
            //   infowindow.open(map, marker);
            // });

            search_bar.addListener('place_changed', function() {
                var place = search_bar.getPlace();
                if (!place.geometry) {
                    return;
                }

                if (place.geometry.viewport) {
                    map.fitBounds(place.geometry.viewport);
                } else {
                    map.setCenter(place.geometry.location);
                    map.setZoom(17);
                }

                // Set the position of the marker using the place ID and location.
                marker.setPlace({
                    placeId: place.place_id,
                    //TODO: FIGURE OUT WHY DROP ANIMATION ISN'T WORKING
                    //TODO: WHEN SEARCHING FOR NEW LOCATION
                    // animation: google.maps.Animation.DROP,
                    location: place.geometry.location
                });
                marker.setVisible(true);
            });
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}


/////////////// SEARCH SECTION /////////////////////////

//when a button is clicked, first print out the json format
//you want the geocoder to get the location of the address input
//after you get the location have the map function create the map with a marker at that specific location

// var searchBox = new google.maps.places.SearchBox($('#address').value());



///////////////////// GET CURRENT LOCATION ///////////////////
// var initialLocation;
// var browserSupportFlag =  new Boolean();
// var mapDiv = document.getElementById('map');
// var geocoder;
// var map;
// var marker;
//

//   map = new google.maps.Map(mapDiv, myOptions);
//   marker = new gogole.maps.Marker(markerOptions);
//   // Try W3C Geolocation (Preferred)
//   if(navigator.geolocation) {
//     browserSupportFlag = true;
//     navigator.geolocation.getCurrentPosition(function(position) {
//       initialLocation = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);
//       map.setCenter(initialLocation);
//       marker.setCenter(initialLocation)
//     }, function() {
//       handleNoGeolocation(browserSupportFlag);
//     });
//   }
//   // Browser doesn't support Geolocation
//   else {
//     browserSupportFlag = false;
//     handleNoGeolocation(browserSupportFlag);
//   }
//   function handleNoGeolocation(errorFlag) {
//
//     if (errorFlag == true) {
//       alert("Geolocation service failed.");
//       var address = $('#initial_location').val();
//       initialLocation = siberia;
//     } else {
//       alert("Your browser doesn't support geolocation. We've placed you in Siberia.");
//       // initialLocation = newyork;
//     }
//     map.setCenter(initialLocation);
//     marker.setCenter(initialLocation)
//   }
// }
