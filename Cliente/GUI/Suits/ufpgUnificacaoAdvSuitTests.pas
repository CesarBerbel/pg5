unit ufpgUnificacaoAdvSuitTests;

interface

uses
  TestFramework, ufpgUnificacaoAdvTests, ufpgCadPessoaTests, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Unificação de Advogados';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPessoaTests.Create('TestarCadastroControlado',
      'TestarCadastroAdvogado', 2));
    RegisterTest(CS_CAMINHO_TESTE, TffpgUnificacaoAdvTests.Create('TestarUnificacaoAdvogados',
      '', 1, True));
  end;

end.

