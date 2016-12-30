unit ufpgRedistribuicaoEntreForosTests;

interface

uses
  ufpgRedistribuicaoEntreForos, ufpgRedistribuicaoEntreForosFake, TestFrameWork,
  Windows, Forms, FutureWindows, SysUtils, DB, DBClient, uspTestCase, uspConjuntoDados;

type
  TfpgRedistribuicaoEntreForosTests = class(TspTestCase)
  private
    FoRedistribuicaoEntreForos: TfpgRedistribuicaoEntreForosFake;
    FoDados: TspConjuntoDados;
    function CriarDataSetTeste: TspConjuntoDados;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarValorParametroDataSetCampNao;
    procedure TestarValorParametroDataSetCampoSim;
    procedure TestarValorParametroDataSetCampoVazioNao;
    procedure TestarValorParametroDataSetCampoVazioSim;
    procedure TestarValorParametroDataSetCampSim;
    procedure TestarValorParametroDataSetNilDefaultNao;
    procedure TestarValorParametroDataSetNilDefaultSim;
    procedure TestarValorParametroDataSetSemCampoNao;
    procedure TestarValorParametroDataSetSemCampoSim;
    procedure TestarValorParametroDataSetVazioNao;
    procedure TestarValorParametroDataSetVazioSim;
  end;

implementation

uses
  uSajConstante, fpgServidor_tlb;

const
  sCAMPO_CODIGO = 'cdObjeto';
  sCAMPO_CONTEUDO = 'deConteudo';
  sCAMPO_FAKE = 'cdIntegracao';

procedure TfpgRedistribuicaoEntreForosTests.SetUp;
begin
  FoRedistribuicaoEntreForos := TfpgRedistribuicaoEntreForosFake.spCreate(nil, CLASS_fpgServidorDM, IID_IfpgServidorDM); //PC_OK
  FoDados := CriarDataSetTeste;
end;

procedure TfpgRedistribuicaoEntreForosTests.TearDown;
begin
  FreeAndNil(FoRedistribuicaoEntreForos);//PC_OK
  FreeAndNil(FoDados);//PC_OK
end;

function TfpgRedistribuicaoEntreForosTests.CriarDataSetTeste: TspConjuntoDados;
begin
  result := TspConjuntoDados.Create(nil);//PC_OK
  result.FieldDefs.Add(sCAMPO_CODIGO, ftInteger);
  result.FieldDefs.Add(sCAMPO_CONTEUDO, ftString, 100);
  result.CreateDataSet;

  result.Append;
  result.FieldByName(sCAMPO_CODIGO).AsInteger := 1;
  result.FieldByName(sCAMPO_CONTEUDO).AsString := sFLAG_SIM;
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetVazioSim;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(
    STRING_INDEFINIDO, True, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetVazioNao;
begin
  CheckFalse(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(
    STRING_INDEFINIDO, False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetSemCampoSim;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_FAKE,
    True, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetSemCampoNao;
begin
  CheckFalse(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_FAKE,
    False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetCampoVazioSim;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_CONTEUDO,
    False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetCampoVazioNao;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_CONTEUDO,
    False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetCampNao;
begin
  FoDados.First;
  FoDados.edit;
  FoDados.FieldByName(sCAMPO_CONTEUDO).AsString := sFLAG_NAO;
  FoDados.post;
  CheckFalse(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(
    sCAMPO_CONTEUDO, False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetCampSim;
begin
  FoDados.First;
  FoDados.edit;
  FoDados.FieldByName(sCAMPO_CONTEUDO).AsString := sFLAG_SIM;
  FoDados.post;
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_CONTEUDO,
    False, FoDados));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetCampoSim;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(sCAMPO_CONTEUDO,
    False, FoDados));
end;


procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetNilDefaultSim;
begin
  CheckTrue(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(
    STRING_INDEFINIDO, True, nil));
end;

procedure TfpgRedistribuicaoEntreForosTests.TestarValorParametroDataSetNilDefaultNao;
begin
  CheckFalse(FoRedistribuicaoEntreForos.TestarSeParametroDefaultOuSimFake(
    STRING_INDEFINIDO, False, nil));
end;

initialization
  RegisterTest('Servidor\ufpgRedistribuicaoEntreForosTests',
    TfpgRedistribuicaoEntreForosTests.Suite);

end.

