# 📡 LiveStreamingServer

Servidor de livestreaming pessoal utilizando **Nginx com módulo RTMP**, containerizado com Docker. Permite receber uma transmissão via OBS (ou qualquer software compatível com RTMP) e fazer restream simultâneo para **Twitch** e **YouTube**.

---

## 🧱 Arquitetura

```
OBS / Software de Stream
        │
        │  RTMP (porta 1935)
        ▼
  [Docker Container]
  Nginx + RTMP Module
        │
        ├──► Twitch (rtmp://...)
        ├──► YouTube (rtmp://...)
        └──► HLS local (http://localhost:8081/live)
```

---

## ✅ Requisitos

- [Docker](https://www.docker.com/) (v20+)
- [Docker Compose](https://docs.docker.com/compose/) (v2+)
- Chaves de stream da **Twitch** e/ou **YouTube**
- Software de transmissão compatível com RTMP (ex: [OBS Studio](https://obsproject.com/))

---

## 📁 Estrutura do Projeto

```
LiveStreamingServer/
├── Dockerfile
├── docker-compose.yml
├── nginx.conf.template
├── .env                  # variáveis de ambiente (não commitar!)
├── .gitignore
└── README.md
```

---

## ⚙️ Configuração

### 1. Clone o repositório

```bash
git clone https://github.com/seu-usuario/LiveStreamingServer.git
cd LiveStreamingServer
```

### 2. Crie o arquivo `.env`

Copie o exemplo abaixo e preencha com suas chaves:

```env
TWITCH_STREAMING_URL=rtmp://live.twitch.tv/app
TWITCH_STREAMING_KEY=live_xxxxxxxxxxxxxxxxxx

YOUTUBE_STREAMING_URL=rtmp://a.rtmp.youtube.com/live2
YOUTUBE_STREAMING_KEY=xxxx-xxxx-xxxx-xxxx-xxxx
```

> **Onde encontrar suas chaves:**
> - **Twitch:** [Dashboard](https://dashboard.twitch.tv/) → Configurações → Stream → Chave de Stream
> - **YouTube:** [YouTube Studio](https://studio.youtube.com/) → Transmissões ao vivo → Chave de Stream

### 3. Adicione o `.env` ao `.gitignore`

Certifique-se de que o `.env` **nunca** seja commitado:

```gitignore
.env
```

---

## ▶️ Como Executar

### Subir o servidor

```bash
docker compose up --build
```

### Subir em background (detached)

```bash
docker compose up --build -d
```

### Parar o servidor

```bash
docker compose down
```

### Rebuild forçado (sem cache)

```bash
docker compose down
docker compose build --no-cache
docker compose up
```

---

## 📡 Configurando o OBS

No OBS Studio, vá em **Configurações → Stream** e preencha:

| Campo | Valor |
|---|---|
| Serviço | `Personalizado` |
| Servidor | `rtmp://localhost/live` |
| Chave de stream | qualquer valor (ex: `stream`) |

---

## 🎬 Assistir a stream localmente (HLS)

A stream também fica disponível localmente via HLS na porta `8081`:

```
http://localhost:8081/live/stream.m3u8
```

Pode ser reproduzida em qualquer player compatível com HLS, como [VLC](https://www.videolan.org/) ou via browser com players como [hls.js](https://github.com/video-dev/hls.js/).

---

## 🔧 Portas utilizadas

| Porta | Protocolo | Uso |
|---|---|---|
| `1935` | RTMP | Receber stream do OBS |
| `8081` | HTTP | Servir stream HLS localmente |

---
