unit ufpgRelatorioMultasDeVarasExecucoesPenaisSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgCadHistoricoParteTests, ufpgCadMultaTests, uaipFiltroRelMultaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Emitir relatório de multas de uma vara de execuções penais';

initialization
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    //13/09/2016 - Raphael.Whitlock - Task: 50921 - Alterado pois cada tribunal tem seu teste especifico.
    if gsCliente = CS_CLIENTE_PG5_TJSP then
      RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
        'TestarRelatorioMultasDeVarasExecucoesPenais_1_10_3_1'))
    else
      RegisterTest(CS_CAMINHO_TESTE, TffpgCadHistoricoParteTests.Create('TestarHistoricoPartes',
        'TestarHistoricoPartesReuPreso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMultaTests.Create('TestarCadMulta',
      'TestarRelatorioMultasDeVarasExecucoesPenais_1_10_3_1'));

    RegisterTest(CS_CAMINHO_TESTE, TfaipFiltroRelMultaTests.Create('TestarRelMulta',
      'TestarRelatorioMultasDeVarasExecucoesPenais_1_10_3_1', 1, True));
  end
end.

