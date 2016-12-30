unit ufpgFormatadorNomeArquivoPeticoesIntermediariasTests;

interface

uses
  ufpgFormatadorNomeArquivoPeticoesIntermediarias, TestFrameWork, Windows, Forms,
  FutureWindows, SysUtils, ufpgParametrosArquivoImportacao;

type
  TfpgFormatadorNomeArquivoPeticoesIntermediariasTests = class(TTestCase)
  private
    FoFormatadorNomeArquivo: TfpgFormatadorNomeArquivoPeticoesIntermediarias;
    procedure TestFormatarNomeArquivoPadraoPeticaoIntermediariaSemExtensaoArquivoException;
    procedure TestFormatarNomeArquivoPadraoPeticaoIntermediariaArquivoEmBrancoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //Test methods
    procedure TestFormatarNomeArquivoPadraoPeticaoIntermediariaArquivoEmBranco;
    procedure TestFormatarNomeArquivoPadraoPeticaoIntermediariaComExtensaoArquivo;
    procedure TestFormatarNomeArquivoPadraoPeticaoIntermediariaSemExtensaoArquivo;
  end;

implementation

uses
  uspExcecao, usajConstante;

const
  sDATA = '17/10/2013 08:00:00';
  sNOME_ARQUIVO_SEM_EXTENSAO = 'TesteFormatador';
  sNOME_ARQUIVO_COM_EXTENSAO = 'TesteFormatador.txt';
  sNOME_ARQUIVO_FORMATADO = 'TesteFormatador_023_20131017_0800.TXT';
  nCDFORO = 23;


{ TfpgFormatadorNomeArquivoPeticoesIntermediariasTests }

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.SetUp;
begin
  inherited;
  FoFormatadorNomeArquivo := TfpgFormatadorNomeArquivoPeticoesIntermediarias.Create(); //PC_OK
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.TearDown;
begin
  inherited;
  FreeAndNil(FoFormatadorNomeArquivo); //PC_OK
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.
TestFormatarNomeArquivoPadraoPeticaoIntermediariaArquivoEmBranco;
begin
  CheckException(TestFormatarNomeArquivoPadraoPeticaoIntermediariaArquivoEmBrancoException,
    EspRegraNegocio);
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.
TestFormatarNomeArquivoPadraoPeticaoIntermediariaArquivoEmBrancoException;
var
  dtDataArquivo: TDateTime;
  sNomeArquivo: string;
  oParametrosArquivoImportacao: TfpgParametrosArquivoImportacao;
begin
  oParametrosArquivoImportacao := TfpgParametrosArquivoImportacao.Create();
  try
    dtDataArquivo := StrToDateTime(sDATA);
    sNomeArquivo := STRING_INDEFINIDO;
    oParametrosArquivoImportacao.fpgCdForo := nCDFORO;
    oParametrosArquivoImportacao.fpgDataInclusao := dtDataArquivo;
    oParametrosArquivoImportacao.fpgNomeArquivo := sNomeArquivo;
    FoFormatadorNomeArquivo.FormatarNomeArquivo(oParametrosArquivoImportacao);
  finally
    FreeAndNil(oParametrosArquivoImportacao);
  end;
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.
TestFormatarNomeArquivoPadraoPeticaoIntermediariaComExtensaoArquivo;
var
  dtDataArquivo: TDateTime;
  sNomeArquivo: string;
  oParametrosArquivoImportacao: TfpgParametrosArquivoImportacao;
begin
  oParametrosArquivoImportacao := TfpgParametrosArquivoImportacao.Create();
  try
    dtDataArquivo := StrToDateTime(sDATA);
    sNomeArquivo := sNOME_ARQUIVO_COM_EXTENSAO;
    oParametrosArquivoImportacao.fpgCdForo := nCDFORO;
    oParametrosArquivoImportacao.fpgDataInclusao := dtDataArquivo;
    oParametrosArquivoImportacao.fpgNomeArquivo := sNomeArquivo;
    CheckEqualsString(FoFormatadorNomeArquivo.FormatarNomeArquivo(oParametrosArquivoImportacao),
      sNOME_ARQUIVO_FORMATADO);
  finally
    FreeAndNil(oParametrosArquivoImportacao);
  end;
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.
TestFormatarNomeArquivoPadraoPeticaoIntermediariaSemExtensaoArquivo;
begin
  CheckException(TestFormatarNomeArquivoPadraoPeticaoIntermediariaSemExtensaoArquivoException,
    EspRegraNegocio);
end;

procedure TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.
TestFormatarNomeArquivoPadraoPeticaoIntermediariaSemExtensaoArquivoException;
var
  dtDataArquivo: TDateTime;
  sNomeArquivo: string;
  oParametrosArquivoImportacao: TfpgParametrosArquivoImportacao;
begin
  oParametrosArquivoImportacao := TfpgParametrosArquivoImportacao.Create();
  try
    dtDataArquivo := StrToDateTime(sDATA);
    sNomeArquivo := sNOME_ARQUIVO_SEM_EXTENSAO;
    oParametrosArquivoImportacao.fpgCdForo := nCDFORO;
    oParametrosArquivoImportacao.fpgDataInclusao := dtDataArquivo;
    oParametrosArquivoImportacao.fpgNomeArquivo := sNomeArquivo;
    CheckEqualsString(FoFormatadorNomeArquivo.FormatarNomeArquivo(oParametrosArquivoImportacao),
      sNOME_ARQUIVO_FORMATADO);
  finally
    FreeAndNil(oParametrosArquivoImportacao);
  end;
end;

initialization

  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\ufpgFormatadorNomeArquivoPeticoesIntermediariasTests',
    TfpgFormatadorNomeArquivoPeticoesIntermediariasTests.Suite);

end.

