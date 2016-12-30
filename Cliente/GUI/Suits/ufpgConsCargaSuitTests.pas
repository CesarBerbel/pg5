unit ufpgConsCargaSuitTests;

interface

uses
  TestFramework, ufpgConsCargaTests, ufpgCadProcessoTests, ufpgMaterializaProcessoTests,
  usajConstante, ufpgRemessaTests, ufpgVariaveisTestesGUI, ufpgConstanteGUITests;

implementation

const
  CS_CAMINHO_TESTE = 'Consultar as cargas de um Processo Fisico';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
      'TestarMaterializaProcesso', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRemessaTests.Create('TestarRemessaCarga',
      'TestarRemessaProcessoFisicoCriminal'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConsCargaTests.Create('TestarConsultarCarga',
      'TestarConsultaCargaProcessoFisico1_12_9_1', 1, True));
  end;
end.

