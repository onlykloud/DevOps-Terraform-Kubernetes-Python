from flask import Flask, jsonify, request
from flask_restful import Resource, Api
import os
app = Flask(__name__)
api = Api(app)

class Greetings(Resource):
    def get(self):
        HOST = os.getenv('HOSTNAME')
        return {'result': 'Hello World from %s' % (HOST)}

api.add_resource(Greetings, '/greetings')

class Square(Resource):
    def get(self):
        number = int(request.args.get('number'))
        square = number**2
        return {'number': '%s' % (number),
                'square':'%s' % (square)}

api.add_resource(Square, '/square')


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')