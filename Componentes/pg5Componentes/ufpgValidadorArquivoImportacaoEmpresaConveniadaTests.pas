unit ufpgValidadorArquivoImportacaoEmpresaConveniadaTests;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  TestFrameWork, ufpgValidadorArquivoImportacaoEmpresaConveniada,
  ufpgRegistroArquivoImportacaoEmpresaConveniada;

type
  TfpgValidadorArquivoImportacaoEmpresaConveniadaFake = class(
    TfpgValidadorArquivoImportacaoEmpresaConveniada)
  protected
    procedure ValidarArquivo(pslArquivo: TStringList); override;
    function CriarRegistroArquivoImportacaoEmpresaConveniada: TfpgRegistroArquivoImportacaoEmpresaConveniada; override;
  end;

type
  TfpgValidadorArquivoImportacaoEmpresaConveniadaTests = class(TTestCase)
  private
    FoValidadorArquivoImportacaoEmpresaConveniada: TfpgValidadorArquivoImportacaoEmpresaConveniadaFake;
    procedure TestTestarFormatoArquivoImportacaoArquivoInvalidoException;
    procedure TestTestarFormatoArquivoImportacaoExtensaoInvalidaException;
    procedure TestTestarFormatoArquivoImportacaoExtensaoValidaException;
    procedure CriarArquivo(pbArquivoValido: boolean);
    procedure TestTestarConteudoArquivoImportacaoValidoArquivoVazioException;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    //Test methods
    procedure TestTestarFormatoArquivoImportacaoArquivoInvalido;
    procedure TestTestarFormatoArquivoImportacaoExtensaoInvalida;
    procedure TestTestarFormatoArquivoImportacaoExtensaoValida;

    procedure TestTestarConteudoArquivoImportacaoValidoArquivoVazio;
    procedure TestTestarConteudoArquivoImportacaoValidoArquivoValido;
  end;

implementation

uses
  uspExcecao, usajConstante;

const
  sCAMINHO_ARQUIVO = 'c:\TestarImportarArquivo.txt';
  sLINHA_1 = '00|SABESP|01463762000197|Avenida das Empresas|100||Centro|88015260|São Paulo|SP';
  sLINHA_2 = '01|50000';
  sLINHA_3 =
    '02|João da Silva|1|11111111111|1|Avenida das Partes|555|Bloco A Apto.604|Centro|88015201|São Paulo|SP';


{ TfpgValidadorArquivoImportacaoEmpresaConveniadaFake }

function TfpgValidadorArquivoImportacaoEmpresaConveniadaFake.
CriarRegistroArquivoImportacaoEmpresaConveniada: TfpgRegistroArquivoImportacaoEmpresaConveniada;
var
  vspDB: olevariant;
begin
  vspDB := null;
  result := TfpgRegistroArquivoImportacaoEmpresaConveniada.Create(vspDB); //PC_OK
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaFake.ValidarArquivo(
  pslArquivo: TStringList);
begin
  Exit;
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.SetUp;
var
  vspDB: olevariant;
begin
  vspDB := null;
  FoValidadorArquivoImportacaoEmpresaConveniada := TfpgValidadorArquivoImportacaoEmpresaConveniadaFake.Create(vspDB); //PC_OK
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.TearDown;
begin
  FreeAndNil(FoValidadorArquivoImportacaoEmpresaConveniada); //PC_OK
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoExtensaoValida;
begin
  CheckException(TestTestarFormatoArquivoImportacaoExtensaoValidaException, nil);
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoExtensaoValidaException;
begin
  FoValidadorArquivoImportacaoEmpresaConveniada.TestarFormatoArquivoImportacao('texto.txt');
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoExtensaoInvalida;
begin
  CheckException(TestTestarFormatoArquivoImportacaoExtensaoInvalidaException, EspRegraNegocio);
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoExtensaoInvalidaException;
begin
  FoValidadorArquivoImportacaoEmpresaConveniada.TestarFormatoArquivoImportacao('text.pdf');
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoArquivoInvalido;
begin
  CheckException(TestTestarFormatoArquivoImportacaoArquivoInvalidoException, EspRegraNegocio);
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarFormatoArquivoImportacaoArquivoInvalidoException;
begin
  FoValidadorArquivoImportacaoEmpresaConveniada.TestarFormatoArquivoImportacao('');
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.CriarArquivo(
  pbArquivoValido: boolean);
var
  oArquivo: TextFile;
begin
  AssignFile(oArquivo, sCAMINHO_ARQUIVO);
  Rewrite(oArquivo);
  try
    if not pbArquivoValido then
      Exit;
    writeln(oArquivo, sLINHA_1);
    writeln(oArquivo, sLINHA_2);
    writeln(oArquivo, sLINHA_3);
  finally
    CloseFile(oArquivo)
  end;
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarConteudoArquivoImportacaoValidoArquivoValido;
var
  oArquivoStream: TMemoryStream;
begin
  oArquivoStream := TMemoryStream.Create;
  try
    CriarArquivo(True);
    oArquivoStream.LoadFromFile(sCAMINHO_ARQUIVO);
    FoValidadorArquivoImportacaoEmpresaConveniada.TestarConteudoArquivoImportacaoValido(
      oArquivoStream);
    DeleteFile(sCAMINHO_ARQUIVO);
  finally
    FreeAndNil(oArquivoStream);
  end;
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarConteudoArquivoImportacaoValidoArquivoVazio;
begin
  CheckException(TestTestarConteudoArquivoImportacaoValidoArquivoVazioException, EspRegraNegocio);
end;

procedure TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.
TestTestarConteudoArquivoImportacaoValidoArquivoVazioException;
var
  oArquivoStream: TMemoryStream;
begin
  oArquivoStream := TMemoryStream.Create;
  try
    CriarArquivo(False);
    oArquivoStream.LoadFromFile(sCAMINHO_ARQUIVO);
    FoValidadorArquivoImportacaoEmpresaConveniada.TestarConteudoArquivoImportacaoValido(
      oArquivoStream);
    DeleteFile(sCAMINHO_ARQUIVO);
  finally
    FreeAndNil(oArquivoStream);
  end;
end;

initialization

  TestFrameWork.RegisterTest(
    'Unitário\PG5\Componentes\ufpgValidadorArquivoImportacaoEmpresaConveniadaTests',
    TfpgValidadorArquivoImportacaoEmpresaConveniadaTests.Suite);

end.
