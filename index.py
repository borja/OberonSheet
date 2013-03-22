from bottle import route, run, template

@bottle.route('/')
def index():
print "Entra alguien!"
    return bottle.template("home")

@bottle.route('/static/:path#.+#', name='static')
def static(path):
    return bottle.static_file(path, root='static')

bottle.run(host='localhost', port=8082, debug=True)
