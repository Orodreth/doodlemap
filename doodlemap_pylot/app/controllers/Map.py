"""
    Sample Controller File

    A Controller should be in charge of responding to a request.
    Load models to interact with the database and load views to render them to the client.

    Create a controller using this template
"""
from system.core.controller import *
from flask import redirect, request, session
import geocoder


class Map(Controller):
    def __init__(self, action):
        super(Map, self).__init__(action)
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

        print session['address']
        print session['latitude']
        print session['longitude']
        print session['placeid']

        # session['address'] = request.form['location']
        # session['latitude'] = request.form['latitude']
        # session['longitude'] = request.form['longitude']
        # session['placeid'] = request.form['id']

        return self.load_view('map/map.html', address=session['address'], latitude=session['latitude'], longitude=session['longitude'], place_id=session['placeid'])
