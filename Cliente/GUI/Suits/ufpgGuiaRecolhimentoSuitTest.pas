unit ufpgGuiaRecolhimentoSuitTest;

interface

uses
  TestFrameWork, ufpgCadProcessoTests, ufpgCadHistoricoParteTests, ufpgVariaveisTestesGUI,
  ufpgConstanteGUITests;

implementation

const
  CS_CAMINHO_TESTE = 'Guia de Recolhimento';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoGuiaRecolhimento'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
      'TestarEmissaoGuiaRecolhimento'));

    //  RegisterTest(CS_CAMINHO_TESTE, TffpgVisualizaProcessoTests.Create(
    //    'TestarVisualizacaoAutos', ''));    
  end;

end.

