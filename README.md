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
- firebase login --no-localhost
  - 「? Allow Firebase to collect CLI usage and error reporting information? (Y/n)」に「Y」を入力
  - URLをcontrolキーを押しながらクリックし、googleログインを実行
  - 「 ? Paste authorization code here:」にブラウザに表示されたコードを入力
- cd workspace/
- firebase init
  - 「Hosting: Configure files for Firebase Hosting and (optionally) set up GitHub Action deploys」にspaceキーを押しEnter
  - 「Use an existing project」を選択しEnter
  - 使用するプロジェクトを選択しEnter
  - 「? What do you want to use as your public directory?」に「build/web」を入力
  - 「? Configure as a single-page app (rewrite all urls to /index.html)?」に「N」を入力
  - 「? Set up automatic builds and deploys with GitHub?(y/N)」に「N」を入力
  - 「? File build/web/404.html already exists. Overwrite? (y/N)」に「N」を入力
  - 「? File build/web/index.html already exists. Overwrite?」に「N」を入力
- flutter create .
- flutter build web
- firebase deploy
