#-*- encoding: utf-8 -*-
from flask import Flask, request, jsonify
from pybithumb import Bithumb
app = Flask(__name__)

@app.route('/btc')
def environments(): 
    btcprice = Bithumb.get_current_price("BTC")
    roundpz = round(btcprice)
    return jsonify({"price":roundpz})
 
 
 
 
if __name__ == "__main__":
    app.run(host="127.0.0.1", port=5000)
