// Esse projeto NÃO QUEBRA BUILD, ele apenas reporta o resultado no PLOT

// inicialmente, o projeto é CONSOLE
{$APPTYPE CONSOLE}

// inicialmente, pode ser feito Metadados
{$DEFINE METADADOS}

// Metadados, só roda no NOTURNO, então se não for, desativa
{$IFNDEF NOTURNO}
  {$UNDEF METADADOS}
{$ENDIF}

// Via RUN no Delphi, a saída é em modo GUI
{$IFNDEF LOCAL}
  {$IFNDEF CONTINUO}
    {$IFNDEF NOTURNO}
      {$IFNDEF SEMANAL}
        {$APPTYPE GUI}
      {$ENDIF}
    {$ENDIF}
  {$ENDIF}
{$ENDIF}


program pg5AppTestsDebitoTecnico;  

uses
  FastMM4_DebugMode,
  FastMM4Messages_DebugMode,
  MidasMemPatch,
  TestFramework,
  GUITestRunner,
  TextTestRunner,
  XMLTestRunnerNUnit,
  Forms,
  
  ufpgVincRecolMandItemGuia in '..\..\..\..\src\pg5\Componentes\pg5Componentes\ufpgVincRecolMandItemGuia.pas',
  ufpgVincRecolMandItemGuiaDebitoTecnicoTests in '..\Componentes\pg5Componentes\ufpgVincRecolMandItemGuiaDebitoTecnicoTests.pas',
  
  ufpgVincRecolMandItemRecolhimento in '..\..\..\..\src\pg5\Componentes\pg5Componentes\ufpgVincRecolMandItemRecolhimento.pas',  
  ufpgVincRecolMandItemRecolhimentoDebitoTecnicoTests in '..\Componentes\pg5Componentes\ufpgVincRecolMandItemRecolhimentoDebitoTecnicoTests.pas',
  
  ufpgVincRecolMandItens in '..\..\..\..\src\pg5\Componentes\pg5Componentes\ufpgVincRecolMandItens.pas',
  ufpgVincRecolMandItensDebitoTecnicoTests in '..\Componentes\pg5Componentes\ufpgVincRecolMandItensDebitoTecnicoTests.pas'
  
  {$IFDEF METADADOS}
  ,
  uspConectarServidor in '..\..\..\..\src\3rd_party\sp4Dev\tests\xunit\Componentes\sp4Geral\uspConectarServidor.pas',

  uggpConjuntoDeDadosRegistro in '..\..\..\..\src\ggp\Componentes\ggpComponentesDT\uggpConjuntoDeDadosRegistro.pas',
  ufpgcConjuntoDeDadosRegistro in '..\..\..\..\src\pg5c\Componentes\pg5cComponentesDT\ufpgcConjuntoDeDadosRegistro.pas',
  ufpgConjuntoDeDadosRegistro in '..\..\..\..\src\pg5\Componentes\pg5ComponentesDT\ufpgConjuntoDeDadosRegistro.pas',
  usarConjuntoDeDadosRegistro in '..\..\..\..\src\ar\Componentes\arComponentesDT\usarConjuntoDeDadosRegistro.pas',
  uproConjuntoDeDadosRegistro in '..\..\..\..\src\pro\Componentes\proComponentesDT\uproConjuntoDeDadosRegistro.pas',
  
  ufpgConjuntoDadosTests in '..\Componentes\pg5Dados\ufpgConjuntoDadosTests.pas',
  uspConjuntoDadosTests in '..\..\..\..\src\3rd_party\sp4Dev\tests\xunit\Componentes\sp4Geral\uspConjuntoDadosTests.pas'
  {$ENDIF}
  ;

{$R *.RES}

var
  oResultado: TTestResult;
begin
  {$IFDEF METADADOS}
  oValidarClassesCreate(TfpgValidarClasseTestes);
  {$ENDIF} 

  Application.Initialize;

  if System.IsConsole then
  begin
    oResultado := nil;
    try
      oResultado := XMLTestRunnerNUnit.RunRegisteredTests('pg5AppTestsDebitoTecnicoReports.xml');
    finally
      if oResultado <> nil then
        oResultado.Free;
    end;
  end
  else
    GUITestRunner.RunRegisteredTests;

  {$IFDEF METADADOS}
  oValidarClassesFree;
  {$ENDIF}
end.

