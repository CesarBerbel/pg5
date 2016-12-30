unit ufpgUsuarioValidacaoCPFTests;

interface

uses
  TestFrameWork, Windows, Forms, FutureWindows, SysUtils, DB, DBClient,
  uspClientDataSet, ufpgUsuarioValidacaoCPF, ufpgUsuarioValidacaoCPFFake;

type
  TfpgUsuarioValidacaoCPFTests = class(TTestCase)
  private
    FoUsuarioValidacaoCPF: TfpgUsuarioValidacaoCPFFake;
    procedure CriarEstruturaDatasetDadosUsuario(var pcdsDadosUsuario: TspClientDataSet);
    procedure CriarEstruturaDataSetDadosUsuarioEnvio(pcdsDadosUsuario: TspClientDataSet);
    procedure PopularDatasetDadosUsuario(var pcdsDadosUsuario: TspClientDataSet);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestCPFValido;
    procedure TestCPFNaoValido;
    procedure TestCPFNaoValidoAlteracaoFlagForaUso;
    procedure TestCPFNaoValidoOk;
    procedure TestCPFNaoValidoLimpar;
    procedure TestCPFNaoValidoCancelar;

    procedure TestLoginCPFValido;
    procedure TestLoginCPFNaoValido;
  end;

implementation

uses
  uspExcecao, uspTestCase, usajConstante, usegUsuario, uspMensagem;

{ TfpgUsuarioValidacaoCPFTests }

procedure TfpgUsuarioValidacaoCPFTests.CriarEstruturaDatasetDadosUsuario(
  var pcdsDadosUsuario: TspClientDataSet);
begin
  pcdsDadosUsuario.Close;
  pcdsDadosUsuario.FieldDefs.Clear;
  pcdsDadosUsuario.FieldDefs.Add('CDUSUARIO', ftString, 15);
  pcdsDadosUsuario.FieldDefs.Add('NMUSUARIO', ftString, 100);
  pcdsDadosUsuario.FieldDefs.Add('FLFORAUSO', ftString, 1);
  pcdsDadosUsuario.FieldDefs.Add('NUCPF', ftString, 11);
  pcdsDadosUsuario.CreateDataSet;

  pcdsDadosUsuario.Active := True;
end;

procedure TfpgUsuarioValidacaoCPFTests.CriarEstruturaDataSetDadosUsuarioEnvio(
  pcdsDadosUsuario: TspClientDataSet);
begin
  pcdsDadosUsuario.Close;
  pcdsDadosUsuario.FieldDefs.Clear;
  pcdsDadosUsuario.FieldDefs.Add('CDUSUARIO', ftString, 15);
  pcdsDadosUsuario.FieldDefs.Add('FLFORAUSO', ftString, 1);
  pcdsDadosUsuario.CreateDataSet;

  pcdsDadosUsuario.Active := True;
end;

procedure TfpgUsuarioValidacaoCPFTests.PopularDatasetDadosUsuario(
  var pcdsDadosUsuario: TspClientDataSet);
begin
  TspTestCase.AppendStringList(pcdsDadosUsuario, 'USUARIO001,USUARIO_001,S,32205532227');
  TspTestCase.AppendStringList(pcdsDadosUsuario, 'USUARIO002,USUARIO_002,S,32205532227');

  TspTestCase.AppendStringList(pcdsDadosUsuario, 'USUARIO003,USUARIO_003,S,62686915803');
  TspTestCase.AppendStringList(pcdsDadosUsuario, 'USUARIO004,USUARIO_004,N,62686915803');
end;

procedure TfpgUsuarioValidacaoCPFTests.SetUp;
var
  cdsDadosUsuario: TspClientDataSet;
