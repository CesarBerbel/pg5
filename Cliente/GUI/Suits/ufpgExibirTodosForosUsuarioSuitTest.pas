unit ufpgExibirTodosForosUsuarioSuitTest;

interface

uses
  TestFramework, ufpgVisualizaFluxoTrabalhoTests, ufpgConstanteGUITests,
  ufpgVariaveisTestesGUI, ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Exibir no fluxo foros das lotações do usuário';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoVariosForos'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarVisualizarProcessosOutrosForos', 1, True));
  end;

end.

