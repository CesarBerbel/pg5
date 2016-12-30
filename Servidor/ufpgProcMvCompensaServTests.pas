unit ufpgProcMvCompensaServTests;

interface

uses
  contnrs, SysUtils, TestFrameWork, uspTestCase, uspControleTestesUnitarios,
  Classes, DBClient, ufpgProcMvCompensaServFake, fpgServidor_TLB, uspClientDataSet, usajConstante;

type
  TefpgProcMvCompensaServTests = class(TspTestCase)
  private
    procedure InicializarDadosTeste;
    function LocalizarRegProcMvCompensa(const psCdProcesso: string;
      const pnNuSeqProcessoMv: integer): boolean;
  protected
    FeFpgProcMvCompensaServFake: TefpgProcMvCompensaServFake;
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDatadistribAntesInicioPesos;

    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoLancaoRegistro;

    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoLancaoVariosRegistros;

    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoCdProcesso;
    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoNuSeqProcessoMv;

    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoUmaMovimentacaoIncrementaPeso;
    procedure TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoSegundaMovimentacaoNaoIncrementaPeso;

    procedure TestarRemoverMovimentacaoCompensaDistribuicaoSemMovimentacao;
    procedure TestarRemoverMovimentacaoCompensaDistribuicaoUmaMovimentacaoDecrementaPeso;
    procedure TestarRemoverMovimentacaoCompensaDistribuicaoSegundaMovimentacaoNaoDecrementaPeso;

    procedure TestarTestarSeExisteMovimentacaoQueCompensouPesoExistindoRegistro;
    procedure TestarTestarSeExisteMovimentacaoQueCompensouPesoNaoExistindoRegistro;

    procedure TestarRemoverTodasMovimentacoesCompensaDistribuicaoPorVaraCdForoCorreto;
    procedure TestarRemoverTodasMovimentacoesCompensaDistribuicaoPorVaraCdVaraCorreto;
  end;

implementation

const
  sCDPROCESSO1 = '0000000000001';
  sCDPROCESSO2 = '0000000000002';
  sCDPROCESSO3_DTDISTRIBPOSTERIOR = '0000000000003';
  sCDPROCESSO4 = '0000000000004';

{implementation of TefpgProcMvCompensaServTests}

procedure TefpgProcMvCompensaServTests.SetUp;
begin
  goControleTestesUnitarios.spAmbienteEmModoDeTestes := True;
  FeFpgProcMvCompensaServFake := TefpgProcMvCompensaServFake.spCreate(nil, CLASS_fpgServidorDM, IID_IfpgServidorDM); //PC_OK
  InicializarDadosTeste;
end;

procedure TefpgProcMvCompensaServTests.TearDown;
begin
  goControleTestesUnitarios.spAmbienteEmModoDeTestes := False;
  FreeAndNil(FeFpgProcMvCompensaServFake); //PC_OK
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDatadistribAntesInicioPesos;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(
    sCDPROCESSO3_DTDISTRIBPOSTERIOR, 1);

  CheckEquals(NUMERO_INDEFINIDO, FeFpgProcMvCompensaServFake.fpgPesoQtSaidoMovimentProcesso
    [sCDPROCESSO3_DTDISTRIBPOSTERIOR]);
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoUmaMovimentacaoIncrementaPeso;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);

  CheckEquals(1, FeFpgProcMvCompensaServFake.fpgPesoQtSaidoMovimentProcesso[sCDPROCESSO2]);
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoSegundaMovimentacaoNaoIncrementaPeso;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 2);

  CheckEquals(1, FeFpgProcMvCompensaServFake.fpgPesoQtSaidoMovimentProcesso[sCDPROCESSO4]);
end;

procedure TefpgProcMvCompensaServTests.TestarRemoverMovimentacaoCompensaDistribuicaoSemMovimentacao;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 2);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 3);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 4);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 5);

  FeFpgProcMvCompensaServFake.RemoverMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);

  CheckEquals(5, FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcMvCompensa.RecordCount);
end;

procedure TefpgProcMvCompensaServTests.
TestarRemoverMovimentacaoCompensaDistribuicaoUmaMovimentacaoDecrementaPeso;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);
  FeFpgProcMvCompensaServFake.RemoverMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);

  CheckEquals(0, FeFpgProcMvCompensaServFake.fpgPesoQtSaidoMovimentProcesso[sCDPROCESSO1]);
end;

procedure TefpgProcMvCompensaServTests.
TestarRemoverMovimentacaoCompensaDistribuicaoSegundaMovimentacaoNaoDecrementaPeso;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);

  FeFpgProcMvCompensaServFake.RemoverMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);

  CheckEquals(1, FeFpgProcMvCompensaServFake.fpgPesoQtSaidoMovimentProcesso[sCDPROCESSO2]);
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoCdProcesso;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);
  CheckTrue(LocalizarRegProcMvCompensa(sCDPROCESSO1, 1));
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoNuSeqProcessoMv;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 2);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 3);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 4);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 5);

  CheckTrue(LocalizarRegProcMvCompensa(sCDPROCESSO4, 3));
