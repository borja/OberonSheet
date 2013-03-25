import bottle
import pymongo
from bson.objectid import ObjectId
import sys

connection_string = "mongodb://localhost"

#displays all characters
@bottle.route('/')
def index():
    connection = pymongo.Connection(connection_string, safe=True)
    db = connection.oberon
    characters = db.characters

    try:
        cursor = characters.find({}, {'_id': 1, 'information.name': 1})
        mychars = []
        for character in cursor:
            char_row = None
            char_row = { 'name': character['information']['name']}
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

####
@bottle.get('/internal_error')
def error_screen():
    return bottle.template('error_template')

@bottle.route('/static/:path#.+#', name='static')
def static(path):
    return bottle.static_file(path, root='static')

bottle.run(host='localhost', port=8082, debug=True)