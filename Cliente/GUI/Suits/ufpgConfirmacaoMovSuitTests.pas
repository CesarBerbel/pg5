unit ufpgConfirmacaoMovSuitTests;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgConfirmacaoMovTests,
  ufpgCadProcessoTests, usajConstante, ufpgEdicaoDocumentoTests, ufpgEditorTests,
  ufpgMaterializaProcessoTests;

implementation

const
  CS_CAMINHO_TESTE = 'Confirmar as movimentações dos documentos anteriores';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'TestarCadastroProcessoDigital1_1_14'));//'ProcessoPenalGenerico'))

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
      'TestarMaterializaProcesso', 'TestarMaterializaProcessoForo90'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmissaoConfirmaMovFisico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoConfirmaMovFisico'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConfirmacaoMovTests.Create(
      'TestarConfirmacaoMovimentacao', 'TestarConfirmacaoMovimentacaoProcessoFisico', 1, True));
  end
  else
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE, TffpgMaterializaProcessoTests.Create(
      'TestarMaterializaProcesso', 'TestarMaterializaProcesso'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarEmissaoConfirmaMov'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEditorTests.Create('TestarEditor',
      'TestarEmissaoConfirmaMov'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgConfirmacaoMovTests.Create(
      'TestarConfirmacaoMovimentacao', 'TestarConfirmacaoMovimentacaoProcessoFisico', 1, True));
  end;
end.

