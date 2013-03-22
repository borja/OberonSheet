import bottle
import pymongo
import sys

connection_string = "mongodb://localhost"

@bottle.route('/')
def index():
    connection = pymongo.Connection('localhost', 27017, safe=True)
    db = connection.oberon
    characters = db.characters

    try:
        character = characters.find_one({}, { "_id": 0})
        print "Character name is ", character['name']
    except:
        print "Error al buscar en la DB ", sys.exc_info()[0]
        return bottle.template("error_template")
    
    return bottle.template("home", {"character": character})

@bottle.get('/internal_error')
def error_screen():
    return bottle.template("error_template")

@bottle.route('/static/:path#.+#', name='static')
def static(path):
    return bottle.static_file(path, root='static')

bottle.run(host='localhost', port=8082, debug=True)