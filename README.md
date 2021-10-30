# ターミナル
- git clone https://github.com/TarouTanakaYokohama/uMy-foods.git
- docker-compose build
- docker-compose up -d
- docker exec -it flutter bash
- cd ${APP_CODE_PATH_CONTAINER} ; flutter create .
- flutter run -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0

# ブラウザで
- http://localhost:8888

# webデプロイ
- npm install -g firebase-tools
- firebase login --no-localhost
- ディレクトリをusr/local/workspaceに変更
- firebase init
  - 「Hosting」を選択しEnter
  - 「Use an existing project」を選択しEnter
  - 使用するプロジェクトを選択しEnter
  - 「? What do you want to use as your public directory?」に 「build/web」 を入力
  - 「? Configure as a single-page app (rewrite all urls to /index.html)?」に 「N」 を入力
- flutter build web
- firebase deploy
