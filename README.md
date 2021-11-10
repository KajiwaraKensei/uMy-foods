# ターミナル
- git clone https://github.com/TarouTanakaYokohama/uMy-foods.git
- docker-compose build
- docker-compose up -d
- docker exec -it flutter bash
- cd ${APP_CODE_PATH_CONTAINER} ; flutter create .
- flutter run -d web-server --web-port=${WEB_SERVER_PORT} --web-hostname 0.0.0.0

# ブラウザで
- http://localhost:8888

# VSCodeでコンテナを開く
[Remote-Container](https://code.visualstudio.com/docs/remote/create-dev-container#_using-an-image-or-dockerfile)の拡張機能を入れとく

## 設定ファイル
### *.devcontainer/devcontainer.json*  
使いたい拡張機能はここに追加  
ワークスペースのファイルもここで設定  
[詳細](https://code.visualstudio.com/docs/remote/devcontainerjson-reference)

## 実行
1. 左下のリモートウィンドウを開き「ReOpen in Container」を選択
2. 「Ctr + J」で開いたターミナルであとはいつも通り
3. 戻りたい場合は左下のリモートウィンドウを開き「ReOpen folder Locally」を選択
