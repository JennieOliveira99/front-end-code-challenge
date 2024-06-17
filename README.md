
# Front-end Origam Sistemas

> Esse repositório contém a resolução do projeto criado como base para a avaliação de habilidades técnicas em desenvolvimento front-end utilizando Flutter Web.

# 📎​ Proposta de Teste

Origam, empresa que atua com desenvolvimento de Software, requisitou uma página contendo perfil de usuário e aba de publicações, de acordo com o layout proposto pela empresa.

# 💻 Como acessar 
- Faça download desse repositório clicando no botão azul < CODE >

- Abra a pasta do projeto no seu explorador de arquivos.
- Procure pelo arquivo main.dart dentro da pasta lib. Este arquivo contém o código do projeto Flutter.
- Pressione F5 na sua IDE (como o Visual Studio Code) para iniciar o aplicativo.
- Ou abra o terminal na pasta do projeto e execute "flutter run".




# Ferramentas Utilizadas no desenvolvimento
 
![VSCode](https://img.shields.io/badge/VSCode-0078D4?style=for-the-badge&logo=visual%20studio%20code&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Google Chrome](https://img.shields.io/badge/Google_chrome-4285F4?style=for-the-badge&logo=Google-chrome&logoColor=white)
![Trello](https://img.shields.io/badge/Trello-0052CC?style=for-the-badge&logo=trello&logoColor=white)
![Linux Mint](https://img.shields.io/badge/Linux_Mint-87CF3E?style=for-the-badge&logo=linux-mint&logoColor=white)
![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)

### Regras de Negócio

- Listar todos os posts
- Criar um post
- Atualizar um post
- Remover um post


> # Solução Proposta
A criação da solução foi feita seguindo padrões de desenvolvimento como o Scrum, onde na primeira semana e parte da segunda semana foi estudado o básico da linguagem e na segunda semana foi iniciado de fato o projeto e as prioridades foram definidas de acordo com a capacidade de desenvolvimento.
Fatores como Estrutura de pastas, clean code e  lógica de programação foram levados em consideração durante o desenvolvimento.

# Lógica Utilizada:


### ✏️​UI 

Para a criação da Interface, inicialmente, foi criada a Appbar, em seguida dois Containers e desenvolvimento por prioridades.


### ✏️​ Mobile First
Verificou inicialmente se o dispositivo em que o aplicativo está sendo executado é um dispositivo móvel (como um smartphone ou tablet).
Se isMobile for verdadeiro, renderiza uma coluna vertical com dois widgets, caso contrário, ele renderiza uma linha horizontal com dois widgets: 

 - Expanded(flex: 3, child: _buildProfileSection(widget.usuario)): Este widget ocupa 30% da largura da tela e exibe informações do perfil do usuário. Para Exibir as informações do usuário, foi criada uma classe com as propriedades: nomesobrenome, profissao, cidadeEstado, urlImages e dataHora, para facilitar caso as informações de usuário começassem a vir, por exemplo, de um banco de dados ou múltiplos usuários.
 - Expanded(flex: 7, child: _buildMessagesSection(context)): Este widget ocupa 70% da largura da tela e exibe publicações de usuario. 



### ✏️​ CRUD

Inicialmente, foi definida a classe ApiService que interage com um endpoint da API disponibilizada e encapsula métodos (createPost, editPost, deletePost), em seguida houve a criação de métodos e log de erros.

### ✏️​ Definição de Métodos

- fetchPosts: Utiliza o "ApiService" para buscar as postagens e atualiza a lista _posts com os dados retornados.
 - createPost: Cria uma nova postagem através do ApiService, atualiza a lista _posts e limpa o campo de texto _newPostController.
- editPost: Edita uma postagem existente através do ApiService e atualiza a lista _posts.
- deletePost: Exclui uma postagem existente através do ApiService e atualiza a lista _posts.

### ✏️​ Exibição de informações
- Pensando em futuras implementaçõs (caso as informações do usuário viesse de um bano de dados ou se houvesse mais de um usuário), foi criado o arquivo que armazena os dados do usuário, o construtor inicializa as propriedades com base nos parâmetros fornecidos, um método que extrai os valores do mapa e constrói uma instância de Person e o método toJson converte um objeto Person em um mapa JSON.

# Depuração e Testes


| Teste       | Descrição                           |
| :---------------- | :---------------------------------- |
| `Log de Erros Requisição API` | XMLHTTPREQUESTERROR -  falha na criação de publicação, consequentemente, falha no "Deletar Publicação" e "Editar Publicação" | 
| `Log de Erros Requisição API - Teste com outra API` | Ao testar com uma API que retorna mensagens aleatórias, as mensagens foram exibidas normalmente assim como data e hora, mas as informações de usuário não foram recebidas. | 
| `Verificação da URL da API` | Verificação concluída com sucesso.| 
| `Teste Responsividade` | Erro tamanho mobile:  overflowed by 104 pixels on the bottom.| 
| `Implementação da Fonte de texto` | Falha.| 

# Estratégias futuras para a resolução do erros


Para resolver o erro XMLHTTPREQUESTERROR, algumas propostas de depuração e testes serão feitas:
- Verificação e refatoração de métodos http;
- Depurar com ferramentas de desenvolvedor como DevTools;
- Estudo aprofundado em requisições http e consumo de API

Para resolver o erro de importação de Fonte - Google Fonts e Responsividade:
- Análise e refatoração do código.
