# OCR-App

OCR-App é um aplicativo iOS que realiza leitura de textos em imagens por meio de OCR (Reconhecimento Ótico de Caracteres), utilizando as frameworks nativas da Apple **Vision**, **VisionKit** e **PhotosUI**. Desenvolvido com **SwiftUI** e utilizando **async/await** para operações assíncronas, o app oferece uma experiência fluida e moderna sem dependências de terceiros.

A navegação começa por uma Splash Screen, seguida por uma tela inicial com um botão que leva o usuário à tela de OCR. Nela, é possível selecionar imagens da galeria ou capturar uma nova foto com a câmera. Após a seleção, o texto detectado é exibido em um scroll view. O aplicativo trata possíveis erros, como ausência de texto, imagem inválida ou falha no processamento, informando o usuário de forma clara.

O projeto é leve, direto e utiliza apenas recursos nativos da Apple, facilitando a manutenção e integração com outras soluções iOS.

## Funcionalidades

- **Splash Screen**: Exibe a tela inicial enquanto o app é carregado.
- **Tela Inicial**: Contém um botão que permite ao usuário navegar para a tela de OCR.
- **Tela OCR**: Permite ao usuário selecionar imagens (tira uma foto com a câmera ou escolhe da galeria). O texto extraído da imagem é exibido em um scroll view. Há também tratamento de erros para falhas de OCR ou ausência de texto.

## Como Usar

1. Clone o repositório para o seu computador utilizando o comando:

    ```bash
    git clone https://github.com/danielCangianelli/OCR-App
    ```

2. Abra o arquivo do projeto no Xcode:

    ```bash
    open OCRTextReader.xcodeproj
    ```

3. Conecte um dispositivo físico com o modo de desenvolvedor ativado e rode o app:
   - Selecione o dispositivo conectado no Xcode e clique em **Run**.

⚠️ **Observação**: Algumas funcionalidades, como acesso à câmera ou à galeria, podem não funcionar corretamente em simuladores. Recomenda-se utilizar um dispositivo real para testes completos.


4. Ao abrir o app, você verá a **Splash Screen** seguida pela **Tela Inicial**. Clique no botão para navegar até a tela de OCR.
5. Na tela de OCR, clique no botão para selecionar a imagem:
   - Você pode escolher entre tirar uma foto com a câmera ou selecionar uma imagem da galeria.
6. Após a seleção da imagem, o app processa o texto usando OCR e exibe o resultado no scroll view da tela.

## Tratamento de Erros

O aplicativo trata erros comuns durante o processo de OCR, garantindo uma experiência de usuário robusta e amigável:

- **Imagem vazia**: Caso não haja imagem selecionada ou a imagem esteja em branco.
- **Falha do Vision**: Se o framework Vision não conseguir processar a imagem corretamente.
- **Texto não encontrado**: Quando o OCR não consegue identificar texto legível na imagem selecionada.

Cada erro é tratado e exibido para o usuário com mensagens informativas.

## Autores

- **DuckNCode** - *Desenvolvedor principal* - [@dCangianelli](https://github.com/danielCangianelli)
