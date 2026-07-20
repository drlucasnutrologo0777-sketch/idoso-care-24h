# ERRO Step 9 Upload TestFlight — build 53 duplicado

## O que aconteceu (22:26 e anteriores)

A Apple recusa porque o `.ipa` enviado tem **CFBundleVersion = 53** (ja usado no TestFlight).

**Nao e bug do app.** O Codemagic esta:

1. Usando **workflow visual antigo** (log mostra **Step 9** — nosso yaml tem **7 passos**)
2. **Nao baixando** os commits do GitHub (57/58), OU
3. Fazendo **Rebuild** e reenviando **IPA velho** do cache

Por isso todas as correcoes no GitHub **nao aparecem** no build que voce roda.

---

## Prova no log

Se NAO aparecer estas linhas, o build **ignorou o GitHub**:

```
Build alvo: 2.0.0 (58)
=== IC24 UI BUILD SCRIPT
CFBundleVersion=58
```

Se so aparece **Step 9 Upload TestFlight** e erro Apple 53 → workflow errado.

---

## Corrigir no Codemagic (obrigatorio)

1. https://codemagic.io/apps → **idoso-care-24h**
2. **App settings** → **Build** (ou Repository settings)
3. **Configuration as code** → marcar **`codemagic.yaml`**
4. Branch: **`main`**
5. **Desativar** workflow Flutter manual / visual (o que gera Step 9)
6. **Start new build** (NAO "Rebuild" do build que falhou)
7. Escolher workflow: **Idoso Care 24H — iOS TestFlight**
8. Commit: **`120d6b3` ou mais novo** (build 58)

---

## Build 58 no codigo (commit mais recente)

Fix nuclear no Xcode — mesmo workflow burro gera 58:

- `ios/Runner/Info.plist` → `CFBundleVersion` **58** (fixo, nao variavel)
- `ios/Flutter/Version.xcconfig` → **58**
- `ios/IC24_IOS_BUILD.txt` → **58** (prova que puxou GitHub)

Repo: https://github.com/drlucasnutrologo0777-sketch/idoso-care-24h

---

## Se nao achar "Configuration as code"

No build, abra o passo **1** do log e veja se clona `drlucasnutrologo0777-sketch/idoso-care-24h`.

Se clonar **outro repo** ou branch **master** → apontar para **main** + repo certo.

---

## Link

- Codemagic: https://codemagic.io/apps
- GitHub: https://github.com/drlucasnutrologo0777-sketch/idoso-care-24h
