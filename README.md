# ターミナル
- git clone https://github.com/TarouTanakaYokohama/uMy-foods.git
- docker-compose build
- docker-compose up -d
- docker exec -it flutter bash
- cd ${APP_CODE_PATH_CONTAINER} ; flutter create .
- flutter run -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0 --web-renderer html

# ブラウザで
- http://localhost:8888

# webデプロイ
- firebase login --no-localhost
  - 「? Allow Firebase to collect CLI usage and error reporting information? (Y/n)」に「Y」を入力
  - URLをcontrolキーを押しながらクリックし、googleログインを実行
  -「 ? Paste authorization code here:」にブラウザに表示されたコードを入力
- ディレクトリをusr/local/workspaceに変更
- firebase init
  - 「Hosting」を選択しEnter
  - 「Use an existing project」を選択しEnter
  - 使用するプロジェクトを選択しEnter
  - 「? What do you want to use as your public directory?」に「build/web」を入力
  - 「? Configure as a single-page app (rewrite all urls to /index.html)?」に「N」を入力
  - 「? Set up automatic builds and deploys with GitHub?(y/N)」に「N」を入力
- flutter build web
- firebase deploy
