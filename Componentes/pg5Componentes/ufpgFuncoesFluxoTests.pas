unit ufpgFuncoesFluxoTests;

interface

uses
  ufpgFuncoesFluxoFake, TestFrameWork, SysUtils, uspClientDataSet, DB,
  usajConstante, uwflconstante;

type
  TfpgFuncoesFluxoTests = class(TTestCase)
  private
    FfpgFuncoesFluxo: TfpgFuncoesFluxoFake;
    FcdsHistObjeto: TspClientDataSet;
  protected

    procedure SetUp; override;
    procedure TearDown; override;

  published

    // Test methods
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_ComunicacaoPrisional;
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_IntimacaoEletronica;
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_ForaUso;
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_FilaAtoAgEmissao;
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_AutorizacaoComponente;
    procedure TestDefinirHabilitacaoOpcaoEncaminhamento_FilaAtoAgEmissao_VericarEhSubFluxoProcessoOuPeticao;
    procedure TestDefinirHabilitacaoOpcaoExclusao_ComunicacaoPrisional;
    procedure TestDefinirHabilitacaoOpcaoExclusao_IntimacaoEletronica;
    procedure TestDefinirHabilitacaoOpcaoExclusao_ForaUso;
    procedure TestDefinirHabilitacaoOpcaoExclusao_VerificarRestricaoSubFluxoCustasParaExclusao;
    procedure TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir;
    procedure TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir_Mandado;
    procedure TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir_cdAR;

  end;

implementation

{ TfpgFuncoesFluxoTests }

procedure TfpgFuncoesFluxoTests.SetUp;
begin
  inherited;
  FfpgFuncoesFluxo := TfpgFuncoesFluxoFake.Create; //PC_OK
  FcdsHistObjeto := TspClientDataSet.Create(nil); //PC_OK
  FcdsHistObjeto.FieldDefs.Add('cdAR', ftString, 13);
  FcdsHistObjeto.CreateDataSet;
end;

procedure TfpgFuncoesFluxoTests.TearDown;
begin
  FreeAndNil(FcdsHistObjeto); //PC_OK
  FreeAndNil(FfpgFuncoesFluxo); //PC_OK
  inherited;
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoEncaminhamento_AutorizacaoComponente;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    STRING_INDEFINIDO, True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoEncaminhamento_ComunicacaoPrisional;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    STRING_INDEFINIDO, False, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, nOBJCOMUNICACAOPRISIONAL));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoEncaminhamento_FilaAtoAgEmissao;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    STRING_INDEFINIDO, True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    ncdFila_Ag_Emissao, NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.
TestDefinirHabilitacaoOpcaoEncaminhamento_FilaAtoAgEmissao_VericarEhSubFluxoProcessoOuPeticao;
begin
  CheckTrue(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    'Exemplo', True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    nObjRecursoPeticao));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoEncaminhamento_ForaUso;
begin
  CheckTrue(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    STRING_INDEFINIDO, False, True, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoEncaminhamento_IntimacaoEletronica;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoEncaminhamento(FcdsHistObjeto,
    STRING_INDEFINIDO, False, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, nObjIntimacaoEletronica));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoExclusao_ComunicacaoPrisional;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    STRING_INDEFINIDO, False, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, nOBJCOMUNICACAOPRISIONAL));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoExclusao_ForaUso;
begin
  CheckTrue(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    STRING_INDEFINIDO, False, True, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.TestDefinirHabilitacaoOpcaoExclusao_IntimacaoEletronica;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    STRING_INDEFINIDO, False, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, nObjIntimacaoEletronica));
end;

procedure TfpgFuncoesFluxoTests.
TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    STRING_INDEFINIDO, True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO, NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.
TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir_cdAR;
begin
  FcdsHistObjeto.Append;
  FcdsHistObjeto.FieldByName('cdAR').AsString := 'AF9454AB';
  FcdsHistObjeto.Post;
  CheckTrue(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    'Exemplo', True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO,
    NUMERO_INDEFINIDO));
end;

procedure TfpgFuncoesFluxoTests.
TestDefinirHabilitacaoOpcaoExclusao_VerificarAutorizacaoExtraParaMoverCopiarExcluir_Mandado;
begin
  CheckTrue(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    'Exemplo', True, False, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO, NUMERO_INDEFINIDO, nOBJMANDADO));
end;

procedure TfpgFuncoesFluxoTests.
TestDefinirHabilitacaoOpcaoExclusao_VerificarRestricaoSubFluxoCustasParaExclusao;
begin
  CheckFalse(FfpgFuncoesFluxo.DefinirHabilitacaoOpcaoExclusao(FcdsHistObjeto,
    STRING_INDEFINIDO, False, True, NUMERO_INDEFINIDO, 1, NUMERO_INDEFINIDO, nObjCarta));
end;

initialization
  RegisterTest('Unitário\PG5\ufpgFuncoesFluxoTests Suite', TfpgFuncoesFluxoTests.Suite);

end.

