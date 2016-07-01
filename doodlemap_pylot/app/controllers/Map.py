"""
    Sample Controller File

    A Controller should be in charge of responding to a request.
    Load models to interact with the database and load views to render them to the client.

    Create a controller using this template
"""
from system.core.controller import *
from flask import redirect, request, session
import geocoder
import math

class Map(Controller):
    def __init__(self, action):
        super(Map, self).__init__(action)

        self.load_model('Survey')

    def index(self):

        print session['address']
        print session['latitude']
        print session['longitude']
        print session['placeid']

        # session['address'] = request.form['location']
        # session['latitude'] = request.form['latitude']
        # session['longitude'] = request.form['longitude']
        # session['placeid'] = request.form['id']
        round(float(session['latitude']))
        round(float(session['longitude']))
        surveys = self.models['Survey'].get_all_surveys(round(float(session['latitude'])), round(float(session['longitude'])))
        print surveys
        return self.load_view('map/map.html', address=session['address'], latitude=session['latitude'], longitude=session['longitude'], place_id=session['placeid'], location = session['initial_location'], surveys = surveys)

    def create_survey(self):
        count = len(request.form) - 1
        print count
        print request.form
        make_dict = {}
        make_dict["user_id"] = session["user_id"]

        opts = []
        for name in request.form:
            print name
            if name == "description":
                make_dict["desc"] = request.form[name]
            else:
                opts.append(request.form[name])
        make_dict["opts"] = opts
        print make_dict
        make_dict['lat'] = round(float(session['latitude']))
        make_dict['lng'] = round(float(session['longitude']))
        result = self.models["Survey"].create_survey(make_dict)
        if result['status']:
            return redirect('/map')
        else:
            flash(result['error'])

    def add_vote(self, id):
        data = {'voter_id': session['user_id'], 'option_id': id}
        self.models['Survey'].vote(data)
        return redirect('/map')
