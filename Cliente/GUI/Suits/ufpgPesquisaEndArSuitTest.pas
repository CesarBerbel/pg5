unit ufpgPesquisaEndArSuitTest;

interface

uses
  TestFramework, ufpgConstanteGUITests, ufpgVariaveisTestesGUI, ufpgCadProcessoTests,
  ufpgEdicaoDocumentoTests;

const
  CS_CAMINHO_TESTE = 'Verificar Duplicação Pesquisa de Endereço AR';

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSP then
  begin
    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoCivilEndAR'));

    RegisterTest(CS_CAMINHO_TESTE, TffpgEdicaoDocumentoTests.Create('TestarEmitirDocumento',
      'TestarDuplicaEndAR', 1, True));
  end;
end.

