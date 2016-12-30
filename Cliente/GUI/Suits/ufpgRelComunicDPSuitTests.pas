unit ufpgRelComunicDPSuitTests;

interface

uses
  TestFramework, ufpgRelComunicDPTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgCadProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Relatório de Comunicado com Delegacia de Policia';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'ProcessoPenalGenerico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRelComunicDPTests.Create(
      'TestarRelComunicadoDelegaciaPolicia',
      'TestarRelComunicadoDelegaciaPoliciaPeriodoProcesso1_2_31_2', 1, True));
  end;
end.

