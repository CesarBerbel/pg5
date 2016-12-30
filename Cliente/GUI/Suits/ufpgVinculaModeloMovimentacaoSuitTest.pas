unit ufpgVinculaModeloMovimentacaoSuitTest;

interface

uses
  TestFramework, ufpgCadProcessoTests, ufpgCadMovimentacaoUnitariaTests,
  ufpgMaterializaProcessoTests, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgVariaveisTestesGUI, ufpgConstanteGUITests;

implementation

const
  CS_CAMINHO_TESTE = 'Desvincular documento';

initialization

  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPenalSimples'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
      'TestarMaterializaProcesso', ''));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarDesvincularDocumento'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarDesvincularDocumento'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadMovimentacaoUnitariaTests.Create(
      'TestarDesvincularDocumento', '', 1, True));
  end;
end.

