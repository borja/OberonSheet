import bottle
import pymongo
from bson.objectid import ObjectId
import sys
import json

connection_string = "mongodb://localhost"

#displays all characters
@bottle.route('/')
def index():
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters

    try:
        cursor = characters.find({}, {'_id': 1, 'name': 1})
        mychars = []
        for character in cursor:
            char_row = None
            char_row = { 'name': character['name']}
            char_row['_id'] = character['_id']
            mychars.append(char_row)
    except:
        print "Error al buscar en la DB ", sys.exc_info()[0]
        return bottle.template('error_template')
    return bottle.template("home", {'characters': mychars})

#displays info on a character
@bottle.route('/character/<_id_>')
def show_character(_id_="notfound"):
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters
    try:
        character = characters.find_one({'_id': ObjectId(_id_)}, { '_id': 0})
        print "Looking for character ", character
    except:
        return bottle.template('error_template')
    return bottle.template("character", {'character': character})

@bottle.get('/get_template')
def get_template():
    get_parameter = bottle.request.query['name']
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    templates = db.templates
    ordered = {}
    to_return = {}
    try:
        template = templates.find_one({'name': get_parameter}, {'_id': 0})
        for key in template:
            if key != 'name':
                ordered[int(template[key]['seq'])] =  key
        to_return['template'] = template
        to_return['order'] = ordered
        return to_return
    except: 
        print "error"
        print sys.exc_info()[0]
    

@bottle.get('/new_character')
def new_character():
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    templates = db.templates
    try:
        template = templates.find_one()
    except:
        return bottle.template('error_template')

    return bottle.template("character_editor", character='', template=template)

@bottle.post('/new_character')
def post_new_character():
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters

    post_data = bottle.request.json
    print "Entra"
    print "NEW ", post_data
    try:
        characters.insert(post_data, safe=True)
        print "hero stored"
        return "success"
    except:
        print "oops, mongo error ", sys.exc_info()[0]
        return "error"

@bottle.get('/edit_character/<_id_>')
def edit_character(_id_="notfound"):
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters
    try:
        character = characters.find_one({'_id': ObjectId(_id_)})
    except:
        return bottle.template('error_template')
    return bottle.template('character_editor', character = character)

@bottle.post('/edit_character')
def post_edit_character():
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters
    post_data = bottle.request.json
    _id_ = post_data['_id']
    try:
        print "EDIT", post_data
        for section in post_data:
            if type(post_data[section]) is dict:
                for item in post_data[section]:
                    characters.update({ '_id': ObjectId(_id_) }, { '$set': { section+'.'+item: post_data[section][item] } })
        return "success"
    except:
        print "oops, mongo error ", sys.exc_info()[0]
        return "error"

####
@bottle.get('/internal_error')
def error_screen():
    return bottle.template('error_template')

@bottle.route('/static/:path#.+#', name='static')
def static(path):
    return bottle.static_file(path, root='static')

bottle.run(host='localhost', port=8082, debug=True)