unit ufpgConsProcessoCondicaoTests;

interface

uses
  ufpgConsProcessoCondicao, TestFrameWork, SysUtils;

type
  TfpgConsProcessoCondicaoTests = class(TTestCase)
  private
    FofpgConsProcessoCondcao: TfpgConsProcessoCondicao;
  protected

    procedure SetUp; override;
    procedure TearDown; override;

  published

    // Test methods
    //procedure TestAdicionarColunaDescricaoMeioProcesso;

    procedure TestDefinirCondicaoFisicoDigitalHibrido;
    procedure TestDefinirCondicaoFisicoOuDigital;
    procedure TestDefinirCondicaoFisicoOuHibrido;
    procedure TestDefinirCondicaoFisico;
    procedure TestDefinirCondicaoDigitalHibrido;
    procedure TestDefinirCondicaoDigital;
    procedure TestDefinirCondicaoHibrido;

  end;

implementation

uses
  usajConstante;

{ TfpgConsProcessoCondicaoTests }

procedure TfpgConsProcessoCondicaoTests.SetUp;
begin
  inherited;
  FofpgConsProcessoCondcao := TfpgConsProcessoCondicao.Create; //PC_Ok
end;

procedure TfpgConsProcessoCondicaoTests.TearDown;
begin
  FreeAndNil(FofpgConsProcessoCondcao); //PC_Ok
  inherited;
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoDigital;
var
  sCondicao: string;
  sCondicaoEsperada: string;
begin
  sCondicaoEsperada := '((P.FLPROCVIRTUAL = :FLPROCVIRTUAL) AND (P.FLPROCHIBRIDO = :FLPROCHIBRIDO))';
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(sFLAG_SIM, sFLAG_NAO, sCondicao);
  CheckEqualsString(sCondicaoEsperada, sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoDigitalHibrido;
var
  sCondicao: string;
  sCondicaoEsperada: string;
begin
  sCondicaoEsperada := '(((P.FLPROCVIRTUAL = :FLPROCVIRTUAL) AND (P.FLPROCHIBRIDO <> ' +
    ':FLPROCHIBRIDO)) OR (P.FLPROCHIBRIDO = :FLPROCHIBRIDO))';
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(sFLAG_SIM, sFLAG_SIM, sCondicao);
  CheckEqualsString(sCondicaoEsperada, sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoFisico;
var
  sCondicao: string;
  sCondicaoEsperada: string;
begin
  sCondicaoEsperada := '((P.FLPROCVIRTUAL = :FLPROCVIRTUAL) AND (P.FLPROCHIBRIDO = :FLPROCHIBRIDO))';
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(sFLAG_NAO, sFLAG_NAO, sCondicao);
  CheckEqualsString(sCondicaoEsperada, sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoFisicoDigitalHibrido;
var
  sCondicao: string;
begin
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(STRING_INDEFINIDO,
    STRING_INDEFINIDO, sCondicao);
  CheckEqualsString(STRING_INDEFINIDO, sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoFisicoOuDigital;
var
  sCondicao: string;
begin
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(STRING_INDEFINIDO, sFLAG_NAO, sCondicao);
  CheckEqualsString('P.FLPROCHIBRIDO = :FLPROCHIBRIDO', sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoFisicoOuHibrido;
var
  sCondicao: string;
  sCondicaoEsperada: string;
begin
  sCondicaoEsperada := '(((P.FLPROCVIRTUAL = :FLPROCVIRTUAL) AND (P.FLPROCHIBRIDO <> ' +
    ':FLPROCHIBRIDO)) OR (P.FLPROCHIBRIDO = :FLPROCHIBRIDO))';
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(sFLAG_NAO, sFLAG_SIM, sCondicao);
  CheckEqualsString(sCondicaoEsperada, sCondicao);
end;

procedure TfpgConsProcessoCondicaoTests.TestDefinirCondicaoHibrido;
var
  sCondicao: string;
  sCondicaoEsperada: string;
begin
  sCondicaoEsperada := 'P.FLPROCHIBRIDO = :FLPROCHIBRIDO';
  FofpgConsProcessoCondcao.DefinirCondicaoMeioProcesso(STRING_INDEFINIDO, sFLAG_SIM, sCondicao);
  CheckEqualsString(sCondicaoEsperada, sCondicao);
end;

initialization

  TestFramework.RegisterTest('ufpgConsProcessoCondicaoTests Suite',
    TfpgConsProcessoCondicaoTests.Suite);

end.
  
