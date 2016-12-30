unit ufpgCadContatoSuitTest;

interface

uses
  TestFramework, ufpgCadContatoTests, ufpgConstanteGUITests, ufpgVariaveisTestesGUI;

implementation

initialization
  if gsCliente = CS_CLIENTE_PG5_TJSC then
    RegisterTest('Cadastrar um contato', TffpgCadContatoTests.Create('TestarCadastroBasicoContato',
      STRING_INDEFINIDO, 1, True));
end.
                                                                                     
