unit ufpgPautaAudienciaBlocoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, uggpPautaAudienciaBlocoTests,
  ufpgCadPautaAudienciaTests, uggpRelPautaAudienciaCorridoTests;

implementation

uses
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

const
  CS_CAMINHO_TESTE = 'Cadastrar Pauta de Audiência em Bloco';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadPautaAudienciaTests.Create(
      'TestarCadPautaAudiencia', ''));


    RegisterTest(CS_CAMINHO_TESTE, TfggpPautaAudienciaBlocoTests.Create(
      'TestarPautaAudienciaBloco', ''));

    RegisterTest(CS_CAMINHO_TESTE, TfggpRelPautaAudienciaCorridoTests.Create(
      'TestarRelPautaAudienciaCorrido', '', 1, True));
  end;

end.

