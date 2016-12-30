unit ufpgValidadorDadosArTests;

interface

uses
  ufpgValidadorDadosAr, TestFrameWork, Windows, Forms, FutureWindows, SysUtils,
  uspConjuntoDados, DBClient, DB, usajConstante, Classes;

type
  TfpgValidadorDadosArTests = class(TTestCase)
  private
    FoValidadorDadosAr: TfpgValidadorDadosAr;
    FoDataSetAr: TClientDataSet;
    procedure CriarDataSet;
    // 04/11/2014 - Pio.Neto - Salt: 163917/5
    procedure PopularDataSet(psAutoEnvelopavel: string; pnqtPaginas: integer;
      psnmDest: string = ''; psLogradouro: string = ''; psBairro: string = '';
      psCidade: string = ''; psCEP: string = ''; psEstado: string = ''; const psDocumento: string = '');
    procedure TestFormatoPDFCompatibilidadeException;
    procedure TestFormatoA3InvalidoException;
    procedure TestValidarArAutoenvelopavelSucesso;
    procedure TestARUnipaginadoMaisPaginasException;
    procedure TestArUnipaginadoComAnexosException;
    procedure TestValidarArMultipaginadoSucesso;
    procedure TestFormatoPaisagemInvalidoException;
    procedure TestFormatoCustomInvalidoException;
    procedure TestARLimitePaginasException;
    procedure TestQtdPaginasDiferenteException;
    procedure TestDadosBairroARException;
    procedure TestDadosCEPARException;
    procedure TestDadosDestinatarioARException;
    procedure TestDadosLogradouroARException;
    procedure TestDadosMunicipioARException;
    procedure TestDadosUFARException;
    /// <summary>
    ///  Testar o método ValidarTAmanhoMaximoAR forçando uma exception.
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 04/11/2014 - Pio.Neto - Salt: 163917/5
    /// </remarks>
    procedure TestarValidarTamanhoMaximoException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestValidarPaginasARComSucesso;
    procedure TestValidarPaginasARUnipaginadas;
    procedure TestValidarPaginasArMultipaginado;
    procedure TestValidarDadosDestinatarioARComSucesso;
    procedure TestValidarDadosDestinatarioARVazio;
    procedure TestFormatoPDFInvalido;
    /// <summary>
    ///  Chama o teste para capturar a exception e validar se esta correta
    /// </summary>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 04/11/2014 - Pio.Neto - Salt: 163917/5
    /// </remarks>
    procedure TestarValidarTamanhoMaximoARExcedido;
  end;

implementation

uses
  ufpgErroDadosArException, ufpgErroDadosEspecificosArException;

const
  sPDF_A3 = 'PDFA3.pdf';
  sPDF_CORRETO = 'PDFCorreto.pdf';
  sPDF_PAISAGEM = 'PDFPaisagem.pdf';
  sPDF_CUSTOM = 'PDFCustom.pdf';

{ TfpgValidadorDadosArTests }

procedure TfpgValidadorDadosArTests.CriarDataSet;
begin
  FoDataSetAr.FieldDefs.Add('flAutoEnvelopavel', ftString, 1);
  FoDataSetAr.FieldDefs.Add('qtPaginas', ftInteger);
  FoDataSetAr.FieldDefs.Add('nmDestinatario', ftString, 100);
  FoDataSetAr.FieldDefs.Add('deLogradouroDest', ftString, 100);
  FoDataSetAr.FieldDefs.Add('deBairroDest', ftString, 100);
  FoDataSetAr.FieldDefs.Add('deCidadeDest', ftString, 100);
  FoDataSetAr.FieldDefs.Add('nuCEPDest', ftString, 7);
  FoDataSetAr.FieldDefs.Add('cdUFDest', ftString, 2);
  // 04/11/2014 - Pio.Neto - Salt: 163917/5
  FoDataSetAr.FieldDefs.Add('blDocumento', ftBlob);
  FoDataSetAr.CreateDataSet;
end;

// 04/11/2014 - Pio.Neto - Salt: 163917/5
procedure TfpgValidadorDadosArTests.PopularDataSet(psAutoEnvelopavel: string;
  pnqtPaginas: integer; psnmDest: string = ''; psLogradouro: string = '';
  psBairro: string = ''; psCidade: string = ''; psCEP: string = '';
  psEstado: string = ''; const psDocumento: string = '');
