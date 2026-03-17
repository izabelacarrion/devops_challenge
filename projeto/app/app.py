import os
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

APP_ENV = os.getenv("APP_ENV", "unknown")

class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        if self.path == "/health":
            response = {
                "status": "ok",
                "version": "1.0.0",
                "environment": APP_ENV
            }

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()

            self.wfile.write(json.dumps(response).encode())

        else:
            self.send_response(404)
            self.end_headers()

server = HTTPServer(("0.0.0.0", 8080), Handler)
server.serve_forever()