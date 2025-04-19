# kubectl ダミースクリプト

このプロジェクトは、`kubectl` コマンドの挙動を模倣するダミースクリプトを提供します。  
テストやモック目的で、実際の Kubernetes 環境を使用せずにシェルスクリプトなどの動作確認が可能になります。

---

## 📦 構成

- `kubectl` … ダミースクリプト（`mock_kubectl.sh`）
- `data/` … コマンドごとの出力内容を格納するテキストファイル群

---

## 🛠 インストールと使い方

### 1. スクリプトを設置

```bash
chmod +x kubectl
```

### 2. 実行時にこのスクリプトを優先的に使うよう PATH を調整

```bash
export PATH="$(pwd):$PATH"
```

これで、任意のシェルスクリプトやコマンドから `kubectl` を実行すると、このモックが呼ばれます。

---

## 🧠 仕様

- 与えられた引数を `_` で結合し、対応する `data/xxx.txt` ファイルを出力します。
- 引数に `-` で始まるオプションが含まれる場合、その `-` は取り除かれます。
    - 例: `-n` → `n`
- **6番目以降の引数は無視**されます。

---

## 🧪 実行例とファイルマッピング

| 実行コマンド                        | 対応ファイル名                       |
|----------------------------------|----------------------------------|
| `kubectl get pod`               | `data/get_pod.txt`               |
| `kubectl get pod -n test`       | `data/get_pod_n_test.txt`       |
| `kubectl describe node mynode -o yaml` | `data/describe_node_mynode_o_yaml.txt` |
| `kubectl get pod -n test extra` | `data/get_pod_n_test_extra.txt` |
| `kubectl get pod -n test extra1 extra2` | `data/get_pod_n_test_extra1.txt`（6番目以降は無視） |

---

## 📁 データファイル作成ルール

必要な出力結果を `data/` ディレクトリ内にプレーンテキストファイルとして用意してください。

例:

```bash
mkdir -p data
echo "pod1   Running" > data/get_pod.txt
echo "pod2   Completed" > data/get_pod_n_test.txt
```

---

## 📌 注意点

- ファイル名は引数順に `_` で連結された形式になります。
- ファイルが存在しない場合はエラーを出力して終了します。
- シェルスクリプトやCIテストのモック環境に最適です。

---

## 📃 ライセンス

Apache License 2.0
