unit ufpgDigPecaProcessualSuitTests;

interface

uses
  TestFramework, ufpgVariaveisTestesGui, ufpgConstanteGuiTests, ufpgCadProcessoTests,
  ufpgDigPecaProcessualTests, usajConstante;

implementation

const
  CS_CAMINHO_TESTE = 'Digitalizar peças processuais\';

initialization

  if gsCliente = 'erro' then
  begin
    {** Suit que substitui o teste  TestarDigitalizacaoDePecasAssinarLiberar_l_4_1
    TestarRecategorizaçãoDePecas_l_4_2 e TestarSigiloPastaDigitalPublicoExterno_1_4_3 **}
    RegisterTest(CS_CAMINHO_TESTE + 'Assinar e liberar, recategorizar e tornar sigiloso',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + 'Assinar e liberar, recategorizar e tornar sigiloso',
      TffpgDigPecaProcessualTests.Create('TestarDigitalizacaoPeca', '', 1, True));

    //Importar Arquivo         
    RegisterTest(CS_CAMINHO_TESTE + 'Importar Arquivo',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + 'Importar Arquivo',
      TffpgDigPecaProcessualTests.Create('TestarImportarArquivo', '', 1, True));

    //Alterar tipo documento
    RegisterTest(CS_CAMINHO_TESTE + 'Alterar Tipo Documento',
      TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      CS_PROCESSO_PENAL_GENERICO_DIRECIONADA));

    RegisterTest(CS_CAMINHO_TESTE + 'Alterar Tipo Documento',
      TffpgDigPecaProcessualTests.Create('TestarAlterarTipoDocumento',
      STRING_INDEFINIDO, 1, True));
  end;

end.

