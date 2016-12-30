unit ufpgVirtualizarProcessoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgMaterializaProcessotests,
  ufpgVirtualizarProcessoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

const
  CS_CAMINHO_TESTE = 'Virtualização de Processo';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessotests.Create(
      'TestarMaterializaProcesso', STRING_INDEFINIDO));

    RegisterTest(CS_CAMINHO_TESTE, TffpgVirtualizarProcessoTests.Create(
      'TestarVirtualizarProcesso', STRING_INDEFINIDO, 1, True));
  end;
end.

