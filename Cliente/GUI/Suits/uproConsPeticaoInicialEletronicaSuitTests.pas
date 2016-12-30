unit uproConsPeticaoInicialEletronicaSuitTests;

interface

uses
  SysUtils, TestFramework, ufpgCadProcessoTests, uproConsPeticaoInicialEletronicaTests,
  ufpgConstanteGUITests, ufpgVariaveisTestesGUI,
  ufpgExecutarRoteiroPROTests;

implementation

uses
  usajConstante;

const
  CS_CAMINHO_TESTE = 'Cadastro de Petições Iniciais';

var
  oproConsPeticaoInicialEletronicaTests: TfproConsPeticaoInicialEletronicaTests;

initialization

  if gsCliente = 'erro' then
  begin
    oproConsPeticaoInicialEletronicaTests :=
      TfproConsPeticaoInicialEletronicaTests.Create('TestarConsPeticaoInicialEletronica',
      STRING_INDEFINIDO);
    RegisterTest(CS_CAMINHO_TESTE, oproConsPeticaoInicialEletronicaTests);

    RegisterTest(CS_CAMINHO_TESTE, TffpgCadProcessoTests.Create('TestarCadastroProcesso',
      'CadastroProcessoPeticaoInicial', 1, True));
  end;

finalization
  //if Assigned(oproConsPeticaoInicialEletronicaTests) then
  //  FreeAndNil(oproConsPeticaoInicialEletronicaTests);
  oproConsPeticaoInicialEletronicaTests := nil;

end.

