unit ufpgControleTelaCadProcessoDependenteTests;

interface

uses
  ufpgControleTelaCadProcessoDependente, TestFrameWork, Windows, Forms,
  FutureWindows, SysUtils, uspConjuntoDados, DB, DBCtrls, DBClient;

type
  TProcesso = record
    sCdProcesso: string;
    sFlTipoClasse: string;
    sFlProcVirtual: string;
    sSituacaoProcesso: string;
    sTpFormaTramita: string;
    sTpControleTramita: string;
    sProcessoApenso: string;
  end;

  TfpgControleTelaCadProcessoDependenteFake = class(TfpgControleTelaCadProcessoDependente)
  protected
    function TestarExisteDocumentoNoProcesso(psCdProcesso: string; pbCadastrandoeSAJ: boolean;
      pvDocumento: variant): boolean; override;

    function TestarUsuarioAutorizadoJuntar: boolean; override;
    //espindola - 27/06/2014 - SALT: 161377/1
    function TestarAutorizadoAcessarDigPecaProcessual: boolean; override;
  end;

  TfpgControleTelaCadProcessoDependenteTests = class(TTestCase)
  private
    FoControleTela: TfpgControleTelaCadProcessoDependenteFake;
    FoForm: TForm;

    procedure DefinirEstruturaConjuntoProcesso(poConjunto: TspConjuntoDados);
    procedure AtribuirDadosConjuntoProcesso(poConjunto: TspConjuntoDados; prProcesso: TProcesso);
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestHabilitarBotaoDigitalizarProcessoFisico;
    procedure TestHabilitarBotaoDigitalizarProcessoDigital;
    procedure TestHabilitarBotaoTransferir;
    procedure TestHabilitarBotaoApensarProcessoPrincipal;
    procedure TestHabilitarBotaoApensarProcessoApenso;
    procedure TestHabilitarBotaoApensarPeticaoDiversa;
    procedure TestHabilitarBotaoApensarOutrasPeticoes;
    procedure TestHabilitarBotaoImprimirEtiquetaPeticaoDiversa;
    procedure TestHabilitarBotaoImprimirEtiquetaOutrasPeticoes;
    procedure TestHabilitarBotaoImprimirPecasProcessoFisico;
    procedure TestHabilitarBotaoImprimirPecasProcessoDigital;
    procedure TestHabilitarBotaoJuntarPeticaoDiversao;
    procedure TestHabilitarBotaoJuntarProcessoDependenteTramitacaoPrincipal;
    procedure TestHabilitarBotaoJuntarProcessoDependenteTramitacaoDependente;
    procedure TestHabilitarBotaoJuntarProcessoApartado;
    procedure TestHabilitarBotaoJuntarPeticaoDiversaoCadastroNaoSalvo;
  end;

implementation

uses
  usajConstante;

const
  sNUMERO_PROCESSO = 'II0000P100000';
  nTOPO_ARVORE = 0;
  nPRIMEIRO_NIVEL_ARVORE = 1;
  nSEGUNDO_NIVEL_ARVORE = 2;

{ TfpgControleTelaCadProcessoDependenteTests }

procedure TfpgControleTelaCadProcessoDependenteTests.SetUp;
begin
  FoControleTela := TfpgControleTelaCadProcessoDependenteFake.Create(); //PC_OK
  FoForm := TForm.Create(nil); //PC_OK

  inherited;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TearDown;
