unit ufpgCadastrarModeloVinculandoMovimentacaoAtosDocumentoSuitTest;

interface

uses
  TestFramework, ufpgCadModeloTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

implementation

const
  CS_CAMINHO_TESTE = 'Cadastrar um segundo modelo, vinculando movimentação e atos do documento';

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadModeloTests.Create('TestarCadastrarModelo',
      'TestarCadastrarModeloVincMovAtosDoDocumento_1_12_2', 1, True));
  end;

end.

