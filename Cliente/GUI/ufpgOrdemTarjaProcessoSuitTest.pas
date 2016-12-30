unit ufpgOrdemTarjaProcessoSuitTest;

interface

uses

  TestFramework, ufpgCadProcessoTests, uggpRelPautaAudienciaCorridoTests,
  ufpgCadPautaAudienciaTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgVisualizaFluxoTrabalhoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Testar Ordem Tarja Fluxo de Trabalho';

// 01/11/2016  - Carlos.Gaspar - TASK: 67011
initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastrarProcessoTarjaIdoso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastrarProcessoTarjaDoencaGrave'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastrarProcessoTarjaUrgente'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoCivilDirecionadaTarja', 3));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaFluxoTrabalhoTests.Create(
      'TestarFluxoTrabalho', 'TestarOrdemTarjaProcesso', 1, True));
  end;
end.

