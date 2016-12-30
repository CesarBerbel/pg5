unit ufpgCadSolicitacaoRetiradaArmasTests;

interface

uses
  ufpgCadSolicitacaoRetiradaArmas, TestFrameWork, Forms, usgaSolicitMovArma,
  SysUtils, DBClient, DB;

type
  TffpgCadSolicitacaoRetiradaArmasTests = class(TTestCase)
  private
    FoControleTela: TffpgCadSolicitacaoRetiradaArmas;
    FoForm: TForm;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
    procedure CriarCamposSolicitMovArma(oObjeto: integer);
    procedure PreencherCdsSolicitMovArma(oObjeto: integer);
  published
    function TestVerificarSolicitacoesJaEnviadas: boolean;
    procedure TestDesmarcarEnvioDeRegistroEmSituacaoPendente;
    procedure TestMarcarRegistrosEnviadosComoPendente;
  end;

implementation

{ TffpgCadSolicitacaoRetiradaArmasTests }

procedure TffpgCadSolicitacaoRetiradaArmasTests.CriarCamposSolicitMovArma(oObjeto: integer);
var
  oObjetoClient: TClientDataSet;
begin
  oObjetoClient := TClientDataSet(oObjeto);
  oObjetoClient.FieldDefs.Add('cdArma', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('nuSeqSolicitacao', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('tpSolicitacao', ftString, 1);
  oObjetoClient.FieldDefs.Add('cdForoHist', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('cdUsuInclusao', ftString, 15);
  oObjetoClient.FieldDefs.Add('dtUsuInclusao', ftDate);
  oObjetoClient.FieldDefs.Add('CC_deArma', ftString, 1000);
  oObjetoClient.FieldDefs.Add('CC_cdProcesso', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('CC_nuProcesso', ftString, 20);
  oObjetoClient.FieldDefs.Add('CC_cdTipoMovimentacao', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('CC_Situacao', ftString, 200);
  oObjetoClient.FieldDefs.Add('CC_cdMotivo', ftInteger, 0);
  oObjetoClient.FieldDefs.Add('CC_deMotivo', ftString, 250);
end;

procedure TffpgCadSolicitacaoRetiradaArmasTests.PreencherCdsSolicitMovArma(oObjeto: integer);
var
  oObjetoClient: TClientDataSet;
  nCodigoSequencial: integer;
begin
  oObjetoClient := TClientDataSet(oObjeto);
  for nCodigoSequencial := 1 to 3 do
  begin
    oObjetoClient.Append;
    oObjetoClient.FieldByName('cdArma').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('nuSeqSolicitacao').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('tpSolicitacao').AsString := '';
    oObjetoClient.FieldByName('cdForoHist').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('cdUsuInclusao').AsString := '';
    oObjetoClient.FieldByName('dtUsuInclusao').AsDateTime := Date;
    oObjetoClient.FieldByName('CC_deArma').AsString := '';
    oObjetoClient.FieldByName('CC_cdProcesso').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('CC_nuProcesso').AsString := '';
    oObjetoClient.FieldByName('CC_cdTipoMovimentacao').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('CC_Situacao').AsString := 'Pendente';
    oObjetoClient.FieldByName('CC_cdMotivo').AsInteger := nCodigoSequencial;
    oObjetoClient.FieldByName('CC_deMotivo').AsString := '';
    oObjetoClient.Post;
  end;
end;

procedure TffpgCadSolicitacaoRetiradaArmasTests.SetUp;
begin
  FoControleTela := TffpgCadSolicitacaoRetiradaArmas.Create(nil); //PC_OK
  FoForm := TForm.Create(nil); //PC_OK
  inherited;
end;

procedure TffpgCadSolicitacaoRetiradaArmasTests.TearDown;
begin
  FoForm.Free; //PC_OK
  FoControleTela.Free; //PC_OK
  inherited;
end;

procedure TffpgCadSolicitacaoRetiradaArmasTests.TestDesmarcarEnvioDeRegistroEmSituacaoPendente;
var
  oObjeto: TClientDataSet;
begin
  oObjeto := TClientDataSet.Create(nil);
  try
    CriarCamposSolicitMovArma(integer(oObjeto));
    oObjeto.CreateDataSet;
    PreencherCdsSolicitMovArma(integer(oObjeto));
    FoControleTela.DesmarcarEnvioDeRegistroEmSituacaoPendente(integer(oObjeto));
  finally
    FreeAndNil(oObjeto);
  end;
end;

procedure TffpgCadSolicitacaoRetiradaArmasTests.TestMarcarRegistrosEnviadosComoPendente;
begin

end;

function TffpgCadSolicitacaoRetiradaArmasTests.TestVerificarSolicitacoesJaEnviadas: boolean;
begin
  result := True;
end;

initialization

  TestFramework.RegisterTest('Unitário\ufpgCadSolicitacaoRetiradaArmasTests',
    TffpgCadSolicitacaoRetiradaArmasTests.Suite);

end.

