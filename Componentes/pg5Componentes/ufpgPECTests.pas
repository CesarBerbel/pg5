unit ufpgPECTests;

{*****************************************************************************
 Projeto/Sistema: SAJ / PG5
 Objetivo: Implementar a Classe de testes unitários ufpgPECTests
 Criacao: 20/09/2013 - DAVID
*****************************************************************************}

interface

uses
  ufpgPEC, TestFrameWork, Windows, Forms, FutureWindows, SysUtils;

type
  /// <summary>
  /// Classe para testar a Unit ufpgPEC
  /// </summary>
  /// <remarks>
  ///  08/10/2013 - DAVID - SALT: 144622/7
  /// </remarks>
  TefpgPECTests = class(TTestCase)
  protected
    //procedure SetUp; override;
    //procedure TearDown; override;
  published
    /// <summary>
    ///  Método que cria a Classe
    /// </summary>
    /// <remarks>
    ///  08/10/2013 - DAVID - SALT: 144622/7
    /// </remarks
    procedure TestarCreate;

    /// <summary>
    ///  Método que testa o método TestarPECPodeSerDistribuidaVaraSemCompetência
    /// </summary>
    /// <remarks>
    ///  08/10/2013 - DAVID - SALT: 144622/7
    /// </remarks
    procedure TestarTestarPECPodeSerDistribuidaVaraSemCompetencia;
  end;

implementation

uses
  uspServidorAplicacao, usajConstante, ufpgPECFake, uaipProcessoOrigem, fpgServidor_TLB;

{ TefpgPECTests }

//08/10/2013 - DAVID - SALT: 144622/7
procedure TefpgPECTests.TestarCreate;
var
  efpgPEC: TefpgPEC;
  sSpDono: TspServidorAplicacao;
begin
  sSpDono := nil;
  efpgPEC := TefpgPEC.Create(sSpDono);
  try
    CheckTrue(efpgPEC.FoSpDono = nil);
  finally
    FreeAndNil(efpgPEC);
  end;
end;

//08/10/2013 - DAVID - SALT: 144622/7
procedure TefpgPECTests.TestarTestarPECPodeSerDistribuidaVaraSemCompetencia;
var
  efpgPecFake: TefpgPECFake;
begin
  efpgPecFake := TefpgPECFake.Create(nil);
  try
    CheckTrue(efpgPecFake.TestarPECPodeSerDistribuidaVaraSemCompetencia('123A'));
  finally
    FreeAndNil(efpgPecFake);
  end;
end;

initialization

  TestFrameWork.RegisterTest('Unitário\ufpgPECTests', TefpgPECTests.Suite);

end.

