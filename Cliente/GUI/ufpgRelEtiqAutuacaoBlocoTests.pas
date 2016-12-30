unit ufpgRelEtiqAutuacaoBlocoTests;

interface

uses
  ufpgRelEtiqAutuacaoBloco, ufpgGUITestCase, ufpgRelEtiqAutuacaoBlocoModelTests, ufpgDataModelTests;

type
  TffpgRelEtiqAutuacaoBlocoTests = class(TfpgGUITestCase)
  private
    FoTela: TffpgRelEtiqAutuacaoBloco;
    FoDados: TffpgRelEtiqAutuacaoBlocoModelTests;
    procedure ExecutarTesteAuditoriaImpressaoEtiqueta;
  protected
    function PegarClasseModelTests: TfpgDataModelTestsClass; override;
  published
    procedure TestarAuditoriaImpressaoEtiqueta;
  end;

implementation

uses
  usajConstante, ufpgFuncoesGUITestes, TestFrameWork, FutureWindows, uspRPPreviewForm;

{ TffpgRelEtiqAutuacaoBlocoTests }

procedure TffpgRelEtiqAutuacaoBlocoTests.ExecutarTesteAuditoriaImpressaoEtiqueta;
var
  nQtEtiqImpressa: integer;
begin
  FoTela := TffpgRelEtiqAutuacaoBloco(spTela);
  FoDados := (Self.spDataModelTests) as TffpgRelEtiqAutuacaoBlocoModelTests;

  if FoDados.fpgNuProcesso = STRING_INDEFINIDO then
    FoDados.fpgNuProcesso := UsarProcessoArray;
  Check(FoDados.fpgNuProcesso = STRING_INDEFINIDO, 'Número de Processo não encontrado.');

  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);
  nQtEtiqImpressa := FoTela.cdsProcesso.FieldByName('CC_qtEtiquetasImpressa').AsInteger;
  TFutureWindows.Expect('TfspRPPreviewForm', 5000).ExecProc(FecharJanelaModal);

  // 12/09/2014 - Fischer - SALT: 145483/1
  // oTela.pbVisualizar.Click;
  FoTela.pbLimpar.Click;
  EnterTextInto(FoTela.dfNuProcesso.FdfNumeroProcessoExterno, FoDados.fpgNuProcesso, False);

  CheckTrue(nQtEtiqImpressa = FoTela.cdsProcesso.FieldByName('CC_qtEtiquetasImpressa').AsInteger,
    'Não gravou auditoria da impressão');

end;

function TffpgRelEtiqAutuacaoBlocoTests.PegarClasseModelTests: TfpgDataModelTestsClass;
begin
  result := TffpgRelEtiqAutuacaoBlocoModelTests;
end;

procedure TffpgRelEtiqAutuacaoBlocoTests.TestarAuditoriaImpressaoEtiqueta;
begin
  ExecutarRoteiroTestes(ExecutarTesteAuditoriaImpressaoEtiqueta);
end;

end.

