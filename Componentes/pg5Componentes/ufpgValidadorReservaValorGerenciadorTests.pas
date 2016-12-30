unit ufpgValidadorReservaValorGerenciadorTests;

interface

uses
  TestFrameWork, ufpgValidadorReservaValorGerenciadorFake, uspClientDataSet, DB,
  DBClient, uspTestCase;

type
  TfpgValidadorReservaValorGerenciadorTests = class(TSpTestCase)
  private
    FoValidadorReservaValorGerenciador: TfpgValidadorReservaValorGerenciadorFake;
    procedure DefinirDadosFakeBasicos;
    procedure CriarDataSetEnvio;
    procedure CriarDataSetTela;
    procedure PopularDadosTela;
  protected
    FcdsEnvio: TSpClientDataSet;
    FcdsTela: TClientDataSet;
    procedure SetUp; override;
    procedure TearDown; override;

  published
    procedure TestValidarReservaValorSemIntegracao;
    procedure TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioSim;
    procedure TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioCancelar;
    procedure TestValidarReservaValorComIntegracaoDocNaoMandado;
    procedure TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioNao;

  end;

implementation

uses
  SysUtils, uspExcecao;

{ TfpgValidadorReservaValorGerenciadorTests }

procedure TfpgValidadorReservaValorGerenciadorTests.SetUp;
begin
  inherited;
  FoValidadorReservaValorGerenciador := TfpgValidadorReservaValorGerenciadorFake.Create(nil); //PC_OK
  DefinirDadosFakeBasicos;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.DefinirDadosFakeBasicos;
begin
  CriarDataSetTela;
  CriarDataSetEnvio;
  FoValidadorReservaValorGerenciador.fpgFakeTesteAtual := FTestName;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.PopularDadosTela;
begin
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK1);
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK2);
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK3);
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK4);
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK5);
  AppendStringList(TSpClientDataSet(fcdsTela), sDOCOK2);
end;

procedure TfpgValidadorReservaValorGerenciadorTests.TearDown;
begin
  inherited;
  FreeAndNil(FoValidadorReservaValorGerenciador); //PC_OK
end;

procedure TfpgValidadorReservaValorGerenciadorTests.TestValidarReservaValorSemIntegracao;
begin
  PopularDadosTela;
  FoValidadorReservaValorGerenciador.ValidarReservaValor;

  while not fcdsTela.EOF do
  begin
    fcdsEnvio.Append;
    fcdsEnvio.FieldByName('CDDOCUMENTO').Assign(fcdsTela.FieldByName('CDDOCUMENTO'));
    FoValidadorReservaValorGerenciador.DefinirSeGeraAuditoriaReservaValorParaMandado(
      fcdsEnvio, fcdsTela);
    fcdsEnvio.post;
    fcdsTela.Next;
  end;

  fcdsEnvio.First;
  while not FcdsEnvio.EOF do
  begin
    CheckFalse(fcdsEnvio.FieldByName('FLGERARAUDITRESERVAVALOR').AsBoolean);
    fcdsEnvio.Next;
  end;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.
TestValidarReservaValorComIntegracaoDocNaoMandado;
const
  sDOC_FAKE = '000XXXXX';
begin
  fcdsTela.Append;
  AppendStringList(TSpClientDataSet(FcdsTela), sDOC_FAKE);

  FoValidadorReservaValorGerenciador.ValidarReservaValor;

  while not fcdsTela.EOF do
  begin
    fcdsEnvio.Append;
    fcdsEnvio.FieldByName('CDDOCUMENTO').Assign(fcdsTela.FieldByName('CDDOCUMENTO'));
    FoValidadorReservaValorGerenciador.DefinirSeGeraAuditoriaReservaValorParaMandado(
      fcdsEnvio, fcdsTela);
    fcdsEnvio.post;
    fcdsTela.Next;
  end;

  fcdsEnvio.First;
  while not FcdsEnvio.EOF do
  begin
    CheckFalse(fcdsEnvio.FieldByName('FLGERARAUDITRESERVAVALOR').AsBoolean);
    fcdsEnvio.Next;
  end;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.CriarDataSetEnvio;
begin
  FcdsEnvio := TSpClientDataSet.Create(nil); //PC_OK
  FcdsEnvio.FieldDefs.Add('CDDOCUMENTO', ftString, 20);
  FcdsEnvio.FieldDefs.Add('FLGERARAUDITRESERVAVALOR', ftBoolean);
  FcdsEnvio.CreateDataSet;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.CriarDataSetTela;
begin
  FcdsTela := TClientDataSet.Create(nil); //PC_OK

  FcdsTela.FieldDefs.Add('CDDOCUMENTO', FtString, 20);
  FcdsTela.CreateDataSet;
end;

procedure TfpgValidadorReservaValorGerenciadorTests.
TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioSim;
begin
  PopularDadosTela;
  CheckException(FoValidadorReservaValorGerenciador.ValidarReservaValor, EspRegraNegocio);
end;

procedure TfpgValidadorReservaValorGerenciadorTests.
TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioCancelar;
begin
  PopularDadosTela;
  CheckException(FoValidadorReservaValorGerenciador.ValidarReservaValor, EspRegraNegocio);
end;

procedure TfpgValidadorReservaValorGerenciadorTests.
TestValidarReservaValorComIntegracaoMandadoComReservaUsuarioNao;
begin
  PopularDadosTela;
  FoValidadorReservaValorGerenciador.ValidarReservaValor;
  fcdsTela.First;

  fcdsEnvio.Append;
  fcdsEnvio.FieldByName('CDDOCUMENTO').Assign(fcdsTela.FieldByName('CDDOCUMENTO'));
  FoValidadorReservaValorGerenciador.DefinirSeGeraAuditoriaReservaValorParaMandado(
    fcdsEnvio, fcdsTela);
  fcdsEnvio.post;     

  fcdsEnvio.First;
  while not FcdsEnvio.EOF do
  begin
    CheckTrue(fcdsEnvio.FieldByName('FLGERARAUDITRESERVAVALOR').AsBoolean);
    fcdsEnvio.Next;
  end;
end;

initialization

  TestFramework.RegisterTest('Unitário\PG5\Classes\ufpgValidadorReservaValorGerenciadorTests',
    TfpgValidadorReservaValorGerenciadorTests.Suite);

end.

