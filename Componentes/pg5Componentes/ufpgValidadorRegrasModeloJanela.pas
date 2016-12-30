unit ufpgValidadorRegrasModeloJanela;

interface

uses
  SysUtils, TestFrameWork, DB, DBClient, ufpgValidadorModeloJanelaPeticaoInicialWeb,
  ufpgObjetoInterParametrosCadastroProcesso;

type
  TfpgValidadorRegrasModeloJanela = class(TTestCase)
  private
    FoValidadorModeloJanelaPeticaoInicialWeb: TfpgValidadorModeloJanelaPeticaoInicialWeb;
    FoParametrosCadastroProcesso: TfpgObjetoInterParametrosCadastroProcesso;
    procedure CriarEstruturaParaTeste;
    procedure AtribuirDados;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    // Test methods
    procedure TestValidarDadosProcessoPreenchidosInexistente;
    procedure TestValidarDadosProcessoPreenchidosCartaPrecatoria;
    procedure TestValidarDadosProcessoPreenchidosCartaOrdem;
    procedure TestValidarDadosProcessoPreenchidosExecFiscal;
    procedure TestValidarDadosProcessoPreenchidosExecFiscalComDados;
    procedure TestValidarDadosProcessoPreenchidosDelegacia;
    procedure TestValidarDadosProcessoPreenchidosDelegaciaComDados;
    procedure TestValidarDadosProcessoPreenchidosRequisitorio;
  end;

implementation

uses
  usajConstante, uspClientDataSet, ufpgValidadorModeloJanelaPeticaoInicialWebCartaPrecatoria,
  ufpgValidadorModeloJanelaPeticaoInicialWebOrdem,
  ufpgValidadorModeloJanelaPeticaoInicialWebExecFiscal,
  ufpgValidadorModeloJanelaPeticaoInicialWebDelegacia,
  ufpgValidadorModeloJanelaPeticaoInicialWebRequisitorio,
  ufpgValidadorModeloJanelaPeticaoInicialWebFactory;

{nTPMODELOJANELA_PRECATORIA
nTPMODELOJANELA_ORDEM
nTPMODELOJANELA_EXEC_FISCAL
nTPMODELOJANELA_DELEGACIA
nTPMODELOJANELA_REQUISITORIO}
const
  nTPMODELOJANELA_INEXISTENTE = 0;

procedure TfpgValidadorRegrasModeloJanela.SetUp;
begin
  inherited;
  FoParametrosCadastroProcesso := TfpgObjetoInterParametrosCadastroProcesso.Create; //PC_OK
  CriarEstruturaParaTeste;
end;

procedure TfpgValidadorRegrasModeloJanela.TearDown;
begin
  inherited;
  if Assigned(FoParametrosCadastroProcesso) then
    FreeAndNil(FoParametrosCadastroProcesso); //PC_OK
end;

procedure TfpgValidadorRegrasModeloJanela.CriarEstruturaParaTeste;
var
  cdsDados: TspClientDataSet;
begin
  cdsDados := TspClientDataSet.Create(nil);
  try
    cdsDados.FieldDefs.Add('nuCDAForm', ftString, 1);
    cdsDados.FieldDefs.Add('vlCDA', ftString, 1);
    cdsDados.CreateDataSet;
    FoParametrosCadastroProcesso.fpgCDAs := cdsDados.Data;
    FoParametrosCadastroProcesso.fpgDocDP := cdsDados.Data;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.AtribuirDados;
var
  cdsDados: TspClientDataSet;
begin
  cdsDados := TspClientDataSet.Create(nil);
  try
    cdsDados.Data := FoParametrosCadastroProcesso.fpgCDAs;
    cdsDados.Insert;
    cdsDados.FieldByName('nuCDAForm').AsString := 'Valor';
    cdsDados.FieldByName('vlCDA').AsString := 'Valor';
    cdsDados.Post;
    FoParametrosCadastroProcesso.fpgCDAs := cdsDados.Data;
    FoParametrosCadastroProcesso.fpgDocDP := cdsDados.Data;
  finally
    FreeAndNil(cdsDados);
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosInexistente;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_INEXISTENTE);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem = STRING_INDEFINIDO);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosCartaPrecatoria;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_PRECATORIA);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckFalse(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_CARTA_PRECATORIA);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosCartaOrdem;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_ORDEM);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckFalse(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_CARTA_ORDEM);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosExecFiscal;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_EXEC_FISCAL);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckFalse(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_EXEC_FISCAL);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosExecFiscalComDados;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_EXEC_FISCAL);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    AtribuirDados;
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_EXEC_FISCAL);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosDelegacia;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_DELEGACIA);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckFalse(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_DELEGACIA);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosDelegaciaComDados;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_DELEGACIA);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    AtribuirDados;
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem =
      SRETORNO_MSG_DELEGACIA);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

procedure TfpgValidadorRegrasModeloJanela.TestValidarDadosProcessoPreenchidosRequisitorio;
begin
  FoValidadorModeloJanelaPeticaoInicialWeb :=
    TfpgValidadorModeloJanelaPeticaoInicialWebFactory.CriarValidador(nTPMODELOJANELA_REQUISITORIO);
  try
    FoValidadorModeloJanelaPeticaoInicialWeb.fpgParametrosCadastroProcesso :=
      FoParametrosCadastroProcesso;

    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.ValidarDadosProcessoPreenchidos);
    CheckTrue(FoValidadorModeloJanelaPeticaoInicialWeb.fpgComplementoMensagem = STRING_INDEFINIDO);
  finally
    FreeAndNil(FoValidadorModeloJanelaPeticaoInicialWeb); //PC_OK
  end;
end;

initialization
  Registertest('Unitário\PG5\Componentes', TfpgValidadorRegrasModeloJanela.Suite);

end.

