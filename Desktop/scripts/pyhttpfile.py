from http.server import HTTPServer, SimpleHTTPRequestHandler
from email.parser import BytesParser
from email.policy import HTTP


class UploadHandler(SimpleHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/html")
        self.end_headers()
        self.wfile.write(
            b"""
            <html><head>
            <meta name="viewport" content="width=device-width">
            <body>
            <form method=post enctype=multipart/form-data>
                <input type=file name=file>
                <input type=submit>
            </form>
            </body></html>
        """.replace(b"            ", b"")
        )

    def do_POST(self):
        # 读取原始请求体
        content_length = int(self.headers["Content-Length"])
        body = self.rfile.read(content_length)

        # 使用 email 模块解析 multipart 数据
        msg = BytesParser(policy=HTTP).parsebytes(
            b"Content-Type: "
            + self.headers["Content-Type"].encode()
            + b"\r\n\r\n"
            + body
        )

        # 提取文件内容
        for part in msg.iter_parts():
            if part.get_content_disposition() == "form-data":
                filename = part.get_filename()
                if filename:
                    with open(filename, "wb") as f:
                        f.write(part.get_content())
                    break

        self.send_response(200)
        self.end_headers()


if __name__ == "__main__":
    HTTPServer(("", 8000), UploadHandler).serve_forever()
