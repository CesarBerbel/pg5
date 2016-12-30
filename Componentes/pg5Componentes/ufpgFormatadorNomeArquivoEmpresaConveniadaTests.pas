unit ufpgFormatadorNomeArquivoEmpresaConveniadaTests;

interface

uses
  ufpgFormatadorNomeArquivoEmpresaConveniada, TestFrameWork, Windows, Forms,
  FutureWindows, SysUtils, ufpgParametrosArquivoImportacao;

type
  TfpgFormatadorNomeArquivoEmpresaConveniadaTests = class(TTestCase)
  private
    FoFormatadorNomeArquivo: TfpgFormatadorNomeArquivoEmpresaConveniada;
    procedure TestFormatarNomeArquivoPadraoEmpresaConveniadaArquivoEmBrancoException;
    procedure TestFormatarNomeArquivoPadraoEmpresaConveniadaSemExtensaoArquivoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //Test methods
    procedure TestFormatarNomeArquivoPadraoEmpresaConveniadaArquivoEmBranco;
    procedure TestFormatarNomeArquivoPadraoEmpresaConveniadaComExtensaoArquivo;
    procedure TestFormatarNomeArquivoPadraoEmpresaConveniadaSemExtensaoArquivo;
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


{ TfpgFormatadorNomeArquivoEmpresaConveniadaTests }

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.SetUp;
begin
  inherited;
  FoFormatadorNomeArquivo := TfpgFormatadorNomeArquivoEmpresaConveniada.Create(); //PC_OK
end;

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.TearDown;
begin
  inherited;
  FreeAndNil(FoFormatadorNomeArquivo); //PC_OK
end;

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.
TestFormatarNomeArquivoPadraoEmpresaConveniadaArquivoEmBranco;
begin
  CheckException(TestFormatarNomeArquivoPadraoEmpresaConveniadaArquivoEmBrancoException,
    EspRegraNegocio);
end;

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.
TestFormatarNomeArquivoPadraoEmpresaConveniadaArquivoEmBrancoException;
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

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.
TestFormatarNomeArquivoPadraoEmpresaConveniadaComExtensaoArquivo;
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

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.
TestFormatarNomeArquivoPadraoEmpresaConveniadaSemExtensaoArquivo;
begin
  CheckException(TestFormatarNomeArquivoPadraoEmpresaConveniadaSemExtensaoArquivoException,
    EspRegraNegocio);
end;

procedure TfpgFormatadorNomeArquivoEmpresaConveniadaTests.
TestFormatarNomeArquivoPadraoEmpresaConveniadaSemExtensaoArquivoException;
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
    FoFormatadorNomeArquivo.FormatarNomeArquivo(oParametrosArquivoImportacao);
  finally
    FreeAndNil(oParametrosArquivoImportacao);
  end;
end;

initialization

  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\ufpgFormatadorNomeArquivoEmpresaConveniadaTests',
    TfpgFormatadorNomeArquivoEmpresaConveniadaTests.Suite);

end.

