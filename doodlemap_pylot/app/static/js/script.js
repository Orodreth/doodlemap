$(document).ready(function(){
    $("#left-panel").slideDown("slow").tabs();

    var counter = 1;
      $(".add").click(function(){

        console.log(counter);
        counter++;
        if (counter > 4){
          alert("Maximum 4 options for each survey!");
          return false;
        }else{
            $('#newvote').append('<div id="vote'+ counter+ '" ><p>Options: </p><input type="text" name="option'+counter+'"> <input type="button" onclick="deleteTheEntireRow()" class="btn btn-secondary-outline remove" value="Remove"></div>');
        }
      });
      $(".remove").click(function(){
        $(this).parent().remove();
        counter--;
      });
});

//TODO: FIND HOW TO RESET SESSION VALUE

var mapDiv = mapDiv = document.getElementById('map');
var geocoder;
var map;
var marker;
var address;
var id;
var latitude;
var longitude;

function search_input() {

    var search_bar = new google.maps.places.Autocomplete(document.getElementById('address'));

    // search_bar.addListener('place_changed', function() {
    //     var place = search_bar.getPlace();
    //     console.log(place['place_id']);
    // });

}

/////////////////// CREATING MAP //////////////////////////
function initialize() {
    geocoder = new google.maps.Geocoder();

    address = document.getElementById('initial_location').value;
    id = document.getElementById('initial_id').value;
    latitude = document.getElementById('initial_latitude').value;
    longitude = document.getElementById('initial_longitude').value;

    console.log('initial address');
    console.log(address);
    console.log(id);
    console.log(latitude);
    console.log(longitude);

    geocoder.geocode({'address': address}, function (results, status) {
        if (status == google.maps.GeocoderStatus.OK) {

            var LatLng = new google.maps.LatLng(latitude, longitude);

            ///////// CREATING MAP RELATIVE TO INITIAL LOCATION ////////////
            map = new google.maps.Map(mapDiv, {
                center: LatLng,
                zoom: 15,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                mapTypeControl: false
            });

            ///////// CREATING MARKER RELATIVE TO INITIAL LOCATION////////////
            marker = new google.maps.Marker({
                position: LatLng,
                animation: google.maps.Animation.DROP,
                map: map
            });
            ///////// CREATING SEARCH BAR////////////
            var input = document.getElementById('pac-input');
            var new_search_bar = new google.maps.places.Autocomplete(input);
            new_search_bar.bindTo('bounds', map);
            map.controls[google.maps.ControlPosition.TOP_CENTER].push(input);
            $('#info_tab').html("");
            var service = new google.maps.places.PlacesService(map);

            /////////////  GETTING PLACE DETAILS //////////////
            service.getDetails(request={ placeId: id }, function callback(place, status) {
                if (status == google.maps.places.PlacesServiceStatus.OK) {
                    console.log(place.place_id);

                    marker.addListener('click', function () {
                        ////////////// ADDING TO INFO TAB ///////////////
                        $('#info_tab').html('<p>'+ place.place_id + '</p>' + '<p>' + place["rating"] + '</p>'
                                        + "<img src="+place.photos[0].getUrl({'maxWidth': 500, 'maxHeight': 500}) + ">");
                        /////////////////////////////////////////////////

                        ////////////// ADDING TO MEDIA TAB //////////////
                        /////////////////////////////////////////////////

                        // //////////// ADDING TO SURVEY TAB //////////////
                        //////////////////////////////////////////////////
                    });
                }
            });

            ///////// CHECKING NEW INPUT VALUES IN SEARCH BAR////////////
            new_search_bar.addListener('place_changed', function () {
                var new_place = new_search_bar.getPlace();
                console.log(new_place);
                address = new_place.formatted_address;
                id = new_place.place_id;
                latitude = new_place.geometry.location.lat();
                longitude = new_place.geometry.location.lng();



                console.log('new address');
                console.log(address);
                console.log(id);
                console.log(latitude);
                console.log(longitude);
                // console.log($('#initial_id').val());
                // console.log($('#initial_latitude').val());
                // console.log($('#initial_longitude').val());

                // console.log($('#initial_location').val(new_place['formatted_address']));
                // console.log($('#initial_id').val());
                // console.log($('#initial_latitude').val());
                // console.log($('#initial_longitude').val());

                service.getDetails(request={ placeId:new_place.place_id }, function callback(new_place, status) {
                    if (status == google.maps.places.PlacesServiceStatus.OK) {
                        marker.addListener('click', function () {
                            ////////////// ADDING TO INFO TAB ///////////////
                            $('#info_tab').html('<p>'+ new_place.place_id + '</p>'
                                                    + '<p>' + new_place["rating"] + '</p>'
                                                    + "<img src="+new_place.photos[0].getUrl({'maxWidth': 500, 'maxHeight': 500}) + ">");
                            /////////////////////////////////////////////////

                            ////////////// ADDING TO MEDIA TAB //////////////
                            /////////////////////////////////////////////////

                            ////////////// ADDING TO SURVEY TAB //////////////
                            //////////////////////////////////////////////////
                        });
                    }
                });

                if (!new_place.geometry) {
                    return;
                }

                if (new_place.geometry.viewport) {
                    map.fitBounds(new_place.geometry.viewport);
                } else {
                    map.setCenter(new_place.geometry.location);
                    map.setZoom(15);
                }

                // Set the position of the marker using the new_place ID and location.
                marker.setPlace({
                    placeId: new_place.place_id,
                    //TODO: FIGURE OUT WHY DROP ANIMATION ISN'T WORKING
                    //TODO: WHEN SEARCHING FOR NEW LOCATION
                    // animation: google.maps.Animation.DROP,
                    location: new_place.geometry.location
                });

                marker.setVisible(true);

                $.get('/welcome/refresh', function (res) {

                });
            });
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}

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