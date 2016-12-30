unit ufpgLogFluxoSuitTests;

interface

uses
  TestFramework, ufpgLogFluxoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadProcessoTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Relatóro Historico do Processo no Fluxo';

initialization
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgLogFluxoTests.Create('TestarRelHistoricoProcessoFluxo',
      STRING_INDEFINIDO, 1, True));
  end;
end.

