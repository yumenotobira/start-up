## nixの導入

```
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

https://github.com/DeterminateSystems/nix-installer の説明を参考
インストール成功後、シェルの再起動

## gitの設定

### sshキーの追加

```
ssh-keygen -t ed25519 -f id_ed_github
mv id_ed_github ~/.ssh/
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed_github
```

GitHub に公開鍵を登録した後、以下のSSH設定を追加

```
mkdir -p ~/.ssh && cat >> ~/.ssh/config <<'EOF'
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed_github
  IdentitiesOnly yes
EOF
```

### リポジトリのクローン

```
git clone git@github.com:yumenotobira/start-up.git
```

## 適用

### 初回適用

```
nix run home-manager/release-25.11 -- switch --flake .
```

### 2回目以降適用

```
home-manager switch --flake .
```

## tmux

### よく開くレイアウトで開く

```
tmuxp load {レイアウトを記載したyamlファイル}
```

