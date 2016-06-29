//TODO: FIND HOW TO CENTER VALUES FOR THOSE THAT ARE PART OF LARGER AREAS SUCH AS HONG KONG
//TODO: USE PLACE SEARCH PAGINATION FOR SURVEY PART

var mapDiv = document.getElementById('map');
var geocoder;
var map;
var marker;
var latitude;
var longitude;

function search_input() {

    var search_bar = new google.maps.places.Autocomplete(document.getElementById('address'));

    // search_bar.addListener('place_changed', function() {
    //     var place = search_bar.getPlace();
    //     console.log(place['place_id']);
    //     return place['place_id'];
    // });

}

/////////////////// CREATING MAP //////////////////////////
function initialize() {
    geocoder = new google.maps.Geocoder();

    // var new_location = search_input(address);
    // console.log(new_location);
    // var search_bar = search_input();
    var address = $('#initial_location').val();
    geocoder.geocode({'address': address}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {

            ///////// SETTING THE INITAL POSITION /////////////
            // latitude = results[0].geometry.location.lat();
            // longitude = results[0].geometry.location.lng();
            // var LatLng = new google.maps.LatLng(latitude, longitude);
            // console.log(LatLng);
            var LatLng = new google.maps.LatLng($('#initial_latitude').val(),
                                                $('#initial_longitude').val());

            ///////// CREATING MAP RELATIVE TO INITIAL LOCATION ////////////
            map = new google.maps.Map(mapDiv, {
                center: LatLng,
                zoom: 15,
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
            var new_search_bar = new google.maps.places.Autocomplete(input);
            // var infowindow = new google.maps.InfoWindow({
            //
            //
            // });

            new_search_bar.bindTo('bounds', map);
            map.controls[google.maps.ControlPosition.TOP_RIGHT].push(input);
            ////////////// INFO WINDOW EVENT /////////////////
            var infowindow = new google.maps.InfoWindow();

            marker.addListener('click', function() {
                infowindow.open(map, marker);
            });

            //TODO: ADD A LISTENER TO MARKER TO OPEN SIDE PANEL
            //TODO: USE SEARCH PAGINATION TO DO SO
            // marker.addListener('click', function() {
            //   infowindow.open(map, marker);
            // });
            new_search_bar.addListener('place_changed', function() {
                var place = new_search_bar.getPlace();
                infowindow = new google.maps.InfoWindow({
                    content: place.place_id
                })
                if (!place.geometry) {
                    return;
                }

                if (place.geometry.viewport) {
                    map.fitBounds(place.geometry.viewport);
                } else {
                    map.setCenter(place.geometry.location);
                    map.setZoom(15);
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
