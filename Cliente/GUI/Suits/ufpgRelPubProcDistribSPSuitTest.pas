unit ufpgRelPubProcDistribSPSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgRelPubProcDistribSPTests,
  ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Publicação de Processo Distribuído';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadProcessoGuiaRecolhimento'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelPubProcDistribSPTests.Create(
      'TestarRelPubProcDistribSP', 'TestarPubProcDistribSP', 1, True));
  end;

end.

