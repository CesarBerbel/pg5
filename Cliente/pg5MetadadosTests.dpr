// Esse projeto QUEBRA BUILD. Roda somente no NOTURNO e é console.
//11/04/2013 - Maico - SALT 134219/1

{$APPTYPE CONSOLE}

program pg5MetadadosTests;

uses
  FastMM4_DebugMode,
  FastMM4Messages_DebugMode,
  MidasMemPatch,
  SysUtils,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  XMLTestRunnerNUnit,
  Forms,

  uspConectarServidor in '..\..\..\..\src\3rd_party\sp4Dev\tests\xunit\Componentes\sp4Geral\uspConectarServidor.pas',

  // 3rd_party
  ucgoConjuntoDeDadosRegistro in '..\..\..\..\src\3rd_party\cgoDev\src\Componentes\cgoComponentesDT\ucgoConjuntoDeDadosRegistro.pas',

  // dev
  usarConjuntoDeDadosRegistro in '..\..\..\..\src\ar\Componentes\arComponentesDT\usarConjuntoDeDadosRegistro.pas',

  uccpConjuntoDeDadosRegistro in '..\..\..\..\src\ccp\Componentes\ccpComponentesDT\uccpConjuntoDeDadosRegistro.pas',
  uaipConjuntoDeDadosRegistro in '..\..\..\..\src\aip\Componentes\aipComponentesDT\uaipConjuntoDeDadosRegistro.pas',
  usmdConjuntoDeDadosRegistro in '..\..\..\..\src\smd\Componentes\smdComponentesDT\usmdConjuntoDeDadosRegistro.pas',
  ufpgConjuntoDadosTests in '..\Componentes\pg5Dados\ufpgConjuntoDadosTests.pas',
  uspConjuntoDadosTests in '..\..\..\..\src\3rd_party\sp4Dev\tests\xunit\Componentes\sp4Geral\uspConjuntoDadosTests.pas',
  // necessitam de BANCO DE DADOS mas não são METADADOS

  // 3rd_party
  uspTestCaseSpConsulta in '..\..\..\..\src\3rd_party\sp4Dev\tests\xunit\Componentes\sp4Geral\uspTestCaseSpConsulta.pas',
  usajUnidEmissoraCons in '..\..\..\..\src\3rd_party\sajDev\src\Componentes\sajConsultas\usajUnidEmissoraCons.pas',
  usajUnidEmissoraConsTests in '..\..\..\..\src\3rd_party\sajDev\tests\xunit\Componentes\sajConsultas\usajUnidEmissoraConsTests.pas';

{$R *.RES}

{---------------------------------------------------------------------------------------------------
  ATENÇÃO !!!
----------------------------------------------------------------------------------------------------
 A unit uspConjuntoDadosTests in '..\..\sp4d5\Fontes\spGeral\uspConjuntoDadosTests.pas' deve
 obrigatoriamente ser declarada depois de todas as units de registro de componentes para poder pegar
 todos os conjuntos de dados.
----------------------------------------------------------------------------------------------------}

var
  oResultado: TTestResult;
begin
  oValidarClassesCreate(TfpgValidarClasseTestes);

  Application.Initialize;

  if System.IsConsole then
  begin
    oResultado := XMLTestRunnerNUnit.RunRegisteredTests(ChangeFileExt(Application.ExeName, '')+'Reports.xml');
    try
      // esse projeto deve quebrar o BUILD então retorna ERROS + FALHAS
      if not oResultado.WasSuccessful then
        System.Halt(oResultado.ErrorCount + oResultado.FailureCount);
    finally
      oResultado.Free;
    end;
  end;

  oValidarClassesFree;
end.
