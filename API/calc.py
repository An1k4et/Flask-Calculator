from flask import Flask, request, jsonify
import parser

app = Flask(__name__)
@app.route('/API', methods = ['GET'])

def calculate():
    output = {}
    problem = str(request.args['query'])
    after = ""
    for i in range(len(problem)):
        if problem[i] == " ":
            after += "+"
        else:
            after += problem[i]
    try:
        a = parser.expr(after).compile()
        result = str(eval(a))
        
    except Exception:
        result = "ERROR"

    output['output'] = result
    return output

if __name__ == "__main__":
    app.run()

