unit ufpgControleUsuarioNetTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, DB, DBClient,
  ufpgControleUsuarioNet, uspTestCase;

type
  TfpgControleUsuarioNetTest = class(TspTestCase)
  private
    FoControleUsuarioNet: TfpgControleUsuarioNet;
    procedure TestarInserirUsuarioMNIComDataInvalidoException;
    procedure TestarInserirUsuarioMNIComConvenioNaoPreenchidoException;
    procedure TestarInserirUsuarioMNISemCampoConvenioException;
    procedure TestarInserirUsuarioMNISemCampoCNPJException;
    function DefinirDataSetPadrao: TClientDataSet;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarInserirUsuarioMNIComDataInvalido;
    procedure TestarInserirUsuarioMNIComConvenioNaoPreenchido;
    procedure TestarInserirUsuarioMNISemCampoConvenio;
    procedure TestarInserirUsuarioMNISemCampoCNPJ;
  end;

implementation

uses
  uspProblemaTecnicoException;

procedure TfpgControleUsuarioNetTest.SetUp;
begin
  FoControleUsuarioNet := TfpgControleUsuarioNet.Create(nil); //PC_OK
end;

procedure TfpgControleUsuarioNetTest.TearDown;
begin
  if Assigned(FoControleUsuarioNet) then
    FreeAndNil(FoControleUsuarioNet); //PC_OK
end;

function TfpgControleUsuarioNetTest.DefinirDataSetPadrao: TClientDataSet;
begin
  result := TClientDataSet.Create(nil); //PC_OK
  result.FieldDefs.Add('DECONVENIO', ftString, 50);
  result.FieldDefs.Add('NUCNPJ', ftString, 50);
  result.FieldDefs.Add('CDUSUARIONET', ftString, 50);
  result.CreateDataSet;
  result.Open;
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNIComDataInvalido;
begin
  CheckException(TestarInserirUsuarioMNIComDataInvalidoException, EspProblemaTecnicoException,
    'Dataset não criado.');
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNIComDataInvalidoException;
begin
  FoControleUsuarioNet.InserirUsuarioMNI(nil);
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNIComConvenioNaoPreenchido;
begin
  CheckException(TestarInserirUsuarioMNIComConvenioNaoPreenchidoException,
    EspProblemaTecnicoException, 'Descrição do convenio não preenchido.');
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNIComConvenioNaoPreenchidoException;
var
  cdsDados: TClientDataSet;
begin
  cdsDados := DefinirDataSetPadrao;
  try
    FoControleUsuarioNet.InserirUsuarioMNI(cdsDados);
  finally
    FreeAndNil(cdsDados);  //PC_OK
  end;
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNISemCampoConvenio;
begin
  CheckException(TestarInserirUsuarioMNISemCampoConvenioException,
    EspProblemaTecnicoException, 'Campo "Descrição" deve ser preenchido.');
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNISemCampoConvenioException;
var
  cdsDados: TClientDataSet;
begin
  cdsDados := TClientDataSet.Create(nil);
  try
    FoControleUsuarioNet.InserirUsuarioMNI(cdsDados);
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNISemCampoCNPJ;
begin
  CheckException(TestarInserirUsuarioMNISemCampoCNPJException, EspProblemaTecnicoException,
    'Campo "NUCNPJ" deve ser preenchido.');
end;

procedure TfpgControleUsuarioNetTest.TestarInserirUsuarioMNISemCampoCNPJException;
var
  cdsDados: TClientDataSet;
begin
  cdsDados := TClientDataSet.Create(nil);
  cdsDados.FieldDefs.Add('DECONVENIO', ftString, 50);
  cdsDados.CreateDataSet;
  cdsDados.Open;
  cdsDados.Edit;
  cdsDados.FieldByName('DECONVENIO').AsString := 'Agora ta preenchido.';
  cdsDados.Post;
  try
    FoControleUsuarioNet.InserirUsuarioMNI(cdsDados);
  finally
    FreeAndNil(cdsDados);
  end;
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Componentes\ufpgControleUsuarioNetTest',
    TfpgControleUsuarioNetTest.Suite);

end.
