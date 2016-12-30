unit ufpgCancelReativaProcessoSuitTest;

interface

uses
  TestFramework, ufpgVariaveisTestesGUI, ufpgCadProcessoTests, ufpgCadCorrecaoClasseTests,
  ufpgConstanteGUITests, ufpgCancelamentoProcessoTests,
  ufpgReativacaoProcessoTests, usajconstante, ufpgRetificacaoProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Cancelamento, reativação e retificação de Processo';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCancelamentoProcessoTests.Create(
      'TestarCancelamentoProcesso', STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgReativacaoProcessoTests.Create(
      'TestarReativacaoProcessoCancelado', STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgRetificacaoProcessoTests.Create(
      'TestarRetificarProcesso', STRING_INDEFINIDO, 1, True));
  end;
end.

