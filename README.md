# ターミナル
- git clone https://github.com/TarouTanakaYokohama/uMy-foods.git
- docker-compose build
- docker-compose up -d
- docker exec -it flutter bash
- cd ${APP_CODE_PATH_CONTAINER} ; flutter create .
- flutter run -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0 --web-renderer html

# ブラウザで
- http://localhost:8888