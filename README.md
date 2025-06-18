# 📱 HandDoc AI – App Flutter OCR Inteligente

**HandDoc AI** é um aplicativo mobile desenvolvido em **Flutter** (Android e iOS) que utiliza **inteligência artificial** para reconhecer textos manuscritos e digitalizá-los. Ideal para escanear, extrair texto e exportar em diferentes formatos!


## ✅ Objetivo do App

- 📷 Capturar ou escolher imagens da galeria  
- 🌐 Enviar imagens para uma **API FastAPI com OCR**  
- 🧠 Exibir o **texto reconhecido**  
- 📄 Exportar o resultado como **PDF** e **TXT**  
- 📤 Compartilhar os arquivos gerados com outros apps


## 🧰 Tecnologias e Bibliotecas

| Funcionalidade           | Biblioteca Flutter         |
|--------------------------|----------------------------|
| UI/UX                    | `Flutter (Dart) + Material`|
| Permissões               | `permission_handler`       |
| Captura de Imagem        | `image_picker`             |
| Upload Multipart         | `http` ou `dio`            |
| Arquivos Locais          | `path_provider`, `dart:io` |
| Geração de PDF           | `pdf`, `printing`          |
| Compartilhamento         | `share_plus`               |

---

## 🔁 Fluxo de Funcionalidades

### 1. 📷 Captura ou Seleção de Imagem
- Abertura da câmera ou seleção da galeria
- Permissões tratadas com `permission_handler`

### 2. 🔐 Permissões Necessárias

| Plataforma | Permissões Obrigatórias                                  |
|------------|-----------------------------------------------------------|
| Android    | `CAMERA`, `READ_EXTERNAL_STORAGE`, `WRITE_EXTERNAL_STORAGE` |
| iOS        | `NSCameraUsageDescription`, `NSPhotoLibraryUsageDescription` |

### 3. 🌐 Envio da Imagem para a API

| Requisição | Detalhes                                |
|------------|------------------------------------------|
| Método     | `POST http://<SEU_BACKEND_URL>/ocr/`     |
| Headers    | `Content-Type: multipart/form-data`      |
| Parâmetro  | `file` (imagem capturada ou selecionada) |

### 4. 📥 Resultado da OCR

json
        {
        "filename": "img.PNG",
        "text": "Texto reconhecido aqui...",
        "timestamp": "2025-06-18T10:30:00"
        }

 Exibição: Tela de texto OCR + Botões para salvar/exportar

5. 📝 Exportação PDF/TXT
Tipo	Ferramentas
PDF	pdf,printing
TXT	File,path_provider

📂 Caminhos sugeridos:

Androide:/storage/emulated/0/Documents/HandDocAI/

iOS: Diretório interno de documentos do aplicativo

6. 📤 Compartilhamento
Usandoshare_plus

Compartilhamento via WhatsApp, E-mail, Google Drive, etc.

📁 Estrutura de Pastas (Flutter)

    lib/
    ├── main.dart
    ├── screens/
    │   ├── home_screen.dart
    │   ├── ocr_result_screen.dart
    │   ├── export_screen.dart
    ├── services/
    │   └── api_service.dart         // Comunicação com API FastAPI
    ├── utils/
    │   └── file_utils.dart          // Funções para salvar PDF/TXT
    └── widgets/
        └── custom_button.dart       // Botões reutilizáveis
    📦 Dependências ( pubspec.yaml)


dependencies:
    flutter:
        sdk: flutter
    image_picker: ^1.0.0
    permission_handler: ^11.0.0
    http: ^1.0.0
    dio: ^5.0.0                   
    path_provider: ^2.0.0
    pdf: ^3.10.0
    printing: ^5.9.0
    share_plus: ^7.0.0
