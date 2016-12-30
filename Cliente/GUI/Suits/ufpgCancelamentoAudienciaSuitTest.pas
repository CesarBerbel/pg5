unit ufpgCancelamentoAudienciaSuitTest;

interface

uses

  TestFramework, ufpgCadProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  uggpRelPautaAudienciaCorridoTests, ufpgCadPautaAudienciaTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar uma audiência, mudar a situação da mesma e emitir o relatório';


initialization
  if gsCliente <> CS_CLIENTE_PG5_TJMS then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPautaAudienciaTests.Create(
      'TestarCadPautaAudiencia', 'TestarCadPautaAudiencia'));

    //  RegisterTest(CS_CAMINHO_TESTE, TffpgCadPautaAudienciaTests.Create(
    //    'TestarModificarAudiencia', 'TestarCancelamentoAudiencia_1_12_15'));

    RegisterTest(CS_CAMINHO_TESTE, TfggpRelPautaAudienciaCorridoTests.Create(
      'TestarRelPautaAudienciaCorrido', '', 1, True));
  end;
end.