end;

procedure TefpgProcMvCompensaServTests.InicializarDadosTeste;
var
  ocds: TspClientDataSet;
  //i: integer;
begin
  //dados de dsitribuição dos processos. Projeção

  //CDPROCESSO, CC_DTDISTRIBUICAO,CC_CDFORO,CC_CDVARA,CC_CDCARTORIO,CC_CDFOROVAGA,CC_CDVARAVAGA,
  //CC_CDVAGA,CC_CDGRUPOPESO,CC_NUFAIXADIST, CC_FLREUPRESO,CC_DTINICIOPESOVARA

  //PROCESSO 1
  ocds := FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcesso;
  TspTestCase.AppendStringList(ocds, Format('%s,%d,3,2,1,3,2,1,4,10,N,%d,R',
    [sCDPROCESSO1, Trunc(Date), Trunc(Date - 1)]));

  //PROCESSO 2
  ocds := FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcesso;
  TspTestCase.AppendStringList(ocds, Format('%s,%d,4,3,2,4,3,2,5,11,S,%d,R',
    [sCDPROCESSO2, Trunc(Date), Trunc(Date - 1)]));

  //PROCESSO 3 -  Com data de distribuição posterior ao inicio de contabilização de pesos
  ocds := FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcesso;
  TspTestCase.AppendStringList(ocds, Format('%s,%d,5,4,3,5,4,3,6,12,N,%d,R',
    [sCDPROCESSO3_DTDISTRIBPOSTERIOR, Trunc(Date - 1), Trunc(Date)]));

  //PROCESSO 4
  ocds := FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcesso;
  TspTestCase.AppendStringList(ocds, Format('%s,%d,6,5,4,6,5,4,7,13,S,%d,R',
    [sCDPROCESSO4, Trunc(Date), Trunc(Date - 1)]));

end;

function TefpgProcMvCompensaServTests.LocalizarRegProcMvCompensa(const psCdProcesso: string;
  const pnNuSeqProcessoMv: integer): boolean;
begin
  result := FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcMvCompensa.Locate(
    'CDPROCESSO;NUSEQPROCESSOMV', VarArrayOf([psCdProcesso, pnNuSeqProcessoMv]), []);
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoLancaoRegistro;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(
    sCDPROCESSO3_DTDISTRIBPOSTERIOR, 1);

  CheckEquals(1, FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcMvCompensa.RecordCount);
end;

procedure TefpgProcMvCompensaServTests.
TestarIncluirMovimentacaoCompensaDistribuicaoDistribuicaoLancaoVariosRegistros;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 2);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 3);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 2);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 7);

  CheckEquals(7, FeFpgProcMvCompensaServFake.fpgTabelaVirtualProcMvCompensa.RecordCount);
end;

procedure TefpgProcMvCompensaServTests.
TestarRemoverTodasMovimentacoesCompensaDistribuicaoPorVaraCdForoCorreto;
begin
  FeFpgProcMvCompensaServFake.RemoverTodasMovimentacoesCompensaDistribuicaoPorVara(12, 4);

  CheckEquals(12, FeFpgProcMvCompensaServFake.fpgCdForoRegistrosRemovidos);
end;

procedure TefpgProcMvCompensaServTests.
TestarTestarSeExisteMovimentacaoQueCompensouPesoExistindoRegistro;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO2, 1);

  CheckTrue(FeFpgProcMvCompensaServFake.TestarSeExisteMovimentacaoQueCompensouPeso(sCDPROCESSO2));
end;

procedure TefpgProcMvCompensaServTests.
TestarTestarSeExisteMovimentacaoQueCompensouPesoNaoExistindoRegistro;
begin
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 1);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO1, 2);
  FeFpgProcMvCompensaServFake.IncluirMovimentacaoCompensaDistribuicao(sCDPROCESSO4, 2);

  CheckFalse(FeFpgProcMvCompensaServFake.TestarSeExisteMovimentacaoQueCompensouPeso(sCDPROCESSO2));
end;

procedure TefpgProcMvCompensaServTests.
TestarRemoverTodasMovimentacoesCompensaDistribuicaoPorVaraCdVaraCorreto;
begin
  FeFpgProcMvCompensaServFake.RemoverTodasMovimentacoesCompensaDistribuicaoPorVara(12, 4);

  CheckEquals(4, FeFpgProcMvCompensaServFake.fpgCdVaraRegistrosRemovidos);
end;

initialization
  TestFrameWork.RegisterTest('Unitário\PG5\Servidor\ufpgProcMvCompensaServTests',
    TefpgProcMvCompensaServTests.Suite);
end.

