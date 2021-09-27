#-*- encoding: utf-8 -*-

from flask import Flask 
app = Flask(__name__)

@app.route('/btclive')
def index():
  return """
    <body style="overflow-x:hidden;overflow-y:hidden">
	<div id="chart-container"></div>

<script type="text/javascript" src="https://static.cryptowat.ch/assets/scripts/embed.bundle.js"></script>

<script>
var chart = new cryptowatch.Embed('bithumb', 'btckrw', {
timePeriod: '1m',
  presetColorScheme: 'delek'
});
chart.mount('#chart-container');
</script>
"""

if __name__ == '__main__':
  app.run(host="0.0.0.0", port=80)