begin
  FoUsuarioValidacaoCPF := TfpgUsuarioValidacaoCPFFake.Create(nil); //PC_OK

  cdsDadosUsuario := TspClientDataSet.Create(nil); //PC_OK

  CriarEstruturaDatasetDadosUsuario(cdsDadosUsuario);

  PopularDatasetDadosUsuario(cdsDadosUsuario);

  FoUsuarioValidacaoCPF.fpgDadosUsuario := cdsDadosUsuario;

  inherited;
end;

procedure TfpgUsuarioValidacaoCPFTests.TearDown;
begin
  FoUsuarioValidacaoCPF.Free; //PC_OK

  inherited;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFNaoValido;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '62686915803';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_NAO);

    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfNaoOk,
      'Deveria retornar trvCpfNaoOkLimpar, pois simula que o cpf ja está cadastrado para outro usuário'
      );
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFNaoValidoAlteracaoFlagForaUso;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '62686915803';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_SIM);

    cdsDadosUsuario.Edit;
    cdsDadosUsuario.FieldByName('FLFORAUSO').AsString := sFLAG_NAO;
    cdsDadosUsuario.Post;

    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfNaoOk,
      'Deveria retornar trvCpfNaoOkLimpar, pois simula que o cpf ja está cadastrado para outro usuário'
      );
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFNaoValidoCancelar;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '32205532227';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_NAO);

    FoUsuarioValidacaoCPF.fpgRespostaMensagem := s_pbCancelar;
    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfNaoOk,
      'Deveria retornar trvCpfNaoOkLimpar, pois simula que o cpf ja está cadastrado para outro usuário'
      );
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFNaoValidoLimpar;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '32205532227';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_NAO);

    FoUsuarioValidacaoCPF.fpgRespostaMensagem := s_pbNao;
    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfNaoOkLimpar,
      'Deveria retornar trvCpfNaoOkLimpar, pois simula que o cpf ja está cadastrado para outro usuário'
      );
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFNaoValidoOk;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '32205532227';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_NAO);

    FoUsuarioValidacaoCPF.fpgRespostaMensagem := s_pbSim;
    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfOk,
      'Deveria retornar trvCpfOk, pois simula que o cpf não está cadastrado para outro usuário');
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestCPFValido;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '69461548354';
begin
  CheckTrue(FoUsuarioValidacaoCPF.ValidarCPF(sCODIGO_USUARIO, sCPF_USUARIO, nil) = trvCpfOk,
    'Deveria retornar trvCpfOk, pois simula que o cpf não está cadastrado para outro usuário');
end;

procedure TfpgUsuarioValidacaoCPFTests.TestLoginCPFNaoValido;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '62686915803';
var
  cdsDadosUsuario: TspClientDataSet;
begin
  cdsDadosUsuario := TspClientDataSet.Create(nil);
  try
    CriarEstruturaDataSetDadosUsuarioEnvio(cdsDadosUsuario);

    TspTestCase.AppendStringList(cdsDadosUsuario, sCODIGO_USUARIO + ',' + sFLAG_NAO);

    CheckTrue(FoUsuarioValidacaoCPF.ValidarCPFLogin(sCODIGO_USUARIO, sCPF_USUARIO,
      TesegUsuario(cdsDadosUsuario)) = trvCpfNaoOk,
      'Deveria retornar trvCpfNaoOk, pois simula que o cpf ja está cadastrado para outro usuário');
  finally
    FreeAndNil(cdsDadosUsuario);
  end;
end;

procedure TfpgUsuarioValidacaoCPFTests.TestLoginCPFValido;
const
  sCODIGO_USUARIO = 'USUARIO999';
  sCPF_USUARIO = '69461548354';
begin
  CheckTrue(FoUsuarioValidacaoCPF.ValidarCPFLogin(sCODIGO_USUARIO, sCPF_USUARIO, nil) = trvCpfOk,
    'Deveria retornar trvCpfOk, pois simula que o cpf não está cadastrado para outro usuário');
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgUsuarioValidacaoCPFTests',
    TfpgUsuarioValidacaoCPFTests.Suite);

end.

