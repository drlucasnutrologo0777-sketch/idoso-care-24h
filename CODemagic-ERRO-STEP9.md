# Codemagic falha no Step 9 Upload TestFlight (build 53)

## O que está acontecendo

Se o log mostra **Step 9** `Upload TestFlight` e a Apple diz `previousBundleVersion = 53`, o Codemagic **NÃO está usando** o `codemagic.yaml` deste repositório.

O nosso yaml tem **7 passos** (nao 9). O primeiro passo web deve mostrar:

`Build alvo: 2.0.0 (57) — deve ser > 53`

Se isso **nao aparece**, voce esta no workflow errado (editor visual antigo).

## Corrigir no Codemagic (1 vez)

1. https://codemagic.io/apps → app **idoso-care-24h**
2. **Settings** (engrenagem) → **Build**
3. **Configuration as code** → selecione **`codemagic.yaml`**
4. **Branch:** `main`
5. Desative / apague workflow manual "Flutter iOS" se existir
6. **Start new build** (NAO "Rebuild")
7. Workflow: **Idoso Care 24H — iOS TestFlight**

## Como saber que deu certo

No log, antes do upload:

```
Gerando IPA CFBundleVersion=57
CFBundleVersion no IPA antes do upload: 57
```

Se aparecer **53**, pare — workflow errado ou Rebuild com cache.

## Versao iOS fixa no codigo

Arquivo `ios/Flutter/Version.xcconfig` — `FLUTTER_BUILD_NUMBER=57`  
Mesmo workflow antigo passa a gerar **57**, nao 53.