begin
  FoForm.Free; //PC_OK
  FoControleTela.Free; //PC_OK

  inherited;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoApensarPeticaoDiversa;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_DIVERSOS;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoApensar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoDigitalizarProcessoFisico;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sFlProcVirtual := sFLAG_NAO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoDigitalizar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoImprimirEtiquetaPeticaoDiversa;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_DIVERSOS;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoImprimirEtiqueta(oProcesso,
      nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoImprimirPecasProcessoFisico;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sFlProcVirtual := sFLAG_NAO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoImprimirPecas(oProcesso, False, null, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoTransferir;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sFlProcVirtual := sFLAG_NAO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoTransferir(oProcesso, nPRIMEIRO_NIVEL_ARVORE));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.DefinirEstruturaConjuntoProcesso(
  poConjunto: TspConjuntoDados);
begin
  poConjunto.FieldDefs.Clear;
  poConjunto.FieldDefs.Add('CDPROCESSO', ftString, 13, False);
  poConjunto.FieldDefs.Add('FLTIPOCLASSE', ftString, 1, False);
  poConjunto.FieldDefs.Add('FLPROCVIRTUAL', ftString, 1, False);
  poConjunto.FieldDefs.Add('CDSITUACAOPROCESSO', ftString, 1, False);
  poConjunto.FieldDefs.Add('TPFORMATRAMITA', ftString, 1, False);
  poConjunto.FieldDefs.Add('TPCONTROLETRAMITA', ftString, 1, False);
  poConjunto.FieldDefs.Add('CC_EHPROCAPENSO', ftString, 1, False);
  poConjunto.CreateDataSet;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.AtribuirDadosConjuntoProcesso(
  poConjunto: TspConjuntoDados; prProcesso: TProcesso);
begin
  poConjunto.Edit;
  poConjunto.FieldByName('CDPROCESSO').AsString := prProcesso.sCdProcesso;
  poConjunto.FieldByName('FLTIPOCLASSE').AsString := prProcesso.sFlTipoClasse;
  poConjunto.FieldByName('FLPROCVIRTUAL').AsString := prProcesso.sFlProcVirtual;
  poConjunto.FieldByName('CDSITUACAOPROCESSO').AsString := prProcesso.sSituacaoProcesso;
  poConjunto.FieldByName('TPFORMATRAMITA').AsString := prProcesso.sTpFormaTramita;
  poConjunto.FieldByName('TPCONTROLETRAMITA').AsString := prProcesso.sTpControleTramita;
  poConjunto.FieldByName('CC_EHPROCAPENSO').AsString := prProcesso.sProcessoApenso;
  poConjunto.Post;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoApensarOutrasPeticoes;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoApensar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoApensarProcessoPrincipal;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoApensar(oProcesso, nTOPO_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoApensarProcessoApenso;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_SIM;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoApensar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoDigitalizarProcessoDigital;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoDigitalizar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoImprimirPecasProcessoDigital;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
  vDocumento: variant;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoImprimirPecas(oProcesso, False, vDocumento, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoImprimirEtiquetaOutrasPeticoes;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_RECURSO;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoImprimirEtiqueta(oProcesso,
      nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoJuntarPeticaoDiversao;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_DIVERSOS;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sTpFormaTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sTpControleTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoJuntar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;


procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoJuntarProcessoDependenteTramitacaoPrincipal;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_ACAO_INCID;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sTpFormaTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sTpControleTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckTrue(FoControleTela.HabilitarBotaoJuntar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoJuntarProcessoDependenteTramitacaoDependente;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_ACAO_INCID;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sTpFormaTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sTpControleTramita := sTPCONTROLETRAMITADEPENDENTE;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoJuntar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.TestHabilitarBotaoJuntarProcessoApartado;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_ACAO_INCID;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sTpFormaTramita := sTPFORMATRAMITAAPARTADO;
    rProcesso.sTpControleTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoJuntar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, False));
  finally
    FreeAndNil(oProcesso);
  end;
end;

procedure TfpgControleTelaCadProcessoDependenteTests.
TestHabilitarBotaoJuntarPeticaoDiversaoCadastroNaoSalvo;
var
  oProcesso: TspConjuntoDados;
  rProcesso: TProcesso;
begin
  oProcesso := TspConjuntoDados.Create(nil);
  try
    DefinirEstruturaConjuntoProcesso(oProcesso);
    rProcesso.sCdProcesso := sNUMERO_PROCESSO;
    rProcesso.sFlTipoClasse := sFLTIPOCLASSE_DIVERSOS;
    rProcesso.sFlProcVirtual := sFLAG_SIM;
    rProcesso.sSituacaoProcesso := sCDSITPROC_ANDAMENTO;
    rProcesso.sTpFormaTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sTpControleTramita := sTPFORMATRAMITAAUTOSPRINC;
    rProcesso.sProcessoApenso := sFLAG_NAO;
    AtribuirDadosConjuntoProcesso(oProcesso, rProcesso);

    CheckFalse(FoControleTela.HabilitarBotaoJuntar(oProcesso, nPRIMEIRO_NIVEL_ARVORE, True));
  finally
    FreeAndNil(oProcesso);
  end;
end;

{ TfpgControleTelaCadProcessoDependenteFake }

//espindola - 27/06/2014 - SALT: 161377/1
function TfpgControleTelaCadProcessoDependenteFake.TestarAutorizadoAcessarDigPecaProcessual: boolean;
begin
  result := True;
end;

function TfpgControleTelaCadProcessoDependenteFake.TestarExisteDocumentoNoProcesso(
  psCdProcesso: string; pbCadastrandoeSAJ: boolean; pvDocumento: variant): boolean;
begin
  result := True;
end;

function TfpgControleTelaCadProcessoDependenteFake.TestarUsuarioAutorizadoJuntar: boolean;
begin
  result := True;
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Classes\ufpgControleTelaCadProcessoDependenteTests',
    TfpgControleTelaCadProcessoDependenteTests.Suite);

end.

