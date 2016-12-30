unit ufpgCadPessoaSuitTests;


interface

uses
  TestFramework, ufpgCadPessoaTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  usajConstante, ufpgCadProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastro Pessoa';
  CS_CAMINHO_TESTE_ADV = 'Cadastro Advogado';
  CS_CAMINHO_TESTE_CONTROLADO = 'Cadastro de Pessoa Controlado';

initialization

  RegisterTest(CS_CAMINHO_TESTE_ADV, TffpgCadPessoaTests.Create('TestarCadastroControlado',
    'TestarCadastroAdvogado', 1, True));


  RegisterTest(CS_CAMINHO_TESTE, TffpgCadPessoaTests.Create('TestarPesquisarPessoa',
    'TestarPesquisarPessoa', 1, True));

  RegisterTest(CS_CAMINHO_TESTE, TffpgCadPessoaTests.Create('TestarCadastrarPessoa',
    'TestarCadastroBasicoPessoas', 1, True));

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Forma Pagamento',
      TffpgCadPessoaTests.Create('TestarCadastroControlado', 'TestarCadastroControlado'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Forma Pagamento',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadastroControlado'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Forma Pagamento',
      TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento', 'TestarCadastroControlado'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Forma Pagamento',
      TffpgEditorTests.Create('TestarEditor', 'TestarCadastroControlado', 1, True));

    //    03/11/2016 - Raphael.Whitlock - Task: 67188
    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Fora Uso',
      TffpgCadPessoaTests.Create('TestarCadastroControlado', 'TestarCadastroControlado'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Fora Uso',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso', 'TestarCadastroControladoForaUso'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Fora Uso',
      TffpgCadPessoaTests.Create('TestarCadastroControlado', 'TestarCadastroControladoForaUso'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Validar Fora Uso',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastroAlteraControlado', 1, True));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Função de Segurança',
      TffpgCadPessoaTests.Create('TestarCadastroControlado', 'TestarCadastroControlado'));

    RegisterTest(CS_CAMINHO_TESTE_CONTROLADO + '\Função de Segurança',
      TffpgCadPessoaTests.Create('TestarCadastrarPessoa',
      'TestarCadastroControladoFuncaoSeguranca', 1, True));
  end;

end.