begin
  FoDataSetAr.Append;
  FoDataSetAr.FieldByName('flAutoEnvelopavel').AsString := psAutoEnvelopavel;
  FoDataSetAr.FieldByName('qtPaginas').AsInteger := pnqtPaginas;
  FoDataSetAr.FieldByName('nmDestinatario').AsString := psnmDest;
  FoDataSetAr.FieldByName('deLogradouroDest').AsString := psLogradouro;
  FoDataSetAr.FieldByName('deBairroDest').AsString := psBairro;
  FoDataSetAr.FieldByName('deCidadeDest').AsString := psCidade;
  FoDataSetAr.FieldByName('nuCEPDest').AsString := psCEP;
  FoDataSetAr.FieldByName('cdUFDest').AsString := psEstado;
  // 04/11/2014 - Pio.Neto - Salt: 163917/5
  FoDataSetAr.FieldByName('blDocumento').AsString := psDocumento;
  FoDataSetAr.Post;
end;

procedure TfpgValidadorDadosArTests.SetUp;
begin
  inherited;
  FoValidadorDadosAr := TfpgValidadorDadosAr.Create;  //PC_OK
  FoDataSetAr := TClientDataSet.Create(nil);  //PC_OK
  CriarDataSet;
end;

procedure TfpgValidadorDadosArTests.TearDown;
begin
  inherited;
  FreeAndNil(FoValidadorDadosAr);  //PC_OK
  FreeAndNil(FoDataSetAr);  //PC_OK
end;

procedure TfpgValidadorDadosArTests.TestValidarDadosDestinatarioARComSucesso;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', 'Rua 1', 'Centro', 'São José', '88117-235', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
  CheckEqualsWideString(STRING_INDEFINIDO, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestFormatoPDFCompatibilidadeException;
var
  sArquivoPDF, sCaminhoDoArquivo: string;
begin
  sCaminhoDoArquivo := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) +
    'tests\input\PDF_AR\';
  sArquivoPDF := '0;' + sCaminhoDoArquivo + 'Teste.ZIP';
  FoValidadorDadosAr.ValidarFormatoPDF(sArquivoPDF);
end;

procedure TfpgValidadorDadosArTests.TestValidarPaginasARComSucesso;
begin
  TestValidarArAutoenvelopavelSucesso;
  TestValidarArMultipaginadoSucesso;
end;

procedure TfpgValidadorDadosArTests.TestFormatoPDFInvalido;
begin
  CheckException(TestFormatoPDFCompatibilidadeException, EfpgErroArIncompativelAdobeException,
    'Erro de Compatibilidade');
  CheckException(TestFormatoA3InvalidoException, EfpgFormatoARInvalidoException,
    'Erro de largura do PDF');
  CheckException(TestFormatoPaisagemInvalidoException, EfpgFormatoARInvalidoException,
    'Erro de PDF em paisagem');
  CheckException(TestFormatoCustomInvalidoException, EfpgFormatoARInvalidoException,
    'Erro de comprimento do PDF');
end;

procedure TfpgValidadorDadosArTests.TestFormatoA3InvalidoException;
var
  sCaminhoDoArquivo, sArquivoPDF: string;
begin
  sCaminhoDoArquivo := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) +
    'tests\input\PDF_AR\';
  sArquivoPDF := '0;' + sCaminhoDoArquivo + sPDF_A3;
  FoValidadorDadosAr.ValidarFormatoPDF(sArquivoPDF);
end;

procedure TfpgValidadorDadosArTests.TestValidarArAutoenvelopavelSucesso;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  sMsgErro := STRING_INDEFINIDO;
  nPgZip := 1;
  nPgAnexo := 0;
  PopularDataSet('S', 1);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
  CheckEqualsWideString(STRING_INDEFINIDO, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestValidarArMultipaginadoSucesso;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  sMsgErro := STRING_INDEFINIDO;
  nPgZip := 2;
  nPgAnexo := 0;
  PopularDataSet('N', 2);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
  CheckEqualsWideString(STRING_INDEFINIDO, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestFormatoPaisagemInvalidoException;
var
  sCaminhoDoArquivo, sArquivoPDF: string;
begin
  sCaminhoDoArquivo := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) +
    'tests\input\PDF_AR\';
  sArquivoPDF := '0;' + sCaminhoDoArquivo + sPDF_PAISAGEM;
  FoValidadorDadosAr.ValidarFormatoPDF(sArquivoPDF);
end;

procedure TfpgValidadorDadosArTests.TestFormatoCustomInvalidoException;
var
  sCaminhoDoArquivo, sArquivoPDF: string;
begin
  sCaminhoDoArquivo := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) +
    'tests\input\PDF_AR\';
  sArquivoPDF := '0;' + sCaminhoDoArquivo + sPDF_CUSTOM;
  FoValidadorDadosAr.ValidarFormatoPDF(sArquivoPDF);
end;

