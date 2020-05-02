from flask import Flask,request,jsonify
import logging
import os
app = Flask(__name__)
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

@app.route("/greetings")
def hello():
    host = os.getenv('HOSTNAME')
    return "Hello World from " %host

@app.route("/square", methods=['POST'])
def hello():
    content = request.json
    number = content['number']
    square = number*number
    task = {
        'number' : request.json['number'],
        'square' : square
    }
    task.append(task)
    return jsonify({'task': task}), 201
