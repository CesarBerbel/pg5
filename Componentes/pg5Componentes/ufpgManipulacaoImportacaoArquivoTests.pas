unit ufpgManipulacaoImportacaoArquivoTests;

interface

uses
  ufpgManipulacaoImportacaoArquivo, TestFrameWork, Windows, Forms, FutureWindows,
  SysUtils, uspConjuntoDados, DBClient, DB, uspExcecao, usajConstante, Classes,
  ufpgParametrosArquivoImportacao;

type
  TfpgManipulacaoImportacaoArquivoFake = class(TfpgManipulacaoImportacaoArquivo)
  private
    FoDataSetDadosArquivo: TspConjuntoDados;
  protected
    function PegarDataAtual: TDateTime; override;
    function CriarConjuntoDadosArqImporta: TspConjuntoDados; override;
    procedure InicializarInsercaoConjuntoDados(poArqImportaInsert: TspConjuntoDados); override;
    function PegarForoUsuario: integer; override;
    function PegarUsuarioLotado: string; override;
    procedure SalvarConjuntoDados(poArqImportaInsert: TspConjuntoDados); override;
    procedure ValidarArquivo(poArquivoStream: TMemoryStream; psCaminhoArquivo: string); override;
  public
    property fpgDataSetDadosArquivo: TspConjuntoDados 
      read FoDataSetDadosArquivo   write FoDataSetDadosArquivo;
  end;

type
  TfpgManipulacaoImportacaoArquivoTests = class(TTestCase)
  private
    FoManipulacaoImportacaoArquivo: TfpgManipulacaoImportacaoArquivoFake;
    procedure CriarArquivo;
    procedure TestImportarArquivoArquivoInexistenteException;
    function TestarImportarArquivoPeticaoIntermediaria: boolean;
    function TestarImportarArquivoEmpresaConveniada: boolean;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //Test methods
    procedure TestImportarArquivoPeticaoIntermediariaComSucesso;
    procedure TestImportarArquivoEmpresaConveniadaComSucesso;
    procedure TestImportarArquivoArquivoInexistente;
  end;

implementation

uses
  ufpgTpArqImporta;

const
  nCD_FORO = 23;
  sUSUARIO_SOFTPLAN = 'SOFTPLAN';
  sDATA_RETORNO = '17/10/2013 08:00:00';
  sNOME_ARQUIVO = 'ArquivoFormatado';

  sLINHA_1 = '00|SABESP|01463762000197|Avenida das Empresas|100||Centro|88015260|São Paulo|SP';
  sLINHA_2 = '01|50000';
  sLINHA_3 =
    '02|João da Silva|1|11111111111|1|Avenida das Partes|555|Bloco A Apto.604|Centro|88015201|São Paulo|SP';

  sARQUIVO = 'c:\TestarImportarArquivo.txt';
  sARQUIVO_INEXISTENTE = 'c:\ArquivoNaoExiste.txt';

{ TfpgManipulacaoImportacaoArquivoFake }

function TfpgManipulacaoImportacaoArquivoFake.CriarConjuntoDadosArqImporta: TspConjuntoDados;
begin
  FoDataSetDadosArquivo := TspConjuntoDados.Create(nil); //pc_ok
  FoDataSetDadosArquivo.FieldDefs.Add('CDARQIMPORTA', ftString, 5, True);
  FoDataSetDadosArquivo.FieldDefs.Add('CDTPARQIMPORTA', ftInteger);
  FoDataSetDadosArquivo.FieldDefs.Add('NMARQIMPORTA', ftString, 256, True);
  FoDataSetDadosArquivo.FieldDefs.Add('BLARQIMPORTA', ftBlob);
  FoDataSetDadosArquivo.FieldDefs.Add('FLARQPROCESSADO', ftString, 1, True);
  FoDataSetDadosArquivo.FieldDefs.Add('CDVARA', ftInteger);
  FoDataSetDadosArquivo.FieldDefs.Add('CDTIPOCARTORIO', ftInteger);
  FoDataSetDadosArquivo.FieldDefs.Add('CDCLASSE', ftInteger);
  FoDataSetDadosArquivo.FieldDefs.Add('CDASSUNTO', ftInteger);
  FoDataSetDadosArquivo.FieldDefs.Add('CDFORO', ftInteger);

  FoDataSetDadosArquivo.CreateDataSet;
  FoDataSetDadosArquivo.EmptyDataSet;
  result := FoDataSetDadosArquivo;
end;

procedure TfpgManipulacaoImportacaoArquivoFake.InicializarInsercaoConjuntoDados(
  poArqImportaInsert: TspConjuntoDados);
begin
  poArqImportaInsert.Insert;
  poArqImportaInsert.FieldByName('CDARQIMPORTA').AsString := '1';
  poArqImportaInsert.FieldByName('FLARQPROCESSADO').AsString := sFLAG_SIM;
end;

function TfpgManipulacaoImportacaoArquivoFake.PegarDataAtual: TDateTime;
begin
  result := StrToDateTime(sDATA_RETORNO);
end;