procedure TfpgValidadorDadosArTests.TestARUnipaginadoMaisPaginasException;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  sMsgErro := STRING_INDEFINIDO;
  nPgZip := 0;
  nPgAnexo := 0;
  PopularDataSet('S', 2);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestArUnipaginadoComAnexosException;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  nPgZip := 0;
  nPgAnexo := 2;
  PopularDataSet('S', 1);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestARLimitePaginasException;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  nPgZip := 91;
  nPgAnexo := 0;
  PopularDataSet('N', 91);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestQtdPaginasDiferenteException;
var
  nPgZip, nPgAnexo: integer;
  sMsgErro: WideString;
begin
  nPgZip := 5;
  nPgAnexo := 0;
  PopularDataSet('N', 3);
  FoValidadorDadosAr.ValidarPaginasAR(FoDataSetAr, nPgZip, nPgAnexo, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestValidarPaginasARUnipaginadas;
begin
  CheckException(TestARUnipaginadoMaisPaginasException, EfpgARUnipaginadoMaisPaginasException,
    'Documento unipaginado com mais páginas');
  CheckException(TestArUnipaginadoComAnexosException, EfpgErroArUnipaginadoComAnexosException,
    'Documento unipaginado com anexos');
end;

procedure TfpgValidadorDadosArTests.TestValidarPaginasArMultipaginado;
begin
  CheckException(TestARLimitePaginasException, EfpgErroARLimitePaginasException,
    'Documento com muitas páginas');
  CheckException(TestQtdPaginasDiferenteException, EfpgErroDadosArQtdPaginasDiferenteException,
    'Documento com páginas diferente do indicado');
end;

procedure TfpgValidadorDadosArTests.TestValidarDadosDestinatarioARVazio;
begin
  CheckException(TestDadosDestinatarioARException, EfpgDadosDestinatarioARException,
    'Nome do destinatário vazio');
  CheckException(TestDadosLogradouroARException, EfpgDadosLogradouroARException,
    'Logradouro vazio');
  CheckException(TestDadosBairroARException, EfpgDadosBairroARException, 'Bairro vazio');
  CheckException(TestDadosMunicipioARException, EfpgDadosMunicipioARException, 'Municipio vazio');
  CheckException(TestDadosCEPARException, EfpgDadosCEPARException, 'CEP vazio');
  CheckException(TestDadosUFARException, EfpgDadosUFARException, 'UF vazio');
end;

procedure TfpgValidadorDadosArTests.TestDadosBairroARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', 'Rua 1', '', 'São José', '88117-235', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestDadosCEPARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', 'Rua 1', 'Centro', 'São José', '', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestDadosDestinatarioARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, '', 'Rua 1', 'Centro', 'São José', '88117-235', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestDadosLogradouroARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', '', 'Centro', 'São José', '88117-235', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestDadosMunicipioARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', 'Rua 1', 'Centro', '', '88117-235', 'SC');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

procedure TfpgValidadorDadosArTests.TestDadosUFARException;
var
  sMsgErro: WideString;
begin
  PopularDataSet('S', 1, 'Maico', 'Rua 1', 'Centro', 'São José', '88117-235', '');
  FoValidadorDadosAr.ValidarDadosDestinatarioAR(FoDataSetAr, sMsgErro);
end;

// 04/11/2014 - Pio.Neto - Salt: 163917/5
procedure TfpgValidadorDadosArTests.TestarValidarTamanhoMaximoException;
const
  sCONTEUDO = 'Campo Blob com mais de 1K';

var
  oFld: TField;
  sConteudoCampo: string;
  oStream: TMemoryStream;

begin
  oStream := TMemoryStream.Create;
  try
    while oStream.Size < 2048 do
    begin
      oStream.WriteBuffer(sCONTEUDO, oStream.Size + Length(sCONTEUDO));
    end;

    SetLength(sConteudoCampo, oStream.Size);
    Move(oStream.memory^, sConteudoCampo[1], oStream.Size);
    PopularDataSet(sFLAG_NAO, 1, STRING_INDEFINIDO, STRING_INDEFINIDO, STRING_INDEFINIDO, 
      STRING_INDEFINIDO, STRING_INDEFINIDO, STRING_INDEFINIDO, sConteudoCampo);
    oFld := FoDataSetAr.FindField('blDocumento');
    FoValidadorDadosAr.ValidarTamanhoMaximoAR(1, oFld);
  finally
    FreeAndNil(oStream);
  end;
end;

// 04/11/2014 - Pio.Neto - Salt: 163917/5
procedure TfpgValidadorDadosArTests.TestarValidarTamanhoMaximoARExcedido;
begin
  CheckException(TestarValidarTamanhoMaximoException, EfpgErroDadosARTamanhoMaximoException,
    'Tamanho');
end;

initialization

  TestFrameWork.RegisterTest('Unitário\PG5\Componentes\ValidadorDadosAr',
    TfpgValidadorDadosArTests.Suite);

end.

