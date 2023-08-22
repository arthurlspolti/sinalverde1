# Flutter App Exemplos

Este repositório contém exemplos de código para um aplicativo Flutter desenvolvido com a linguagem Dart. Cada seção representa uma parte diferente do aplicativo e demonstra o uso de diferentes conceitos e bibliotecas.

## Página Inicial

A classe `HomePageWidget` é responsável pela tela inicial do aplicativo. Nesta tela, um botão de áudio é exibido, que reproduz um toque quando pressionado. Além disso, há uma barra de navegação com o título "Sinal verde".

## Tela de Carregamento

A classe `LoadingScreen` representa a tela de carregamento exibida ao iniciar o aplicativo. Ela utiliza um ícone animado de ampulheta e, após um atraso de 3 segundos, navega para a página inicial.

## Página de Toque

A classe `MyTouchPage` é a página intermediária que é acessada a partir da tela inicial. Ela exibe uma imagem de seta e, após um atraso de 8 segundos, permite a navegação para a próxima página.

## Página de Status do Semáforo

A classe `SecondPage` representa a tela que exibe o status de um semáforo. Ela se conecta a uma rede Wi-Fi específica, obtém o status do semáforo a partir de uma URL e atualiza a cor do círculo e o texto de status de acordo com o resultado.

## Como Usar

1. Clone este repositório para o seu ambiente de desenvolvimento:

```bash
git clone https://github.com/seu-usuario/nome-do-repositorio.git
```
2. Abra o projeto no seu editor de código preferido.
3. Execute o aplicativo em um emulador ou dispositivo físico.