function TfpgManipulacaoImportacaoArquivoFake.PegarForoUsuario: integer;
begin
  result := nCD_FORO;
end;

function TfpgManipulacaoImportacaoArquivoFake.PegarUsuarioLotado: string;
begin
  result := sUSUARIO_SOFTPLAN;
end;

procedure TfpgManipulacaoImportacaoArquivoFake.SalvarConjuntoDados(
  poArqImportaInsert: TspConjuntoDados);
begin
  poArqImportaInsert.Post;
  FoDataSetDadosArquivo.Data := poArqImportaInsert.Data;
end;

procedure TfpgManipulacaoImportacaoArquivoFake.ValidarArquivo(poArquivoStream: TMemoryStream;
  psCaminhoArquivo: string);
begin
  exit;
end;

{ TfpgManipulacaoImportacaoArquivoTests }

procedure TfpgManipulacaoImportacaoArquivoTests.SetUp;
begin
  inherited;
  FoManipulacaoImportacaoArquivo := TfpgManipulacaoImportacaoArquivoFake.Create(); //PC_OK
end;

procedure TfpgManipulacaoImportacaoArquivoTests.TearDown;
begin
  inherited;
  FreeAndNil(FoManipulacaoImportacaoArquivo);//PC_OK
end;

procedure TfpgManipulacaoImportacaoArquivoTests.CriarArquivo;
var
  oArquivo: TextFile;
begin
  AssignFile(oArquivo, sARQUIVO);
  Rewrite(oArquivo);
  try
    writeln(oArquivo, sLINHA_1);
    writeln(oArquivo, sLINHA_2);
    writeln(oArquivo, sLINHA_3);
  finally
    CloseFile(oArquivo)
  end;
end;

procedure TfpgManipulacaoImportacaoArquivoTests.TestImportarArquivoPeticaoIntermediariaComSucesso;
begin
  CriarArquivo;
  CheckTrue(TestarImportarArquivoPeticaoIntermediaria);
  DeleteFile(sARQUIVO);
end;

function TfpgManipulacaoImportacaoArquivoTests.TestarImportarArquivoPeticaoIntermediaria: boolean;
var
  oParametros: TfpgParametrosArquivoImportacao;
begin
  result := True;
  oParametros := TfpgParametrosArquivoImportacao.Create();
  try
    try
      oParametros.fpgNomeArquivo := sARQUIVO;
      oParametros.fpgCdForo := 666;
      oParametros.fpgCdVara := 2;
      oParametros.fpgCdTipoCartorio := 1;
      oParametros.fpgCdClasse := 889;
      oParametros.fpgCdAssunto := 4960;
      oParametros.fpgCdTpArqImporta := nTIPOARQUIVOIMPORTACAO_PETICAO_INTERMEDIARIA;
      FoManipulacaoImportacaoArquivo.ImportarArquivo(oParametros);
    except
      result := False;
    end;
  finally
    FreeAndNil(oParametros);
  end;
end;

procedure TfpgManipulacaoImportacaoArquivoTests.TestImportarArquivoEmpresaConveniadaComSucesso;
begin
  CriarArquivo;
  CheckTrue(TestarImportarArquivoEmpresaConveniada);
  DeleteFile(sARQUIVO);
end;

function TfpgManipulacaoImportacaoArquivoTests.TestarImportarArquivoEmpresaConveniada: boolean;
var
  oParametros: TfpgParametrosArquivoImportacao;
begin
  result := True;
  oParametros := TfpgParametrosArquivoImportacao.Create();
  try
    try
      oParametros.fpgNomeArquivo := sARQUIVO;
      oParametros.fpgCdVara := 2;
      oParametros.fpgCdTipoCartorio := 1;
      oParametros.fpgCdClasse := 889;
      oParametros.fpgCdAssunto := 4960;
      oParametros.fpgCdTpArqImporta := nTIPOARQUIVOIMPORTACAO_EMPRESA_CONVENIADA;
      FoManipulacaoImportacaoArquivo.ImportarArquivo(oParametros);
    except
      result := False;
    end;
  finally
    FreeAndNil(oParametros);
  end;
end;

procedure TfpgManipulacaoImportacaoArquivoTests.TestImportarArquivoArquivoInexistente;
begin
  CheckException(TestImportarArquivoArquivoInexistenteException, EspRegraNegocio);
end;

procedure TfpgManipulacaoImportacaoArquivoTests.TestImportarArquivoArquivoInexistenteException;
var
  oParametros: TfpgParametrosArquivoImportacao;
begin
  oParametros := TfpgParametrosArquivoImportacao.Create();
  try
    oParametros.fpgNomeArquivo := sARQUIVO_INEXISTENTE;
    FoManipulacaoImportacaoArquivo.ImportarArquivo(oParametros);
  finally
    FreeAndNil(oParametros);
  end;
end;

initialization

  TestFrameWork.RegisterTest('Unitário\PG5\Componentes\ManipulacaoimportacaoArquivo',
    TfpgManipulacaoImportacaoArquivoTests.Suite);

end.
