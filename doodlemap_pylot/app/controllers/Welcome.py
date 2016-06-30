"""
    Sample Controller File

    A Controller should be in charge of responding to a request.
    Load models to interact with the database and load views to render them to the client.

    Create a controller using this template
"""
from system.core.controller import *
from flask import redirect, request, session
import json
import geocoder

class Welcome(Controller):
    def __init__(self, action):
        super(Welcome, self).__init__(action)
        """
        This is an example of loading a model.
        Every controller has access to the load_model method.
        """
        self.load_model('WelcomeModel')
        self.db = self._app.db

        """

        This is an example of a controller method that will load a view for the client

        """

    def index(self):
        """
        A loaded model is accessible through the models attribute
        self.models['WelcomeModel'].get_users()

        self.models['WelcomeModel'].add_message()
        # messages = self.models['WelcomeModel'].grab_messages()
        # user = self.models['WelcomeModel'].get_user()
        # to pass information on to a view it's the same as it was with Flask

        # return self.load_view('index.html', messages=messages, user=user)
        """
        return self.load_view('index.html')

    # data = {
    #     'address': session['address'],
    #     'key': 'AIzaSyB6qaM40Um39N4vywpaU_Hj5NwoD2FB3PA'
    # }
    #
    # url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + data['address'] + "&key=" + data['key']
    # response = requests.get(url).content

    # initial_location = session['address']
    # g = geocoder.google(initial_location)
    # g = g.geojson
    # session['lat'] = g['geometry']['coordinates'][0]
    # print session['lat']
    # session['lng'] = g['geometry']['coordinates'][1]
    # print session['lng']

    def search(self):

        print request.form['address']

        initial_location = request.form['address']
        g = geocoder.google(initial_location)
        geo = g.geojson

        session['address'] = geo['properties']['address']
        session['latitude'] = geo['properties']['lat']
        session['longitude'] = geo['properties']['lng']

        places_data = {
            'input': request.form['address'],
            'key': 'AIzaSyB6qaM40Um39N4vywpaU_Hj5NwoD2FB3PA'
        }

        places_url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' \
                     + places_data['input'] +'&key='+ places_data['key']
        json_places = requests.get(places_url).content
        places_response = json.loads(json_places)
        session['placeid'] = places_response['predictions'][0]['place_id']

        print 'Geos'
        print geo['properties']
        print places_response['predictions'][0]['place_id']
        print geo['properties']['address']
        print geo['properties']['lat']
        print geo['properties']['lng']


        print 'Sessions'
        print session['address']
        print session['latitude']
        print session['longitude']
        print session['placeid']


        # places_details_data = {
        #    'placeid': places_response['predictions'][0]['place_id'],
        #     'key': 'AIzaSyB6qaM40Um39N4vywpaU_Hj5NwoD2FB3PA'
        # }
        #
        # places_details_url = 'https://maps.googleapis.com/maps/api/place/details/json?placeid='\
        #             + places_details_data['placeid'] +'&key='+ places_details_data['key']
        # json_detail_places = requests.get(places_details_url).content
        # places_details_response = json.loads(json_detail_places)
        # session['address'] = places_details_response['result']['formatted_address']
        #
        # print places_details_response
        # print places_details_response['result']['formatted_address']

        return redirect('/map')

    def refresh(self):
        # session['address'] = request.form['location']
        # new_latitude = request.form['latitude']
        # new_longitude = request.form['longitude']
        # new_place = request.form['placeid']
		#
        # g = geocoder.google(initial_location)
        # geo = g.geojson
		#
        # session['address'] = geo['properties']['address']
        # session['latitude'] = geo['properties']['lat']
        # session['longitude'] = geo['properties']['lng']
		#
        # places_data = {
        #     'input': request.form['address'],
        #     'key': 'AIzaSyB6qaM40Um39N4vywpaU_Hj5NwoD2FB3PA'
        # }
		#
        # places_url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=' \
        #              + places_data['input'] + '&key=' + places_data['key']
        # json_places = requests.get(places_url).content
        # places_response = json.loads(json_places)
        # session['placeid'] = places_response['predictions'][0]['place_id']
		#
        # print 'Geos'
        # print geo['properties']
        # print places_response['predictions'][0]['place_id']
        # print geo['properties']['address']
        # print geo['properties']['lat']
        # print geo['properties']['lng']
		#
        # print 'Sessions'
        # print session['address']
        # print session['latitude']
        # print session['longitude']
        # print session['placeid']

        return jsonify("{}")
